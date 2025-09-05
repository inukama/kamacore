SRC_DIR = ../src
TOP_MODULE = kamacore_top

run:
	./obj_dir/Vkamacore_top	

view:
	gtkwave waveform.vcd

full:
	echo VERILATING 1
	verilator --cc ../src/kamacore_top.sv --relative-includes --top-module kamacore_top
	echo VERILATING 2
	verilator -Wall --trace -cc ../src/kamacore_top.sv -exe tb_kamacore_top.cpp --relative-includes --top-module kamacore_top
	echo MAKE 
	make -C obj_dir/ -f Vkamacore_top.mk Vkamacore_top

full_nowarn:
	echo VERILATING 1
	-verilator --cc ../src/kamacore_top.sv --relative-includes --top-module kamacore_top
	echo VERILATING 2
	-verilator -Wall --trace -cc ../src/kamacore_top.sv -exe tb_kamacore_top.cpp --relative-includes --top-module kamacore_top
	echo MAKE 
	make -C obj_dir/ -f Vkamacore_top.mk Vkamacore_top

lint:
	verilator --lint-only $(SRC_DIR)/$(TOP_MODULE).sv -Wall --relative-includes --top-module $(TOP_MODULE)

lint_nowarn:
	verilator --lint-only $(SRC_DIR)/$(TOP_MODULE).sv --relative-includes --top-module $(TOP_MODULE)
