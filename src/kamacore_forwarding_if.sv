
// TODO: Rename to something like "stage result" to better reflect utility as an interface that exposes the result of stages in general and not just for forwarding (especially for wb -> id).
interface kamacore_forwarding_if ();
    logic we;
    logic [REG_ADDR_WIDTH-1:0] a;
    logic [CPU_WIDTH-1:0] data_original;
    logic [CPU_WIDTH-1:0] data_forwarded;
endinterface
