﻿using System;
using System.Collections.Generic;

namespace DXDecompiler.DX9Shader
{
	/// <summary>
	/// Instruction Token 
	/// https://docs.microsoft.com/en-us/windows-hardware/drivers/display/instruction-token
	/// 
	/// Bits
	/// 
	/// [15:00] Bits 0 through 15 indicate an operation code. D3DSIO_* is an example of an operation code, where* represents the instruction. For example, the following code snippet shows an ADD instruction:
	/// 
	/// [23:16] Bits 16 through 23 indicate specific controls related to the operation code.
	///
	/// [27:24] For pixel and vertex shader versions earlier than 2_0, bits 24 through 27 are reserved and set to 0x0.
	///
	/// For pixel and vertex shader versions 2_0 and later, bits 24 through 27 specify the size in DWORDs of the instruction excluding the instruction token itself (that is, the number of tokens that comprise the instruction excluding the instruction token).
	/// 
	/// [28] For pixel and vertex shader versions earlier than 2_0, bit 28 is reserved and set to 0x0.
	///
	/// For pixel and vertex shader versions 2_0 and later, bit 28 indicates whether the instruction is predicated(that is, contains an extra predicate source token at the end of the shader code.If this bit is set to 0x1, the instruction is predicated.
	///
	/// [29] Reserved. This value is set to 0x0.
	///
	/// [30] For pixel shader versions earlier than 2_0, bit 30 is the co-issue bit. If set to 1, execute this instruction with previous instructions; otherwise, execute separately.
	/// For pixel shader version 2_0 and later and all vertex shader versions, bit 30 is reserved and set to 0x0.
	/// 
	/// [31] Bit 31 is zero (0x0).
	/// </summary>
	public class InstructionToken : Token
	{
		public List<Operand> Operands;
		public InstructionToken(Opcode opcode, int length, ShaderModel shaderModel) : base(opcode, length, shaderModel)
		{
			Operands = new List<Operand>();
		}
		public override string ToString()
		{
			string result = Opcode.ToString();
			for(int i = 0; i < Operands.Count; i++)
			{
				var operand = Operands[i];
				result += " ";
				if(operand is DestinationOperand dest)
				{
					result += dest.GetDestinationName();
				}
				else
				{
					result += GetSourceName(i);
				}
			}
			return result;
		}

		internal static string ApplyModifier(SourceModifier modifier, string value)
		{
			switch(modifier)
			{
				case SourceModifier.None:
					return value;
				case SourceModifier.Negate:
					return $"-{value}";
				case SourceModifier.Bias:
					return $"{value}_bias";
				case SourceModifier.BiasAndNegate:
					return $"-{value}_bias";
				case SourceModifier.Sign:
					return $"{value}_bx2";
				case SourceModifier.SignAndNegate:
					return $"-{value}_bx2";
				case SourceModifier.Complement:
					throw new NotImplementedException();
				case SourceModifier.X2:
					return $"{value}_x2";
				case SourceModifier.X2AndNegate:
					return $"-{value}_x2";
				case SourceModifier.DivideByZ:
					return $"{value}_dz";
				case SourceModifier.DivideByW:
					return $"{value}_dw";
				case SourceModifier.Abs:
					return $"{value}_abs";
				case SourceModifier.AbsAndNegate:
					return $"-{value}_abs";
				case SourceModifier.Not:
					throw new NotImplementedException();
				default:
					throw new NotImplementedException();
			}
		}
		string GetSourceName(int srcIndex)
		{
			var instruction = this;
			string sourceRegisterName = instruction.GetParamRegisterName(srcIndex);
			sourceRegisterName = ApplyModifier(instruction.GetSourceModifier(srcIndex), sourceRegisterName);
			sourceRegisterName += instruction.GetSourceSwizzleName(srcIndex);
			if(instruction.IsRelativeAddressMode(srcIndex))
			{
				sourceRegisterName += $"[{GetSourceName(srcIndex + 1)}]";
			}
			return sourceRegisterName;
		}

		public byte[] GetParamBytes(int index)
		{
			return BitConverter.GetBytes(Data[index]);
		}

		public float GetParamSingle(int index)
		{
			return BitConverter.ToSingle(GetParamBytes(index), 0);
		}

		public float GetParamInt(int index)
		{
			return BitConverter.ToInt32(GetParamBytes(index), 0);
		}

		public RegisterKey GetParamRegisterKey(int index)
		{
			return new RegisterKey(
				GetParamRegisterType(index),
				GetParamRegisterNumber(index));
		}

		public RegisterType GetParamRegisterType(int index)
		{
			uint p = Data[index];
			return (RegisterType)(((p >> 28) & 0x7) | ((p >> 8) & 0x18));
		}

		public uint GetParamRegisterNumber(int index)
		{
			return Data[index] & 0x7FF;
		}

		public string GetParamRegisterName(int index)
		{
			var registerType = GetParamRegisterType(index);
			var registerNumber = GetParamRegisterNumber(index);

			string registerTypeName;
			switch(registerType)
			{
				case RegisterType.Addr:
					if(_shaderModel.Type == ShaderType.Vertex)
					{
						registerTypeName = "a";
					}
					else
					{
						registerTypeName = "t";
					}
					break;
				case RegisterType.Const:
					registerTypeName = "c";
					break;
				case RegisterType.Const2:
					registerTypeName = "c";
					registerNumber += 2048;
					break;
				case RegisterType.Const3:
					registerTypeName = "c";
					registerNumber += 4096;
					break;
				case RegisterType.Const4:
					registerTypeName = "c";
					registerNumber += 6144;
					break;
				case RegisterType.ConstBool:
					registerTypeName = "b";
					break;
				case RegisterType.ConstInt:
					registerTypeName = "i";
					break;
				case RegisterType.Input:
					registerTypeName = "v";
					break;
				case RegisterType.Output:
					if(_shaderModel.MajorVersion >= 3)
					{
						registerTypeName = "o";
					}
					else
					{
						registerTypeName = "oT";
					}
					break;
				case RegisterType.RastOut:
					{
						//Unsure about this one
						var usage = GetDeclUsage();
						if(usage == DeclUsage.Position)
						{
							return "oPos";
						}
						else
						{
							return "oPts";
						}
					}
				case RegisterType.Temp:
					registerTypeName = "r";
					break;
				case RegisterType.Sampler:
					registerTypeName = "s";
					break;
				case RegisterType.ColorOut:
					registerTypeName = "oC";
					break;
				case RegisterType.DepthOut:
					registerTypeName = "oDepth";
					break;
				case RegisterType.AttrOut:
					registerTypeName = "oD";
					break;
				case RegisterType.MiscType:
					if(registerNumber == 0)
					{
						return "vFace";
					}
					else if(registerNumber == 1)
					{
						return "vPos";
					}
					else
					{
						throw new NotImplementedException();
					}
				case RegisterType.Loop:
					return "aL";
				default:
					throw new NotImplementedException();
			}

			return $"{registerTypeName}{registerNumber}";
		}

		public int GetDestinationParamIndex()
		{
			if(Opcode == Opcode.Dcl) return 1;
			return 0;
		}

		public ResultModifier GetDestinationResultModifier()
		{
			int destIndex = GetDestinationParamIndex();
			return (ResultModifier)((Data[destIndex] >> 20) & 0xF);
		}

		public ComponentFlags GetDestinationWriteMask()
		{
			int destIndex = GetDestinationParamIndex();
			return (ComponentFlags)((Data[destIndex] >> 16) & 0xF);
		}

		public string GetDestinationWriteMaskName(uint destinationLength, bool hlsl)
		{
			ComponentFlags writeMask = GetDestinationWriteMask();
			var writeMaskLength = GetDestinationMaskLength();

			if(!hlsl)
			{
				destinationLength = 4; // explicit mask in assembly
			}
			if(Opcode.Rep == Opcode)
			{
				return "";
			}
			// Check if mask is the same length and of the form .xyzw
			if(writeMaskLength == destinationLength && writeMask == (ComponentFlags)((1 << writeMaskLength) - 1))
			{
				return "";
			}

			string writeMaskName =
				string.Format(".{0}{1}{2}{3}",
				((writeMask & ComponentFlags.X) != 0) ? "x" : "",
				((writeMask & ComponentFlags.Y) != 0) ? "y" : "",
				((writeMask & ComponentFlags.Z) != 0) ? "z" : "",
				((writeMask & ComponentFlags.W) != 0) ? "w" : "");
			return writeMaskName;
		}

		// Length of ".xy" = 2
		// Length of ".yw" = 4 (xyzw)
		public int GetDestinationMaskedLength()
		{
			ComponentFlags writeMask = GetDestinationWriteMask();
			for(int i = 3; i != 0; i--)
			{
				var mask = (ComponentFlags)(1 << i);
				if((writeMask & mask) != ComponentFlags.None)
				{
					return i + 1;
				}
			}
			return 0;
		}

		// Length of ".yw" = 2
		public int GetDestinationMaskLength()
		{
			ComponentFlags writeMask = GetDestinationWriteMask();
			int length = 0;
			for(int i = 0; i < 4; i++)
			{
				var mask = (ComponentFlags)(1 << i);
				if((writeMask & mask) != ComponentFlags.None)
				{
					length++;
				}
			}
			return length;
		}

		public int GetSourceSwizzle(int srcIndex)
		{
			return (int)((Data[srcIndex] >> 16) & 0xFF);
		}

		public byte[] GetSourceSwizzleComponents(int srcIndex)
		{
			int swizzle = GetSourceSwizzle(srcIndex);
			byte[] swizzleArray = new byte[4];
			for(int i = 0; i < 4; i++)
			{
				swizzleArray[i] = (byte)((swizzle >> (i * 2)) & 0x3);
			}
			return swizzleArray;
		}

		public string GetSourceSwizzleName(int srcIndex, bool hlsl = false)
		{
			int swizzleLength = 4;
			if(Opcode == Opcode.Dp4)
			{
				swizzleLength = 4;
			}
			//TODO: Probably useful in hlsl mode
			else if(hlsl)
			{
				if(Opcode == Opcode.Dp3)
				{
					swizzleLength = 3;
				}
				else if(HasDestination)
				{
					swizzleLength = GetDestinationMaskLength();
				}
			}

			string swizzleName = "";
			byte[] swizzle = GetSourceSwizzleComponents(srcIndex);
			for(int i = 0; i < swizzleLength; i++)
			{
				switch(swizzle[i])
				{
					case 0:
						swizzleName += "x";
						break;
					case 1:
						swizzleName += "y";
						break;
					case 2:
						swizzleName += "z";
						break;
					case 3:
						swizzleName += "w";
						break;
				}
			}
			switch(swizzleName)
			{
				case "xxx":
					return ".x";
				case "yyy":
					return ".y";
				case "zzz":
					return ".z";
				case "xyz":
					return "";
				case "xyzw":
					return "";
				case "xxxx":
					return ".x";
				case "yyyy":
					return ".y";
				case "zzzz":
					return ".z";
				case "wwww":
					return ".w";
				default:
					return "." + swizzleName;
			}
		}

		public SourceModifier GetSourceModifier(int srcIndex)
		{
			return (SourceModifier)((Data[srcIndex] >> 24) & 0xF);
		}

		// For output, input and texture declarations
		public DeclUsage GetDeclUsage()
		{
			return (DeclUsage)(Data[0] & 0x1F);
		}

		// For output, input and texture declarations
		public int GetDeclIndex()
		{
			return (int)(Data[0] >> 16) & 0x0F;
		}

		public bool IsRelativeAddressMode(int index)
		{
			return (Data[index] & (1 << 13)) != 0;
		}

		// For sampler declarations
		public SamplerTextureType GetDeclSamplerTextureType()
		{
			return (SamplerTextureType)((Data[0] >> 27) & 0xF);
		}

		public string GetDeclSemantic()
		{
			var registerType = GetParamRegisterType(1);
			switch(registerType)
			{
				case RegisterType.Input:
				case RegisterType.Output:
					string name;
					switch(GetDeclUsage())
					{
						case DeclUsage.Binormal:
						case DeclUsage.BlendIndices:
						case DeclUsage.BlendWeight:
						case DeclUsage.Color:
						case DeclUsage.Depth:
						case DeclUsage.Fog:
						case DeclUsage.Normal:
						case DeclUsage.Position:
						case DeclUsage.PositionT:
						case DeclUsage.PSize:
						case DeclUsage.Sample:
						case DeclUsage.Tangent:
						case DeclUsage.TessFactor:
						case DeclUsage.TexCoord:
							name = GetDeclUsage().ToString().ToUpper();
							break;
						default:
							throw new NotImplementedException();
					}
					if(GetDeclIndex() != 0)
					{
						name += GetDeclIndex().ToString();
					}
					return name;
				case RegisterType.Sampler:
					var samplerTexturetype = GetDeclSamplerTextureType();
					switch(samplerTexturetype)
					{
						case SamplerTextureType.TwoD:
							return "2d";
						case SamplerTextureType.Cube:
							return "cube";
						case SamplerTextureType.Volume:
							return "volume";
						default:
							throw new NotImplementedException();
					}
				case RegisterType.MiscType:
					if(GetParamRegisterNumber(1) == 0)
					{
						return "vFace";
					}
					if(GetParamRegisterNumber(1) == 1)
					{
						return "vPos";
					}
					throw new NotImplementedException();
				case RegisterType.Addr:
					return "tex";
				default:
					//return "Warning - Not Implemented register type";
					throw new NotImplementedException();
			}
		}
	}
}
