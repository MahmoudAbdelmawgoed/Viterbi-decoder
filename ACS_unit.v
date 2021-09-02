`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 09:16:08 PM
// Design Name: 
// Module Name: ACS_unit
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


module ACS_unit #(parameter data_width = 2, parameter path_width = 4, parameter seq_width = 10) (
     input clk,
     input reset,
     input Enable1,
     input Enable2,
     input Enable3,
     input Enable4,
     input [1:0] sel,
     input      [data_width-1 : 0] acs00_branch,
     input      [data_width-1 : 0] acs01_branch,
     input      [data_width-1 : 0] acs10_branch,
     input      [data_width-1 : 0] acs11_branch,

     output wire [path_width-1 : 0] pmu00,
     output wire [seq_width-1  : 0] seq00,

     output wire [path_width-1 : 0] pmu01,
     output wire [seq_width-1  : 0] seq01,

     output wire [path_width-1 : 0] pmu10,
     output wire [seq_width-1  : 0] seq10,

     output wire [path_width-1 : 0] pmu11,
     output wire [seq_width-1  : 0] seq11
    );

ACS ACS00( .clk(clk), .reset(reset), .Enable(Enable1), .bmu1(acs00_branch), .sel(sel),
.pmu1(pmu00), .bmu2(acs01_branch), .pmu2(pmu10), .pmu(pmu00), .seq1(seq00), .seq2(seq10), .concatenate(0), .seq(seq00));

ACS ACS01( .clk(clk), .reset(reset), .Enable(Enable2), .bmu1(acs01_branch), .sel(sel),
.pmu1(pmu00), .bmu2(acs00_branch), .pmu2(pmu10), .pmu(pmu01), .seq1(seq00), .seq2(seq10), .concatenate(1), .seq(seq01));

ACS ACS10( .clk(clk), .reset(reset), .Enable(Enable3), .bmu1(acs10_branch), .sel(sel),
.pmu1(pmu01), .bmu2(acs11_branch), .pmu2(pmu11), .pmu(pmu10), .seq1(seq01), .seq2(seq11), .concatenate(0), .seq(seq10));

ACS ACS11( .clk(clk), .reset(reset), .Enable(Enable4), .bmu1(acs11_branch), .sel(sel),
.pmu1(pmu01), .bmu2(acs10_branch), .pmu2(pmu11), .pmu(pmu11), .seq1(seq01), .seq2(seq11), .concatenate(1), .seq(seq11));

endmodule