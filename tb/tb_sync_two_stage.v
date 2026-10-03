`timescale 1ns/1ps

module tb_sync_two_stage;
    parameter WIDTH = 5;

    reg             clk;
    reg             rst_n;
    reg [WIDTH-1:0] din;
    wire [WIDTH-1:0] dout;

    integer errors;

    sync_two_stage #(.WIDTH(WIDTH)) dut(
        .rclk(clk),
        .rrst_n(rst_n),
        .din(din),
        .dout(dout)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_sync_two_stage);
        errors = 0;
        clk    = 1'b0;
        rst_n  = 1'b0;
        din    = {WIDTH{1'b0}};

        #12 rst_n = 1'b1;

        din = 5'b10101;
        #10; expect({WIDTH{1'b0}});
        #10; expect(5'b10101);

        din = 5'b01010;
        #10; expect(5'b10101);
        #10; expect(5'b01010);

        if (errors == 0) $display("=== SYNC ALL PASS ===");
        else             $display("=== %0d FAILURES ===", errors);
        $finish;
    end

    task expect;
        input [WIDTH-1:0] exp;
        begin
            if (dout !== exp) begin
                $display("FAIL t=%0t dout=%b exp=%b", $time, dout, exp);
                errors = errors + 1;
            end else begin
                $display("PASS t=%0t dout=%b", $time, dout);
            end
        end
    endtask
endmodule
