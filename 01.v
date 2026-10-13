//Write a Verilog module for a 2-input AND gate. 

//design

module q1(
  input wire a,
  input wire  b,
  output wire y);

  assign y = a & b;
endmodule


//tb

module q1_tb;
    reg a;
    reg b;
    reg y;

    q1 dut(
    .a(a),
    .b(b),
    .y(y));

    initial begin
        $display("a b | y");
        //1
        a = 0;
        b = 0;
        #10;
     $display("a=%b b=%b | y=%b", a, b, y);

       //2
        a = 0;
        b = 1;
        #10;
        $display("a=%b b=%b | y=%b", a, b, y);
        //3
        a = 1;
        b = 0;
        #10;
       $display("a=%b b=%b | y=%b", a, b, y);
        //4
        a = 1;
        b = 1;
        #10;
        $display("a=%b b=%b | y=%b", a, b, y);
        $finish;
    
    end


    
endmodule




