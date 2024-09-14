module controller(
input [31:0]inst ,
input BrLT,
input BrEq,
output reg PCSel,
output reg [2:0] ImmSel, 
output reg RegWEn,
output reg BrUn,
output reg BSel,
output reg ASel,
output reg [3:0] ALUSel, 
output reg [1:0] MemRW,
output reg [1:0] WBSel 
) ;

reg [6:0] opcode ;
reg [2:0] funct3 ;
reg funct7 ; //only the 5 th bit is required i.e inst[30]



// types 
parameter R_type = 7'b0110011 ;
parameter I_type = 7'b0000011 ;
parameter I_type_shamt = 7'b0010011 ;
parameter S_type = 7'b0100011 ;
parameter B_type = 7'b1100011 ;
parameter J_type = 7'b1101111 ;
parameter U_type_LUI = 7'b0110111 ;
parameter U_type_AUIPC = 7'b0010111 ;
parameter I_type_JALR = 7'b1100111 ;


//R type 
parameter SLL = 4'b0010 ;
parameter SRL = 4'b1010 ;
parameter SRA = 4'b1011 ;
parameter ADD = 4'b0000 ;
parameter SUB = 4'b0001 ;
parameter XOR = 4'b1000 ;
parameter OR = 4'b1100 ;
parameter AND = 4'b1110 ;
parameter SLT = 4'b0100 ;
parameter SLTU = 4'b0110 ;

//I_type 
/*parameter LB = 3'b000 ;
parameter LH = 3'b001 ;
parameter Lw = 3'b010 ;
parameter LBU = 3'b100 ;
parameter LHU = 3'b101 ;
*/

//I_type_shamt
parameter SLLI = 4'b001 ;
parameter SRLI = 4'b101 ;
//parameter SRAI = 4'b101 ; // same as SRLI 


parameter ADDI = 3'b000 ;
parameter ANDI = 3'b111 ;
parameter ORI = 3'b110 ;
parameter XORI = 3'b100 ;
parameter SLTI = 3'b010 ;
parameter SLTIU = 3'b011 ;

//S_type 
/*
parameter SW = 3'b010 ;
parameter SH = 3'b001 ;
parameter SB = 3'b000 ;
*/

//B_type 
parameter BEQ = 3'b000 ;
parameter BNE = 3'b001 ;
parameter BLT = 3'b100 ;
parameter BLTU = 3'b110 ;
parameter BGE = 3'b101 ;
parameter BGEU = 3'b111 ;


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
    opcode = inst[6:0] ;
    funct3 = inst[14:12] ;
    funct7 = inst[30] ;
    case (opcode)
    R_type: 
    begin 
        PCSel = 1'b0 ; // select PC+4
        ImmSel = 3'b000 ; // dont care 
        RegWEn = 1'b1 ; // write the value to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b0 ; // select rs2 
        ASel = 1'b0 ; // select rs1 
        MemRW = 2'b00 ; // dont care 
        WBSel = 2'b01 ; // select the alu signal

        case ({funct3,funct7})
        SLL: ALUSel = sll_op ;
        SRL: ALUSel = srl_op ;
        SRA: ALUSel = sra_op ; 
        ADD: ALUSel = add_op ; 
        SUB: ALUSel = sub_op ; 
        XOR: ALUSel = xor_op ; 
        OR: ALUSel = or_op ; 
        AND: ALUSel = and_op ; 
        SLT: ALUSel = slt_op ; 
        SLTU: ALUSel = sltu_op ; 
        default: ALUSel = 4'b0000 ;
        endcase  

    end 
    I_type: 
    begin 
        PCSel = 1'b0 ; // select PC+4
        ImmSel = 3'b000 ; // dont care 
        RegWEn = 1'b1 ; // write the value to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b0 ; // select rs1 
        MemRW = 2'b10 ; // read from memory 
        WBSel = 2'b00 ; // select the memory
        ALUSel = add_op ; // ADD operation 
    end 
    I_type_shamt: 
    begin 
        PCSel = 1'b0 ; // select PC+4
        RegWEn = 1'b1 ; // write the value to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select immediate 
        ASel = 1'b0 ; // select rs1 
        MemRW = 2'b00 ; // dont care 
        WBSel = 2'b01 ; // select the alu signal
        case(funct3) 
        ADDI: 
        begin
            ImmSel = 3'b000 ;
            ALUSel = add_op ;
        end 
        ANDI: 
        begin
            ImmSel = 3'b000 ;
            ALUSel = and_op ;
        end
        ORI: 
        begin
            ImmSel = 3'b000 ;
            ALUSel = or_op ;
        end
        XORI:
        begin
            ImmSel = 3'b000 ;
            ALUSel = xor_op ;
        end
        SLTI: 
        begin
            ImmSel = 3'b000 ;
            ALUSel = slt_op ;
        end
        SLTIU: 
        begin
            ImmSel = 3'b000 ;
            ALUSel = sltu_op ;
        end
        SLLI: 
        begin
            ImmSel = 3'b101 ;
            ALUSel = sll_op ;
        end
        SRLI: 
        begin
            ImmSel = 3'b101 ;
            if (funct7) ALUSel = sra_op ; // sra_operation
            else ALUSel = srl_op ;
        end
        default: 
        begin 
            ImmSel = 3'b000 ;
            ALUSel = 4'b0000 ;
        end 
        endcase 
    end 
    S_type: 
    begin 
        PCSel = 1'b0 ; // select PC+4
        ImmSel = 3'b001 ; // S type immediate 
        RegWEn = 1'b0 ; // disable the reg file
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b0 ; // select rs1 
        MemRW = 2'b01 ; // write to memory 
        WBSel = 2'b00 ; // dont care 
        ALUSel = add_op ; // ADD operation 
    end
    B_type: 
    begin 
        ImmSel = 3'b010 ; // S type immediate 
        RegWEn = 1'b0 ; // disable the reg file  
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b1 ; // select current pc 
        MemRW = 2'b00 ; // dont care  
        WBSel = 2'b00 ; // dont care 
        ALUSel = add_op ; // ADD operation 
        case (funct3)
        BEQ: 
        begin
            PCSel = BrEq? 1'b1:1'b0 ;
            BrUn = BrEq? 1'b0:1'b0 ;
        end
        BNE: 
        begin
            PCSel = BrEq? 1'b1:1'b0 ;
            BrUn = BrEq? 1'b0:1'b0 ;
        end
        BLT: 
        begin
            PCSel = BrLT? 1'b1:1'b0 ;
            BrUn = BrLT? 1'b0:1'b0 ;
        end
        BLTU: 
        begin
            PCSel = BrLT? 1'b1:1'b0 ;
            BrUn = BrLT? 1'b1:1'b1 ;
        end
        BGE: 
        begin
            PCSel = BrLT? 1'b0:1'b1 ;
            BrUn = BrLT? 1'b0:1'b0 ;
        end 
        BGEU: 
        begin
            PCSel = BrLT? 1'b0:1'b1 ;
            BrUn = BrLT? 1'b1:1'b1 ;
        end
        default: 
        begin 
            PCSel = 1'b0 ;
            BrUn = 1'b0 ;
        end 
        endcase 
    end
    J_type: 
    begin 
        PCSel = 1'b1 ; // taken
        ImmSel = 3'b011 ; // J type immediate 
        RegWEn = 1'b1 ; // write PC+4 to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b1 ; // select current PC 
        MemRW = 2'b00 ; // no mem operation 
        WBSel = 2'b10 ; // select the PC+4 line
        ALUSel = add_op ; // ADD operation 
    end
    U_type_LUI: 
    begin 
        PCSel = 1'b0 ; // not taken 
        ImmSel = 3'b100 ; // U type immediate 
        RegWEn = 1'b1 ; // write PC+4 to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b0 ; // dont care 
        MemRW = 2'b00 ; // no memory operation 
        WBSel = 2'b01 ; // select the alu line
        ALUSel = lui_op ; // ADD operation 
    end
    U_type_AUIPC: 
    begin 
        PCSel = 1'b0 ; // not taken 
        ImmSel = 3'b100 ; // U type immediate 
        RegWEn = 1'b1 ; // write PC+4 to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b1 ; // dont care 
        MemRW = 2'b00 ; // no memory operation 
        WBSel = 2'b01 ; // select the alu line
        ALUSel = add_op ; // ADD operation 
    end 
    I_type_JALR: 
    begin 
        PCSel = 1'b1 ; // taken 
        ImmSel = 3'b000 ; // I type immediate 
        RegWEn = 1'b1 ; // write PC+4 to rd 
        BrUn = 1'b0 ; // dont care 
        BSel = 1'b1 ; // select the immediate  
        ASel = 1'b0 ; // dont care 
        MemRW = 2'b00 ; // no memory operation 
        WBSel = 2'b10 ; // select the alu line
        ALUSel = jalr_op ; // JALR operation 
    end   
    default: 
    begin 
        PCSel = 1'b0 ; 
        ImmSel = 3'b000 ;
        RegWEn = 1'b0 ; 
        BrUn = 1'b0 ;  
        BSel = 1'b0 ;  
        ASel = 1'b0 ; 
        MemRW = 2'b00 ;  
        WBSel = 2'b00 ; 
        ALUSel = add_op ;
    end 
    endcase 

end 

endmodule 
