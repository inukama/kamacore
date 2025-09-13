////////////////////////
// Instruction Decode //
////////////////////////

module kamacore_stage_id (
    input logic clk,
    input logic rst,
    input logic writeback_rd_we,
    input logic [REG_ADDR_WIDTH-1:0] writeback_rd_a,
    input logic [CPU_WIDTH-1:0] writeback_rd_data,
    kamacore_pipeline_stage pipeline_if_id,
    kamacore_pipeline_stage pipeline_id_ex,
    kamacore_forwarding_if forwarding_rs1,
    kamacore_forwarding_if forwarding_rs2
);
    // Access register file
    kamacore_register_file register_file(
        .clk(clk),
        .rst(rst),

        .source1_a(forwarding_rs1.a),
        .source1_data(forwarding_rs1.data_original),

        .source2_a(forwarding_rs2.a),
        .source2_data(forwarding_rs2.data_original),

        .destination_we(writeback_rd_we),
        .destination_a(writeback_rd_a),
        .destination_data(writeback_rd_data)
    );

    // Generate control signals
    st_control_signals control_signals;
    kamacore_control_unit control_unit(
        .instruction(pipeline_if_id.instruction),
        .control_signals(control_signals)
    );
    
    // Stage buffer
    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_id_ex.instruction <= '0;
            pipeline_id_ex.rs1_data <= '0;
            pipeline_id_ex.rs2_data <= '0;
            pipeline_id_ex.control_signals <= '0;
        end else begin
            pipeline_id_ex.instruction <= pipeline_if_id.instruction;
            pipeline_id_ex.rs1_data <= forwarding_rs1.data_forwarded;
            pipeline_id_ex.rs2_data <= forwarding_rs2.data_forwarded;
            pipeline_id_ex.control_signals <= control_signals;
        end
    end

    assign forwarding_rs1.a = pipeline_if_id.instruction[19:15];
    assign forwarding_rs2.a = pipeline_if_id.instruction[24:20];
endmodule
