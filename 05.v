//Write a testbench for a simple 2-input OR gate. 

//design
module q5(
    input wire a,
    input wire b,
    output wire y
);
assign y = a|b;
endmodule


//testbench
module q5_tb;
reg a;
reg b;
reg y;

q5 dut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin
    $display("a b | y");
    //1
    a = 0;
    b = 0; 
    #10;
    $display("a=%b b=%b | y=%b",a, b, y);
    //2 
    a = 0;
    b = 1;
    #10;
    $display("a=%b b=%b | y=%b",a, b, y);
    //3
    a = 1;
    b = 0;
    #10;
    $display("a=%b b=%b | y=%b",a, b, y);
    //4
    a = 1;
    b = 1;
    #10;
    $display("a=%b b=%b | y=%b",a, b, y);
    $finish;
end
endmodule

