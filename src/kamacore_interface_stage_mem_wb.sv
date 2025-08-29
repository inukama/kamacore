
interface stage_mem_wb (
    input clk,
    input clear,
    input hold
)
    logic [reg_addr_width:0] destination_register,
    logic [cpu_width:0] read_data_b
    logic [cpu_width:0] data_memory_result
    logic control_memory_read,
    logic control_write_rd,
    logic control_write_register

    modport EX (output destination_register, read_data_b, data_memory_result, control_memory_read, control_write_rd, control_write_register);

    modport EX (input destination_register, read_data_b, data_memory_result, control_memory_read, control_write_rd, control_write_register);
endinterface
