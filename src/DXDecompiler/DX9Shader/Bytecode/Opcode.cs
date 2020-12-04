﻿namespace DXDecompiler.DX9Shader
{
	/// <summary>
	/// D3DSHADER_INSTRUCTION_OPCODE_TYPE - d3d9types.h
	/// https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3d9types/ne-d3d9types-_d3dshader_instruction_opcode_type
	/// Also known as D3DSIO_* codes
	/// </summary>
	// D3DSHADER_INSTRUCTION_OPCODE_TYPE - d3d9types.h
	// 
	// 
	public enum Opcode
	{
		Nop,
		Mov,
		Add,
		Sub,
		Mad,
		Mul,
		Rcp,
		Rsq,
		Dp3,
		Dp4,
		Min,
		Max,
		Slt,
		Sge,
		Exp,
		Log,
		Lit,
		Dst,
		Lrp,
		Frc,
		M4x4,
		M4x3,
		M3x4,
		M3x3,
		M3x2,
		Call,
		CallNZ,
		Loop,
		Ret,
		EndLoop,
		Label,
		Dcl,
		Pow,
		Crs,
		Sgn,
		Abs,
		Nrm,
		SinCos,
		Rep,
		EndRep,
		If,
		IfC,
		Else,
		Endif,
		Break,
		BreakC,
		MovA,
		DefB,
		DefI,
		TexCoord = 64,
		TexKill,
		Tex,
		TexBem,
		TexBeml,
		TexReg2AR,
		TexReg2GB,
		TeXM3x2Pad,
		TexM3x2Tex,
		TeXM3x3Pad,
		TexM3x3Tex,
		TexM3x3Diff,
		TexM3x3Spec,
		TexM3x3VSpec,
		ExpP,
		LogP,
		Cnd,
		Def,
		TexReg2RGB,
		TexDP3Tex,
		TexM3x2Depth,
		TexDP3,
		TexM3x3,
		TexDepth,
		Cmp,
		Bem,
		DP2Add,
		DSX,
		DSY,
		TexLDD,
		SetP,
		TexLDL,
		Breakp,
		Phase = 0xFFFD,
		Comment = 0xFFFE,
		End = 0xFFFF
	}
}
