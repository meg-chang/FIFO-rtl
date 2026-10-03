TOP		= tb_bin2gray
RTL_DIR = ../rtl
TB_DIR = ../tb

wave.vcd: $(TB_DIR)/$(TOP).v $(RTL_DIR)/bin2gray.v
	iverilog -Wall -o sim.out $(TB_DIR)/$(TOP).v $(RTL_DIR)/bin2gray.v
	vvp sim.out

wave: wave.vcd
	gtkwave wave.vcd &

clean:
	rm -f sim.out wave.vcd

.PHONY: all wave clean
