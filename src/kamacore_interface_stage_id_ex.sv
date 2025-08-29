
interface stage_id_ex (
    input clk,
    input clear,
    input hold
)
    logic [cpu_width:0] instruction,
    logic [cpu_width:0] data_a,
    logic [cpu_width:0] data_b,
    logic [reg_addr_width:0] destination_register,
    logic control_alu_use_immediate,
    logic control_memory_read,
    logic control_memory_write,
    logic control_write_rd,
    logic control_write_register

    modport ID (output instruction, data_a, data_b, destination_register, control_alu_use_immediate, control_memory_read, control_memory_write, control_write_rd, control_write_register);

    modport EX (input instruction, data_a, data_b, destination_register, control_alu_use_immediate, control_memory_read, control_memory_write, control_write_rd, control_write_register);
endinterface
