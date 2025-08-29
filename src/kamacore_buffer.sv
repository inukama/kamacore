
module buffer # (
    parameter WIDTH = 1
) (
    input logic clk,
    input logic rst,
    input logic [WIDTH-1:0] D,
    output logic [WIDTH-1:0] Q,
);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            Q <= 0; 
        end else begin
            Q <= D;
        end
    end
endmodule
