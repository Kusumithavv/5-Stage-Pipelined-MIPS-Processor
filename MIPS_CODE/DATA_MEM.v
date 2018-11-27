`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:59:21 04/02/2018 
// Design Name: 
// Module Name:    DATA_MEM 
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
module DATA_MEM(MemWrite,MemRead,Addr,Wdata,Rdata); 
    input [31:0] Addr,Wdata; 
    input MemWrite,MemRead; //control signals
    output [31:0] Rdata; 
     
    reg [31:0] Rdata; 
    reg [31:0] datamem[127:0];//16 32-bit registers 
   
 
    always@(Addr,Wdata,MemWrite,MemRead) 
    if(MemWrite) 
    begin 
      //$display("Writing %d -> Addr: %d",Wdata,Addr); 
      datamem[Addr]<=Wdata; //memory write 
    end 
 
    always@(Addr,Wdata,MemWrite,MemRead) 
    if(MemRead) 
      Rdata <= datamem[Addr];//memory read 
 
endmodule 
