#!/bin/env bash
SIM_FILES=$(find ../sim -name "*.v")
SRC_FILES=$(find ../src -name "*.v")

iverilog -o cpu.vvp $SIM_FILES $SRC_FILES -I ../src/
vvp cpu.vvp
