`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:51:49 04/01/2018
// Design Name:   ALU_Module
// Module Name:   C:/Users/Hp/Documents/Xilinx/Digital_Project_2/TB_ALU_Module.v
// Project Name:  Digital_Project_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_ALU_Module;

	// Inputs
	reg [3:0] ALUCon;
	reg [7:0] DataA;
	reg [7:0] DataB;

	// Outputs
	wire [7:0] Result;

	// Instantiate the Unit Under Test (UUT)
	ALU_Module uut (
		.ALUCon(ALUCon), 
		.DataA(DataA), 
		.DataB(DataB), 
		.Result(Result)
	);

	initial begin
		// Initialize Inputs
		ALUCon = 0;
		DataA = 0;
		DataB = 0;
	end
		
        
		// Add stimulus here
		
		initial begin
		#100; //AND
		ALUCon = 4'b0000;
		DataA = 8'b00000011;
		DataB = 8'b01110010;
		end
		
		initial begin
		#150; //OR
		ALUCon = 4'b0001;
		DataA = 8'b00001111;
		DataB = 8'b11000010;
		end
		
		initial begin
		#200; //ADD
		ALUCon = 4'b0010;
		DataA = 8'b11110011;
		DataB = 8'b00000010;
		end
		
		initial begin
		#250; //SUB
		ALUCon = 4'b0011;
		DataA = 8'b00000111;
		DataB = 8'b00000010;
		end
		
		initial begin
		#300; //NOR
		ALUCon = 4'b0100;
		DataA = 8'b11110011;
		DataB = 8'b00110010;
		end
		
		initial begin
		#350; //EXOR
		ALUCon = 4'b0101;
		DataA = 8'b10110011;
		DataB = 8'b00110010;
		end
		
		initial begin
		#400; //Increment
		ALUCon = 4'b0110;
		DataA = 8'b11111110;
		DataB = 8'b00000000;
		end
		
		initial begin
		#450; //NOR
		ALUCon = 4'b0111;
		DataA = 8'b11111111;
		DataB = 8'b00000000;
		end
		
		initial begin
		#500; //COMPLEMENT
		ALUCon = 4'b1000;
		DataA = 8'b11111111;
		DataB = 8'b00000000;
		end
		
		initial begin				
		$monitor ($time ,"   %b 	%b		%b		%b",ALUCon,DataA,DataB,Result);		
	   end
		
		initial #550 $finish; 
	
      
endmodule

