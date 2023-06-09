//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Alexander Faust and Azra Rangwala
// 
//     Create Date: 2023-05-15
//     Module Name: controller
//     Description: 32-bit RISC-based CPU controller
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] op, funct,
    input  logic       zero,
    output logic [1:0] memtoreg, 
    output logic       memwrite,
    output logic       pcsrc, alusrc,
    output logic [1:0] regdst, 
    output logic       regwrite,
    output logic [1:0] jump,
    output logic [2:0] alucontrol
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [1:0] aluop;
    logic       branch;
    
    // CPU main decoder
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop, funct);
    // CPU's ALU decoder
    aludec ad(funct, aluop, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
