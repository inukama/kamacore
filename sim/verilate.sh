echo VERILATING 1
verilator --cc ../src/kamacore_top.sv --relative-includes --top-module kamacore_top
echo VERILATING 2
verilator -Wall --trace -cc ../src/kamacore_top.sv -exe tb_kamacore_top.cpp --relative-includes --top-module kamacore_top
echo MAKE 
make -C obj_dir/ -f Vkamacore_top.mk Vkamacore_top
