//////////////////
// Memory stage //
//////////////////

module kamacore_stage_mem (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_ex_mem, 
    kamacore_pipeline_stage pipeline_mem_wb
);
    logic [CPU_WIDTH-1:0] data_memory_result; 

    // Access unmapped SRAM data memory cache
    kamacore_memory data_memory(
        .clk(clk),
        .we(0), // TODO: Control signal
        .a(pipeline_ex_mem.alu_result),
        .dpra(0), // TODO: Can be used for something else
        .di(0), // TODO: source2
        .spo(data_memory_result),
        .dpo()
    );

    // Stage buffer
    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_mem_wb.alu_result <= '0;
            pipeline_mem_wb.instruction <= '0;
            pipeline_mem_wb.data_memory_result <= '0;
            pipeline_mem_wb.control_signals <= '0;
        end else begin
            pipeline_mem_wb.alu_result <= pipeline_ex_mem.alu_result;
            pipeline_mem_wb.instruction <= pipeline_ex_mem.instruction;
            pipeline_mem_wb.data_memory_result <= data_memory_result;
            pipeline_mem_wb.control_signals <= pipeline_ex_mem.control_signals;
        end
    end
endmodule
