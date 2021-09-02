`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 04:44:11 PM
// Design Name: 
// Module Name: BMU_top
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


module BMU_top #(parameter data_width = 2) (
    input       [data_width-1 : 0] rx_data,
    output wire [data_width-1 : 0] bmu_out00,
    output wire [data_width-1 : 0] bmu_out01,
    output wire [data_width-1 : 0] bmu_out10,
    output wire [data_width-1 : 0] bmu_out11
    );
wire [data_width-1 : 0] state00;
wire [data_width-1 : 0] state11;
wire [data_width-1 : 0] state10;
wire [data_width-1 : 0] state01;
// hena bdl m a3ml el convolutional encoder b el FSM 3mlt zy lookup table fih 3ltol el values ally htdkhol k-unput ll BMU w da akid
// 3la 7sb shakl el encoder w el states ally hy3mlha b el polynomila y3ny mkan el XOR fen blzbt
assign state00 = 00;
assign state11 = 11;
assign state10 = 10;
assign state01 = 01;

BMU bmu00 (.rx_data(rx_data), .trellis(state00), .bmu_out(bmu_out00));
BMU bmu01 (.rx_data(rx_data), .trellis(state11), .bmu_out(bmu_out01));
BMU bmu10 (.rx_data(rx_data), .trellis(state10), .bmu_out(bmu_out10));
BMU bmu11 (.rx_data(rx_data), .trellis(state01), .bmu_out(bmu_out11));

endmodule
