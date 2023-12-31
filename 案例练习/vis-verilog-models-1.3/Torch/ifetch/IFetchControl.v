// +----------------------------------------------------------------+
// |            Copyright (c) 1994 Stanford University.             |
// |                      All Rights Reserved.                      |
// |                                                                |
// |   This software is distributed with *ABSOLUTELY NO SUPPORT*    |
// |   and *NO WARRANTY*.   Use or reproduction of this code for    |
// |   commerical gains is strictly prohibited.   Otherwise, you    |
// |   are given permission to use or modify this code as long      |
// |   as you do not remove this notice.                            |
// +----------------------------------------------------------------+
//
//  Title: 	Instruction Fetch Control module
//  Created:	Sat Mar 26 21:34:11 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  IFetchControl.v,v 7.38 1995/01/28 00:47:54 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
// This Section contains all the control signals that goes to IFetchDatapath.v
// It also includes control signal latches and combinational logics.
//
//
// Main Sections
//	- signals that are either global in IFetch world or hard to be
//		placed in anywhere else
//	- Controls signals that goes to the outside world
//	- Controls for ICache Refill, including the state machine
//	- Controls for ICache Instruction Fetch
//	- Controls for Tag/PID Comparator
//	- Controls for non-Cacheable Instr
//	- Controls for PCUnit
//
//	Hierarchy: processor.instrFetch
//
//  Revision History:
//	Modified: Wed Nov 30 22:42:15 1994	<ricardog@chroma.Stanford.EDU>
//	* -- Added code to qualify ICACHE access.
//	Modified: Wed Nov 30 14:47:44 1994	<ricardog@chroma.Stanford.EDU>
//	* Removed local clock qualification.
//	Modified: Sun Aug  7 22:16:51 1994	<ricardog@chroma.Stanford.EDU>
//	* Moved ICACHE outside of IFetchDatapath.
//	Modified: Mon Jun 27 15:19:44 1994	<ricardog@chroma.Stanford.EDU>
//	* Renamed Reset to Reset_s1 and qualfied state latches with MemStall
//	Modified:	Sun May 22 16:32:11 1994	<ricardog@chroma>
//	* Changed MemStall_s2 to MemStall_s1.
//	Modified:	Tue Apr 12 12:27:15 1994	<ricardog@chroma>
//	* Changed timing of HoldPC_v2r to be _s2r.
//	Modified:	Sat Apr  9 16:41:19 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Fri Apr  1 16:32:59 1994	<ricardog@chroma>
//	* Better implementation of jump mux.
//	Modified:	Fri Apr  1 16:32:45 1994	<ricardog@chroma>
//	* Moved branch logic.

module IFetchControl(
    Phi1,
//    Phi2,
    Gamma1_s1,
    MemStall_s1,
    Stall_s1,
    Reset_s1,
    MipsMode_s2e,
    MipsMode_b_s2e,
    ItlbMiss_v2e,
    ExtDataValid_s2,
    L2Miss_s2,
    IStall_s1,
    IFetchStall_s1,
    AKill_s1e,
    BKill_s1e,
    KillOne_s1e,
    LatchShiftReg_s1,
    WriteData_s2,
    WriteTag_s2,
    DataEnable_s2,
    TagEnable_s2,
    LatchDataReg_s1,
    ExtMuxSelect_s1,
    WritePack_s2,
    ADynamicBit_v1r,
    BDynamicBit_v1r,
    ADrvB_s2r,
    BDrvA_s2r,
    LatchInstrs_s1r,
    LatchTags_s1r,
    PCOffset_s2i,
    Match_v2r,
    ICacheLineValid_s2r,
    ICacheMiss_v2r,
    NonCacheable_s1,
    LatchNonCachePkt_s2,
    NonCacheableHeld_s1,
    Except_s1w,
    BEQnext_s1e,
    BNEnext_s1e,
    BLEZnext_s1e,
    BGTZnext_s1e,
    BLTZnext_s1e,
    BGEZnext_s1e,
    ImmPC_s1e,
    RegPC_s1e,
    SEqualsT_v1e,
    SIsNegative_v1e,
    TakenBranch_s2e,
    EPCSel_s1m,
    EPCNSel_s1m,
    SystemBit_s2e,
    PC_bit31_s2i,
    PCPacketNum_s2i,
    IAddrError_v2i,
    PCUnitPsi2_s2,
    latchEPC_s1w,
    RestoreIStallPC_s1,
    HoldPC_s2r,
    HoldPC_s2e,
    EPCBufEnable_s2m,
    EPCMuxSel_s2m,
    Jump0_s1e,
    Jump1_s1e,
    Jump2_s1e,
    Jump3_s1e,
    Jump4_s1e,
    Jump5_v1e
    );
//----------------------------------------------------------------------------

//-------------Declarations for IFetch global signals------------------------
output		Gamma1_s1;	        // Gamma1 = Phi1 & ~MemStall
wire		Gamma1_s1;
output		IFetchStall_s1;		// De-asserted one cycle early
reg		IFetchStall_s1;		// for IFetch logic
reg		IFetchStall_s2;		// delayed version
wire		IFetchStall_v2;		// Stall instruction fetch logic
wire		SecondIssue_s2r;	// whether will do 2nd cycle of
reg		SecondIssue_s1e;	// dnop'ed packet
reg		SecondIssue_s2e;
wire		SecondIssueCond_s2r;
reg		SecondIssueCond_s1e;


//-------------Declarations for Outside world signals------------------------

input		Phi1;		        // Clocks
wire		Phi2;
input		MemStall_s1;		// Memory stall signal
input		Stall_s1;	        // Global stall signal
input		Reset_s1;		// Pin reset signal
input		MipsMode_s2e;		// MIPS mode bit from coprocessor
output		MipsMode_b_s2e;		// 
input		ItlbMiss_v2e;		// TLB miss; empty pipeline
input		ExtDataValid_s2;	// data bus valid
input		L2Miss_s2;		// Level 2 miss; must restart refill
output		IStall_s1;		// Global I-Stall signal
output		AKill_s1e, BKill_s1e;	// to outside world
output		KillOne_s1e;	
reg		Reset_s2;               // latched reset
reg		MipsMode_s1;            // latched for when needed
reg		IStall_s1;              // latched global IStall signal
wire		IStall_v2;		// generated by IFetchFSM
reg		ItlbMiss_s1, ItlbMiss_s2;	// latched & delayed versions
reg		AKill_s1e, BKill_s1e;	// to outside world
wire		AKill_v2r, BKill_v2r;
wire		KillOne_s1e;

//-------------Declarations for Refill Section------------------------

output		LatchShiftReg_s1;
reg		LatchShiftReg_s1;
wire		LatchShiftReg_v2;
output		WriteData_s2;
wire		WriteData_s2;
output		WriteTag_s2;		// write tag, valid, PID bits
wire		WriteTag_s2;		// write tag, valid, PID bits
output		DataEnable_s2;		// 
wire		DataEnable_s2;		// 
wire		SecondIssueMips_s2r;
reg		SecondIssueMips_s1e;
output		TagEnable_s2;		// 
wire		TagEnable_s2;		// 
output		LatchDataReg_s1;
reg		LatchDataReg_s1;
wire		LatchDataReg_v2;
output		ExtMuxSelect_s1;	// control signals & latches
reg		ExtMuxSelect_s1;	//   from IFetchFSM
wire		ExtMuxSelect_v2;
wire		WriteCache_v1;
reg		WriteCache_s2;

//-------------Declarations for IFetchFSM-----------------------------------
output	[1:0]	WritePack_s2;
wire	[1:0]	WritePack_s2;
reg 	[3:0]	PrevState_s2;		// Previous state of fsm
reg 	[3:0]	PresState_s1;		// latched present state for phi 2
wire 	[3:0]	PresState_v2;		// Present state of fsm

//-------------Declarations for ICACHE control------------------------------
wire		ReadCache_v1i;
reg		ReadCache_s2i;
//wire		ReadCache_s1r;
reg		ReadCache_s1r;
reg		ReadCache_s2r;

//-------------Declarations for Instr Fetch---------------------------------
input		ADynamicBit_v1r;	// dynamic NOOP bit out of cache
input		BDynamicBit_v1r;	// dynamic NOOP bit out of cache
output		ADrvB_s2r, BDrvA_s2r;	// routing muxes
output		LatchInstrs_s1r;	// to IFetchDatapath.v
output		LatchTags_s1r;		// to IFetchDatapath.v
wire		ADrvB_v1r, BDrvA_v1r;	// control signals for instruction
reg		ADrvB_s2r, BDrvA_s2r;	//   routing muxes
reg		ADrvB_s1e, BDrvA_s1e;
reg		ADynamicBit_s2r;	// dynamic NOOP bit out of InstrReg
reg		BDynamicBit_s2r;	// dynamic NOOP bit out of InstrReg
reg		ADynamicBit_s1e;	// dynamic NOOP bit staged
reg		BDynamicBit_s1e;	// dynamic NOOP bit staged
reg		Hold_s1e, Hold_s2e;	// delayed Hold_v2r signal

//-------------Declarations for Comparator Section------------------------
input		PCOffset_s2i;		// Bit 0 of PC. from IFetchDatapath.v
input		Match_v2r;		// from Comparator
input		ICacheLineValid_s2r;	// from Comparator
output		ICacheMiss_v2r;		// to outside world
reg		PCOffset_s1r, PCOffset_s2r;
wire		ICacheMiss_v2r;

//-------------Declarations for NonCacheable Section------------------------
input		NonCacheable_s1;	// instruction access is non-cachable
					// from outside world
output		LatchNonCachePkt_s2;
output		NonCacheableHeld_s1;	// delayed version to IFetchDatapath.v
wire		LatchNonCachePkt_v1;
reg		LatchNonCachePkt_s2;
reg		NonCacheable_s2;	// latched & held version of signal
reg		NonCacheableHeld_s1;	// delayed version

//-------------Declarations for PC Unit Section------------------------------
input		Except_s1w;		// Global exception signal
					// from outside world
input		BEQnext_s1e;		// Decoded branch signals from the
input		BNEnext_s1e;		// instruction decoder
input		BLEZnext_s1e;		// the branch condition is evaluated
input		BGTZnext_s1e;		// here
input		BLTZnext_s1e;
input		BGEZnext_s1e;
input		ImmPC_s1e;		// Jump instruction
input		RegPC_s1e;		// Jump register
input		SEqualsT_v1e;		// Condition codes from RF
input		SIsNegative_v1e;
wire		takenBranch_v1e;	// Set if a br/J was taken prev phase
output		TakenBranch_s2e;
reg		TakenBranch_s2e;
input		EPCSel_s1m, EPCNSel_s1m; // from cop0, for MFC0 (from EPC/EPCN)
input		SystemBit_s2e;		// Checked against MSB of PC
input		PC_bit31_s2i;
input	[1:0]	PCPacketNum_s2i;	// bit [2:1] of the PC#
reg	[1:0]	PCPacketNum_s1r;
output		IAddrError_v2i;		// Asserted if MSB of PC is high
					// (kernel space) while in user mode
output		RestoreIStallPC_s1;	// Tells PC Unit IStall is finished--
					//   continue fetching where left off
output		PCUnitPsi2_s2;		// Phi2 & ~MemStall & ~IStall_s2
output		latchEPC_s1w;		// Phi1 & Except_s1w
output		HoldPC_s2r;		// to PC Unit
output		HoldPC_s2e;		// this is the same as Hold_s2e
output		EPCBufEnable_s2m;
output		EPCMuxSel_s2m;
output		Jump0_s1e;		// PC select signals
output		Jump1_s1e;
output		Jump2_s1e;
output		Jump3_s1e;
output		Jump4_s1e;
output		Jump5_v1e;
reg		IStall_s2;		// delayed version of IStall
reg		Except_s2w;		// delayed version of Except_s1w
reg		IncPC_s2e;		// delayed version of PC incr. signal
wire		HoldPC_s2r;
wire		Hold_s2r;		// hold for 2nd cycle of dnop packet
wire		IAddrError_v2i;
wire		HoldPC_s2e;
wire		EPCBufEnable_s2m;
wire		EPCMuxSel_s2m;
reg		EPCSel_s2m, EPCNSel_s2m;  
wire		Jump0_s1e;
wire		Jump1_s1e;
wire		Jump2_s1e;
wire		Jump3_s1e;
wire		Jump4_s1e;
wire		Jump5_v1e;


//----------------------------------------------------------------------------
//		 ---- Define States for Refill FSM ----
//----------------------------------------------------------------------------
`define CACHEHIT    4'b0010
`define WAITExtByte 4'b0011
`define EXTBYTE     4'b0111
`define WAITXfer0   4'b0000
`define XFER0       4'b0001
`define WAITXfer1   4'b0100
`define XFER1       4'b0101
`define WAITXfer2   4'b1000
`define XFER2       4'b1001
`define WAITXfer3   4'b1100
`define XFER3       4'b1101
`define REFETCH     4'b1111

initial begin
    IFetchStall_s1 = 0;
    IFetchStall_s2 = 0;
    SecondIssue_s1e = 0;
    SecondIssue_s2e = 0;
    SecondIssueCond_s1e = 0;
    Reset_s2 = 0;
    MipsMode_s1 = 0;
    IStall_s1 = 0;
    ItlbMiss_s1 = 0;
    ItlbMiss_s2 = 0;
    AKill_s1e = 0;
    BKill_s1e = 0;
    LatchShiftReg_s1 = 0;
    SecondIssueMips_s1e = 0;
    LatchDataReg_s1 = 0;
    ExtMuxSelect_s1 = 0;
    WriteCache_s2 = 0;
    PrevState_s2 = 0;
    PresState_s1 = 0;
    ReadCache_s2i = 0;
    ReadCache_s1r = 0;
    ReadCache_s2r = 0;
    ADrvB_s2r = 0;
    BDrvA_s2r = 0;
    ADrvB_s1e = 0;
    BDrvA_s1e = 0;
    ADynamicBit_s2r = 0;
    BDynamicBit_s2r = 0;
    ADynamicBit_s1e = 0;
    BDynamicBit_s1e = 0;
    Hold_s1e = 0;
    Hold_s2e = 0;
    PCOffset_s1r = 0;
    PCOffset_s2r = 0;
    LatchNonCachePkt_s2 = 0;
    NonCacheable_s2 = 0;
    NonCacheableHeld_s1 = 0;
    TakenBranch_s2e = 0;
    PCPacketNum_s1r = 0;
    IStall_s2 = 0;
    Except_s2w = 0;
    IncPC_s2e = 0;
    EPCSel_s2m = 0;
    EPCNSel_s2m = 0;  
end

assign Phi2 = ~Phi1;

//----------------------------------------------------------------------------
//		       ---- Global Controls ----
//---------------------------------------------------------------------------
assign Gamma1_s1 = ~MemStall_s1 | IStall_s1;

// Stage Reset signal
always @(Phi1 or Reset_s1) begin
    if (Phi1)  Reset_s2 = Reset_s1;
end

always @(Phi2 or MipsMode_s2e) begin
    if (Phi2)  MipsMode_s1 = MipsMode_s2e;
end

//---------------------------------------------------------------------------
//			   --- Inversion ---
//---------------------------------------------------------------------------
assign MipsMode_b_s2e = ~MipsMode_s2e;

//------------------------------------------------------------------------
//			---- FSM for IStall ----
//------------------------------------------------------------------------
// Assert IStall and IFetchStall when there is an ICache miss
// and leave them asserted until the cache is back in the right state
// (usually once the line has been fetched).
//
// IFetchStall_v2 goes low a cycle earlier than IStall_v2 so that
// instruction fetch logic (to generate mux & Kill signals, in
// IFetchControl.v) will be generated for the refetched instruction.
//
assign IStall_v2 = ~Reset_s2 & (ICacheMiss_v2r |
		    IStall_s2 & ~(PrevState_s2 == `CACHEHIT));
assign IFetchStall_v2 = ((ICacheMiss_v2r & PrevState_s2 == `CACHEHIT) |
		    (IFetchStall_s2 & PrevState_s2 != `REFETCH)) &
		    ~Reset_s2;

always @(Phi2 or IStall_v2 or IStall_s2 or IFetchStall_v2) begin
    if (Phi2) begin
	IStall_s1 = IStall_v2;
	IFetchStall_s1 = IFetchStall_v2;
    end
end

always @(Phi1 or IStall_s1 or IFetchStall_s1 or Except_s1w) begin
    if (Phi1) begin
	IStall_s2 = IStall_s1;
	IFetchStall_s2 = IFetchStall_s1;
    end
end

//------------------------------------------------------------------------
//			 ---- TLB Signals ----
//------------------------------------------------------------------------
// Latch signal ItlbMiss_v2e and hold until exception is raised
always @(Phi2 or ItlbMiss_v2e or ItlbMiss_s2 or Except_s2w or Reset_s2) begin
    if (Phi2)
	ItlbMiss_s1 = (ItlbMiss_v2e | ItlbMiss_s2) & ~Except_s2w &
			~Reset_s2;
end

always @(Phi1 or ItlbMiss_s1) begin
    if (Phi1)  ItlbMiss_s2 = ItlbMiss_s1;
end    

//---------------------------------------------------------------------------
//			 ---- Second Issue ----
//---------------------------------------------------------------------------
// NOTE: SecondIssue used to be dependent on ICacheMiss_v2r but I
// have removed it from the equation to prevent a critical path. It run
// on boosttest and bubble with icache empty.
//
// As long as no exceptional conditions exist (ICache miss, stall, or
// exception), a second issue of a packet can occur iff:
//    (1) packet is not odd target of a branch (already into "second" issue)
//    (2) not about to branch (i.e. not a dynamically nop'ed delay slot)
//    (3) not already doing second issue.
assign SecondIssueCond_s2r = ~PCOffset_s2r & IncPC_s2e & ~SecondIssue_s2e &
			    ~IFetchStall_s2 & ~Except_s2w;
//
// If the above conditions are met, a second cycle occurs if at least
// one dynamic nop bit is set in the instruction packet.
assign SecondIssue_s2r = (ADynamicBit_s2r | BDynamicBit_s2r) &
			    SecondIssueCond_s2r;

//----------------------------------------------------------------------------
//		Control Signals To the Outside World
//			-- not all of them ---
//---------------------------------------------------------------------------
//
// Assert Kill signals if exception occurs or reset is asserted.
//
// If neither reset or exception occurs, only assert them if in Torch mode
// and are not servicing an ICache miss.
// 
// Then, kill A side instruction if:
//     (1) doing first issue of a packet in which the A side instruction
//         is dyn. nop'ed
//     (2) packet is target of an odd target branch and neither A nor B
//         is dyn. nop'ed (so should only execute B side)
assign AKill_v2r = ~MipsMode_s2e & ~IFetchStall_s2 &
		    (ADynamicBit_s2r & ~PCOffset_s2r & ~SecondIssue_s2e |
		    PCOffset_s2r & ~ADynamicBit_s2r & ~BDynamicBit_s2r) |
		    Except_s2w | Reset_s2;
                                      
// Kill B side instruction if:
//      doing first issue of a packet in which the B side instruction
//      is dyn. nop'ed
assign BKill_v2r = ~MipsMode_s2e & ~IFetchStall_s2 &
		    BDynamicBit_s2r & ~PCOffset_s2r & ~SecondIssue_s2e |
		    Except_s2w | Reset_s2;

//
// Instruction sent to both sides if either ADrvB_s1e or BDrvA_s1e is asserted.
assign KillOne_s1e = ADrvB_s1e | BDrvA_s1e;
                                      
always @(Phi2 or AKill_v2r or BKill_v2r) begin
    if (Phi2) begin
	AKill_s1e = AKill_v2r;
	BKill_s1e = BKill_v2r;
    end
end


//----------------------------------------------------------------------------
//			---- Refill Section ----
//---------------------------------------------------------------------------

always @(Phi2 or ExtMuxSelect_v2 or LatchShiftReg_v2 or LatchDataReg_v2) begin
    if (Phi2) begin
	    ExtMuxSelect_s1  = ExtMuxSelect_v2;
	    LatchShiftReg_s1 = LatchShiftReg_v2;
	    LatchDataReg_s1  = LatchDataReg_v2;
    end
end

//------------------------------------------------------------------------
//                  Latches for State Machine
//		that controls the Refill Operation
//------------------------------------------------------------------------
// Determines state and generates controls for ICache refilling and stalling.
// Combinational logic to determine next state
// What should the FSM do in case of an Exception????

assign PresState_v2 = stateNS2(PrevState_s2, ICacheMiss_v2r, MipsMode_s2e,
			       ExtDataValid_s2, Reset_s2, ItlbMiss_s2,
			       L2Miss_s2, Except_s2w);

function [3:0] stateNS2;
    input [3:0] PrevState_s2;
    input	ICacheMiss_v2r;
    input	MipsMode_s2e;
    input	ExtDataValid_s2;
    input	Reset_s2;
    input	ItlbMiss_s2;
    input	L2Miss_s2;
    input	Except_s2w;
begin: _stateNS2
    if      (Reset_s2)	  stateNS2 = `CACHEHIT;
    else if (ItlbMiss_s2 &
             (PrevState_s2 != `REFETCH) & (PrevState_s2 != `CACHEHIT))
			  stateNS2 = `REFETCH;
    else if (L2Miss_s2)   stateNS2 = `WAITExtByte;
    else begin
      case (PrevState_s2)
	`CACHEHIT:
	    stateNS2 = (ICacheMiss_v2r == 1'b0) ? `CACHEHIT :
		       (MipsMode_s2e == 1'b0) ? `WAITExtByte : `WAITXfer0;
	`WAITExtByte:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `EXTBYTE : `WAITExtByte;
	`EXTBYTE:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER0 : `WAITXfer0;
	`WAITXfer0:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER0 : `WAITXfer0;
	`XFER0:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER1 : `WAITXfer1;
	`WAITXfer1:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER1 : `WAITXfer1;
	`XFER1:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER2 : `WAITXfer2;
	`WAITXfer2:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER2 : `WAITXfer2;
	`XFER2:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER3 : `WAITXfer3;
	`WAITXfer3:
	    stateNS2 = (ExtDataValid_s2 == 1'b1) ? `XFER3 : `WAITXfer3;
	`XFER3:
	    stateNS2 = `REFETCH;
	`REFETCH:
	    stateNS2 = `CACHEHIT;
	default:
	    stateNS2 = `CACHEHIT;
      endcase
    end
end
endfunction // stateNS2

//
// Calculate Output Control Signals
//
assign ExtMuxSelect_v2 = (PresState_v2 == `EXTBYTE);
assign LatchShiftReg_v2 = ((PresState_v2 == `EXTBYTE) |
	    (PresState_v2 == `XFER1) |
	    (PresState_v2 == `XFER2) | (PresState_v2 == `XFER3));
assign LatchDataReg_v2 =
	    ((PresState_v2 == `XFER0) | (PresState_v2 == `XFER1) |
	     (PresState_v2 == `XFER2) | (PresState_v2 == `XFER3));

assign LatchNonCachePkt_v1 = LatchDataReg_s1 &
				(PCPacketNum_s1r == PresState_s1[3:2]);

assign WriteCache_v1 =
	    ((PresState_s1 == `XFER0) | (PresState_s1 == `XFER1) |
	     (PresState_s1 == `XFER2) | (PresState_s1 == `XFER3)) &
	    ~NonCacheableHeld_s1;

assign ReadCache_v1i = (PresState_s1 == `CACHEHIT | PresState_s1 == `REFETCH) & ~NonCacheableHeld_s1;

assign WriteTag_s2 = (PrevState_s2 == `XFER3);

assign WritePack_s2[1] = (PrevState_s2 == `XFER2) | (PrevState_s2 == `XFER3);
assign WritePack_s2[0] = (PrevState_s2 == `XFER1) | (PrevState_s2 == `XFER3);

always @(Phi1 or PresState_s1 or MemStall_s1) begin
    if (Phi1 & ~MemStall_s1)  PrevState_s2 = PresState_s1;
end

always @(Phi2 or PresState_v2) begin
    if (Phi2)  PresState_s1 = PresState_v2;
end
//------------------------------------------------------------------------

//----------------------------------------------------------------------------
//		   ---- ICache Instruction Fetch ----
//----------------------------------------------------------------------------
//
// In Mips mode, drive A-side instruction onto B-side bus if at even address.
//
// In Torch mode, drive A onto B-side bus if:
//     (1) doing second issue and only A was dynamically nop'ed
//     (2) packet is target of an odd-target branch and only A is dyn. nop'ed
assign ADrvB_v1r = MipsMode_s1 & ~PCOffset_s1r |
		    ~MipsMode_s1 & (ADynamicBit_s1e & ~BDynamicBit_s1e &
				    SecondIssueCond_s1e |
				    ADynamicBit_v1r & ~BDynamicBit_v1r &
				    PCOffset_s1r);
//
// In Mips mode, drive B side instruction onto A side bus if at odd address.
//
// In Torch mode, drive B onto A-side bus if:
//     (1) doing second issue and only B was dynamically nop'ed
//     (2) packet is target of an odd-target branch and only B is dyn. nop'ed
assign BDrvA_v1r = MipsMode_s1 & PCOffset_s1r |
		    ~MipsMode_s1 & (BDynamicBit_s1e & ~ADynamicBit_s1e &
				    SecondIssueCond_s1e |
				    BDynamicBit_v1r & ~ADynamicBit_v1r &
				    PCOffset_s1r);

always @(Phi1 or ADrvB_v1r or BDrvA_v1r or ADynamicBit_v1r or
	BDynamicBit_v1r or MemStall_s1) begin
    if (Phi1 & ~MemStall_s1) begin
	ADrvB_s2r = ADrvB_v1r;
	BDrvA_s2r = BDrvA_v1r;
	ADynamicBit_s2r = ADynamicBit_v1r;
	BDynamicBit_s2r = BDynamicBit_v1r;
    end
end

always @(Phi1 or SecondIssue_s1e or Hold_s1e or MemStall_s1) begin
    if (Phi1 & ~MemStall_s1) begin
	
	Hold_s2e = Hold_s1e;
	SecondIssue_s2e = SecondIssue_s1e;
    end
end

always @(Phi2 or ADrvB_s2r or BDrvA_s2r
         or SecondIssue_s2r or SecondIssueCond_s2r
         or ADynamicBit_s2r or BDynamicBit_s2r
         or Hold_s2r) begin
    if (Phi2) begin
	ADrvB_s1e = ADrvB_s2r;
	BDrvA_s1e = BDrvA_s2r;
	SecondIssue_s1e = SecondIssue_s2r;
	SecondIssueCond_s1e = SecondIssueCond_s2r;
	ADynamicBit_s1e = ADynamicBit_s2r;
	BDynamicBit_s1e = BDynamicBit_s2r;
	Hold_s1e = Hold_s2r;
    end
end

always @(Phi2 or PCPacketNum_s2i) begin
    if (Phi2)  PCPacketNum_s1r = PCPacketNum_s2i;
end

//  these are simply renaming.  Can get rid of these if we want.
assign HoldPC_s2r = Hold_s2r;
assign LatchInstrs_s1r = (~Hold_s1e & ~SecondIssueMips_s1e) & ~IFetchStall_s1 & ~MemStall_s1;
assign LatchTags_s1r = ~MemStall_s1 & ReadCache_s1r;

//---------------------------------------------------------------------------
//			 --- ICACHE Control ---
//---------------------------------------------------------------------------
always @(Phi1 or ReadCache_v1i or ReadCache_s1r) begin
    if (Phi1) begin
	ReadCache_s2i = ReadCache_v1i;
	ReadCache_s2r = ReadCache_s1r;
    end
end

always @(Phi1 or WriteCache_v1) begin
    if (Phi1)  WriteCache_s2 = WriteCache_v1;
end

always @(Phi2 or ReadCache_s2i or SecondIssueMips_s2r or SecondIssue_s2e or
	IncPC_s2e) begin
    if (Phi2) begin
	ReadCache_s1r = ReadCache_s2i;
	SecondIssueMips_s1e = SecondIssueMips_s2r & IncPC_s2e;
    end
end

// WriteTag is generated in FSM section.
assign WriteData_s2 = (WriteCache_s2 & ~L2Miss_s2);
//
// Enable reading or writing of the ICACHE
//
assign SecondIssueMips_s2r = PCOffset_s2i & MipsMode_s2e &
			PrevState_s2 == `CACHEHIT;
assign DataEnable_s2 = WriteData_s2 | (ReadCache_s2i & (~SecondIssue_s2e & ~SecondIssueMips_s2r | ~IncPC_s2e));
assign TagEnable_s2 = WriteTag_s2 | (ReadCache_s2i & (~SecondIssue_s2e & ~SecondIssueMips_s2r | ~IncPC_s2e));

//----------------------------------------------------------------------------
//		      ---- Comparator Section ----
//----------------------------------------------------------------------------

always @(Phi1 or PCOffset_s1r or MemStall_s1) begin
    if (Phi1 & ~MemStall_s1)  PCOffset_s2r = PCOffset_s1r;
end

always @(Phi2 or PCOffset_s2i) begin
    if (Phi2)  PCOffset_s1r = PCOffset_s2i;
end

assign ICacheMiss_v2r = ~(ICacheLineValid_s2r & Match_v2r) &
			    ~Hold_s2e & ~NonCacheable_s2 & ~ItlbMiss_s2 &
			    ~Except_s2w & PrevState_s2 != `REFETCH;

//----------------------------------------------------------------------------
//		    ---- Non-Cacheable Section ----
//----------------------------------------------------------------------------

always @(Phi1 or LatchNonCachePkt_v1) begin
    if (Phi1 == 1'b1)  LatchNonCachePkt_s2 = LatchNonCachePkt_v1;
end

always @(Phi2 or NonCacheable_s2) begin
    if (Phi2 == 1'b1)  NonCacheableHeld_s1 = NonCacheable_s2;
end


// Hold NonCachable until phi2 of RF of fetched packet (to keep ICacheMiss
// from being asserted again for this packet)

always @(Phi1 or NonCacheable_s1 or NonCacheableHeld_s1 or IStall_s1 or
         Reset_s1) begin
    if (Phi1 == 1'b1) begin
	NonCacheable_s2 = NonCacheable_s1 | 
			    (NonCacheableHeld_s1 & IStall_s1 & ~Reset_s1);
    end
end

//----------------------------------------------------------------------------
//		   ---- PC Unit Control Signals ----
//----------------------------------------------------------------------------
// Stage exception signal
always @(Phi1 or Stall_s1 or Except_s1w) begin
    if (Phi1 & ~Stall_s1)  Except_s2w = Except_s1w;
end

//
// If takenBranch_s1e is late can generate this signal on following
// phase (just need to delay all the signals).
//
always @(Phi1 or Stall_s1 or ImmPC_s1e or RegPC_s1e or takenBranch_v1e) begin
    if (Phi1 & ~Stall_s1) begin
	IncPC_s2e = ~ImmPC_s1e & ~RegPC_s1e & ~takenBranch_v1e;
    end
end

assign RestoreIStallPC_s1 = IStall_s1 & ~IFetchStall_s1;

//
// Controls the latch for the first latch in the PC chain. Qualify with
// IStall to prevent overwriting the next PC during a stall
//
assign PCUnitPsi2_s2 = Phi2 & ~IStall_s2;

//
// Controls the PEC and EPCN latches. Should only open during an
// exception
//
assign latchEPC_s1w = Phi1 & Except_s1w;

//
// Hold instructions and PC if in Torch mode and will do second issue
// of a dynamically nop'ed packet.  Goes PCunit eventually.
// NOTE: The following signal used to be gated with ~MipsMode_s2e but I
// don't think that is necessary since there is no way that SecondIssue_s2r 
// could ever be asserted when in MipsMode. SecondIssue_s2r depends on the
// dynamic bits which should only be set in Torch mode.
//
assign Hold_s2r = SecondIssue_s2r;


//----------------------------------------------------------------------------
//		   ---- Branch Condition ----
//----------------------------------------------------------------------------
// Combine the decoded branch types with the appropriate condition from 
// the register file to determine whether the branch should be taken or not.
assign takenBranch_v1e =
	(BEQnext_s1e & SEqualsT_v1e) |
	(BNEnext_s1e & ~SEqualsT_v1e) |
	(BLEZnext_s1e & (SEqualsT_v1e | SIsNegative_v1e)) |
	(BGTZnext_s1e & ~SEqualsT_v1e & ~SIsNegative_v1e) |
	(BLTZnext_s1e & SIsNegative_v1e) |
	(BGEZnext_s1e & (SEqualsT_v1e | ~SIsNegative_v1e));

//
// The PC select is done with a two-level MUX structure. The first four
// signals control a large 4-1 MUX for the early PC's and the last
// controls a 2-1 MUX for the branch PC.
//
assign Jump0_s1e = ~Except_s1w & ~IStall_s1 & ~ImmPC_s1e & ~RegPC_s1e;
assign Jump1_s1e = ~Except_s1w & ~IStall_s1 & ImmPC_s1e;
assign Jump2_s1e = ~Except_s1w & ~IStall_s1 & RegPC_s1e;
assign Jump3_s1e =  Except_s1w & ~IStall_s1;
assign Jump4_s1e =  IStall_s1;
assign Jump5_v1e = (~Except_s1w & ~IStall_s1) & takenBranch_v1e;

//
// Keep branch information to generate commit on following cycle (done in
// instruction decoder)
//
always @(Phi1 or Stall_s1 or takenBranch_v1e or ImmPC_s1e or RegPC_s1e) begin
    if (Phi1 & ~Stall_s1)
	 TakenBranch_s2e = takenBranch_v1e;
end

//
// Check for Address Violations ----
// SystemBit_s2e is the Kernel/User bit (and is 0 if in kernel mode)
assign IAddrError_v2i = PC_bit31_s2i & SystemBit_s2e;

// rename these signals
assign HoldPC_s2e = Hold_s2e;

// PC Chain
always @(Phi1 or EPCSel_s1m or EPCNSel_s1m) begin
    if (Phi1) begin
	EPCSel_s2m = EPCSel_s1m;
	EPCNSel_s2m = EPCNSel_s1m;
    end
end
assign EPCBufEnable_s2m = Phi2 & (EPCSel_s2m | EPCNSel_s2m);
assign EPCMuxSel_s2m = EPCSel_s2m;


endmodule				  // IFetchControl
