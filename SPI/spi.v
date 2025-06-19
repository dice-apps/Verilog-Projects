

module spi(
    input wire clk,
    input wire reset,
    input wire [15:0] data_in, //Input data
    output wire spi_cs_L, //chip select (selecting the slave)
    output wire spi_sclk, //Serial CLK, these are wires
    output wire spi_data, //MOSI line, these are wires
    output wire [4:0]counter
);

reg [15:0]MOSI; //SPI shift register
reg [4:0]count; //control counter
reg cs_l; //SPI chip select (active low)
reg sclk;
reg [2:0]state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        MOSI <= 16'b0;
        count <= 5'd16;
        cs_l <= 1'b1;
        sclk <= 1'b0;
    end

    else begin
        case (state)
            S0: begin
                sclk <= 1'b0;
                cs_l <= 1'b1;
                state <= S1;
            end

            S1: begin
                sclk <= 1'b0;
                cs_l <= 1'b0;
                MOSI <= datain[count - 1];
                count <= count - 1;
                state <= S2;
            end

            S2: begin
                sclk <= 1'b1;
                if(count > 0) state <= 1;
                else begin
                    count <= 16;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end

assign spi_cs_L = cs_l;
    assign spi_sclk = sclk;
    assign spi_data = MOSI;
    assign counter = count;

endmodule