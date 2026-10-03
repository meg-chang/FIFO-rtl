`timescale 1ns/1ps

module tb_gray2bin;
    parameter PTR_WIDTH = 4;

    reg [PTR_WIDTH-1:0] gray;
    wire [PTR_WIDTH-1:0] bin;
    wire [PTR_WIDTH-1:0] gray_backs;

    integer i;
    integer errors;

    gray2bin #(.PTR_WIDTH(PTR_WIDTH)) dut (
        .gray(gray),
        .bin(bin)
    );

    bin2gray #(.PTR_WIDTH(PTR_WIDTH)) ref_enc (
        .bin(bin),
        .gray(gray_backs)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_gray2bin);
        errors = 0;

        for (i = 0; i < 16; i = i + 1) begin
            gray = i;
            #10;
            if (gray_backs !== gray) begin
                $display("FAIL gray=%b bin=%b back=%b", gray, bin, gray_backs);
                errors = errors + 1;
            end else begin
                $display("PASS gray=%b -> bin=%b", gray, bin);
            end
        end

        if (errors == 0) $display("=== GRAY2BIN ALL 16 CASES PASS ===");
        else             $display("=== %0d FAILURES ===", errors);
        $finish;
    end
endmodule
