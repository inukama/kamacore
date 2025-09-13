
interface kamacore_forwarding_unit (
    kamacore_forwarding_if forwarding_id_rs1,
    kamacore_forwarding_if forwarding_id_rs2,
    kamacore_forwarding_if forwarding_ex_rs1,
    kamacore_forwarding_if forwarding_ex_rs2,

    kamacore_forwarding_if forwarding_ex_result,
    kamacore_forwarding_if forwarding_mem_result,
    kamacore_forwarding_if forwarding_wb_result
);

    // Forward ID rs1
    always_comb begin
        forwarding_id_rs1.data_forwarded = forwarding_id_rs1.data_original;
        if (forwarding_id_rs1.a != 0) begin
            if (forwarding_ex_result.we && forwarding_ex_result.a == forwarding_id_rs1.a) begin
                forwarding_id_rs1.data_forwarded = forwarding_ex_result.data_original;
            end else if (forwarding_mem_result.we && forwarding_mem_result.a == forwarding_id_rs1.a) begin
                forwarding_id_rs1.data_forwarded = forwarding_mem_result.data_original;
            end else if (forwarding_wb_result.we && forwarding_wb_result.a == forwarding_id_rs1.a) begin
                forwarding_id_rs1.data_forwarded = forwarding_wb_result.data_original;
            end
        end
    end

    // Forward ID rs2
    always_comb begin
        forwarding_id_rs2.data_forwarded = forwarding_id_rs2.data_original;
        if (forwarding_id_rs2.a != 0) begin
            if (forwarding_ex_result.we && forwarding_ex_result.a == forwarding_id_rs2.a) begin
                forwarding_id_rs2.data_forwarded = forwarding_ex_result.data_original;
            end else if (forwarding_mem_result.we && forwarding_mem_result.a == forwarding_id_rs2.a) begin
                forwarding_id_rs2.data_forwarded = forwarding_mem_result.data_original;
            end else if (forwarding_wb_result.we && forwarding_wb_result.a == forwarding_id_rs2.a) begin
                forwarding_id_rs2.data_forwarded = forwarding_wb_result.data_original;
            end
        end
    end

    // Forward EX rs1
    always_comb begin
        forwarding_ex_rs1.data_forwarded = forwarding_ex_rs1.data_original;
        if (forwarding_ex_rs1.a != 0) begin
            if (forwarding_mem_result.we && forwarding_mem_result.a == forwarding_id_rs1.a) begin
                forwarding_ex_rs1.data_forwarded = forwarding_mem_result.data_original;
            end else if (forwarding_wb_result.we && forwarding_wb_result.a == forwarding_id_rs1.a) begin
                forwarding_ex_rs1.data_forwarded = forwarding_wb_result.data_original;
            end
        end
    end

    // Forward EX rs2
    always_comb begin
        forwarding_ex_rs2.data_forwarded = forwarding_ex_rs2.data_original;
        if (forwarding_ex_rs2.a != 0) begin
            if (forwarding_mem_result.we && forwarding_mem_result.a == forwarding_id_rs2.a) begin
                forwarding_ex_rs2.data_forwarded = forwarding_mem_result.data_original;
            end else if (forwarding_wb_result.we && forwarding_wb_result.a == forwarding_id_rs2.a) begin
                forwarding_ex_rs2.data_forwarded = forwarding_wb_result.data_original;
            end
        end
    end
endinterface
