`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:50 04/02/2018 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(flush,clock,IFIDWrite,PC_Plus4,Inst,InstReg,PC_Plus4Reg); 
    input [31:0] PC_Plus4,Inst; 
    input clock,IFIDWrite,flush; 
    output [31:0] InstReg, PC_Plus4Reg; 
     
    reg [31:0] InstReg, PC_Plus4Reg; 
     
    initial begin 
        InstReg = 0; 
        PC_Plus4Reg = 0; 
    end 
     
    always@(posedge clock) 
    begin 
        if(flush) 
        begin 
           InstReg <= 0; 
           PC_Plus4Reg <=0; 
        end 
        else if(IFIDWrite) 
        begin 
           InstReg <= Inst; 
           PC_Plus4Reg <= PC_Plus4; 
        end 
    end 
 
endmodule 
