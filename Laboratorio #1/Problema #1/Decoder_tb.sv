module Binario_a_BCD_tb();

		// Inputs
    logic [3:0] binary_input;
	 
	 logic [7:0] bcd_output;
	 
	 Binario_a_BCD modulo(binary_input, bcd_output);
	 
	 
	 initial begin
        // Initialize Inputs and display results
        binary_input = 4'b0000; #10;
        
        binary_input = 4'b0001; #10;

        binary_input = 4'b0010; #10;
        
        binary_input = 4'b0011; #10;
       
        binary_input = 4'b0100; #10;
        
        binary_input = 4'b0101; #10;
        
        binary_input = 4'b0110; #10;
        
        binary_input = 4'b0111; #10;

        binary_input = 4'b1000; #10;
    
        binary_input = 4'b1001; #10;

    end

endmodule
