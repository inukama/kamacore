`include "kamacore_datatypes.svh"
`include "kamacore_pipeline_stage.sv"
`include "kamacore_stage_if.sv"
`include "kamacore_stage_id.sv"
`include "kamacore_stage_ex.sv"
`include "kamacore_stage_mem.sv"
`include "kamacore_stage_wb.sv"
`include "kamacore_memory.sv"
`include "kamacore_register_file.sv"

module kamacore_top(
    input logic clk,
    input logic rst
);
    logic writeback_rd_we;
    logic [CPU_WIDTH-1:0] writeback_rd_a;
    logic [REG_ADDR_WIDTH-1:0] writeback_rd_data;

    kamacore_pipeline_stage stage_if_id(clk, rst);
    kamacore_pipeline_stage stage_id_ex(clk, rst);
    kamacore_pipeline_stage stage_ex_mem(clk, rst);
    kamacore_pipeline_stage stage_mem_wb(clk, rst);

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
        .writeback_rd_data(writeback_rd_data)
    );

    kamacore_stage_ex stage_ex(
        .clk(clk), .rst(rst),
        .pipeline_id_ex(stage_id_ex),
        .pipeline_ex_id(stage_ex_mem)
    );

    kamacore_stage_mem stage_mem(
        .clk(clk), .rst(rst),
        .pipeline_ex_mem(stage_ex_mem),
        .pipeline_mem_wb(stage_mem_wb)
    );

    kamacore_stage_wb stage_wb(
        .clk(clk), .rst(rst),
        .pipeline_mem_wb(stage_mem_wb),

        .writeback_rd_we(writeback_rd_we),
        .writeback_rd_a(writeback_rd_a),
        .writeback_rd_data(writeback_rd_data)
    );
    /* verilator lint_on PINCONNECTEMPTY */

endmodule
