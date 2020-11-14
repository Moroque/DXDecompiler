//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   float4x4 matInvTPoseWorld;
//   float4x4 matWorldViewProj;
//
//
// Registers:
//
//   Name             Reg   Size
//   ---------------- ----- ----
//   matWorldViewProj c0       4
//   matInvTPoseWorld c4       4
//

    vs_3_0
    def c8, 1, 0, 0.300000012, 0
    dcl_position v0
    dcl_normal v1
    dcl_position o0
    dcl_color o1
    mad r0, v0.xyzx, c8.xxxy, c8.yyyx
    dp4 o0.x, r0, c0
    dp4 o0.y, r0, c1
    dp4 o0.z, r0, c2
    dp4 o0.w, r0, c3
    dp3 r0.x, v1, c4
    dp3 r0.z, v1, c6
    dp3 r0.w, v1, c7
    dp3 r0.y, v1, c5
    dp4 r0.x, r0, r0
    rsq r0.x, r0.x
    mul_sat r0.x, r0.x, r0.y
    max o1.xyz, r0.x, c8.z
    mov o1.w, c8.x

// approximately 14 instruction slots used