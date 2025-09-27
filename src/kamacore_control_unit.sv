
module kamacore_control_unit (
    input logic [CPU_WIDTH-1:0] instruction,
    output st_control_signals control_signals
);
    e_opcode opcode7 = e_opcode'(instruction[6:0]); // TODO: Figure out why I can't name the variable opcode
    logic [2:0] funct3 = instruction[14:12]; 
    logic [6:0] funct7 = instruction[31:25];

    always_comb begin
        case (opcode7)
            OPCODE_R_TYPE:  begin
                control_signals.rd_we = 1;
            end
            OPCODE_I_TYPE: begin
                control_signals.rd_we = 1;
            end
            default: begin
                control_signals = '0;
            end
        endcase
    end

endmodule
