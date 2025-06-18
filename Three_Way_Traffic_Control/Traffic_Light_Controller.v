`timescale 1ns/1ps


module Traffic_Light_Controller(

    input wire clk,
    input wire reset,
    output reg [2:0]light_M1,
    output reg [2:0]light_M2,
    output reg [2:0]light_MT,
    output reg [2:0]light_S
);

//defining states
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;

reg [3:0]count;
reg [2:0]ps; //present state

//defining input times
parameter sec2 = 2; //TY
parameter sec3 = 3; //TSG
parameter sec5 = 5; //TTG
parameter sec7 = 7; //TMG

//state transitions
//here state is changed based on input
always @(posedge clk or posedge reset) begin
    if(reset) begin
        ps <= S1;
        count <= 0;
    end

    else begin
        
        case (ps)
            S1: if(count < sec7) begin
                    ps <= S1;
                    count <= count + 1;
                end

                else begin
                    ps <= S2;
                    count <= 0;
                end

            S2: if(count < sec2) begin
                    ps <= S2;
                    count <= count +1;
                end

                else begin
                    ps <= S3;
                    count <= 0;
                end

            S3: if(count < sec5) begin
                    ps <= S3;
                    count <= count + 1;
                end

                else begin
                    ps <= S4;
                    count <= 0;
                end

            S4: if(count < sec2) begin
                    ps <= S4;
                    count <= count +1;
                end

                else begin
                    ps <= S5;
                    count <= 0;
                end

            S5: if(count < sec3) begin
                    ps <= S5;
                    count <= count + 1;
                end

                else begin
                    ps <= S6;
                    count <= 0;
                end

            S6: if(count < sec2) begin
                    ps <= S6;
                    count <= count + 1;
                end

                else begin
                    ps <= S1;
                    count <= 0;
                end


            default: begin
                ps <= S1;
                count <= 0;
            end
            
                    
        endcase

        //display the current state and the count
        $display("State = %b, Count = %b", ps, count);
    end
end

//assigning lights
//here the outputs(lights) are changed based on the state
always @(ps) begin
    case (ps)
        S1: begin
            light_M1 <= 3'b001;
            light_M2 <= 3'b001;
            light_MT <= 3'b100;
            light_S <= 3'b100;
        end

        S2: begin
            light_M1 <= 3'b001;
            light_M2 <= 3'b010;
            light_MT <= 3'b100;
            light_S <= 3'b100;
        end

        S3: begin
            light_M1 <= 3'b001;
            light_M2 <= 3'b100;
            light_MT <= 3'b001;
            light_S <= 3'b100;
        end

        S4: begin
            light_M1 <= 3'b010;
            light_M2 <= 3'b100;
            light_MT <= 3'b010;
            light_S <= 3'b100;
        end

        S5: begin
            light_M1 <= 3'b100;
            light_M2 <= 3'b100;
            light_MT <= 3'b100;
            light_S <= 3'b001;
        end

        S6: begin
            light_M1 <= 3'b100;
            light_M2 <= 3'b100;
            light_MT <= 3'b100;
            light_S <= 3'b010;
        end

        default: begin
            light_M1 <= 3'b000;
            light_M2 <= 3'b000;
            light_MT <= 3'b000;
            light_S <= 3'b000;
        end
    endcase
end

endmodule