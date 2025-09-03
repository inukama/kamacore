///////////////////
// Execute stage //
///////////////////

module kamacore_stage_ex (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_id_ex,
    kamacore_pipeline_stage pipeline_ex_mem
);
    // Arithmetic Logic Unit
    logic [CPU_WIDTH-1:0] alu_result;
    kamacore_alu alu(
        .source1(pipeline_id_ex.rs1_data),
        .source2(pipeline_id_ex.rs2_data),
        .imm32i(),
        .imm32u(),
        .instruction(pipeline_id_ex.instruction),
        .alu_result(alu_result)
    );

    // Stage buffer
    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_ex_mem.alu_result <= '0;
            pipeline_ex_mem.instruction <= '0;
        end else begin
            pipeline_ex_mem.alu_result <= alu_result;
            pipeline_ex_mem.instruction <= pipeline_id_ex.instruction;
        end
    end
endmodule
