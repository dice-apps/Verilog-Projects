`timescale 1ns/1ps

module automatic_washing_machine(
    input wire clk,
    input wire reset,
    input wire start,
    input wire door_close,
    input wire filled,
    input wire detergent_added,
    input wire wash_done,
    input wire drained_1,
    input wire rinse_filled,
    input wire drained_2,
    input spin_done,

    output reg fill_valve_on,
    output reg detergent_valve_on,
    output reg motor_on,
    output reg drain_valve_on,
    output reg spin_motor_on,
    output reg door_lock,
    output reg done

);

//defining states

parameter S0 = 4'd0;//Idle
parameter S1 = 4'd1;//Fill water
parameter S2 = 4'd2;//Add detergent
parameter S3 = 4'd3;//Wash
parameter S4 = 4'd4;//Drain_water_1
parameter S5 = 4'd5;//Rinse
parameter S6 = 4'd6;//Drain water 2
parameter S7 = 4'd7;//Spin
parameter S8 = 4'd8;//Done

reg [3:0]current_state;
reg [3:0]next_state;

//defining state register
always @(posedge clk or posedge reset) begin
    if(reset) begin
        current_state <= S0;
    end
    
    else current_state <= next_state; //current state will  be the next state
end

//defining state transitions
always @(*) begin
    case (current_state)
        S0: begin
            if(start && door_close) next_state <= S1;
            else next_state <= S0;
        end

        S1: begin
            if(filled) next_state <= S2;
            else next_state <= S1;
        end

        S2: begin
          next_state <= detergent_added ? S3 : S2;
        end

        S3: begin
          next_state <= wash_done ? S4 : S3;
        end

        S4: begin
          next_state <= drained_1 ? S5 : S4;
        end

        S5: begin
          next_state <= rinse_filled ? S6 : S5;
        end

        S6: begin
          next_state <= drained_2 ? S7 : S6;
        end

        S7: begin
          next_state <= spin_done ? S8 : S7;
        end

        S8: begin
          next_state <= S0;
        end

        default: next_state <= S0;
    endcase
end

//defining output logic => Moore machine(output depends only on current state)
always @(*) begin

    //setting output values to 0, by default
    fill_valve_on = 0;
    detergent_valve_on = 0;
    motor_on = 0;
    drain_valve_on = 0;
    fill_valve_on = 0;
    spin_motor_on = 0;
    door_lock = 0;
    done = 0;

    case (current_state)
        S0: begin
          door_lock <= 0;
        end

        S1: begin
          fill_valve_on <= 1;
          door_lock <= 1;
        end

        S2: begin
          detergent_valve_on <= 1;
          door_lock <= 1;
        end

        S3: begin
          motor_on <= 1;
          door_lock <= 1;
        end

        S4: begin
          drain_valve_on <= 1;
          door_lock <= 1;
        end

        S5: begin
          fill_valve_on <= 1;
          door_lock <= 1;
        end

        S6: begin
          drain_valve_on <= 1;
          door_lock <= 1;
        end

        S7: begin
          spin_motor_on <= 1;
          door_lock <= 1;
        end

        S8: begin
          done <= 1;
          door_lock <= 1;
        end
    endcase

end
endmodule