`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2021 05:42:23 PM
// Design Name: 
// Module Name: ACS
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


module ACS #(parameter data_width = 2, parameter path_width = 4, parameter seq_width = 5) (
	 input clk,
	 input reset,
	 input Enable,
	 input      [data_width-1 : 0] bmu1,
	 input      [path_width-1 : 0] pmu1,
	 input      [data_width-1 : 0] bmu2,
	 input      [path_width-1 : 0] pmu2,
	 input      [path_width-1 : 0] seq1, // 9 bits then concatenate to be 10 bits
	 input      [path_width-1 : 0] seq2, // 9 bits then concatenate to be 10 bits
	 input concatenate,
	 input [1:0] sel,
	 output reg [path_width-1 : 0] pmu,
	 output reg [seq_width-1  : 0] seq
    );
	
	// 3bits
reg [path_width-1 : 0] adder1_out; // 2 bits + 4 bits = 5 bits when computing max path number, it was 12
reg [path_width-1 : 0] adder2_out;
reg [path_width-1 : 0] mux_out;
reg [seq_width-1 : 0] seq_mux;
reg [seq_width-1 : 0] MUX;

always @ (posedge clk or posedge reset)
	begin
		if (reset)
			begin
				pmu <= 4'd0;  // path_width
				seq <= 5'd0; // seq_width
			end
		else if (Enable)
			begin
				pmu <= MUX;
				seq <= seq_mux; 
			end
		else
			seq <= seq_mux;
	end

always @*
	begin
		adder1_out = bmu1 + pmu1;
		adder2_out = bmu2 + pmu2;
		if(adder1_out > adder2_out)
			begin
				mux_out = adder1_out;
				seq_mux = {seq1, concatenate};
			end
		else  
			begin
				mux_out = adder2_out;
				seq_mux = {seq2, concatenate};
			end
		case(sel)
			2'b00 : MUX   = adder1_out;
			2'b01 : MUX   = mux_out;
			2'b10 : MUX   = adder2_out;
			default : MUX = mux_out;
		endcase
		// el mux da 34an f awl clock cycle el mafrod n el adder el tany ally goa el ACS myshtghlsh f el mux da by3ml kda f3ln 
		// b3d kda 3ady mn el clk el tanya el adder el awl w el tany hysht8lo w y7sl el comparison w n select 3ady

end
endmodule
