// Implement a 2:1 multiplexer using `assign` and `case`. 

//using assign
module q2_assign(

    input wire a,
    input wire b,
    input wire sel,
    output wire y);


    assign y = sel ? a : b;
endmodule


// using case

module q2_case(
    input wire a,
    input wire b,
    input wire sel,
    output logic y);

    always @(*) begin
        case (sel)
        1'b0: y = a;
        1'b1: y = b;
        endcase
    end
endmodule

