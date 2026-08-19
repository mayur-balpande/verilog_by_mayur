// Design an FSM-based ATM system. 
module q22(
    input clk,
    input reset,
    input card_read,
    input pin_valid,
    input transaction_valid,
    input account_selected,
    input cash_collected,
    output reg read_card,
    output reg check_pin,
    output reg do_transaction,
    output reg select_account,
    output reg dispense_cash,
    output reg reject_transaction,
    output reg [2:0] state
);

parameter CARD_ENTRY = 3'b000;
parameter PIN = 3'b001;
parameter TRANSACTION = 3'b010;
parameter ACCOUNT_TYPE = 3'b011;
parameter CASH_COLLECTION = 3'b100;
parameter EJECT_CARD = 3'b101;



always @(posedge clk or posedge reset) begin
    if (reset)
        state <= CARD_ENTRY;
    else begin
        case (state)
            CARD_ENTRY: begin
                read_card <= 1;
                check_pin <= 0;
                do_transaction <= 0;
                select_account <= 0;
                dispense_cash <= 0;
                reject_transaction <= 0;

                if (card_read)
                    state <= PIN;
            end

            PIN: begin
                read_card <= 0;
                check_pin <= 1;
                do_transaction <= 0;
                select_account <= 0;
                dispense_cash <= 0;
                reject_transaction <= 0;

                if (pin_valid)
                    state <= TRANSACTION;
            end

            TRANSACTION: begin
                read_card <= 0;
                check_pin <= 0;
                do_transaction <= 1;
                select_account <= 0;
                dispense_cash <= 0;
                reject_transaction <= 0;

                if (transaction_valid)
                    state <= ACCOUNT_TYPE;
            end

            ACCOUNT_TYPE: begin
                read_card <= 0;
                check_pin <= 0;
                do_transaction <= 0;
                select_account <= 1;
                dispense_cash <= 0;
                reject_transaction <= 0;

                if (account_selected)
                    state <= CASH_COLLECTION;
            end

            CASH_COLLECTION: begin
                read_card <= 0;
                check_pin <= 0;
                do_transaction <= 0;
                select_account <= 0;
                dispense_cash <= 1;
                reject_transaction <= 0;

                if (cash_collected)
                    state <= EJECT_CARD;
            end

            EJECT_CARD: begin
                read_card <= 0;
                check_pin <= 0;
                do_transaction <= 0;
                select_account <= 0;
                dispense_cash <= 0;
                reject_transaction <= 1;

                state <= CARD_ENTRY; // Reset to initial state after ejecting card
            end
        endcase
    end
    end
endmodule
