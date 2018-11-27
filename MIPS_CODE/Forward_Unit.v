`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:44 04/02/2018 
// Design Name: 
// Module Name:    Forward_Unit 
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
module Forward_Unit(in_out,MEMRegRd,WBRegRd,EXRegRs,EXRegRt, MEM_RegWrite, WB_RegWrite, ForwardA, ForwardB); 
   input[4:0] MEMRegRd,WBRegRd,EXRegRs,EXRegRt;  // Reg port 4 bit data 
   input MEM_RegWrite, WB_RegWrite; //control signals 
	input in_out;
   output[1:0] ForwardA, ForwardB; 
 
   reg[1:0] ForwardA, ForwardB; 
    
   //Forward A 
   always@(MEM_RegWrite or MEMRegRd or EXRegRs or WB_RegWrite or WBRegRd) 
   begin 
      if((MEM_RegWrite)&&(MEMRegRd != 0)&&(MEMRegRd == EXRegRs)) 
         ForwardA = 2'b10; // 2nd signal will be selected in MUX
      else if((WB_RegWrite)&&(WBRegRd != 0)&&(WBRegRd == EXRegRs)&&(MEMRegRd != EXRegRs) ) 
         ForwardA = 2'b01;  // 1st signal will be selected in MUX
		else if(in_out)
			ForwardA = 2'b11; 
      else //If no hazard, no forwarding required
         ForwardA = 2'b00; 
   end 
 
   //Forward B 
   always@(WB_RegWrite or WBRegRd or EXRegRt or MEMRegRd or MEM_RegWrite) 
   begin 
      if((WB_RegWrite)&&(WBRegRd != 0)&&(WBRegRd == EXRegRt)&&(MEMRegRd != EXRegRt) ) 
         ForwardB = 2'b01; 
      else if((MEM_RegWrite)&&(MEMRegRd != 0)&&(MEMRegRd == EXRegRt)) 
         ForwardB = 2'b10; 
      else  
         ForwardB = 2'b00; 
			//$display("ForwardB= %b ",ForwardB);
   end 
 
endmodule