class uart_scoreboard;
    mailbox #(uart_transaction) mon2scb;

    function new(mailbox #(uart_transaction) mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task run();
        uart_transaction tr;
        forever
        begin
            mon2scb.get(tr);
            if (tr.data !== tr.rx_data)
                $display("FAIL data=%0h rx=%0h", tr.data, tr.rx_data);
            else
                $display("PASS data=%0h", tr.data);
        end
    endtask
endclass
