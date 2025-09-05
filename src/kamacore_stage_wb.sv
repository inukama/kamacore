///////////////
// Writeback //
///////////////

module kamacore_stage_wb (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_mem_wb,
    output logic writeback_rd_we,
    output logic [REG_ADDR_WIDTH-1:0] writeback_rd_a,
    output logic [CPU_WIDTH-1:0] writeback_rd_data
);
    // Decide writeback result
    assign writeback_rd_we = pipeline_mem_wb.control_signals.rd_we;
    assign writeback_rd_data = pipeline_mem_wb.alu_result; // TODO: Make this based on data mem result or alu depending on instruction
    assign writeback_rd_a = pipeline_mem_wb.instruction[11:7];
endmodule
