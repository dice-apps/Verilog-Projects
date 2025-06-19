`include "spi.v"

module spi_tb();

reg clk;
reg reset;
reg [15:0]data_in;

wire spi_cs_L;
wire spi_sclk;
wire spi_data;
wire [4:0]counter;

spi dut(
    .clk(clk),
    .reset(reset),
    .data_in(data_in);
    .spi_cs_L(spi_cs_L);
    .spi_sclk(spi_sclk);
    .spi_data(spi_data);
);

endmodule