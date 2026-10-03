`timescale 1ns/1ps

module tb_bin2gray;
    parameter PTR_WIDTH = 4;

    reg [PTR_WIDTH-1:0] bin;
    wire [PTR_WIDTH-1:0] gray;

    integer i;
    integer errors;

    bin2gray #(.PTR_WIDTH(PTR_WIDTH)) dut (
        .bin (bin),
        .gray (gray)
    );

    function [PTR_WIDTH-1:0] exp_gray;
        input [PTR_WIDTH-1:0] b;
        begin
            exp_gray = b ^ (b >> 1);
        end
    endfunction

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_bin2gray);
        errors = 0;

        for (i = 0; i < 16; i = i + 1) begin
            bin = i;
            #10;
            if (gray !== exp_gray(i)) begin
                $display("FAIL bin=%b gray=%b exp=%b", bin, gray, exp_gray(i));
                errors = errors + 1;
            end else begin
                $display("PASS bin=%2d %b -> gray %b", i, bin, gray);
            end
        end

        if (errors == 0) $display("=== ALL 16 CASES PASS ===");
        else            $display("=== FAILURES ===", errors);
        $finish;
    end
endmodule

