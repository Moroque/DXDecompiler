//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cbPerObject
// {
//
//   float4x4 g_mWorldViewProjection;   // Offset:    0 Size:    64
//   float4x4 g_mWorld;                 // Offset:   64 Size:    64
//   float4 g_vObjectColor;             // Offset:  128 Size:    16 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// cbPerObject                       cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// POSITION                 0   xyzw        0     NONE   float   xyzw
// NORMAL                   0   xyz         1     NONE   float   xyz 
// TEXCOORD                 0   xy          2     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// NORMAL                   0   xyz         0     NONE   float   xyz 
// TEXCOORD                 0   xy          1     NONE   float   xy  
// SV_POSITION              0   xyzw        2      POS   float   xyzw
//
//
// Constant buffer to DX9 shader constant mappings:
//
// Target Reg Buffer  Start Reg # of Regs        Data Conversion
// ---------- ------- --------- --------- ----------------------
// c1         cb0             0         7  ( FLT, FLT, FLT, FLT)
//
//
// Runtime generated constant mappings:
//
// Target Reg                               Constant Description
// ---------- --------------------------------------------------
// c0                              Vertex Shader position offset
//
//
// Level9 shader bytecode:
//
    vs_2_x
    dcl_texcoord v0
    dcl_texcoord1 v1
    dcl_texcoord2 v2
    dp4 oPos.z, v0, c3
    dp3 oT0.x, v1, c5
    dp3 oT0.y, v1, c6
    dp3 oT0.z, v1, c7
    dp4 r0.x, v0, c1
    dp4 r0.y, v0, c2
    dp4 r0.z, v0, c4
    mad oPos.xy, r0.z, c0, r0
    mov oPos.w, r0.z
    mov oT1.xy, v2

// approximately 10 instruction slots used
vs_4_0
dcl_constantbuffer CB0[7], immediateIndexed
dcl_input v0.xyzw
dcl_input v1.xyz
dcl_input v2.xy
dcl_output o0.xyz
dcl_output o1.xy
dcl_output_siv o2.xyzw, position
dp3 o0.x, v1.xyzx, cb0[4].xyzx
dp3 o0.y, v1.xyzx, cb0[5].xyzx
dp3 o0.z, v1.xyzx, cb0[6].xyzx
mov o1.xy, v2.xyxx
dp4 o2.x, v0.xyzw, cb0[0].xyzw
dp4 o2.y, v0.xyzw, cb0[1].xyzw
dp4 o2.z, v0.xyzw, cb0[2].xyzw
dp4 o2.w, v0.xyzw, cb0[3].xyzw
ret 
// Approximately 9 instruction slots used
