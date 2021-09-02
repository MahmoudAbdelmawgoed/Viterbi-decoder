`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2021 12:54:17 AM
// Design Name: 
// Module Name: top
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


module top #(parameter data_width = 2, parameter path_width = 4, parameter seq_width = 5)(
	input clk,
    input reset,
    input [data_width-1 : 0] state,
	input [data_width-1 : 0] rx_data,
	output reg [seq_width-1  : 0] sequence
    );
wire [path_width-1 : 0] pmu00;
wire [path_width-1 : 0] pmu01;
wire [path_width-1 : 0] pmu10;
wire [path_width-1 : 0] pmu11;
wire [seq_width-1  : 0] seq00;
wire [seq_width-1  : 0] seq01;
wire [seq_width-1  : 0] seq10;
wire [seq_width-1  : 0] seq11;
wire [data_width-1 : 0] bmu_out00;
wire [data_width-1 : 0] bmu_out01;
wire [data_width-1 : 0] bmu_out10;
wire [data_width-1 : 0] bmu_out11;
reg Enable1;
reg Enable2;
reg Enable3;
reg Enable4;
reg [1:0] sel;

BMU_top  BMU ( .rx_data(rx_data), .bmu_out00(bmu_out00), .bmu_out01(bmu_out01), .bmu_out10(bmu_out10), .bmu_out11(bmu_out11));


ACS_unit ACS (.clk(clk), .reset(reset), .Enable1(Enable1), .Enable2(Enable2), .Enable3(Enable3), .Enable4(Enable4), 
.acs00_branch(bmu_out00), .acs01_branch(bmu_out01),.acs10_branch(bmu_out10), .acs11_branch(bmu_out11),
.pmu00(pmu00), .seq00(seq00), .pmu01(pmu01), .seq01(seq01), .pmu10(pmu10), .seq10(seq10), .pmu11(pmu11),
.seq11(seq11), .sel(sel));


reg [2:0] counter;
reg [seq_width-1 : 0] Right_path;
reg [seq_width-1 : 0] Right_path1;
reg [seq_width-1 : 0] Right_path2;

reg [path_width-1 : 0] max1;
reg [path_width-1 : 0] max2;
always @(posedge clk or posedge reset) 
	begin 
		if(reset)
			counter <= 3'd0;
		 else 
		 	counter <= counter + 1'b1;
	end

/*always @*
	begin
		if( counter == 3'd0)
			begin
				Enable   = 1'b0;
				sequence = 5'd0;
				sel      = 1'b0;
			end
		else if(counter == 3'd4)
			begin
				Enable   = 1'b1;
				sequence = 5'd0;
			    sel      = 1'b0;
			end
		else if(counter == 3'd5)
			begin 
				Enable   = 1'b1;
				sequence = Right_path;
				sel      = 1'b0;
			end
		else if(counter == 3'd1)
			begin 
				Enable   = 1'b1;
				sel      = 1'b1;
			end
		else
			begin
				Enable   = 1'b1;
				sequence = 5'd0;
				sel      = 1'b0;
			end
	end*/

	always @*
		begin
			case (counter)
				3'd0 : begin
						case (state)
// amshy wra kol state htla2y n kol state f awl clock cycle bysh8l 2 states mo3ynen bs y3ny fi 2 ACS bs ally hysht8lo f awl clock 
// 3la 7sb el initial state eh 							
							2'b00 : begin 		
									Enable1  = 1'b1;
									Enable2  = 1'b1;
									Enable3  = 1'b0;
									Enable4  = 1'b0;
								    sel      = 2'b00; // adder1
							end

							2'b01 : begin 
									Enable1  = 1'b0;
									Enable2  = 1'b0;
									Enable3  = 1'b1;
									Enable4  = 1'b1;
									sel      = 2'b00; // adder1
							end	

							2'b10 : begin 
									Enable1  = 1'b1;
									Enable2  = 1'b1;
									Enable3  = 1'b0;
									Enable4  = 1'b0;
									sel      = 2'b10; // adder2
							end	

							2'b11 : begin 
									Enable1  = 1'b0;
									Enable2  = 1'b0;
									Enable3  = 1'b1;
									Enable4  = 1'b1;
									sel      = 2'b10; // adder2
							end
						endcase
						sequence = 5'd0;		
				end

				3'd1 : begin
					case (state)
							2'b00 : sel = 2'b00; // adder1
							2'b01 : sel = 2'b10; // adder2
							2'b10 : sel = 2'b00; // adder1
							2'b11 :	sel = 2'b10; // adder2
					endcase
						Enable1  = 1'b1;
						Enable2  = 1'b1;
						Enable3  = 1'b1;
						Enable4  = 1'b1;
						sequence = 5'd0;
				end

				3'd5 : begin
						sel      = 2'b01;
						Enable1  = 1'b1;
						Enable2  = 1'b1;
						Enable3  = 1'b1;
						Enable4  = 1'b1;
						sequence = Right_path;
				end

				default : begin 
						sel      = 2'b01;
						Enable1  = 1'b1;
						Enable2  = 1'b1;
						Enable3  = 1'b1;
						Enable4  = 1'b1;
						sequence = 5'd0;
				end
			endcase
		end
//////////////////////////////////////////////////////// Comparator ///////////////////////////////////////////////
always @*
	begin
		if(pmu00 > pmu01) begin
			Right_path1 = seq00;
			max1 = pmu00;
			end
		else begin
			Right_path1 = seq01;
            max1 = pmu01;
            end
		if (pmu10 > pmu11) begin
			Right_path2 = seq10;
			max2 = pmu10;
			end
		else begin
			Right_path2 = seq10;
            max2 = pmu11;
            end
		if(max1 > max2)
			Right_path = Right_path1;
		else
			Right_path = Right_path2;
	end
endmodule
