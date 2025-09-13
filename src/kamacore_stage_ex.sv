///////////////////
// Execute stage //
///////////////////

module kamacore_stage_ex (
    input logic clk,
    input logic rst,
    kamacore_pipeline_stage pipeline_id_ex,
    kamacore_pipeline_stage pipeline_ex_mem,
    kamacore_forwarding_if forwarding_rs1,
    kamacore_forwarding_if forwarding_rs2,
    kamacore_forwarding_if forwarding_result
);
    // Arithmetic Logic Unit
    logic [CPU_WIDTH-1:0] alu_result;
    kamacore_alu alu(
        .source1(forwarding_rs1.data_forwarded),
        .source2(forwarding_rs2.data_forwarded),
        .instruction(pipeline_id_ex.instruction),
        .alu_result(alu_result)
    );

    // Stage buffer
    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_ex_mem.alu_result <= '0;
            pipeline_ex_mem.instruction <= '0;
            pipeline_ex_mem.control_signals <= '0;
        end else begin
            pipeline_ex_mem.alu_result <= alu_result;
            pipeline_ex_mem.instruction <= pipeline_id_ex.instruction;
            pipeline_ex_mem.control_signals <= pipeline_id_ex.control_signals;
        end
    end

    assign forwarding_rs1.data_original = pipeline_id_ex.rs1_data;
    assign forwarding_rs2.data_original = pipeline_id_ex.rs2_data;
    assign forwarding_result.a = pipeline_id_ex.instruction[11:7];
    assign forwarding_result.data_original = alu_result;    
endmodule
