class uart_monitor;
    virtual uart_if vif;
    mailbox #(uart_transaction) mon2scb;

    int baud_delay = 104;

    function new(virtual uart_if vif, mailbox #(uart_transaction) mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task run();
        uart_transaction tr;
        forever
        begin
            @(negedge vif.rx);
            tr = new();

            repeat (baud_delay + baud_delay/2) @(posedge vif.clk);

            for (int i = 0; i < 8; i++)
            begin
                tr.rx_data[i] = vif.rx;
                repeat (baud_delay) @(posedge vif.clk);
            end

            repeat (baud_delay) @(posedge vif.clk);

            mon2scb.put(tr);
        end
    endtask
endclass
