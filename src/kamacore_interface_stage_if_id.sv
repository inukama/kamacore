
interface stage_if_id (
    input clk,
    input clear,
    input hold
)
    logic [cpu_width:0] instruction

    modport IF (output instruction);
    modport ID (input instruction);
endinterface
