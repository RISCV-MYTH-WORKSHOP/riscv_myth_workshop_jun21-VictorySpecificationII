\m4_TLV_version 1d: tl-x.org
\SV
   `include "sqrt32.v";
   m4_makerchip_module
\TLV
   
   |calc
      
      // Pythagora's Theorem
      @1
         $err1 = $bad_input | $illegal_op;
      @2
         >>1$err2 = >>1$err1 | >>1$over_flow;
      @3
         >>2$err2
      @4
         >>2$err3 = >>1$err2 | >>2$div_by_zero;
      




   // Stop simulation.
   *passed = *cyc_cnt > 40;
\SV
endmodule
