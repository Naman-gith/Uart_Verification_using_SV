class uart_coverage;

    virtual uart_if vif;

    covergroup uart_cg @(posedge vif.clk);

        option.per_instance = 1;

        baud_cp : coverpoint baud_sel {
            bins low = {50};
            bins mid = {104};
            bins high = {200};
        }

        data_cp : coverpoint data_sample {
            bins zero = {8'h00};
            bins ones = {8'hFF};
            bins alt1 = {8'hAA};
            bins alt2 = {8'h55};
            bins others[] = {[1:254]};
        }

        cross baud_cp, data_cp;

    endgroup

    int baud_sel;
    bit [7:0] data_sample;

    function new(virtual uart_if vif);
        this.vif = vif;
        uart_cg = new();
    endfunction

    task sample(int baud, bit [7:0] data);
        baud_sel = baud;
        data_sample = data;
        uart_cg.sample();
    endtask

endclass
