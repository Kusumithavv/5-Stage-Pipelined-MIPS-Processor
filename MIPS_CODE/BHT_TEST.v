`timescale 10ns/1ps
module branchhistory_test();
  reg         clk;
  reg  [1:0]  pcsrc;
  reg  [31:0] originalpc, pcbranch, pc;
  wire [31:0] pcnext;
  wire        clrbp;

   branchhistorytable DUT(clk,pcsrc,pc,pcbranch,originalpc,pcnext,clrbp);

  //  clock 
  always begin
    clk <= 1;
    #5;
    clk <= 0;
    # 5;
  end

  initial begin
    // No -> No: Regular instruction
    originalpc <= 32'h1;
    #1;
    pc <= 32'h1;
    originalpc <= 32'h2;
    pcsrc <= 2'b00;
    #1;

    // No -> Yes: Normal, non-existing in buffer, place originalpc values into buffer[0]
    pc <= 32'h2;
    originalpc <= 32'h3;
    pcsrc<=2'b00;
    #1;
    pc <= 32'h3;
    originalpc <= 32'h4;
    pcbranch <= 32'h50;
    pcsrc <= 2'b01;
    #1;


    // No -> Yes: Normal, non-existing in buffer, place originalpc values into buffer[1]
    pc <= 32'h4;
    originalpc <= 32'h50;
    pcsrc     <= 2'b00;
    #1;
    pc = 32'h50;
    originalpc <= 32'h51;
    pcbranch <= 32'h10;
    pcsrc <= 2'b01;
    #1;

    // Yes -> No: Existing in buffer, pcsrc[0] is false
    pc <= 32'h51;
    originalpc <= 32'h3;
    pcsrc <=2'b00;
    #1;
    pcsrc <= 2'b00;     // clrbp should be generated, originalpc comes back and is pcnext

    // Yes -> Yes: Existing in buffer, pcsrc[0] is true
    pc = 32'h3;
    originalpc <= 32'h23;
    pcsrc<=2'b00;
    #1;
    pcsrc <= 2'b01;
    pc <= 32'h23;
    originalpc <= 32'h24;
    #1;
    pc <=32'h24;
    originalpc <=32'h23;
    pcsrc<=2'b00;
    #1;
    pc <=32'h24;
    pcsrc<=2'b01;
    originalpc <=32'h25;
    #1;
    pcsrc<=2'b00;
    originalpc <= 32'h23;
    pc<=32'h24;
    #1
    pcsrc<=2'b01;
    originalpc<=32'h88;
    pc<=32'h23;
    #1
    pcsrc<=2'bx;
    originalpc<=32'hx;
    pc<=32'hx;
    pcbranch<=32'hx;
    



  end

endmodule
