interface kamacore_pipeline_stage (
    input logic clk,
    input logic rst,
    input logic hold
);
    logic [CPU_WIDTH-1:0] data_memory_result;
    logic [CPU_WIDTH-1:0] instruction;
    logic [REG_ADDR_WIDTH-1:0] destination_register;
    logic [CPU_WIDTH-1:0] alu_result;
    logic [CPU_WIDTH-1:0] rs1_data;
    logic [CPU_WIDTH-1:0] rs2_data;
    logic control_memory_read;
    logic control_memory_write;
    logic control_write_rd;
    logic control_write_register;
    logic control_alu_use_immediate;
    st_control_signals control_signals;

    // TODO: Write functions and assertions for testing 

endinterface
