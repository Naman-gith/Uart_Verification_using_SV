class uart_env;
    uart_generator gen;
    uart_driver drv;
    uart_monitor mon;
    uart_scoreboard scb;

    mailbox #(uart_transaction) gen2drv;
    mailbox #(uart_transaction) mon2scb;

    function new(virtual uart_if vif);
        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);
        drv = new(vif, gen2drv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
    endfunction

    task run();
        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join_none
    endtask
endclass
