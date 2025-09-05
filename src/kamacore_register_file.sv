
module kamacore_register_file(
    input clk,
    input rst,

    input logic [REG_ADDR_WIDTH-1:0] source1_a,
    output logic [CPU_WIDTH-1:0] source1_data,

    input logic [REG_ADDR_WIDTH-1:0] source2_a,
    output logic [CPU_WIDTH-1:0] source2_data,

    input logic destination_we,
    input logic [REG_ADDR_WIDTH-1:0] destination_a,
    input logic [CPU_WIDTH-1:0] destination_data
);

    localparam REGISTER_COUNT = 2 ** REG_ADDR_WIDTH;

    logic [CPU_WIDTH-1:0] registers [REGISTER_COUNT-1:0];

    always_ff @(posedge clk) begin
        for (int i = 0; i < $size(registers); i++) begin  
            registers[i] <= (destination_we && (i == destination_a)) ? destination_data : registers[i];
            if (~rst) begin
                registers[i] <= '0;
            end 
        end
    end

    assign source1_data = (destination_we && (destination_a == source1_a)) ? destination_data : registers[source1_a];
    assign source2_data = (destination_we && (destination_a == source2_a)) ? destination_data : registers[source2_a];

endmodule