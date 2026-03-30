class uart_driver;
    virtual uart_if vif;
    mailbox #(uart_transaction) gen2drv;

    int baud_delay = 104;

    function new(virtual uart_if vif, mailbox #(uart_transaction) gen2drv);
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction

    task run();
        uart_transaction tr;
        forever
        begin
            gen2drv.get(tr);
            drive(tr);
        end
    endtask

    task drive(uart_transaction tr);
        vif.tx <= 1;
        @(posedge vif.clk);
        vif.tx <= 0;
        repeat (baud_delay) @(posedge vif.clk);

        for (int i = 0; i < 8; i++)
        begin
            vif.tx <= tr.data[i];
            repeat (baud_delay) @(posedge vif.clk);
        end

        vif.tx <= 1;
        repeat (baud_delay) @(posedge vif.clk);
    endtask
endclass
