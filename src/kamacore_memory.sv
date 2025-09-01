
// Based on https://docs.amd.com/r/en-US/ug901-vivado-synthesis/Dual-Port-RAM-with-Asynchronous-Read-Coding-Verilog-Example
module kamacore_memory #(
    parameter MEM_ADDR_WIDTH = ADDR_WIDTH,
    parameter RAM_SIZE = 1024
) (
    input logic clk,

    input logic we, // write enable
    input logic [MEM_ADDR_WIDTH-1:0] a, // address
    input logic [MEM_ADDR_WIDTH-1:0] dpra, // dual port read address
    input logic [CPU_WIDTH-1:0] di, // data in

    output logic [CPU_WIDTH-1:0] spo, // single port output
    output logic [CPU_WIDTH-1:0] dpo // dual port output
);

    logic [CPU_WIDTH-1:0] ram [RAM_SIZE-1:0];



    // TODO: Debug only
    initial begin
        ram[3] = {12'd7, 5'd0, 5'd1, 3'd0, 5'd1, OPCODE_I_TYPE};
    end

    always_ff @(posedge clk) begin
        ram[a] <= di;
    end

    assign spo = ram[a];
    assign dpo = ram[dpra]; 
endmodule
