
module branching_unit(
    input [CPU_WIDTH-1:0] instruction,
    input [CPU_WIDTH-1:0] source_1,
    input [CPU_WIDTH-1:0] source_2,
    output branch_valid,
    output [CPU_WIDTH-1:0] branch_offset
);

    logic [6:0] opcode7 = instruction[6:0];
    logic [2:0] funct3 = instruction[14:12]; 

    assign branch_offset = {instruction[31:25], instruction[11:7]};

    always_comb begin
        case ({funct3, opcode7})
            {000, OPCODE_SB_TYPE}:  branch_valid = source1 == source2; // BEQ
            {001, OPCODE_SB_TYPE}:  branch_valid = source1 != source2; // BNE
            {100, OPCODE_SB_TYPE}:  branch_valid = signed'(source1) < signed'(source2); // BLT
            {101, OPCODE_SB_TYPE}:  branch_valid = signed'(source1) >= signed'(source2); // BGE
            {111, OPCODE_SB_TYPE}:  branch_valid = unsigned'(source1) < unsigned'(source2); // BLTU
            {111, OPCODE_SB_TYPE}:  branch_valid = unsigned'(source1) >= unsigned'(source2); // BGEU
            default: branch_valid = 0;
        endcase
    end
endmodule
