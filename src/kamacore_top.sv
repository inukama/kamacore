`include "kamacore_datatypes.svh"
`include "kamacore_pipeline_stage.sv"
`include "kamacore_stage_if.sv"
`include "kamacore_stage_id.sv"
`include "kamacore_stage_ex.sv"
`include "kamacore_stage_mem.sv"
`include "kamacore_stage_wb.sv"
`include "kamacore_memory.sv"
`include "kamacore_register_file.sv"
`include "kamacore_alu.sv"
`include "kamacore_control_unit.sv"
`include "kamacore_forwarding_if.sv"
`include "kamacore_forwarding_unit.sv"

module kamacore_top(
    input logic clk,
    input logic rst
);
    logic writeback_rd_we;
    logic [REG_ADDR_WIDTH-1:0] writeback_rd_a;
    logic [CPU_WIDTH-1:0] writeback_rd_data;

    kamacore_pipeline_stage stage_if_id(clk, rst);
    kamacore_pipeline_stage stage_id_ex(clk, rst);
    kamacore_pipeline_stage stage_ex_mem(clk, rst);
    kamacore_pipeline_stage stage_mem_wb(clk, rst);

    kamacore_forwarding_if forwarding_id_rs1();
    kamacore_forwarding_if forwarding_id_rs2();
    kamacore_forwarding_if forwarding_ex_rs1();
    kamacore_forwarding_if forwarding_ex_rs2();
    kamacore_forwarding_if forwarding_ex_result();
    kamacore_forwarding_if forwarding_mem_result();
    kamacore_forwarding_if forwarding_wb_result();

    /* verilator lint_off PINCONNECTEMPTY */
    kamacore_stage_if stage_if(
        .clk(clk), .rst(rst),
        .branch_valid(),
        .pipeline_if_id(stage_if_id)
    );

    kamacore_stage_id stage_id(
        .clk(clk), .rst(rst),
        .pipeline_if_id(stage_if_id),
        .pipeline_id_ex(stage_id_ex),

        .writeback_rd_we(writeback_rd_we),
        .writeback_rd_a(writeback_rd_a),
        .writeback_rd_data(writeback_rd_data),

        .forwarding_rs1(forwarding_id_rs1),
        .forwarding_rs2(forwarding_id_rs2)
    );

    kamacore_stage_ex stage_ex(
        .clk(clk), .rst(rst),
        .pipeline_id_ex(stage_id_ex),
        .pipeline_ex_mem(stage_ex_mem),

        .forwarding_rs1(forwarding_ex_rs1),
        .forwarding_rs2(forwarding_ex_rs2),
        .forwarding_result(forwarding_ex_result)
    );

    kamacore_stage_mem stage_mem(
        .clk(clk), .rst(rst),
        .pipeline_ex_mem(stage_ex_mem),
        .pipeline_mem_wb(stage_mem_wb),

        .forwarding(forwarding_mem_result)
    );

    kamacore_stage_wb stage_wb(
        .clk(clk), .rst(rst),
        .pipeline_mem_wb(stage_mem_wb),

        .writeback_rd_we(writeback_rd_we),
        .writeback_rd_a(writeback_rd_a),
        .writeback_rd_data(writeback_rd_data),

        .forwarding(forwarding_wb_result)
    );
    /* verilator lint_on PINCONNECTEMPTY */

    kamacore_forwarding_unit forwarding_unit(
        .forwarding_id_rs1(forwarding_id_rs1),
        .forwarding_id_rs2(forwarding_id_rs2),
        .forwarding_ex_rs1(forwarding_ex_rs1),
        .forwarding_ex_rs2(forwarding_ex_rs2),
        .forwarding_ex_result(forwarding_ex_result),
        .forwarding_mem_result(forwarding_mem_result),
        .forwarding_wb_result(forwarding_wb_result)
    );

endmodule
