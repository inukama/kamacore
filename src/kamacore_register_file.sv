
module kamacore_register_file(
    input clk,
    input rst,

    input logic [REG_ADDR_WIDTH-1:0] rs1_a,
    output logic [CPU_WIDTH-1:0] rs1_data,

    input logic [REG_ADDR_WIDTH-1:0] rs2_a,
    output logic [CPU_WIDTH-1:0] rs2_data,

    input logic rd_we,
    input logic [REG_ADDR_WIDTH-1:0] rd_a,
    input logic [CPU_WIDTH-1:0] rd_data
);

    localparam REGISTER_COUNT = 2 ** REG_ADDR_WIDTH;

    logic [CPU_WIDTH-1:0] registers [REGISTER_COUNT-1:0];

    always_ff @(posedge clk) begin
        for (int i = 0; i < $size(registers); i++) begin  
            registers[i] <= (rd_we && (i == rd_a)) ? rd_data : registers[i];
            if (rst) begin
                registers[i] <= '0;
            end 
        end
    end

    assign rs1_data = (rd_we && (rd_a == rs1_a)) ? rd_data : registers[rs1_a];
    assign rs2_data = (rd_we && (rd_a == rs2_a)) ? rd_data : registers[rs2_a];

endmodule