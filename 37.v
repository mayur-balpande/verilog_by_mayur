//Implement an ECC (Error Correction Code) block with Hamming Code.

module q37 #(
    parameter integer N = 8,
    parameter integer M = 4
) (
    input  wire [N-1:0] data_in,
    output reg  [N+M:0] code_out,
    input  wire [N+M:0] code_in,
    output reg  [N-1:0] data_out,
    output reg  [N+M:0] corrected_code,
    output reg error_detected,
    output reg error_corrected,
    output reg uncorrectable
);

    localparam integer HAMMING_WIDTH = N + M;

    reg [N+M:0] encoded_tmp;
    reg [N+M:0] corrected_tmp;
    reg [M-1:0] syndrome;
    reg parity_bit;
    reg check_bit;
    reg overall_bad;
    integer pos;
    integer k;
    integer data_index;
    integer error_pos;

    always @(*) begin
        // Encode: parity bits occupy positions 1, 2, 4, 8, ...
        encoded_tmp = {(N+M+1){1'b0}};
        data_index = 0;

        for (pos = 1; pos <= HAMMING_WIDTH; pos = pos + 1) begin
            if ((pos & (pos - 1)) != 0) begin
                encoded_tmp[pos-1] = data_in[data_index];
                data_index = data_index + 1;
            end
        end

        for (k = 0; k < M; k = k + 1) begin
            parity_bit = 1'b0;
            for (pos = 1; pos <= HAMMING_WIDTH; pos = pos + 1) begin
                if ((pos & (1 << k)) != 0)
                    parity_bit = parity_bit ^ encoded_tmp[pos-1];
            end
            encoded_tmp[(1 << k)-1] = parity_bit;
        end

        // Overall parity bit gives double-error detection.
        encoded_tmp[HAMMING_WIDTH] = ^encoded_tmp[HAMMING_WIDTH-1:0];
        code_out = encoded_tmp;

        // Decode and calculate the Hamming syndrome.
        syndrome = {M{1'b0}};
        for (k = 0; k < M; k = k + 1) begin
            check_bit = 1'b0;
            for (pos = 1; pos <= HAMMING_WIDTH; pos = pos + 1) begin
                if ((pos & (1 << k)) != 0)
                    check_bit = check_bit ^ code_in[pos-1];
            end
            syndrome[k] = check_bit;
        end

        overall_bad = ^code_in;
        corrected_tmp = code_in;
        error_detected = (syndrome != 0) || overall_bad;
        error_corrected = 1'b0;
        uncorrectable = 1'b0;
        error_pos = 0;

        if (overall_bad) begin
            if (syndrome == 0) begin
                // Error was in the overall parity bit.
                corrected_tmp[HAMMING_WIDTH] = ~code_in[HAMMING_WIDTH];
                error_corrected = 1'b1;
            end else if (syndrome <= HAMMING_WIDTH) begin
                error_pos = syndrome;
                corrected_tmp[error_pos-1] = ~code_in[error_pos-1];
                error_corrected = 1'b1;
            end else begin
                uncorrectable = 1'b1;
            end
        end else if (syndrome != 0) begin
            uncorrectable = 1'b1;
        end

        // Extract data bits from the corrected codeword.
        data_out = {N{1'b0}};
        data_index = 0;
        for (pos = 1; pos <= HAMMING_WIDTH; pos = pos + 1) begin
            if ((pos & (pos - 1)) != 0) begin
                data_out[data_index] = corrected_tmp[pos-1];
                data_index = data_index + 1;
            end
        end

        corrected_code = corrected_tmp;
    end

endmodule

