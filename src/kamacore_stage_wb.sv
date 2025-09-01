///////////////
// Writeback //
///////////////

module kamacore_stage_wb (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_mem_wb,
    input logic writeback_rd_we,
    input logic [CPU_WIDTH-1:0] writeback_rd_a,
    input logic [REG_ADDR_WIDTH-1:0] writeback_rd_data
);
    // Decide writeback result
endmodule
