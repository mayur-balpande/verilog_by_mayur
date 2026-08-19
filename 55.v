//Design a priority encoder. 

module q55(
    input [7:0]in,
    output reg [3:0]out,
    output reg valid
);

always @(*) begin
    out = 3'b000;
    valid = 1'b0;

    if(in[7]) begin
        out = 3'd7;
        valid = 1'b1;
    end
    else if (in[6]) begin
        out = 3'd6;
        valid = 1'b1;
    end
    else if (in[5]) begin
        out = 3'd5;
        valid = 1'b1;
    end
    else if (in[4]) begin
        out = 3'd4;
        valid = 1'b1;
    end
    else if (in[3]) begin
        out = 3'd3;
        valid = 1'b1;
    end
    else if (in[2]) begin
        out = 3'd2;
        valid = 1'b1;
    end
    else if (in[1]) begin
        out = 3'd1;
        valid = 1'b1;
    end
    else if (in[0]) begin
        out = 3'd0;
        valid = 1'b1;
    end
end

endmodule

