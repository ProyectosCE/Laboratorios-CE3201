// Máquina de estados principal
// Controla el flujo completo del juego: turnos, tiempo, jugadas, victoria, empate
module FSM_Game_Controller (
    input  logic       clk,
    input  logic       rst,
    input  logic       fsm_reset,

    input  logic       valid_move_p1,
    input  logic       valid_move_p2,
    input  logic       timeout,
    input  logic       win_flag,
    input  logic [1:0] winner_id,

    output logic       enable_input_p1,
    output logic       enable_input_p2,
    output logic       insert_piece_p1,
    output logic       insert_piece_p2,
    output logic       reset_timer,
    output logic       start_timer,
    output logic       check_win,
    output logic       write_status,
    output logic [7:0] status,
    output logic       reset_board,
    output logic       reset_inputs,
    output logic [1:0] turn  // 1: jugador 1, 2: jugador 2
);

    typedef enum logic [3:0] {
        INIT_SCREEN      = 4'd0,
        PLAYER1_WAIT     = 4'd1,
        PLAYER1_PROCESS  = 4'd2,
        PLAYER2_WAIT     = 4'd3,
        PLAYER2_PROCESS  = 4'd4,
        CHECK_WINNER     = 4'd5,
        TIMEOUT_ERROR    = 4'd6,
        PLAYER1_WINS     = 4'd7,
        PLAYER2_WINS     = 4'd8,
        DRAW             = 4'd9,
        GAME_RESET       = 4'd10
    } state_t;

    state_t state, next_state;

    // Estado actual
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= INIT_SCREEN;
        else
            state <= next_state;
    end

    // Lógica de transición
    always_comb begin
        next_state = state;
        case (state)
            INIT_SCREEN:      next_state = PLAYER1_WAIT;

            PLAYER1_WAIT:
                if (timeout) next_state = TIMEOUT_ERROR;
                else if (valid_move_p1) next_state = PLAYER1_PROCESS;

            PLAYER1_PROCESS:  next_state = CHECK_WINNER;

            PLAYER2_WAIT:
                if (timeout) next_state = TIMEOUT_ERROR;
                else if (valid_move_p2) next_state = PLAYER2_PROCESS;

            PLAYER2_PROCESS:  next_state = CHECK_WINNER;

            CHECK_WINNER:
                if (win_flag && winner_id == 2'b01) next_state = PLAYER1_WINS;
                else if (win_flag && winner_id == 2'b10) next_state = PLAYER2_WINS;
                else if (!win_flag && fsm_reset) next_state = GAME_RESET;
                else next_state = (turn == 2'd1) ? PLAYER2_WAIT : PLAYER1_WAIT;

            TIMEOUT_ERROR:
                if (fsm_reset) next_state = GAME_RESET;

            PLAYER1_WINS:
                if (fsm_reset) next_state = GAME_RESET;

            PLAYER2_WINS:
                if (fsm_reset) next_state = GAME_RESET;

            DRAW:
                if (fsm_reset) next_state = GAME_RESET;

            GAME_RESET:
                next_state = INIT_SCREEN;
        endcase
    end

    // Lógica de salida
    always_comb begin
        // Por defecto todas las salidas están desactivadas
        enable_input_p1   = 0;
        enable_input_p2   = 0;
        insert_piece_p1   = 0;
        insert_piece_p2   = 0;
        reset_timer       = 0;
        start_timer       = 0;
        check_win         = 0;
        write_status      = 0;
        status            = 8'h00;
        reset_board       = 0;
        reset_inputs      = 0;
        turn              = 2'd0;

        case (state)
            INIT_SCREEN: begin
                // Nada activo. Pantalla inicial visible por default.
                status = 8'h00;
            end

            PLAYER1_WAIT: begin
                enable_input_p1 = 1;
                start_timer     = 1;
                turn            = 2'd1;
            end

            PLAYER1_PROCESS: begin
                insert_piece_p1 = 1;
                reset_timer     = 1;
            end

            PLAYER2_WAIT: begin
                enable_input_p2 = 1;
                start_timer     = 1;
                turn            = 2'd2;
            end

            PLAYER2_PROCESS: begin
                insert_piece_p2 = 1;
                reset_timer     = 1;
            end

            CHECK_WINNER: begin
                check_win = 1;
            end

            TIMEOUT_ERROR: begin
                write_status = 1;
                status       = 8'hFF;
            end

            PLAYER1_WINS: begin
                write_status = 1;
                status       = 8'h01;
            end

            PLAYER2_WINS: begin
                write_status = 1;
                status       = 8'h02;
            end

            DRAW: begin
                write_status = 1;
                status       = 8'h03;
            end

            GAME_RESET: begin
                reset_board  = 1;
                reset_timer  = 1;
                reset_inputs = 1;
            end
        endcase
    end

endmodule
