//////////////////
// Memory stage //
//////////////////

module kamacore_stage_mem (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_ex_mem, 
    kamacore_pipeline_stage pipeline_mem_wb,
    kamacore_forwarding_if forwarding
);
    logic [CPU_WIDTH-1:0] data_memory_result; 

    logic [CPU_WIDTH-1:0] _dpo_out;
    // Access unmapped SRAM data memory cache
    kamacore_memory data_memory( // TODO: Turn into von-neumann architecture
        .clk(clk),
        .we(0), // TODO: Control signal
        .a(pipeline_ex_mem.alu_result),
        .dpra(0), // TODO: Can be used for something else
        .di(0), // TODO: source2
        .spo(data_memory_result),
        .dpo(_dpo_out)
    );

    // Stage buffer
    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_mem_wb.end_result <= '0;
            pipeline_mem_wb.instruction <= '0;
            pipeline_mem_wb.data_memory_result <= '0;
            pipeline_mem_wb.control_signals <= '0;
        end else begin
            pipeline_mem_wb.end_result <= pipeline_ex_mem.alu_result;
            pipeline_mem_wb.instruction <= pipeline_ex_mem.instruction;
            pipeline_mem_wb.data_memory_result <= data_memory_result;
            pipeline_mem_wb.control_signals <= pipeline_ex_mem.control_signals;
        end
    end

    // TODO: Make this based on data mem result or alu depending on instruction
    assign forwarding.data_original = pipeline_ex_mem.alu_result;
    assign forwarding.we = pipeline_ex_mem.control_signals.rd_we;
    assign forwarding.a = pipeline_ex_mem.instruction[11:7];
endmodule
