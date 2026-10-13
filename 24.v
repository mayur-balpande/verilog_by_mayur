// Implement a basic SDRAM controller. 

module q24(
    input wire clk,
    input wire reset,
    input wire request,
    input wire write_en,
    input wire [12:0] row_addr,
    input wire [9:0] col_addr,
    input wire [1:0] bank_addr,
    input wire [15:0] write_data,

    output reg [15:0] read_data,
    output reg busy,
    output reg done,

    output reg cs_n,
    output reg ras_n,
    output reg cas_n,
    output reg we_n,
    output reg [12:0] sdram_addr,
    output reg [1:0] sdram_ba,
    inout wire [15:0] sdram_dq
);

    parameter IDLE       = 3'b000;
    parameter ACTIVE     = 3'b001;
    parameter WAIT_TRCD  = 3'b010;
    parameter READ       = 3'b011;
    parameter READ_WAIT  = 3'b100;
    parameter WRITE      = 3'b101;
    parameter PRECHARGE  = 3'b110;
    parameter DONE       = 3'b111;

    reg [2:0] state;
    reg write_reg;
    reg [12:0] row_reg;
    reg [9:0] col_reg;
    reg [1:0] bank_reg;
    reg [15:0] write_data_reg;

    reg [15:0] dq_out;
    reg dq_enable;

    assign sdram_dq = dq_enable ? dq_out : 16'bz;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            read_data <= 0;
            busy <= 0;
            done <= 0;

            cs_n <= 1;
            ras_n <= 1;
            cas_n <= 1;
            we_n <= 1;

            sdram_addr <= 0;
            sdram_ba <= 0;
            dq_out <= 0;
            dq_enable <= 0;
        end

        else begin
            //Default command: NOP
            cs_n <= 0;
            ras_n <= 1;
            cas_n <= 1;
            we_n <= 1;
            dq_enable <= 0;
            done <= 0;

            case (state)

                IDLE: begin
                    busy <= 0;

                    if (request) begin
                        write_reg <= write_en;
                        row_reg <= row_addr;
                        col_reg <= col_addr;
                        bank_reg <= bank_addr;
                        write_data_reg <= write_data;

                        busy <= 1;
                        state <= ACTIVE;
                    end
                end

                //ACTIVATE command
                ACTIVE: begin
                    cs_n <= 0;
                    ras_n <= 0;
                    cas_n <= 1;
                    we_n <= 1;

                    sdram_addr <= row_reg;
                    sdram_ba <= bank_reg;

                    state <= WAIT_TRCD;
                end

                //Wait for row-to-column delay
                WAIT_TRCD: begin
                    if (write_reg)
                        state <= WRITE;
                    else
                        state <= READ;
                end

                //READ command
                READ: begin
                    cs_n <= 0;
                    ras_n <= 1;
                    cas_n <= 0;
                    we_n <= 1;

                    sdram_addr <= {3'b000, col_reg};
                    sdram_ba <= bank_reg;

                    state <= READ_WAIT;
                end

                //Capture read data
                READ_WAIT: begin
                    read_data <= sdram_dq;
                    state <= PRECHARGE;
                end

                //WRITE command
                WRITE: begin
                    cs_n <= 0;
                    ras_n <= 1;
                    cas_n <= 0;
                    we_n <= 0;

                    sdram_addr <= {3'b000, col_reg};
                    sdram_ba <= bank_reg;

                    dq_out <= write_data_reg;
                    dq_enable <= 1;

                    state <= PRECHARGE;
                end

                //PRECHARGE command
                PRECHARGE: begin
                    cs_n <= 0;
                    ras_n <= 1;
                    cas_n <= 1;
                    we_n <= 0;

                    sdram_addr <= 13'h400;
                    sdram_ba <= bank_reg;

                    state <= DONE;
                end

                DONE: begin
                    busy <= 0;
                    done <= 1;
                    state <= IDLE;
                end

                default: state <= IDLE;

            endcase
        end
    end

endmodule