//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer $Globals
// {
//
//   float4 g_MaterialAmbientColor;     // Offset:    0 Size:    16
//   float4 g_MaterialDiffuseColor;     // Offset:   16 Size:    16
//   int g_nNumLights;                  // Offset:   32 Size:     4 [unused]
//   float3 g_LightDir;                 // Offset:   36 Size:    12
//   float4 g_LightDiffuse;             // Offset:   48 Size:    16
//   float4 g_LightAmbient;             // Offset:   64 Size:    16
//   float g_fTime;                     // Offset:   80 Size:     4 [unused]
//   float4x4 g_mWorld;                 // Offset:   96 Size:    64
//   float4x4 g_mWorldViewProjection;   // Offset:  160 Size:    64
//
// }
//
// cbuffer $Params
// {
//
//   int nNumLights;                    // Offset:    0 Size:     4
//   bool bTexture;                     // Offset:    4 Size:     4
//   bool bAnimate;                     // Offset:    8 Size:     4 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// $Globals                          cbuffer      NA          NA            cb0      1 
// $Params                           cbuffer      NA          NA            cb1      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Position              0   xyzw        0     NONE   float   xyzw
// NORMAL                   0   xyz         1     NONE   float   xyz 
// TEXCOORD                 0   xy          2     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Position              0   xyzw        0      POS   float   xyzw
// COLOR                    0   xyzw        1     NONE   float   xyzw
// TEXCOORD                 0   xy          2     NONE   float   xy  
//
//
// Constant buffer to DX9 shader constant mappings:
//
// Target Reg Buffer  Source Reg Component
// ---------- ------- ---------- ---------
// i0         cb1              0         0
//
// Target Reg Buffer  Start Reg # of Regs        Data Conversion
// ---------- ------- --------- --------- ----------------------
// c1         cb0             0         5  ( FLT, FLT, FLT, FLT)
// c6         cb0             6         3  ( FLT, FLT, FLT, FLT)
// c9         cb0            10         4  ( FLT, FLT, FLT, FLT)
// c13        cb1             0         1  ( FLT,BOOL,BOOL, FLT)
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
    def c14, 0, 1, 0, 0
    dcl_texcoord v0
    dcl_texcoord1 v1
    dcl_texcoord2 v2
    dp3 r0.x, v1, c6
    dp3 r0.y, v1, c7
    dp3 r0.z, v1, c8
    nrm r1.xyz, r0
    dp3 r0.x, r1, c3.yzww
    max r0.x, r0.x, c14.x
    mov r0.yzw, c14.x
    rep i0
      mad r0.yzw, c4.xxyz, r0.x, r0
    endrep
    mov r1.xyz, c1
    mul r1.xyz, r1, c5
    mad oT0.xyz, c2, r0.yzww, r1
    dp4 r0.x, v0, c9
    dp4 r0.y, v0, c10
    dp4 r0.z, v0, c12
    mad oPos.xy, r0.z, c0, r0
    mov oPos.w, r0.z
    dp4 oPos.z, v0, c11
    mul oT1.xy, v2, c13.y
    mov oT0.w, c14.y

// approximately 26 instruction slots used
vs_4_0
dcl_constantbuffer CB0[14], immediateIndexed
dcl_constantbuffer CB1[1], immediateIndexed
dcl_input v0.xyzw
dcl_input v1.xyz
dcl_input v2.xy
dcl_output_siv o0.xyzw, position
dcl_output o1.xyzw
dcl_output o2.xy
dcl_temps 2
dp4 o0.x, v0.xyzw, cb0[10].xyzw
dp4 o0.y, v0.xyzw, cb0[11].xyzw
dp4 o0.z, v0.xyzw, cb0[12].xyzw
dp4 o0.w, v0.xyzw, cb0[13].xyzw
dp3 r0.x, v1.xyzx, cb0[6].xyzx
dp3 r0.y, v1.xyzx, cb0[7].xyzx
dp3 r0.z, v1.xyzx, cb0[8].xyzx
dp3 r0.w, r0.xyzx, r0.xyzx
rsq r0.w, r0.w
mul r0.xyz, r0.wwww, r0.xyzx
dp3 r0.x, r0.xyzx, cb0[2].yzwy
max r0.x, r0.x, l(0.000000)
mov r0.yzw, l(0,0,0,0)
mov r1.x, l(0)
loop 
  ige r1.y, r1.x, cb1[0].x
  breakc_nz r1.y
  mad r0.yzw, cb0[3].xxyz, r0.xxxx, r0.yyzw
  iadd r1.x, r1.x, l(1)
endloop 
mul r1.xyz, cb0[0].xyzx, cb0[4].xyzx
mad o1.xyz, cb0[1].xyzx, r0.yzwy, r1.xyzx
movc o2.xy, cb1[0].yyyy, v2.xyxx, l(0,0,0,0)
mov o1.w, l(1.000000)
ret 
// Approximately 25 instruction slots used
