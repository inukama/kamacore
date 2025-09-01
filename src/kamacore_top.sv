`include "kamacore_pkg.sv"
`include "kamacore_pipeline_stage.sv"
`include "kamacore_stage_if.sv"
`include "kamacore_stage_id.sv"
`include "kamacore_stage_ex.sv"
`include "kamacore_stage_mem.sv"
`include "kamacore_stage_wb.sv"

import kamacore_pkg::*;

module kamacore_top(
    input clk,
    input rst,
    input hold
);
    logic [CPU_WIDTH-1:0] writeback_result;

    kamacore_pipeline_stage stage_if_id(clk, rst, hold);
    kamacore_pipeline_stage stage_id_ex(clk, rst, hold);
    kamacore_pipeline_stage stage_ex_mem(clk, rst, hold);
    kamacore_pipeline_stage stage_mem_wb(clk, rst, hold);

    /* verilator lint_off PINCONNECTEMPTY */
    kamacore_stage_if stage_if(
        .branch_valid(),
        .pipeline_if_id(stage_if_id)
    );

    kamacore_stage_id stage_id(
        .writeback_result(writeback_result),
        .pipeline_if_id(stage_if_id),
        .pipeline_id_ex(stage_id_ex)
    );

    kamacore_stage_ex stage_ex(
        .pipeline_id_ex(stage_id_ex),
        .pipeline_ex_id(stage_ex_mem)
    );

    kamacore_stage_mem stage_mem(
        .pipeline_ex_mem(stage_ex_mem),
        .pipeline_mem_wb(stage_mem_wb)
    );

    kamacore_stage_wb stage_wb(
        .pipeline_mem_wb(stage_mem_wb),
        .writeback_result(writeback_result)
    );
    /* verilator lint_on PINCONNECTEMPTY */

endmodule
