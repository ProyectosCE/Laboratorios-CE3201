// Testbench para FSM_Game_Controller
`timescale 1ns / 1ps

module tb_FSM_Game_Controller;

    logic clk, rst, fsm_reset;
    logic valid_move_p1, valid_move_p2, timeout;
    logic win_flag;
    logic [1:0] winner_id;
    
    logic enable_input_p1, enable_input_p2;
    logic insert_piece_p1, insert_piece_p2;
    logic reset_timer, start_timer;
    logic check_win, write_status;
    logic [7:0] status;
    logic reset_board, reset_inputs;
    logic [1:0] turn;

    FSM_Game_Controller dut (
        .clk(clk),
        .rst(rst),
        .fsm_reset(fsm_reset),
        .valid_move_p1(valid_move_p1),
        .valid_move_p2(valid_move_p2),
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

    always #10 clk = ~clk;

    initial begin
        $display("Inicio del test para FSM_Game_Controller");

        // Inicialización
        clk = 0;
        rst = 1;
        fsm_reset = 0;
        valid_move_p1 = 0;
        valid_move_p2 = 0;
        timeout = 0;
        win_flag = 0;
        winner_id = 2'b00;

        // Reset global
        @(negedge clk);
        rst = 0;

        // Esperar entrada de jugador 1
        @(negedge clk);
        valid_move_p1 = 1;
        @(negedge clk);
        valid_move_p1 = 0;

        // Simular chequeo sin ganador aún
        @(negedge clk);
        win_flag = 0;
        @(negedge clk);

        // Jugador 2 juega
        valid_move_p2 = 1;
        @(negedge clk);
        valid_move_p2 = 0;

        // Simular victoria jugador 2
        win_flag = 1;
        winner_id = 2'b10;
        @(negedge clk);

        // FSM debe ir a PLAYER2_WINS
        @(negedge clk);
        $display("Estado: victoria jugador 2, status = 0x%0h", status);

        // Reset manual del juego
        fsm_reset = 1;
        @(negedge clk);
        fsm_reset = 0;

        $display("Fin del test.");
        $finish;
    end

endmodule
