
module kamacore_alu(
    input logic signed [CPU_WIDTH-1:0] source1,
    input logic signed [CPU_WIDTH-1:0] source2,

    input logic [CPU_WIDTH-1:0] instruction,

    output logic [CPU_WIDTH-1:0] alu_result
);
    // TODO: Control ALU through control signals rather than instruction directly
    logic [6:0] opcode7 = instruction[6:0];
    logic [2:0] funct3 = instruction[14:12]; 
    logic [6:0] funct7 = instruction[31:25];
    logic signed [31:0] imm11_signed = 32'(signed'(instruction[31:20]));
    logic unsigned [31:0] imm11_unsigned = 32'(unsigned'(instruction[31:20]));
    logic unsigned [4:0] shamt = instruction[24:20];

    localparam funct3_x = 3'b???;
    localparam funct7_x = 7'b???_???_?;

    always_comb begin
        unique casex ({funct7, funct3, opcode7})
            {funct7_x, 3'b000, OPCODE_I_TYPE}: alu_result = source1 + imm11_signed; // ADDI
            {funct7_x, 3'b010, OPCODE_I_TYPE}: alu_result = {31'b0, source1 < imm11_signed}; // SLTI
            {funct7_x, 3'b011, OPCODE_I_TYPE}: alu_result = {31'b0, source1 < imm11_unsigned}; // SLTIU
            {funct7_x, 3'b100, OPCODE_I_TYPE}: alu_result = source1 ^ imm11_signed; // XORI
            {funct7_x, 3'b110, OPCODE_I_TYPE}: alu_result = source1 | imm11_signed; // ORI
            {funct7_x, 3'b110, OPCODE_I_TYPE}: alu_result = source1 & imm11_signed; // ANDI
            {7'b0000000, 3'b001, OPCODE_I_TYPE}: alu_result = source1 << shamt; // SLLI
            {7'b0000000, 3'b101, OPCODE_I_TYPE}: alu_result = source1 >> shamt; // SRLI
            {7'b0100000, 3'b101, OPCODE_I_TYPE}: alu_result = source1 >>> shamt; // SRAI
            
            {7'b0000000, 3'b000, OPCODE_R_TYPE}: alu_result = source1 + source2; // ADD
            {7'b0100000, 3'b000, OPCODE_R_TYPE}: alu_result = source1 - source2; // SUB
            {7'b0000000, 3'b001, OPCODE_R_TYPE}: alu_result = source1 << source2[4:0]; // SLL
            {7'b0000000, 3'b010, OPCODE_R_TYPE}: alu_result = {31'b0, source1 < source2}; // SLT
            {7'b0000000, 3'b011, OPCODE_R_TYPE}: alu_result = {31'b0, unsigned'(source1) < unsigned'(source2)}; // SLTU
            {7'b0000000, 3'b100, OPCODE_R_TYPE}: alu_result = source1 ^ source2; // XOR
            {7'b0000000, 3'b101, OPCODE_R_TYPE}: alu_result = source1 >> source2[4:0]; // SRL
            {7'b0100000, 3'b101, OPCODE_R_TYPE}: alu_result = source1 >>> source2[4:0]; // SRA
            {7'b0000000, 3'b110, OPCODE_R_TYPE}: alu_result = source1 | source2; // OR
            {7'b0000000, 3'b111, OPCODE_R_TYPE}: alu_result = source1 & source2; // AND

            // TODO: branch, load, store, jump
            default: alu_result = 32'd0000;
        endcase
    end
endmodule
