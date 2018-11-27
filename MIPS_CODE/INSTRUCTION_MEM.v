`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:21:35 04/02/2018 
// Design Name: 
// Module Name:    INSTRUCTION_MEM 
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
module INSTRUCTION_MEM(PC,Inst); 
    input [31:0] PC; 
    output [31:0] Inst; 
     
    reg [31:0] instmem[511:0];//32-bit locations of Instruction Memory
     
    assign Inst = instmem[PC]; //assigns output to instruction 
     
endmodule 
