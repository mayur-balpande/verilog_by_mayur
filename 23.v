//Implement a multi-cycle multiplier.

module q22 #(parameter N = 4)(
    input wire clk,
    input wire reset,
    input wire start,
    input wire [N-1:0] a,
    input wire [N-1:0] b,
    output reg [2*N-1:0] product,
    output reg busy,
    output reg done
);

    reg [2*N-1:0] multiplicand;
    reg [N-1:0] multiplier;
    integer count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            product <= 0;
            multiplicand <= 0;
            multiplier <= 0;
            count <= 0;
            busy <= 0;
            done <= 0;
        end

        else begin
            done <= 0;

            if (start && !busy) begin
                product <= 0;
                multiplicand <= a;
                multiplier <= b;
                count <= 0;
                busy <= 1;
            end

            else if (busy) begin
                if (multiplier[0])
                    product <= product + multiplicand;

                multiplicand <= multiplicand << 1;
                multiplier <= multiplier >> 1;

                if (count == N-1) begin
                    busy <= 0;
                    done <= 1;
                end
                else
                    count <= count + 1;
            end
        end
    end

endmodule