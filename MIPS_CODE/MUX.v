`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:58:12 04/02/2018 
// Design Name: 
// Module Name:    MUX 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX(A,X0,X1,X2,X3,Out);//non-clocked mux 
input [1:0] A; 
input [31:0] X3,X2,X1,X0; 
output [31:0] Out; 
 
reg [31:0] Out; 
 
always@(A,X3,X2,X1,X0) 
begin 
  case(A) 
      2'b00: 
        Out <= X0; 
      2'b01: 
        Out <= X1; 
      2'b10: 
        Out <= X2; 
      2'b11: 
        Out <= X3; 
  endcase 
end 
 
endmodule 
