
module kamacore_branching_unit(
    input logic [CPU_WIDTH-1:0] instruction,
    input logic [CPU_WIDTH-1:0] source1,
    input logic [CPU_WIDTH-1:0] source2,
    output logic branch_valid,
    output logic [ADDR_WIDTH-1:0] branch_offset
);

    logic [6:0] opcode7 = instruction[6:0];
    logic [2:0] funct3 = instruction[14:12]; 

    assign branch_offset = 32'(signed'({instruction[31:25], instruction[11:7]}));

    always_comb begin
        case ({funct3, opcode7})
            {3'b000, OPCODE_SB_TYPE}:  branch_valid = source1 == source2; // BEQ
            {3'b001, OPCODE_SB_TYPE}:  branch_valid = source1 != source2; // BNE
            {3'b100, OPCODE_SB_TYPE}:  branch_valid = signed'(source1) < signed'(source2); // BLT
            {3'b101, OPCODE_SB_TYPE}:  branch_valid = signed'(source1) >= signed'(source2); // BGE
            {3'b110, OPCODE_SB_TYPE}:  branch_valid = unsigned'(source1) < unsigned'(source2); // BLTU
            {3'b111, OPCODE_SB_TYPE}:  branch_valid = unsigned'(source1) >= unsigned'(source2); // BGEU
            default: branch_valid = 0;
        endcase
    end
endmodule
