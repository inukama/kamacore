

package kamacore_pkg:
    
    parameter int unsigned cpu_width = 32; // NOTE: Should not be changed
    parameter int unsigned ins_align = 32; // Instructions must be 32-bit aligned in memory. 
    parameter int unsigned addr_width = 32;
    parameter int unsigned reg_addr_width = 5;

    /////////////
    // Opcodes //
    /////////////

    typedef enum logic [6:0] {
        OPCODE_LUI      = 7'h37;
        OPCODE_AUIPC    = 7'h17;
        OPCODE_SB_TYPE  = 7'h63;
        OPCODE_LW       = 7'h03;
        OPCODE_SW       = 7'h23;
        OPCODE_I_TYPE   = 7'h13;
        OPCODE_R_TYPE   = 7'h33;
        OPCODE_EXCEPT   = 7'h73;
        // OPCODE_FENCE    = 7'h0F; // TODO: implement fence instructions
    } opcode;

    ////////////////
    // Interfaces // 
    ////////////////

    interface stage_if_id (
        input clk,
        input clear,
        input hold
    )
        logic [cpu_width:0] instruction

        modport IF (output instruction);
        modport ID (input instruction);
    endinterface


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


    interface stage_ex_mem (
        input clk,
        input clear,
        input hold
    )
        logic [reg_addr_width:0] destination_register,
        logic [cpu_width:0] read_data_b
        logic [cpu_width:0] ex_result
        logic control_memory_read,
        logic control_memory_write,
        logic control_write_rd,
        logic control_write_register

        modport EX (output destination_register, read_data_b, ex_result, control_memory_read, control_memory_write, control_write_rd, control_write_register);

        modport MEM (input destination_register, read_data_b, ex_result, control_memory_read, control_memory_write, control_write_rd, control_write_register);
    endinterface


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




endpackage