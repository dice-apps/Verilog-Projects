`timescale 1ns/1ps
`include "Traffic_Light_Controller.v"

module Traffic_Light_Controller_tb();

reg clk;
reg reset;
wire [2:0]light_M1;
wire [2:0]light_M2;
wire [2:0]light_MT;
wire [2:0]light_S;

Traffic_Light_Controller dut(.clk(clk), .reset(reset), .light_M1(light_M1), .light_M2(light_M2), .light_MT(light_MT), .light_S(light_S));

//setting clock
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 0;
    #20; reset = 1;
    #20; reset = 0;
    #2000;

    $finish;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Traffic_Light_Controller_tb);
end


endmodule