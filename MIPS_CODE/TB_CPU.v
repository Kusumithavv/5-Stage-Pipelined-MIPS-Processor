`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:08:55 04/03/2018
// Design Name:   Processor
// Module Name:   C:/Users/Hp/Documents/Xilinx/Digital_Project_2/TB_CPU.v
// Project Name:  Digital_Project_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_CPU;

	// Inputs
	reg clock;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	Processor cpu (
		.clock(clock)
	);

	initial begin
		clock = 1;	
	end
	
	always begin
		#5 clock = ~clock;
	end
	
	
	//FORMAT:
	//instantiated module name of Processor.
	//Instantiated module name of other modules in Processor.
	//register names in the other modules	
	
	initial begin
		//PC initialization
		cpu.pc=32'd0;		
		
		// Instruction Memory intialization 
		// add Rd,Rs,Rt 
		
		cpu.IM.instmem[0] = 32'h05490002;//addi R9,R10,2 WORKS
		cpu.IM.instmem[4] = 32'h00220020;//add R0,R1,R2 WORKS
		cpu.IM.instmem[8] = 32'h00851830;//and R3,R4,R5 WORKS	
		cpu.IM.instmem[12] = 32'h00E83032;//or R6,R7,R8 WORKS	
		cpu.IM.instmem[16] = 32'h0280B036;//COM R22,R20 WORKS	
		cpu.IM.instmem[20] = 32'h00A20022;//sub R0,R5,R2 WORKS
		cpu.IM.instmem[24] = 32'h00E83038;//Nor R6,R7,R8 WORKS
		
				
		$monitor($time," ---> ALU[d]=%d ,ALU[h]=%h ,R9=%d",cpu.theALU.Result,cpu.theALU.Result,cpu.regs.regfile[9]);
	
		// Register File initialization 
		for (i = 0; i < 32; i = i + 1)
			cpu.regs.regfile[i] = i; 
	 
		
		#400 $finish;
	end
     
	  
endmodule

