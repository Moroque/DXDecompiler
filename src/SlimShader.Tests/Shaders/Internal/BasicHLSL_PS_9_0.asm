//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cbPerFrame
// {
//
//   float3 g_vLightDir;                // Offset:    0 Size:    12
//   float g_fAmbient;                  // Offset:   12 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// g_samLinear                       sampler      NA          NA             s0      1 
// g_txDiffuse                       texture  float4          2d             t0      1 
// cbPerFrame                        cbuffer      NA          NA            cb1      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// NORMAL                   0   xyz         0     NONE   float   xyz 
// TEXCOORD                 0   xy          1     NONE   float   xy  
// SV_POSITION              0   xyzw        2      POS   float       
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
//
//
// Constant buffer to DX9 shader constant mappings:
//
// Target Reg Buffer  Start Reg # of Regs        Data Conversion
// ---------- ------- --------- --------- ----------------------
// c0         cb1             0         1  ( FLT, FLT, FLT, FLT)
//
//
// Sampler/Resource to DX9 shader sampler mappings:
//
// Target Sampler Source Sampler  Source Resource
// -------------- --------------- ----------------
// s0             s0              t0               
//
//
// Level9 shader bytecode:
//
    ps_2_0
    dcl t0.xyz
    dcl t1.xy
    dcl_2d s0
    texld r0, t1, s0
    dp3_sat r1.w, c0, t0
    max r2.w, r1.w, c0.w
    mul r0, r0, r2.w
    mov oC0, r0

// approximately 5 instruction slots used (1 texture, 4 arithmetic)
//
// Constant buffer to DX9 shader constant mappings:
//
// Target Reg Buffer  Start Reg # of Regs        Data Conversion
// ---------- ------- --------- --------- ----------------------
// c0         cb1             0         1  ( FLT, FLT, FLT, FLT)
//
//
// Sampler/Resource to DX9 shader sampler mappings:
//
// Target Sampler Source Sampler  Source Resource
// -------------- --------------- ----------------
// s0             s0              t0               
//
//
// XNA shader bytecode:
//
    ps_2_0
    dcl t0.xyz
    dcl t1.xy
    dcl_2d s0
    dp3_sat r0.x, c0, r0
    max r1.z, r0.x, c0.w
    texld r0, r1, s0
    mul oC0, r1.z, r0

// approximately 4 instruction slots used (1 texture, 3 arithmetic)
ps_4_0
dcl_constantbuffer CB1[1], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v0.xyz
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 2
dp3_sat r0.x, cb1[0].xyzx, v0.xyzx
max r0.x, r0.x, cb1[0].w
sample r1.xyzw, v1.xyxx, t0.xyzw, s0
mul o0.xyzw, r0.xxxx, r1.xyzw
ret 
// Approximately 5 instruction slots used
