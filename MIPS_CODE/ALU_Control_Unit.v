`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:30 04/01/2018 
// Design Name: 
// Module Name:    ALU_Control_Unit 
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
module ALU_Control_Unit(andi,ori,addi,subi,ALUOp,funct,ALUCon); 
    input [1:0] ALUOp; 
    input [5:0] funct; 
    input andi,ori,addi,subi; 
    output [3:0] ALUCon; 
     
    reg [3:0] ALUCon; 
     
    always@(ALUOp or funct or andi or ori or addi or subi) 
    begin 
	 //$display("ALUOp =%h, funct =%h, addi=%b,ori=%b,subi=%b,andi=%b",ALUOp,funct,addi,ori,subi,andi);
		//$display("ALUOp =%h",ALUOp);
	  case(ALUOp) 
        2'b00://lds or sts or in or out
           ALUCon = 4'b0010; //same as add
                
        2'b01://R-type 
        begin		  
			   case(funct)
				6'b110000: 
              ALUCon = 4'b0000;//and -> 30
				  
            6'b110010:
              ALUCon = 4'b0001;//or -> 32
				  
            6'b100000: 
              ALUCon = 4'b0010;//add -> 20
				  
            6'b100010: 
              ALUCon = 4'b0011;//sub -> 22
				  
			   6'b111000:
              ALUCon = 4'b0100;//nor -> 38  				  
				  
			   6'b110100:
              ALUCon = 4'b0101;//Exor -> 34
				  
			   6'b100100: 
              ALUCon = 4'b0110;//inc -> 24
				  
			   6'b100110: 
              ALUCon = 4'b0111;//dec -> 26 
				  
			   6'b110110: 
              ALUCon = 4'b1000;//not -> 36		  
             endcase             
        end 
		
		2'b10://breq or brne
      ALUCon = 4'b0011; //same as sub
		
      2'b11://immediate 
      begin 
          if(andi) 
             ALUCon = 4'b0000;//andi         
          if(ori)  
             ALUCon = 4'b0001;//ori  
          if(addi) 
             ALUCon = 4'b0010;//addi          		
			 if(subi) 
             ALUCon = 4'b0011;//subi 
		end
		
 endcase 
 
 end          
     
endmodule 
