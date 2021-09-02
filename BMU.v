`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 04:26:52 PM
// Design Name: 
// Module Name: BMU
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


module BMU #(parameter data_width = 2) ( 
    input       [data_width-1 : 0] rx_data,
    input       [data_width-1 : 0] trellis,
    output wire [data_width-1 : 0] bmu_out
    );

reg [data_width-1 : 0] temp;
always @*
    begin
        temp[0] = !(rx_data[0] ^ trellis[0]);
        temp[1] = !(rx_data[1] ^ trellis[1]);   
    end
   assign bmu_out = temp[0] + temp[1];
endmodule
