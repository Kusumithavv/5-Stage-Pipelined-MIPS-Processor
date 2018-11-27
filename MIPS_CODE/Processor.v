`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:59 04/02/2018 
// Design Name: 
// Module Name:    Processor 
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
module Processor(clock); 
    input clock; 
     
    //debugging vars 
    reg [31:0] cycle; 
    
    //IF vars 
    wire [31:0] nextpc,IFpc_plus_4,IFinst; 
    reg [31:0] pc; 
    
	 
    //ID vars 
    wire PCSrc; 
    wire [4:0] IDRegRs,IDRegRt,IDRegRd; 
    wire [31:0] IDpc_plus_4,IDinst; 
    wire [31:0] IDRegAout, IDRegBout; 
    wire [31:0] IDimm_value,BranchAddr,PCMuxOut,JumpTarget; 
     
    //control vars in ID stage 
    wire PCWrite,HazMuxCon,IFIDWrite,brne,breq,andi,ori,addi,subi,in_out; 
    wire [8:0] IDcontrol,ConOut; 
         
    //EX vars 
    wire [1:0] EXWB,ForwardA,ForwardB;//aluop; 
    wire [2:0] EXM; 
    wire [3:0] EXEX,ALUCon; 
    wire [4:0] EXRegRs,EXRegRt,EXRegRd,regtopass; 
    wire [31:0] EXRegAout,EXRegBout,EXimm_value, b_value; 
    wire [31:0] EXALUOut,ALUSrcA,ALUSrcB; 
     
    //MEM vars 
    wire [1:0] MEMWB; 
    wire [2:0] MEMM; 
    wire [4:0] MEMRegRd; 
    wire [31:0] MEMALUOut,MEMWriteData,MEMReadData; 
     
    //WB vars 
    wire [1:0] WBWB; 
    wire [4:0] WBRegRd; 
    wire [31:0] datatowrite,WBReadData,WBALUOut; 
     
    parameter port_addr = 32'b1111111111111100;
    //initial conditions 
    initial begin 
       pc = 0; 
       cycle = 0; 
    end 
     
	 
    //debugging variable 
    always@(posedge clock) 
    begin 
       cycle = cycle + 1; 
    end 
     
	  
	  
	  
    // Instruction Fetch (IF)     
	  //IDRegAout==IDRegBout -> breq    IDcontrol[6] = branch
	   //Fast Branch (Double confirmation)
    assign PCSrc = ((IDRegAout==IDRegBout)&breq)|((IDRegAout!=IDRegBout)&brne);
	 
    //assign IFFlush = PCSrc|jump; 
	 assign IFFlush = PCSrc;
    assign IFpc_plus_4 = pc + 4; 
 
		// Branch or Jump Confirmation. If PCSrc =1 -> Branch, else Jump / PC+4
    // assign nextpc = PCSrc ? BranchAddr : PCMuxOut; 
	 assign nextpc = PCSrc ? BranchAddr :IFpc_plus_4;
     

    always @ (posedge clock) begin 
       if(PCWrite) 
       begin 
          pc = nextpc; //update pc 
         // $display("PC: %d",pc); 
       end 
       //else 
        // $display("Skipped writting to PC - nop"); //nop dont update 
    end     
     
    INSTRUCTION_MEM IM(pc,IFinst); 
     
	  //Pipeline reg-> IF_ID 
    IF_ID IFIDreg(IFFlush,clock,IFIDWrite,IFpc_plus_4,IFinst,IDinst,IDpc_plus_4); 	
	 
	 //IDinst =IFinst
	 
	 
    /** 
     * Instruction Decode (ID) 
     */ 
	  // Opcode IDinst[31:26] is later sent to Control Unit in EX stage
	  //R-format instructions
   assign IDRegRs[4:0]=IDinst[25:21]; 
   assign IDRegRt[4:0]=IDinst[20:16]; 
   assign IDRegRd[4:0]=IDinst[15:11]; 
	
	//I-format instructions
	//Sign extended immediate value
   assign IDimm_value ={IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15],IDinst[15:0]}; 
   //Shift branch offset and add to PC value
	assign BranchAddr = (IDimm_value << 2) + IDpc_plus_4; 
	    
   Hazard_Unit HU(IDRegRs,IDRegRt,EXRegRt,EXM[1],PCWrite,IFIDWrite,HazMuxCon); 
	
   Control_Unit thecontrol(IDinst[31:26],ConOut,brne,breq,andi,ori,addi,subi,in_out); 
	//lwsw includes in out
	
	 //EXimm_value[5:0] -> funct , EXEX[1:0] -> aluop  IDcontrol[3:0]=EXEX
    ALU_Control_Unit ALUcontrol(andi,ori,addi,subi,IDcontrol[1:0],EXimm_value[5:0],ALUCon); 
	 
	 assign IDcontrol = HazMuxCon ? ConOut : 0;  
	//If there hazard detection is done, HazMuxCon =1,then Control unit output can be considered
	
   Register_File regs(clock,WBWB[0],datatowrite,WBRegRd,IDRegRs,IDRegRt,IDRegAout,IDRegBout); 
     
   ID_EX IDEXreg(clock,IDcontrol[8:7],IDcontrol[6:4],IDcontrol[3:0],IDRegAout,IDRegBout,IDimm_value,IDRegRs,IDRegRt,IDRegRd,EXWB,EXM,EXEX,EXRegAout,EXRegBout,EXimm_value,EXRegRs,EXRegRt,EXRegRd);                                                         
    
	
	 
	 //IDcontrol[3:0] -> EXEX
	 //IDcontrol[6:4] -> EXM
	 //IDcontrol[8:7] -> EXWB
	 /** Execution (EX) **/ 
    assign regtopass = EXEX[3] ? EXRegRd : EXRegRt; // if EXEX[3]=regdst=1 -> Rd else Rt
    assign b_value = EXEX[2] ? EXimm_value : EXRegBout; // if EXEX[2]=alusrc =1 -> imm value or Reg value
    
	 //Forward_Unit FU(MEMRegRd,WBRegRd,EXRegRs, EXRegRt, MEMWB[0], WBWB[0], ForwardA,ForwardB);
	 //WBWB = WBreg from MEMWB pipeline register
	 Forward_Unit FU(in_out,MEMRegRd,WBRegRd,EXRegRs, EXRegRt, MEMWB[0], WBWB[0], ForwardA,ForwardB);
	 
	 MUX MUX0(ForwardA,EXRegAout,datatowrite,MEMALUOut,port_addr,ALUSrcA); 
    MUX MUX1(ForwardB,b_value,datatowrite,MEMALUOut,0,ALUSrcB); 
	 
 
	 ALU_Module theALU(ALUCon,ALUSrcA,ALUSrcB,EXALUOut); 
     
    EX_MEM EXMEMreg(clock,EXWB,EXM,EXALUOut,regtopass,EXRegBout,MEMM,MEMWB,MEMALUOut,MEMRegRd,MEMWriteData); 
    
	 
	 /** Memory (Mem) **/ 
    DATA_MEM DM(MEMM[0],MEMM[1],MEMALUOut,MEMWriteData,MEMReadData); 
     

    MEM_WB MEMWBreg(clock,MEMWB,MEMReadData,MEMALUOut,MEMRegRd,WBWB,WBReadData,WBALUOut,WBRegRd); 
    // Write Back (WB) 
    assign datatowrite = WBWB[1] ? WBReadData : WBALUOut; 
     
endmodule    
