//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cb0
// {
//
//   float4 g_avSampleWeights[15];      // Offset:    0 Size:   240
//   uint g_outputwidth;                // Offset:  240 Size:     4
//   float g_inverse;                   // Offset:  244 Size:     4
//   int2 g_inputsize;                  // Offset:  248 Size:     8
//
// }
//
// Resource bind info for lum
// {
//
//   float $Element;                    // Offset:    0 Size:     4
//
// }
//
// Resource bind info for Result
// {
//
//   float4 $Element;                   // Offset:    0 Size:    16
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// Input                             texture  float4          2d             t0      1 
// lum                               texture  struct         r/o             t1      1 
// Result                                UAV  struct         r/w             u0      1 
// cb0                               cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// no Input
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// no Output
cs_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[16], immediateIndexed
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_structured t1, 4
dcl_uav_structured u0, 16
dcl_input vThreadIDInGroupFlattened
dcl_input vThreadGroupID.xy
dcl_temps 4
dcl_tgsm_structured g0, 16, 128
dcl_thread_group 128, 1, 1
iadd r0.x, vThreadIDInGroupFlattened.x, l(-7)
imad r0.y, l(114), vThreadGroupID.x, r0.x
mov r0.z, vThreadGroupID.y
bfi r1.yz, l(0, 29, 29, 0), l(0, 3, 3, 0), r0.yyzy, l(0, 4, 3, 0)
iadd r0.zw, cb0[15].zzzw, l(0, 0, -1, -1)
imax r1.x, r1.y, l(0)
imin r1.xy, r0.zwzz, r1.xzxx
mov r1.zw, l(0,0,0,0)
ld_indexable(texture2d)(float,float,float,float) r1.xyz, r1.xyzw, t0.xyzw
ld_structured_indexable(structured_buffer, stride=4)(mixed,mixed,mixed,mixed) r0.z, l(0), l(0), t1.xxxx
add r1.xyz, r1.xyzx, l(-0.500000, -0.500000, -0.500000, 0.000000)
max r1.xyz, r1.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
mad r0.z, r0.z, cb0[15].y, l(0.001000)
div r0.z, l(0.720000), r0.z
mul r1.xyz, r0.zzzz, r1.xyzx
mad r2.xyz, r1.xyzx, l(0.666667, 0.666667, 0.666667, 0.000000), l(1.000000, 1.000000, 1.000000, 0.000000)
mul r3.xyz, r1.xyzx, r2.xyzx
mad r1.xyz, r1.xyzx, r2.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
div r1.xyz, r3.xyzx, r1.xyzx
store_structured g0.xyz, vThreadIDInGroupFlattened.x, l(0), r1.xyzx
sync_g_t
uge r0.z, vThreadIDInGroupFlattened.x, l(7)
ult r0.w, vThreadIDInGroupFlattened.x, l(121)
and r0.z, r0.w, r0.z
imad r0.w, l(114), vThreadGroupID.x, vThreadIDInGroupFlattened.x
iadd r0.w, r0.w, l(-7)
ult r0.w, r0.w, cb0[15].x
and r0.z, r0.w, r0.z
if_nz r0.z
  ld_structured r0.xzw, r0.x, l(0), g0.xxyz
  iadd r2.xyzw, vThreadIDInGroupFlattened.xxxx, l(-6, -5, -4, -3)
  ld_structured r3.xyz, r2.x, l(0), g0.xyzx
  mul r3.xyz, r3.xyzx, cb0[1].xyzx
  mad r0.xzw, r0.xxzw, cb0[0].xxyz, r3.xxyz
  ld_structured r3.xyz, r2.y, l(0), g0.xyzx
  mad r0.xzw, r3.xxyz, cb0[2].xxyz, r0.xxzw
  ld_structured r2.xyz, r2.z, l(0), g0.xyzx
  mad r0.xzw, r2.xxyz, cb0[3].xxyz, r0.xxzw
  ld_structured r2.xyz, r2.w, l(0), g0.xyzx
  mad r0.xzw, r2.xxyz, cb0[4].xxyz, r0.xxzw
  iadd r2.xyzw, vThreadIDInGroupFlattened.xxxx, l(-2, -1, 1, 2)
  ld_structured r3.xyz, r2.x, l(0), g0.xyzx
  mad r0.xzw, r3.xxyz, cb0[5].xxyz, r0.xxzw
  ld_structured r3.xyz, r2.y, l(0), g0.xyzx
  mad r0.xzw, r3.xxyz, cb0[6].xxyz, r0.xxzw
  mad r0.xzw, r1.xxyz, cb0[7].xxyz, r0.xxzw
  ld_structured r1.xyz, r2.z, l(0), g0.xyzx
  mad r0.xzw, r1.xxyz, cb0[8].xxyz, r0.xxzw
  ld_structured r1.xyz, r2.w, l(0), g0.xyzx
  mad r0.xzw, r1.xxyz, cb0[9].xxyz, r0.xxzw
  iadd r1.xyzw, vThreadIDInGroupFlattened.xxxx, l(3, 4, 5, 6)
  ld_structured r2.xyz, r1.x, l(0), g0.xyzx
  mad r0.xzw, r2.xxyz, cb0[10].xxyz, r0.xxzw
  ld_structured r2.xyz, r1.y, l(0), g0.xyzx
  mad r0.xzw, r2.xxyz, cb0[11].xxyz, r0.xxzw
  ld_structured r1.xyz, r1.z, l(0), g0.xyzx
  mad r0.xzw, r1.xxyz, cb0[12].xxyz, r0.xxzw
  ld_structured r1.xyz, r1.w, l(0), g0.xyzx
  mad r0.xzw, r1.xxyz, cb0[13].xxyz, r0.xxzw
  iadd r1.x, vThreadIDInGroupFlattened.x, l(7)
  ld_structured r1.xyz, r1.x, l(0), g0.xyzx
  mad r1.xyz, r1.xyzx, cb0[14].xyzx, r0.xzwx
  imad r0.x, vThreadGroupID.y, cb0[15].x, r0.y
  mov r1.w, l(1.000000)
  store_structured u0.xyzw, r0.x, l(0), r1.xyzw
endif 
ret 
// Approximately 67 instruction slots used