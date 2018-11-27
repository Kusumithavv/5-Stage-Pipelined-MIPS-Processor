`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:37:47 04/02/2018 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(clock,WB,Memout,ALUOut,RegRD,WBreg,Memreg,ALUreg,RegRDreg); 
   input clock; 
   input [1:0] WB; 
   input [4:0] RegRD; 
   input [31:0] Memout,ALUOut; 
   output [1:0] WBreg; 
   output [31:0] Memreg,ALUreg; 
   output [4:0] RegRDreg; 
 
   reg [1:0] WBreg; 
   reg [31:0] Memreg,ALUreg; 
   reg [4:0] RegRDreg; 
    
   initial begin 
      WBreg = 0; 
      Memreg = 0; 
      ALUreg = 0; 
      RegRDreg = 0; 
        
   end 
    
    always@(posedge clock) 
    begin 
        WBreg <= WB; 
        Memreg <= Memout; 
        ALUreg <= ALUOut; 
        RegRDreg <= RegRD; 
    end 
    
endmodule 