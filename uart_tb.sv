module tb;

    logic clk;
    always #5 clk = ~clk;

    uart_if vif(clk);

    uart_env env;

    initial
    begin
        clk = 0;
        vif.rst = 1;
        vif.tx = 1;
        vif.rx = 1;

        #20;
        vif.rst = 0;

        vif.rx = vif.tx;

        env = new(vif);
        env.run();

        #50000;
        $finish;
    end

endmodule
