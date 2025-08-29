

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

endpackage