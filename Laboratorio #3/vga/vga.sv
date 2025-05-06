// Constants for the board
package BoardConstants;
    // Dimensions
    parameter GRID_OFFSET_X = 140;              // Grid left margin
    parameter GRID_OFFSET_Y = 50;               // Grid top margin
    parameter CELL_WIDTH = 70;                  // Width of each cell
    parameter CELL_HEIGHT = 70;                 // Height of each cell
    parameter GRID_WIDTH = 7 * CELL_WIDTH;      // Total grid width for 7 columns
    parameter GRID_HEIGHT = 6 * CELL_HEIGHT;    // Total grid height for 6 rows
    parameter CIRCLE_RADIUS = 25;               // Radius of the game pieces
    
    // Player labels
    parameter P1_LABEL_X = 20;      // X position for P1 label
    parameter P1_LABEL_Y = 100;     // Y position for P1 label
    parameter P2_LABEL_X = 20;      // X position for P2 label
    parameter P2_LABEL_Y = 300;     // Y position for P2 label
    parameter LABEL_WIDTH = 70;     // Width of label
    parameter LABEL_HEIGHT = 60;    // Height of label

    // Select indicator
    parameter COL_SELECT_OFFSET_Y = 10; // Y position for column selector
    parameter P_SELECT_OFFSET_X = 110;  // X position for player selector
    
    // Colors
    parameter GRID_COLOR = 24'h4040FF;   // Blue color for grid
    parameter BG_COLOR = 24'h000080;     // Dark blue background
    parameter P1_COLOR = 24'hFF0000;     // Red for Player 1
    parameter P2_COLOR = 24'hFFFF00;     // Yellow for Player 2
    parameter WINNER_COLOR = 24'h00FF00; // Green highlight for winner
    parameter SELECT_COLOR = 24'hD10CF2; // Pink color for selection
endpackage


// This module takes a clock, a reset and with that displays an image on the VGA
// It needs to controll the VGA, uses a controller for getting the current pizel position
module vga(
    input logic ref_clk, // 50 MHz clock from FPGA
    input logic rst,
    output logic vga_clk, // 25.175 MHz clock for VGA
    output logic h_sync, v_sync, // Sync signals for resetting laser
    output logic sync_b, blank_b, // To FPGA video DAC (_b = active low)
    output logic [7:0] r, g, b); // ..
    
    // Positions
    logic [9:0] x, y;
      
    // Clock divider converts the reference clock to a suitable VGA one, 50 to 25 MHz, ideally it should be 25.175 MHz
    clock_divider clk_div(
        .clk_in(ref_clk),
        .clk_out(vga_clk));
    
    // Works on timing signals (syncs) and position (x,y) updates
    vga_controller vga_ctrl(
        .vga_clk(vga_clk),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .sync_b(sync_b),
        .blank_b(blank_b), 
        .x(x),
        .y(y));
    
    // Selects a color based on the pixel position
    board_drawer brd_drwr(
        .x(x),
        .y(y),
        .blank_b(blank_b),
        .pixel_color({r, g, b})
    ); 
endmodule


/*
    Clock divider for getting a VGA compatible clock
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
    Used to control the laser gun using sync signals and position
*/
module vga_controller #(
    parameter H_ACTIVE = 10'd640,
    H_FP = 10'd16,
    H_SYN = 10'd96,
    H_BP = 10'd48,
    H_MAX = H_ACTIVE + H_FP + H_SYN + H_BP,
    V_BP = 10'd32,
    V_ACTIVE = 10'd480,
    V_FP = 10'd11,
    V_SYN = 10'd2,
    V_MAX = V_ACTIVE + V_FP + V_SYN + V_BP)(
    input logic vga_clk,
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


/*
    Board initializer, used for testing without actual board data
*/
module board_init(output logic [1:0] board [0:5][0:6]);
    initial begin
        // Row 5 (lowest)
        board[5][0] = 2'b01; // P1
        board[5][1] = 2'b10; // P2
        board[5][2] = 2'b01; // P1
        board[5][3] = 2'b11; // P2 - w
        board[5][4] = 2'b01; // P1
        board[5][5] = 2'b10; // P2
        board[5][6] = 2'b01; // P1
        
        // Row 4
        board[4][0] = 2'b10; // P2
        board[4][1] = 2'b01; // P1
        board[4][2] = 2'b11; // P2 - w
        board[4][3] = 2'b01; // P1
        board[4][4] = 2'b00; // Empty
        board[4][5] = 2'b00; // ..
        board[4][6] = 2'b00; // ..
        
        // Row 3
        board[3][0] = 2'b01; // P1
        board[3][1] = 2'b11; // P2 - w
        board[3][2] = 2'b00; // Empty
        board[3][3] = 2'b00; // ..
        board[3][4] = 2'b00; // ..
        board[3][5] = 2'b00; // ..
        board[3][6] = 2'b00; // ..
        
        // Row 2
        board[2][0] = 2'b11; // P2 - w
        board[2][1] = 2'b00; // Empty
        board[2][2] = 2'b00; // ..
        board[2][3] = 2'b00; // ..
        board[2][4] = 2'b00; // ..
        board[2][5] = 2'b00; // ..
        board[2][6] = 2'b00; // ..
        
        // Row 1
        board[1][0] = 2'b00; // Empty
        board[1][1] = 2'b00; // ..
        board[1][2] = 2'b00; // ..
        board[1][3] = 2'b00; // ..
        board[1][4] = 2'b00; // ..
        board[1][5] = 2'b00; // ..
        board[1][6] = 2'b00; // ..
        
        // Row 0 (highest)
        board[0][0] = 2'b00; // Empty
        board[0][1] = 2'b00; // ..
        board[0][2] = 2'b00; // ..
        board[0][3] = 2'b00; // ..
        board[0][4] = 2'b00; // ..
        board[0][5] = 2'b00; // ..
        board[0][6] = 2'b00; // ..
    end
endmodule

/*
    Based on a position on the screen determines if the pixel is in grid, grid border or in the circle inside a cell
*/
module grid_calculator(
    input logic [9:0] x, y,
    output logic [2:0] col, row,
    output logic in_grid_area, is_grid_border, in_circle
);
    import BoardConstants::*;

    // For relative position in the cell
    logic [9:0] rel_x, rel_y;

    // Determine if the current pixel is within the grid area
    assign in_grid_area = (x >= GRID_OFFSET_X && x < GRID_OFFSET_X + GRID_WIDTH &&
                           y >= GRID_OFFSET_Y && y < GRID_OFFSET_Y + GRID_HEIGHT);
    
    // If the current pixel is the grid calculates the column and row in which it is located
    // and gets the relative position in the cell in which it is located
    always_comb begin
        if (in_grid_area) begin
            col = (x - GRID_OFFSET_X) / CELL_WIDTH;
            row = (y - GRID_OFFSET_Y) / CELL_HEIGHT;
            rel_x = x - GRID_OFFSET_X - col * CELL_WIDTH;
            rel_y = y - GRID_OFFSET_Y - row * CELL_HEIGHT;
        end else begin
            col = 0;
            row = 0;
            rel_x = 0;
            rel_y = 0;
        end
    end
    
    // If the pixel on the cell is in the first five top or left pixels it is a border pixel
     // Only the left and top borders are drawn, the cell pattern repeats itself and gives the ilusion of a bigger border
    assign is_grid_border = (rel_x < 5) || (rel_y < 5);
    
    // Variables to check if a pixel is within a circle
    logic [9:0] center_x, center_y;
    logic [19:0] dx, dy, distance_squared;
    
    // Determine if the pixel is inside the circle
    always_comb begin
        // Center of cell
        center_x = CELL_WIDTH/2;
        center_y = CELL_HEIGHT/2;
        
        if (in_grid_area) begin
            // Distance from center (squared)
            dx = (rel_x > center_x) ? (rel_x - center_x) : (center_x - rel_x);
            dy = (rel_y > center_y) ? (rel_y - center_y) : (center_y - rel_y);
            distance_squared = dx*dx + dy*dy;
            
            // Check if inside circle
            in_circle = (distance_squared <= CIRCLE_RADIUS*CIRCLE_RADIUS);
        end else begin
            dx = 0;
            dy = 0;
            distance_squared = 0;
            in_circle = 0;
        end
    end
endmodule


/*
    Based on a position determines if the pixel is part of a player label
*/
module player_labels_calculator(
    input logic [9:0] x, y,
    output logic in_p1_label, in_p2_label);
    
    import BoardConstants::*;

    // Relative positions inside the players labels
    logic [9:0] rel_x_p1, rel_y_p1;
    logic [9:0] rel_x_p2, rel_y_p2;

    // Determine if current pixel is within the P1 label area
    assign in_p1_label_area = (x >= P1_LABEL_X && x < P1_LABEL_X + LABEL_WIDTH &&
                               y >= P1_LABEL_Y && y < P1_LABEL_Y + LABEL_HEIGHT);
    
    // Determine if current pixel is within the P2 label area
    assign in_p2_label_area = (x >= P2_LABEL_X && x < P2_LABEL_X + LABEL_WIDTH &&
                               y >= P2_LABEL_Y && y < P2_LABEL_Y + LABEL_HEIGHT);

    // Calculate relative positions within each label
    always_comb begin
        rel_x_p1 = x - P1_LABEL_X;
        rel_y_p1 = y - P1_LABEL_Y;
        rel_x_p2 = x - P2_LABEL_X;
        rel_y_p2 = y - P2_LABEL_Y;
    end

    // Checks if a pixel is on P label
    function logic is_p_pixel(input logic [9:0] rel_x, rel_y);
        logic result;
        // "P" drawing
        if (rel_x >= 0 && rel_x <= 5) 
            result = 1; // Vertical line
        else if ((rel_x >= 5 && rel_x <= 20) && (rel_y >= 0 && rel_y <= 20)) begin 
            if ((rel_x >= 5 && rel_x <= 15) && (rel_y >= 5 && rel_y <= 15))
                result = 0; // Hollow section on the top
            else
                result = 1; // Top
            end
        else
            result = 0;
        return result;
    endfunction
    
    // Checks if a pixel is on 1 label
    function logic is_1_pixel(input logic [9:0] rel_x, rel_y);
        logic result;
        // "1" drawing
        if (rel_x >= 35 && rel_x <= 40)
            result = 1; // Vertical line
        else if ((rel_y >= 55 && rel_y <= 60) && (rel_x >= 25 && rel_x <= 50))
            result = 1; // Base
        else if ((rel_y >= 0 && rel_y <= 5) && (rel_x >= 30 && rel_x <= 35))
            result = 1; // Angled top
        else
            result = 0;
        return result;
    endfunction
    
    // Checks if a pixel is on 2 label
    function logic is_2_pixel(input logic [9:0] rel_x, rel_y);
        logic result;
        // "2" drawing
        if ((rel_y >= 0 && rel_y <= 5) && (rel_x >= 25 && rel_x <= 50))
            result = 1; // Top horizontal
        else if ((rel_y >= 30 && rel_y <= 35) && (rel_x >= 25 && rel_x <= 50))
            result = 1; // Middle horizontal
        else if ((rel_y >= 55 && rel_y <= 60) && (rel_x >= 25 && rel_x <= 50))
            result = 1; // Bottom horizontal
        else if ((rel_y >= 0 && rel_y <= 30) && (rel_x >= 45 && rel_x <= 50))
            result = 1; // Top-right vertical
        else if ((rel_y >= 35 && rel_y <= 55) && (rel_x >= 25 && rel_x <= 30))
            result = 1; // Bottom-left vertical
        else
            result = 0;
        return result;
    endfunction

    // Determines if the pixel is part of any label using the previous functions
    always_comb begin
        if (in_p1_label_area) begin
            if (is_p_pixel(rel_x_p1, rel_y_p1)) begin
                in_p1_label = 1;
                in_p2_label = 0;    
            end
            else if (is_1_pixel(rel_x_p1, rel_y_p1)) begin
                in_p1_label = 1;
                in_p2_label = 0;
            end
            else begin
                in_p1_label = 0;
                in_p2_label = 0;
            end
        end else if (in_p2_label_area) begin
            if (is_p_pixel(rel_x_p2, rel_y_p2)) begin
                in_p2_label = 1;
                in_p1_label = 0;
            end
            else if (is_2_pixel(rel_x_p2, rel_y_p2)) begin
                in_p2_label = 1;
                in_p1_label = 0;
            end
            else begin
                in_p2_label = 0;
                in_p1_label = 0;
            end
        end else begin
            in_p1_label = 0;
            in_p2_label = 0;
        end
    end
endmodule

/*
    Selects the color of a pixel based on what type of pixel it is and board data
    Border, grid, label, selector, etc..
*/
module pixel_drawer(
    input logic blank_b,
    input logic [2:0] row, col,
    input logic in_grid_area, is_grid_border, in_circle,
    input logic in_p1_label, in_p2_label,
    input logic [1:0] board [0:5][0:6],
    output logic [23:0] pixel_color
);
    import BoardConstants::*;
    
    // Choose color based on board state and position
    always_comb begin
        if (!blank_b) begin
            // Outside of active display area
            pixel_color = 24'h000000; // Black
        end else if (in_p1_label) begin
            // P1 label
            pixel_color = P1_COLOR;
        end else if (in_p2_label) begin
            // P2 label
            pixel_color = P2_COLOR;
        end else if (in_grid_area) begin
            if (is_grid_border) begin
                // Grid lines
                pixel_color = GRID_COLOR;
            end else if (in_circle) begin
                // Inside a circle - check board state
                case (board[row][col])
                    2'b00: pixel_color = BG_COLOR;     // Empty cell
                    2'b01: pixel_color = P1_COLOR;     // Player 1
                    2'b10: pixel_color = P2_COLOR;     // Player 2
                    2'b11: pixel_color = WINNER_COLOR; // Winner highlight
                    default: pixel_color = BG_COLOR;
                endcase
            end else begin
                // Background of cell
                pixel_color = BG_COLOR;
            end
        end else begin
            // Outside grid area
            pixel_color = 24'h000000; // Black
        end
    end
endmodule

module board_drawer(input logic [9:0] x, y,
                    input logic blank_b,
                    output [23:0] pixel_color);

    // Import constants
    import BoardConstants::*;
    
    logic [1:0] board [0:5][0:6];
    logic [2:0] col, row;
    logic in_grid_area, is_grid_border, in_circle;
    logic in_p1_label, in_p2_label;

    // Initialize board with example pattern
    board_init board_initializer(
        .board(board)
    );
    
    // Checks if pixel is on grid
    grid_calculator grid(
        .x(x),
        .y(y),
        .col(col),
        .row(row),
        .in_grid_area(in_grid_area),
        .is_grid_border(is_grid_border),
        .in_circle(in_circle)
    );
    
    // Checks if pixel is on player labels
    player_labels_calculator labels(
            .x(x),
            .y(y),
            .in_p1_label(in_p1_label),
            .in_p2_label(in_p2_label)
    );
    
    // Colors pixel
    pixel_drawer drawer(
        .blank_b(blank_b),
        .row(row),
        .col(col),
        .in_grid_area(in_grid_area),
        .is_grid_border(is_grid_border),
        .in_circle(in_circle),
        .in_p1_label(in_p1_label),
        .in_p2_label(in_p2_label),
        .board(board),
        .pixel_color(pixel_color)
    );
endmodule