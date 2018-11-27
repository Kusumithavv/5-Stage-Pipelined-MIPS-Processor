module branchhistorytable(clk,pcsrc,pc,pcbranch,originalpc,pcnext,clrbp);
      input             clk;
	input      [1:0]  pcsrc;
	input      [31:0] originalpc, pcbranch, pc;
	output reg [31:0] pcnext;
	output reg        clrbp;
	reg [65:0] bht[127:0];
	reg [31:0] pcstorage;
	//66 bits, first 32 bits address, next 32 bits predicted address, 2 bits T/NT
	
	integer i;
	reg flag;           //flag enabled when its a prediction & disabled when its a misprediction
  	initial begin
		for (i=0; i<128; i=i+1) begin
        	        bht[i] = 66'b0;
		end
  	end

	integer j=0;
	integer count=0;
	integer target;          //location in bht pointing 1 line
	always @(*) begin                            //IF Stage
		// IF Stage
		flag = 1'b0;
		for (i=0; i<128; i=i+1) begin
			if (originalpc==bht[i][65:34] ) begin
				if (!bht[i][1]) begin
				  pcstorage = originalpc;
				  pcnext = bht[i][33:2];
				end
				flag = 1'b1;
				target = i;
			end
		end

		// ID and EX Stages   & flag enabled
		if (flag) begin
			if (pcsrc[0]) begin//Branch Taken
				clrbp = 1'b0;
				// Updating the buffer to branch taken
				case(bht[target][1:0])
      					2'b00: bht[target][1:0] = 2'b00;      //00-ST 01-WT 10-WNT 11-SNT
      					2'b01: bht[target][1:0] = 2'b00;
      					2'b10: bht[target][1:0] = 2'b01;
      					2'b11: bht[target][1:0] = 2'b10;
    				endcase
			end
			else begin//BNT
				clrbp = 1'b1;
				pcnext = pcstorage;
				// Updating the buffer to not taken
				case(bht[target][1:0])
      					2'b00: bht[target][1:0] = 2'b01;
      					2'b01: bht[target][1:0] = 2'b10;
      					2'b10: bht[target][1:0] = 2'b11;
      					2'b11: bht[target][1:0] = 2'b11;
    				endcase
			end
		end
		// flag not enabled -mispredicted
		else begin
			if (pcsrc[0]) begin//Branch Taken
				// Write into buffer at next available spot
				bht[count][1:0]   = 2'b00;
				bht[count][33:2]  = pcbranch;
				bht[count][65:34] = pc;
				pcnext = pcbranch;
				clrbp = 1'b0;
				count = count + 1;
				if (count > 127)
					count = 0;
			end
			else begin//Branch Not Taken
				clrbp = 1'b0;
				pcnext = originalpc;
			end
		end
	end
endmodule
