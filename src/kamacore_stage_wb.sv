///////////////
// Writeback //
///////////////

module kamacore_stage_wb (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_mem_wb,
    kamacore_forwarding_if forwarding,

    output logic writeback_rd_we,
    output logic [REG_ADDR_WIDTH-1:0] writeback_rd_a,
    output logic [CPU_WIDTH-1:0] writeback_rd_data
);

    // Decide writeback result
    // TODO: get rid of this redundant code. The forwarding stuff is the same as the writeback stuff
    assign writeback_rd_we = pipeline_mem_wb.control_signals.rd_we;
    assign writeback_rd_data = pipeline_mem_wb.end_result; 
    assign writeback_rd_a = pipeline_mem_wb.instruction[11:7];

    assign forwarding.data_original = pipeline_mem_wb.end_result;
    assign forwarding.we = pipeline_mem_wb.control_signals.rd_we;
    assign forwarding.a = pipeline_mem_wb.instruction[11:7];
endmodule
