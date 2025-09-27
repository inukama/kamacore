///////////////////////
// Instruction Fetch //
///////////////////////

module kamacore_stage_if (
    input logic clk,
    input logic rst,
    input logic branch_valid,
    kamacore_pipeline_stage pipeline_if_id
);
    // Program counter
    logic [CPU_WIDTH-1:0] instruction;
    logic [ADDR_WIDTH-1:0] program_counter;
    logic [ADDR_WIDTH-1:0] program_counter_next;

    logic [CPU_WIDTH-1:0] _dpo_out;
    // Access instruction memory
    kamacore_memory instruction_memory( // TODO: Turn into Von Neumann Architecture
        .clk(clk),
        .we(0),
        .a(program_counter),
        .dpra(program_counter), // TODO: Can be used for something else
        .di(0),
        .spo(instruction),
        .dpo(_dpo_out)
    );
    
    // Stage buffering
    always_ff @(posedge clk) begin
        if (~rst) begin
            pipeline_if_id.instruction <= '0;
            program_counter <= '0;
        end else begin
            pipeline_if_id.instruction <= instruction;
            program_counter <= program_counter_next;
        end
    end

    always_comb begin
        program_counter_next = program_counter + 1;
    end
endmodule
