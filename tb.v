`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2021 11:16:17 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
parameter data_width = 2;
parameter path_width = 4;
parameter seq_width = 5;
 // inputs 
 reg clk;
 reg reset;
 reg [data_width-1 : 0] state;
 reg [data_width-1 : 0] rx_data;
 wire [seq_width-1 : 0] sequence;
 // Instantiate the Unit Under Test (UUT)
  top top(.clk(clk), .reset(reset), .state(state), .rx_data(rx_data), .sequence(sequence));

  always #5 clk = ~clk;

  initial 
    begin
        // Initialize Inputs
        $display ("###################################################");
        clk         = 1'b0;
        reset       = 1'b0;
        state       = 2'b11;
        rx_data     = 2'b01;
        #1 reset    = 1'b1;
        #2 reset    = 1'b0;
        #10 rx_data = 2'b10;
        #10 rx_data = 2'b11;
        #10 rx_data = 2'b00;
        #10 rx_data = 2'b00;
     //   5  15 25 35 45 55
     //   01 10 10 11 00 00
     #10
     $display ("sequence = %0b at time = %0t", sequence, $time);
     $display ("###################################################");
     $finish;
    end
endmodule
