# never have both cells holding the token at the same time
AG ( ! ( ( C1.holdToken = myTRUE ) * ( C2.holdToken = myTRUE) ) );

# never have G1.P3 and G1.P2 holding the token;
# actually need a formula for each pair of procs...
AG ( ! ( ( P3.procState = lock ) * ( P2.procState = lock) ) );

# ensures liveness - needs fairness on the procs to pass
AG ( ( P3.procState = request ) -> AF ( P3.procState = lock) );
