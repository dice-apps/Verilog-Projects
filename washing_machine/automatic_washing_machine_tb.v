`timescale 1ns/1ps
`include "automatic_washing_machine.v"

module automatic_washing_machine_tb();

reg clk;
reg reset;
reg door_close;
reg start;
reg filled;
reg detergent_added;
reg wash_done;
reg drained_1;
reg drained_2;
reg spin_done;

wire motor_on;
wire fill_valve_on;
wire drain_valve_on;
wire detergent_valve_on;
wire spin_motor_on;
wire done;
wire door_lock;

automatic_washing_machine dut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .door_close(door_close),
    .filled(filled),
    .detergent_added(detergent_added),
    .wash_done(wash_done),
    .drained_1(drained_1),
    .rinse_filled(rinse_filled),
    .drained_2(drained_2),
    .spin_done(spin_done),

    .fill_valve_on(fill_valve_on),
    .detergent_valve_on(detergent_valve_on),
    .motor_on(motor_on),
    .drain_valve_on(drain_valve_on),
    .spin_motor_on(spin_motor_on),
    .door_lock(door_lock),
    .done(done)
);

endmodule