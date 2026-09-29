//Implement basic MAC unit

module q103 #(parameter A_WIDTH = 8,
            parameter B_WIDTH = 8,
            parameter ACC_WIDTH = A_WIDTH + B_WIDTH )
            (
                input clk,
                input reset,
                input enable,
                input clear,
                input [A_WIDTH-1:0] a,
                input [B_WIDTH-1:0] b,
                output reg [ACC_WIDTH-1:0] accumulator 
            );

            wire [A_WIDTH + B_WIDTH-1:0] product;
            assign product = a * b;
            

            always @(posedge clk) begin
                if (reset)
                accumulator <= {ACC_WIDTH{1'b0}};
                else if (clear)
                accumulator <= {ACC_WIDTH{1'b0}};
                else if (enable)
                accumulator <= accumulator + product;
            end
endmodule
