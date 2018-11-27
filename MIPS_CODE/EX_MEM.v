`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:15 04/02/2018 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(clock,WB,M,ALUOut,RegRD,WriteDataIn,Mreg,WBreg,ALUreg,RegRDreg,WriteDataOut); 
   input clock; 
   input [1:0] WB; 
   input [2:0] M; 
   input [4:0] RegRD; 
   input [31:0] ALUOut,WriteDataIn; 
   output [1:0] WBreg; 
   output [2:0] Mreg; 
   output [31:0] ALUreg,WriteDataOut; 
   output [4:0] RegRDreg; 
 
   reg [1:0] WBreg; 
   reg [2:0] Mreg; 
   reg [31:0] ALUreg,WriteDataOut; 
   reg [4:0] RegRDreg; 
    
   initial begin 
      WBreg=0; 
      Mreg=0; 
      ALUreg=0; 
      WriteDataOut=0; 
      RegRDreg=0; 
   end 
    
    
    always@(posedge clock) 
    begin 
        WBreg <= WB; 
        Mreg <= M; 
        ALUreg <= ALUOut; 
        RegRDreg <= RegRD; 
        WriteDataOut <= WriteDataIn; 
    end 
 
endmodule 
 