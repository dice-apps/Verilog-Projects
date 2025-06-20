`timescale 1ns/1ps

module automatic_washing_machine(
    input wire clk, 
    input wire reset,
    input wire door_close,
    input wire start,
    input wire filled,
    input wire detergent_added,
    input wire cycle_timeout,
    input wire drained,
    input wire spin_timeout,

    output reg door_lock,
    output reg motor_on,
    output reg fill_valve_on,
    output reg drain_valve_on,
    output reg done,
    output reg soap_wash,
    output reg water_wash
);

//Defining states
parameter S0 = 3'b000; //Check Door
parameter S1 = 3'b001; //Fill water
parameter S2 = 3'b010; //Add detergent
parameter S3 = 3'b011; //Cycle
parameter S4 = 3'b100; //Drain
parameter S5 = 3'b101; //Spin

//Defining state variables
reg [2:0] current_state;
reg [2:0] next_state;

//defining state logic
always @(posedge clk or posedge reset) begin
    if(reset) begin 
        current_state <= S0;
    end
    
    else begin
        case (current_state)
            S0: begin
                if(start && door_close) next_state <= S1;
                else next_state <= S0;
            end

            S1: begin
                if(~filled) next_state <= S1;
                else if (filled) next_state <= S2;
            end

            S2: begin
                if(detergent_added) next_state <= S2;
                else if(~detergent_added) next_state <= S3;
            end

            S3: begin
                if(~cycle_timeout) next_state <= S3;
                else if(cycle_timeout) next_state <= S4;
            end

            S4: begin
                if(~drained) next_state <= S4;
                else if(drained) next_state <= S5;
            end

            S5: begin
                if(~spin_timeout) next_state <= S5;
                else if(spin_timeout) next_state <= S0;
            end
            default: next_state <= S0;
        endcase

        current_state <= next_state;
    end
end


//defining output logic
always @(current_state) begin
    case (current_state)
        S0: begin
            
        end 
        default: 
    endcase
end

endmodule