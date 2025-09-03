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
    kamacore_pipeline_stage pipeline_id_ex
);
    // Access register file



    logic [CPU_WIDTH-1:0] rs1_data;
    logic [CPU_WIDTH-1:0] rs2_data;
    kamacore_register_file register_file(
        .clk(clk),
        .rst(rst),

        .source1_a(pipeline_if_id.instruction[19:15]),
        .source1_data(rs1_data),

        .source2_a(pipeline_if_id.instruction[24:20]),
        .source2_data(rs2_data),

        .destination_we(writeback_rd_we),
        .destination_a(writeback_rd_a),
        .destination_data(writeback_rd_data)
    );

    // Generate control signals
    // Stage buffer

    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_id_ex.instruction <= '0;
            pipeline_id_ex.rs1_data <= '0;
            pipeline_id_ex.rs2_data <= '0;
        end else begin
            pipeline_id_ex.instruction <= pipeline_if_id.instruction;
            pipeline_id_ex.rs1_data <= rs1_data;
            pipeline_id_ex.rs2_data <= rs2_data;
        end
    end
endmodule
