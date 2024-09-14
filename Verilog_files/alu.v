module alu(
input [31:0] A, 
input [31:0] B,
input [3:0] ALUSel ,
output reg [31:0] d_out 
) ;

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

always @(*)
begin 
    case(ALUSel)
    add_op: d_out = A + B ;
    sub_op: d_out = A - B ;
    sll_op: d_out = A << B[4:0] ;
    slt_op: d_out = (A[31] != B[31]) ? (A[31] ? 32'b1 : 32'b0) : ((A < B) ? 32'b1 : 32'b0); // Signed less than
    sltu_op: d_out = (A<B)? 32'b1 : 32'b0 ;
    xor_op: d_out = A^B ;
    srl_op: d_out = A >> B[4:0] ;
    sra_op: d_out = A >>> B[4:0] ;
    or_op: d_out = A | B ;
    and_op: d_out = A & B ; // bitwise and 
    jalr_op: d_out = (A + B) & (~(32'd1)) ; // adding the two numbers and setting last bit to zero by force 
    lui_op: d_out = B ; 
    default: d_out = 32'd0 ; 
    endcase 
end 

endmodule 
