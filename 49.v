 //Code a 2:1 multiplexer using both if-else and case.


// using if

 module q49(
    input I0,
    input I1,
    input sel,
    output reg Y
 );

 always @(*) begin
    if (sel)
    Y = I1;
    else 
    Y = I0;
    
 end

 endmodule


// using case

module q49(
     input I0,
    input I1,
    input sel,
    output reg Y
);

always @(*) begin
    case (sel)
    1'b0: Y = I0;
    1'b1: Y = I1;
    default: Y = 1'b0;
    endcase
end
endmodule
