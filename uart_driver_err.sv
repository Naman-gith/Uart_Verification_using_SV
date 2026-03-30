class uart_driver_err;

    virtual uart_if vif;
    mailbox #(uart_transaction) gen2drv;

    int baud_delay = 104;

    rand bit inject_parity_error;
    rand bit inject_framing_error;
    rand bit inject_noise;

    function new(virtual uart_if vif, mailbox #(uart_transaction) gen2drv);
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction

    task run();
        uart_transaction tr;
        forever
        begin
            gen2drv.get(tr);
            assert(this.randomize());
            drive(tr);
        end
    endtask

    task drive(uart_transaction tr);
        bit parity;
        parity = ^tr.data;

        vif.tx <= 1;
        @(posedge vif.clk);

        vif.tx <= 0;
        repeat (baud_delay) @(posedge vif.clk);

        for (int i = 0; i < 8; i++)
        begin
            vif.tx <= tr.data[i];
            if (inject_noise && $urandom_range(0,10) > 7)
                vif.tx <= ~tr.data[i];
            repeat (baud_delay) @(posedge vif.clk);
        end

        if (inject_parity_error)
            vif.tx <= ~parity;
        else
            vif.tx <= parity;

        repeat (baud_delay) @(posedge vif.clk);

        if (inject_framing_error)
            vif.tx <= 0;
        else
            vif.tx <= 1;

        repeat (baud_delay) @(posedge vif.clk);

        vif.tx <= 1;
    endtask

endclass
