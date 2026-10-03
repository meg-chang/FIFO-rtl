TOP     ?= tb_bin2gray
RTL_DIR := ../rtl
TB_DIR  := ../tb
RTL_SRC := $(wildcard $(RTL_DIR)/*.v)
VFLAGS  := -Wall -g2005

SIM_OUT := $(TOP).sim
VCD     := $(TOP).vcd

.DELETE_ON_ERROR:
.PHONY: all wave lint clean

all: $(VCD)

$(VCD): $(SIM_OUT)
	vvp $(SIM_OUT)
	@mv -f wave.vcd $@

$(SIM_OUT): $(TB_DIR)/$(TOP).v $(RTL_SRC)
	iverilog $(VFLAGS) -o $@ $^

wave: $(VCD)
	gtkwave $(VCD) &

lint:
	iverilog $(VFLAGS) -tnull $(TB_DIR)/$(TOP).v $(RTL_SRC)

clean:
	rm -f *.sim *.vcd sim.out
