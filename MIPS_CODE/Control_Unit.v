`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:16 04/01/2018 
// Design Name: 
// Module Name:    Control_Unit 
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
module Control_Unit(Op,CtrlOut,brne,breq,andi,ori,addi,subi,in_out); 
   input [5:0] Op; 
   output[8:0] CtrlOut; 
   output brne,breq,andi,ori,addi,subi,in_out; 
  
   wire regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch; 
    
   //determines type of instruction 
   wire r = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]; //0
   
	assign addi = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&Op[0]; //1
	assign subi = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0]; //2
   
   assign andi = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]; //3
   assign ori = ~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0]; //4
	
   assign breq = ~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&Op[0]; //5
   assign brne = ~Op[5]&~Op[4]&~Op[3]&Op[2]&Op[1]&~Op[0]; //6
	
	wire in = ~Op[5]&Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]; //10
   wire out = ~Op[5]&Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0]; //14
  
	wire lds = Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]; //20
   wire sts = Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];  //24
	
   wire imm = andi|ori|addi|subi; //immediate value type 

	wire lwsw = lds|sts;
	assign in_out=in|out;
   wire x =lwsw|in_out;
	
   //seperate control arrays for reference 
   wire [3:0] EXE; 
   wire [2:0] M; 
   wire [1:0] WB; 
    
  // microcode control 
  assign regdst = r; 
  assign alusrc = lds|sts|imm|in_out; 
  assign memtoreg = lds|in; 
  assign regwrite = r|lds|imm|in; 
  assign memread = lds|in; 
  assign memwrite = sts|out; 
  assign branch = breq|brne; 
   
  // EXE control 
  assign EXE[3] = regdst; 
  assign EXE[2] = alusrc; 
  
  // ALU Opcodes
  // lds sds in out=00,r=01,br=10,imm=11
  
	assign EXE[1] = ((imm|branch)&(!x)) ? 1:0;
   assign EXE[0] = ((imm|r)&(!x))? 1:0;
  //M control 
  assign M[2] = branch; 
  assign M[1] = memread; 
  assign M[0] = memwrite; 
   
  //WB control 
  assign WB[1] = memtoreg; //not same as diagram 
  assign WB[0] = regwrite; 
   
  //output control in pipeline
  assign CtrlOut[8:7] = WB; //2 bits control
  assign CtrlOut[6:4] = M;  //3 bits control
  assign CtrlOut[3:0] = EXE; //4 bits control
   
endmodule 