// Módulo superior que integra todos los componentes del juego
module Topmodule (
    input  logic clk,
    input  logic rst,
    input  logic btn_confirm_p1,
    input  logic [2:0] switches_p1,
    input  logic fsm_reset,

    // SPI (Jugador 2)
    input  logic spi_clk,
    input  logic spi_mosi,
    input  logic spi_cs,

    // VGA
    output logic hsync,
    output logic vsync,
    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue,
    output logic vga_clk,   // VGA clock output
    output logic sync_b,    // Sync signal (active low)
    output logic blank_b,   // Blank signal (active low)

    // Display 7 segmentos
    output logic [6:0] seg
);

    // Señales internas
    logic [2:0] col_p1, col_p2;
    logic valid_p1, valid_p2;
    logic timeout, check_win, win_flag;
    logic [1:0] winner_id;
    logic [1:0] board [0:5][0:6];
    logic [3:0] seconds;
    logic [2:0] random_col;
    logic random_valid;
    logic [7:0] status;

    // FSM
    logic enable_input_p1, enable_input_p2;
    logic insert_piece_p1, insert_piece_p2;
    logic reset_timer, start_timer;
    logic write_status;
    logic reset_board, reset_inputs;
    logic [1:0] turn;

    // Jugador 1 - entrada local
    Player1_Input p1_input (
        .clk(clk), .rst(rst),
        .btn_confirm(btn_confirm_p1),
        .switches(switches_p1),
        .valid_move(valid_p1),
        .selected_col(col_p1)
    );

    // Jugador 2 - SPI
    Player2_Input p2_input (
        .clk(clk), .rst(rst),
        .spi_clk(spi_clk),
        .spi_mosi(spi_mosi),
        .spi_cs(spi_cs),
        .selected_col(col_p2),
        .valid_move(valid_p2)
    );

    // Temporizador
    Turn_Timer timer (
        .clk(clk), .rst(rst),
        .enable(start_timer),
        .reset_timer(reset_timer),
        .timeout(timeout),
        .count_seconds(seconds)
    );

    // Tablero
    Board_Manager board_logic (
        .clk(clk), .rst(rst | reset_board),
        .insert_en(insert_piece_p1 | insert_piece_p2),
        .player_id((insert_piece_p1) ? 2'b01 : 2'b10),
        .col_sel((insert_piece_p1) ? col_p1 : col_p2),
        .col_full(), // no usado directamente
        .board(board)
    );

    // Verificación de victoria
    Win_Checker win_check (
        .clk(clk), .rst(rst),
        .check_en(check_win),
        .board(board),
        .win_flag(win_flag),
        .winner_id(winner_id)
    );

    // Estado del sistema
    Status_Register status_reg (
        .clk(clk), .rst(rst),
        .write_en(write_status),
        .new_state(status),
        .current_state(status)
    );

    // Display 7 segmentos
    SevenSeg_Controller seg_disp (
        .clk(clk), .rst(rst),
        .seconds(seconds),
        .segments(seg)
    );

    // Controlador principal FSM
    FSM_Game_Controller fsm (
        .clk(clk), .rst(rst), .fsm_reset(fsm_reset),
        .valid_move_p1(valid_p1),
        .valid_move_p2(valid_p2),
        .timeout(timeout),
        .win_flag(win_flag),
        .winner_id(winner_id),
        .enable_input_p1(enable_input_p1),
        .enable_input_p2(enable_input_p2),
        .insert_piece_p1(insert_piece_p1),
        .insert_piece_p2(insert_piece_p2),
        .reset_timer(reset_timer),
        .start_timer(start_timer),
        .check_win(check_win),
        .write_status(write_status),
        .status(status),
        .reset_board(reset_board),
        .reset_inputs(reset_inputs),
        .turn(turn)
    );

    // VGA
    vga vga_inst (
        .ref_clk(clk), 
        .rst(rst),
        .board(board),// Tablero desde Board_Manager
        .player_selected(turn),      // Turno del jugador actual
        .column_selected(random_col), // Columna seleccionada (puede ser random o actual)
        .vga_clk(vga_clk),           // Connected to output
        .h_sync(hsync), 
        .v_sync(vsync),
        .sync_b(sync_b),             // Connected to output
        .blank_b(blank_b),           // Connected to output
        .r(red), 
        .g(green), 
        .b(blue)
    );

endmodule
