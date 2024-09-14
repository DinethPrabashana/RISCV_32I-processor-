module controller_tb;

reg [31:0] Instruction;
reg BrLT, BrEq ;
wire PCSel ;
wire [2:0] ImmSel;
wire RegWEn ;
wire BrUn ;
wire BSel ;
wire ASel ;
wire [3:0] ALUSel ;
wire [1:0] MemRW ;
wire [1:0] WBSel ;


controller dut_1(Instruction, BrLT, BrEq, PCSel, ImmSel, RegWEn, BrUn, BSel, ASel, ALUSel, MemRW, WBSel) ;

initial 
begin 
    BrLT = 0 ;
    BrEq = 0 ;
    Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b110011} ; // SLL
    #5 Instruction = {7'b0000000, 5'd1,5'd1, 3'd5, 5'd3, 7'b0110011} ; // SRL
    #5 Instruction = {7'b0100000, 5'd1,5'd1, 3'd5, 5'd3, 7'b0110011} ; // SRA
    #5 Instruction = {7'b0000000, 5'd1,5'd1, 3'd0, 5'd3, 7'b0110011} ; // ADD
    #5 Instruction = {7'b0100000, 5'd1,5'd1, 3'd0, 5'd0, 7'b0110011} ; //SUB
    #5 Instruction = {7'b0000000, 5'd1,5'd1, 3'd4, 5'd0, 7'b0110011} ; //XOR
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd6, 5'd3, 7'b0110011} ; // OR
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd7, 5'd3, 7'b0110011} ; // AND
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd2, 5'd3, 7'b0110011} ; // SLT
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd3, 5'd3, 7'b0110011} ; // SLTU
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd0, 5'd3, 7'b0000011} ; //LB
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b0000011} ; //LH
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd2, 5'd3, 7'b0000011} ; // LW
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd4, 5'd3, 7'b0000011} ; // LBU
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd5, 5'd3, 7'b0000011} ; // LHU
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b0010011} ; // SLLI
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd5, 5'd3, 7'b0010011} ; //SRLI
    #5 Instruction = {7'b0100000, 5'd1,5'd6, 3'd5, 5'd3, 7'b0010011} ; // SRAI
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd0, 5'd3, 7'b0010011} ; // ADDI 
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd7, 5'd3, 7'b0010011} ; // ANDI
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd6, 5'd3, 7'b0010011} ; // ORI
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd4, 5'd3, 7'b0010011} ; // XORI
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd2, 5'd3, 7'b0010011} ; // SLTI
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd3, 5'd3, 7'b0010011} ; // SLTIU 
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd0, 5'd3, 7'b1100111} ; // jalr
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd2, 5'd3, 7'b0100011} ; // SW 
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b0100011} ; // SH
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd0, 5'd3, 7'b0100011} ; // SB
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd0, 5'd3, 7'b1100011} ; // BEQ
    #5 BrEq = 0;
    #5 BrEq = 1 ;
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b1100011} ; // BNE 
    #5 BrEq = 0 ;
    #5 BrEq = 1 ;
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd4, 5'd3, 7'b1100011} ; // BLT
    #5 BrLT = 0 ;
    #5 BrLT = 1 ;
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd6, 5'd3, 7'b1100011} ; // BLTU
    #5 BrLT = 0 ;
    #5 BrLT = 1 ;
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd5, 5'd3, 7'b1100011} ; // BGE 
    #5 BrLT = 0 ;
    #5 BrLT = 1 ;
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd7, 5'd3, 7'b1100011} ; // BGEU 
    #5 BrLT = 0 ;
    #5 BrLT = 1 ;
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b1101111} ; // JAL 
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b0110111} ; // LUI 
    #5 Instruction = {7'd0, 5'd1,5'd1, 3'd1, 5'd3, 7'b0010111} ; // AUIPC
    #100 $finish ;

end 

endmodule 
