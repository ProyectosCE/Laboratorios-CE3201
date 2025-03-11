module RestadorParametrizadoN_tb();

    // Inputs
    logic [5:0] data_in;
    logic clk;
    logic btn_sub;
    logic rst;

    // Outputs
    logic [5:0] data_out;

    // Instancia del módulo RestadorParametrizadoN
    RestadorParametrizableN modulo(data_in, clk, btn_sub, rst, data_out);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Test sequence
    initial begin
        // Initialize Inputs and display results

        // Test for number 25
        data_in = 6'd25; rst = 1; #10; rst = 0; #10;
        $display("Initial value: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        rst = 1; #10; rst = 0; #10;
        $display("Value after reset: %d", data_out);

        // Test for number 3
        data_in = 6'd3; rst = 1; #10; rst = 0; #10;
        $display("Initial value: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        rst = 1; #10; rst = 0; #10;
        $display("Value after reset: %d", data_out);

        // Test for number 12
        data_in = 6'd12; rst = 1; #10; rst = 0; #10;
        $display("Initial value: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        rst = 1; #10; rst = 0; #10;
        $display("Value after reset: %d", data_out);

        // Test for number 54
        data_in = 6'd54; rst = 1; #10; rst = 0; #10;
        $display("Initial value: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        btn_sub = 1; #10; btn_sub = 0; #10;
        $display("Value after subtraction: %d", data_out);
        rst = 1; #10; rst = 0; #10;
        $display("Value after reset: %d", data_out);
    end

endmodule