/*
	This module takes a clock, a reset and with that displays an image on the VGA
	It needs to controll the VGA, uses a controller for getting the current pizel position
*/
module vga(input logic ref_clk, // 50 MHz clock from FPGA
			  input logic rst,
			  output logic vga_clk, // 25.175 MHz clock for VGA
		     output logic h_sync, v_sync, // Sync signals for resetting laser
		     output logic sync_b, blank_b, // To FPGA video DAC (_b = active low)
		     output logic [7:0] r, g, b); // ..
	// Positions
	logic [9:0] x, y;
	  
	// Clock divider converts the reference clock to a suitable VGA one, 50 to 25 MHz
	// Ideally it should be 25.175 MHz
	clock_divider clk_div(.clk_in(ref_clk),
								 .clk_out(vga_clk));
	
	// Works on timing signals (syncs) and position (x,y) updates
 	vga_controller vga_ctrl(.vga_clk(vga_clk),
									.h_sync(h_sync),
									.v_sync(v_sync),
									.sync_b(sync_b),
									.blank_b(blank_b), 
									.x(x),
									.y(y));
	
	// White screen, here is where the image logic goes..
	assign {r, g, b} = 24'hFF00FF;
endmodule




/*
	Clock divider
*/
module clock_divider #(parameter DIV=2)(
	input clk_in, 
	output logic clk_out
);
	logic [$clog2(DIV):0] counter = DIV-1;
	
	always @(posedge clk_in) begin
		if(counter < (DIV-1)) begin
			counter <= counter + 1;	
		end else begin
			counter <= 0;
		end
		clk_out <= (counter < (DIV/2))? 1'b1 : 1'b0;
	end
endmodule


/*
	This module is used to control the laser gun using sync signals and position
*/
module vga_controller #(parameter H_ACTIVE = 10'd640,
										    H_FP = 10'd16,
										    H_SYN = 10'd96,
										    H_BP = 10'd48,
										    H_MAX = H_ACTIVE + H_FP + H_SYN + H_BP,
										    V_BP = 10'd32,
										    V_ACTIVE = 10'd480,
										    V_FP = 10'd11,
										    V_SYN = 10'd2,
										    V_MAX = V_ACTIVE + V_FP + V_SYN + V_BP)
							  (input logic vga_clk,
							   output logic h_sync, v_sync, sync_b, blank_b,
								output logic [9:0] x, y);
	// Each clock cycle
	always @(posedge vga_clk) begin
		// Moves 1 pixel to the right
		x++;
		// If at last pixel
		if (x == H_MAX) begin
			// Resets to leftmost pixel
			x = 0;
			// Moves scanline 1 down
			y++;
			// If last scanline
			if (y == V_MAX) begin
				// Resets to uppermost scanline
				y = 0;
			end
		end
	end
	
	// The synchronizers are 0 when the laser is being moved back to initial position, active low
	assign sync_b = h_sync & v_sync;
	assign h_sync = ~((x >= H_ACTIVE + H_FP) & (x < H_ACTIVE + H_FP + H_SYN)); // Asserted when not it bounds of the sync section
	assign v_sync = ~((y >= V_ACTIVE + V_FP) & (y < V_ACTIVE + V_FP + V_SYN)); // ..

	// Turns off the laser gun when outside of active range, active low
	assign blank_b = (x < H_ACTIVE) & (y < V_ACTIVE); // Assert when position is inside active range
endmodule
