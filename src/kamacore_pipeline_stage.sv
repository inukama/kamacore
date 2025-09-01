interface kamacore_pipeline_stage (
    input logic clk,
    input logic rst,
    input logic hold
);
    logic [CPU_WIDTH-1:0] data_memory_result;
    logic [CPU_WIDTH-1:0] instruction;
    logic [REG_ADDR_WIDTH-1:0] destination_register;
    logic [CPU_WIDTH-1:0] read_data_b;
    logic [CPU_WIDTH-1:0] ex_result;
    logic [CPU_WIDTH-1:0] data_a;
    logic [CPU_WIDTH-1:0] data_b;
    logic control_memory_read;
    logic control_memory_write;
    logic control_write_rd;
    logic control_write_register;
    logic control_alu_use_immediate;

    // TODO: Write functions and assertions for testing 

endinterface
