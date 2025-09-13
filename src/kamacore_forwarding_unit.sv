module kamacore_forwarding_unit (
    input wire clk,
    input wire reset,

    input wire [3:0] ID_register_a,
    input wire [15:0] ID_data_a,
    input wire [3:0] ID_register_b,
    input wire [15:0] ID_data_b,

    input wire [3:0] EX_register_a,
    input wire [15:0] EX_data_a,
    input wire [3:0] EX_register_b,
    input wire [15:0] EX_data_b,

    input wire [15:0] EX_result,
    input wire [3:0] EX_destination_register,
    input wire EX_control_write_register,

    input wire [15:0] MEM_result,
    input wire [3:0] MEM_destination_register,
    input wire MEM_control_write_register,

    input wire [15:0] WB_result,
    input wire [3:0] WB_destination_register,
    input wire WB_control_write_register,

    output reg [15:0] ID_forwarded_data_a,
    output reg [15:0] ID_forwarded_data_b,

    output reg [15:0] EX_forwarded_data_a,
    output reg [15:0] EX_forwarded_data_b
);
    always_comb begin
        EX_forwarded_data_a = EX_data_a;
        EX_forwarded_data_b = EX_data_b;

        if (EX_register_a != 0) begin
            if (MEM_control_write_register && MEM_destination_register == EX_register_a) begin
                EX_forwarded_data_a = MEM_result;
            end else if (WB_control_write_register && WB_destination_register == EX_register_a) begin
                EX_forwarded_data_a = WB_result;
            end
        end

        if (EX_register_b != 0) begin
            if (MEM_control_write_register && MEM_destination_register == EX_register_b) begin
                EX_forwarded_data_b = MEM_result;
            end else if (WB_control_write_register && WB_destination_register == EX_register_b) begin
                EX_forwarded_data_b = WB_result;
            end
        end
    end


    always@* begin
        ID_forwarded_data_a = ID_data_a;
        ID_forwarded_data_b = ID_data_b;

        if (ID_register_a != 0) begin
            if (EX_control_write_register && EX_destination_register == ID_register_a) begin
                ID_forwarded_data_a = EX_result;
            end else if (MEM_control_write_register && MEM_destination_register == ID_register_a) begin
                ID_forwarded_data_a = MEM_result;
            end else if (WB_control_write_register && WB_destination_register == ID_register_a) begin
                ID_forwarded_data_a = WB_result;
            end
        end

        if (ID_register_b != 0) begin
            if (EX_control_write_register && EX_destination_register == ID_register_b) begin
                ID_forwarded_data_b = EX_result;
            end else if (MEM_control_write_register && MEM_destination_register == ID_register_b) begin
                ID_forwarded_data_b = MEM_result;
            end else if (WB_control_write_register && WB_destination_register == ID_register_b) begin
                ID_forwarded_data_b = WB_result;
            end
        end
    end

    /*
        Forwarding unit:
            - Forwards data from MEM and WB to EX

        Assumptions:
            - If write_to_register is set, it will always write to that memory location

        Pseudocode:
            If MEM writes to reg X
                forward to reg a if a == X
            else if WB writes to reg X
                forward to reg a if a == X

            If MEM writes to reg X
                forward to reg b if b == X
            else if WB writes to reg X
                forward to reg b if b == X
    */
endmodule
