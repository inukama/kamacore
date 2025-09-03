
module kamacore_alu(
    input logic [CPU_WIDTH-1:0] source1,
    input logic [CPU_WIDTH-1:0] source2,
    input logic [CPU_WIDTH-1:0] imm32i, // Sign extended integer
    input logic [CPU_WIDTH-1:0] imm32u,

    input logic [CPU_WIDTH-1:0] instruction,

    output logic [CPU_WIDTH-1:0] alu_result
);


    logic [6:0] opcode7 = instruction[6:0];
    logic [2:0] funct3 = instruction[14:12]; 
    logic [6:0] funct7 = instruction[31:25];

    // TODO: Actually implement RISC-V
    assign alu_result = source1 + instruction[31:20]; // ADDI
endmodule
