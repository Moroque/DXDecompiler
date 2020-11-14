﻿using SlimShader.Chunks.Shex;
using SlimShader.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SlimShader.DebugParser.Shex.Tokens
{
	public class DebugStructuredUnorderedAccessViewDeclarationToken : DebugUnorderedAccessViewDeclarationTokenBase
	{
		public bool HasOrderPreservingCounter;
		public uint ByteStride;

		private bool IsSM51 => Operand.IndexDimension == OperandIndexDimension._3D;

		public static DebugStructuredUnorderedAccessViewDeclarationToken Parse(DebugBytecodeReader reader, DebugShaderVersion version)
		{
			var token0 = reader.ReadUInt32("token0");
			DebugOpcodeHeader.AddNotes(reader, token0);
			reader.AddNote("Coherency", token0.DecodeValue<UnorderedAccessViewCoherency>(16, 16));
			reader.AddNote("IsRasterOrderedAccess", token0.DecodeValue<bool>(17, 17));
			reader.AddNote("HasOrderPreservingCounter", token0.DecodeValue<bool>(23, 23));

			var result = new DebugStructuredUnorderedAccessViewDeclarationToken
			{
				Coherency = token0.DecodeValue<UnorderedAccessViewCoherency>(16, 16),
				IsRasterOrderedAccess = token0.DecodeValue<bool>(17, 17),
				HasOrderPreservingCounter = token0.DecodeValue<bool>(23, 23),
				Operand = DebugOperand.Parse(reader, token0.DecodeValue<OpcodeType>(0, 10)),
				ByteStride = reader.ReadUInt32("ByteStride")
			};
			if (version.IsSM51)
			{
				result.SpaceIndex = reader.ReadUInt32("SpaceIndex");
			}
			return result;
		}
	}
}