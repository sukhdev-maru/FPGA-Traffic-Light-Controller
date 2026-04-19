`timescale 1ns/1ps

module tb_traffic;

reg clk, rst, sensor;
wire [1:0] hwy, cntry;

traffic_light_ctrl uut (
    .clk(clk),
    .rst(rst),
    .sensor(sensor),
    .hwy_light(hwy),
    .cntry_light(cntry)
);

// clock
initial clk = 0;
always #5 clk = ~clk;

// stimulus
initial begin
    rst = 1; sensor = 0;
    #20 rst = 0;

    #30 sensor = 1;
    #100 sensor = 0;
    #100 sensor = 1;

    #200 $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_traffic);
end

endmodule