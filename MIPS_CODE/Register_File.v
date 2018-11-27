`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:08:57 04/02/2018 
// Design Name: 
// Module Name:    Register_File 
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
module Register_File(clock,WE,InData,WrReg,ReadA,ReadB,OutA,OutB); 
    input [4:0] WrReg, ReadA, ReadB; 
    input WE,clock; 
    input [31:0] InData; 
    output [31:0] OutA,OutB; 
     
    reg [31:0] OutA, OutB;//2 32-bit output reg 
    reg [31:0] regfile[31:0];//32 32-bit registers -> R0-R31
     
    initial begin 
        OutA = 32'd0; //random values for initial 
        OutB = 32'd0; 
    end 
     
    always@(clock,InData,WrReg,WE) 
    begin 
      if(WE && clock) 
        begin 
         regfile[WrReg]<=InData;//write to register 
        // $display("O/P in Reg: R%d and Data= %d",WrReg,InData); 
        end 
 
    end 
     
    always @ (clock,ReadA,ReadB,WrReg) 
    begin 
        if(~clock) 
        begin 
      OutA <= regfile[ReadA];//read values from registers 
      OutB <= regfile[ReadB]; 
      
      end 
    end 
 
 
endmodule 
 
