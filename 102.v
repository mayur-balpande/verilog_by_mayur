// Write a GCD calculator.


module q102 #(
    parameter integer WIDTH = 8
) (
    input   clk,
    input  reset,
    input  start,
    input  [WIDTH-1:0] operand_a,
    input  [WIDTH-1:0] operand_b,
    output reg [WIDTH-1:0] gcd,
    output reg busy,
    output reg done
);

    reg [WIDTH-1:0] a_reg;
    reg [WIDTH-1:0] b_reg;

    always @(posedge clk) begin
        if (reset) begin
            a_reg <= {WIDTH{1'b0}};
            b_reg <= {WIDTH{1'b0}};
            gcd   <= {WIDTH{1'b0}};
            busy  <= 1'b0;
            done  <= 1'b0;
        end else begin
            done <= 1'b0;

            if (!busy) begin
                if (start) begin
                    a_reg <= operand_a;
                    b_reg <= operand_b;
                    busy  <= 1'b1;
                end
            end else if ((a_reg == 0) || (b_reg == 0) ||
                         (a_reg == b_reg)) begin
                if (a_reg == 0)
                    gcd <= b_reg;
                else
                    gcd <= a_reg;

                busy <= 1'b0;
                done <= 1'b1;
            end else if (a_reg > b_reg) begin
                a_reg <= a_reg - b_reg;
            end else begin
                b_reg <= b_reg - a_reg;
            end
        end
    end

endmodule
