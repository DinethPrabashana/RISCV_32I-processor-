module alu_tb;

reg [31:0] A , B ;
reg [3:0] ALUSel ;
wire [31:0] d_out ;

//alu operations 
parameter add_op = 4'b0000 ;
parameter sub_op = 4'b0001 ;
parameter sll_op = 4'b0010 ;
parameter slt_op = 4'b0011 ;
parameter sltu_op = 4'b0100 ;
parameter xor_op = 4'b0101 ;
parameter srl_op = 4'b0110 ;
parameter sra_op = 4'b0111 ;
parameter or_op = 4'b1000 ;
parameter and_op = 4'b1001 ;
parameter jalr_op = 4'b1010 ;
parameter lui_op = 4'b1011 ;

alu dut_1(A, B, ALUSel, d_out) ;

initial 
begin 
    A = 32'd1 ;
    B = 32'd2 ;
    ALUSel = add_op ;
    #5 ALUSel = sub_op ;
    #5 ALUSel = sll_op ;
    #5 ALUSel = slt_op ;
    #5 ALUSel = sltu_op ;
    #5 ALUSel = xor_op ;
    #5 ALUSel = srl_op ;
    #5 ALUSel = sra_op ;
    #5 ALUSel = or_op ;
    #5 ALUSel = and_op ;
    #5 ALUSel = jalr_op ;
    #5 ALUSel = lui_op ;
    #100 $finish ;

end 

endmodule 
