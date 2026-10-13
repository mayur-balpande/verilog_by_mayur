//Write a testbench for a 4-bit counter.

//design 4-bit counter


module q59(
    input clk,
    input reset,
    output reg [3:0]count
    
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000; // Reset count to 0
    end else begin
        count <= count + 1; // Increment count on each clock cycle
    end
end
endmodule


//tb 4-bit counter
module tb_q59;
    reg        clk;
    reg        reset;
    wire [3:0] count;

    reg  [3:0] expected_count;
    integer    error_count;

     q59 dut (
        .clk   (clk),
        .reset (reset),
        .count (count)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    // Check counter output after each active clock edge
    always @(posedge clk) begin
        #1;

        if (reset)
            expected_count = 4'b0000;
        else
            expected_count = expected_count + 1'b1;

        if (count !== expected_count) begin
            $display("ERROR at time %0t: count=%b, expected=%b",
                     $time, count, expected_count);
            error_count = error_count + 1;
        end
    end

    initial begin
        clk            = 1'b0;
        reset          = 1'b1;
        expected_count = 4'b0000;
        error_count    = 0;

        #12;
        reset = 1'b0;

        // Run long enough to verify normal counting and 4-bit overflow
        #200;

        if (error_count == 0)
            $display("TEST PASSED");
        else
            $display("TEST FAILED: %0d error(s)", error_count);

        $finish;
    end

endmodule
);
