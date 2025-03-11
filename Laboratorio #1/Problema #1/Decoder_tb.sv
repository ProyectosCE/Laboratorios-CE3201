module Binario_a_BCD_tb();

		// Inputs
    logic [3:0] binary_input;
	 
	 logic [7:0] bcd_output;
	 
	 Binario_a_BCD modulo(binary_input, bcd_output);
	 
	 
	 initial begin
        // Initialize Inputs and display results
		  
		  //0
        binary_input = 4'b0000; #10;
		  
		  //1
        
        binary_input = 4'b0001; #10;
		  
		  //3

        binary_input = 4'b0011; #10;
        
		  //4
        binary_input = 4'b0100; #10;
		  
			//5
        binary_input = 4'b0101; #10;
        
			//7
        binary_input = 4'b0111; #10;
        
		  //9
        binary_input = 4'b1001; #10;
		  
        //10 o A
        binary_input = 4'b1010; #10;
		  
		  //13 O c
        binary_input = 4'b1101; #10;
		  
		  //15 O F
    
        binary_input = 4'b1111; #10;

    end

endmodule
