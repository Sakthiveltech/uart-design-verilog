`timescale 1ns/1ps

module uart_tb;

    reg        clk;
    reg        rst;
    reg        tx_start;
    reg  [7:0] tx_data;
    wire       tx;
    wire       tx_busy;
    wire [7:0] rx_data;
    wire       rx_done;
    wire       parity_error;

    // DIVISOR=5 for fast simulation
    uart_top #(.DIVISOR(5)) uut (
        .clk          (clk),
        .rst          (rst),
        .tx_start     (tx_start),
        .tx_data      (tx_data),
        .tx           (tx),
        .tx_busy      (tx_busy),
        .rx           (tx),
        .rx_data      (rx_data),
        .rx_done      (rx_done),
        .parity_error (parity_error)
    );

    // 50MHz clock
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        $dumpfile("uart_dump.vcd");
        $dumpvars(0, uart_tb);

        // Initialize
        rst      = 1;
        tx_start = 0;
        tx_data  = 8'h00;

        // Hold reset
        #200;
        rst = 0;
        #200;

        // Send 0x55
        tx_data  = 8'h55;
        tx_start = 1;
        #20;
        tx_start = 0;
        #20000;   // Wait for full frame

        // Send 0xAA
        tx_data  = 8'hAA;
        tx_start = 1;
        #20;
        tx_start = 0;
        #20000;   // Wait for full frame

        // Send 0xA5
        tx_data  = 8'hA5;
        tx_start = 1;
        #20;
        tx_start = 0;
        #20000;   // Wait for full frame

        $finish;
    end

endmodule