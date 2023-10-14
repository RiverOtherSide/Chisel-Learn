SOURCE = gcd.v
TARGET = gcd.vcd

$(TARGET) : $(SOURCE)
	iverilog -o $(TARGET)  $(SOURCE)
	vvp $(TARGET)
	rm $(TARGET)

 save:$(TARGET)
	iverilog -o $(TARGET)  $(SOURCE)
	vvp $(TARGET)

 vvp:$(TARGET)
	vvp $(TARGET)

clean:
	rm $(TARGET)