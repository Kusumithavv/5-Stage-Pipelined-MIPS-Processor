`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:32 04/02/2018 
// Design Name: 
// Module Name:    Hazard_Unit 
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
module Hazard_Unit(IDRegRs,IDRegRt,EXRegRt,EXMemRead,PCWrite,IFIDWrite,HazMuxCon); 
    input [4:0] IDRegRs,IDRegRt,EXRegRt; 
    input EXMemRead; 
    output PCWrite, IFIDWrite, HazMuxCon; 
     
    reg PCWrite, IFIDWrite, HazMuxCon; 
     
    always@(IDRegRs,IDRegRt,EXRegRt,EXMemRead) 
    if(EXMemRead&((EXRegRt == IDRegRs)|(EXRegRt == IDRegRt))) //RAW hazard detection
       begin//stall 
           PCWrite = 0; 
           IFIDWrite = 0; 
           HazMuxCon = 1; 
       end 
    else 
       begin//no stall 
           PCWrite = 1; 
           IFIDWrite = 1; 
           HazMuxCon = 1; 
     
       end 
 
endmodule 