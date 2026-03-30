module uart_assertions(uart_if vif);

    int baud_delay = 104;

    property start_bit_check;
        @(posedge vif.clk)
        $fell(vif.tx) |-> ##[1:baud_delay] (vif.tx == 0);
    endproperty

    property stop_bit_check;
        @(posedge vif.clk)
        $rose(vif.tx) |-> ##[1:baud_delay] (vif.tx == 1);
    endproperty

    property data_stability;
        @(posedge vif.clk)
        (vif.tx !== $past(vif.tx)) |-> ##1 $stable(vif.tx) [* (baud_delay-1)];
    endproperty

    property no_glitch;
        @(posedge vif.clk)
        $changed(vif.tx) |-> ##1 !$changed(vif.tx);
    endproperty

    assert property(start_bit_check);
    assert property(stop_bit_check);
    assert property(data_stability);
    assert property(no_glitch);

endmodule
