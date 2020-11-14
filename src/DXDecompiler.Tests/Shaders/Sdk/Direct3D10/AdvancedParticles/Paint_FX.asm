//
// FX Version: fx_4_0
// Child effect (requires effect pool): false
//
// 3 local buffer(s)
//
cbuffer cbAnimMatrices
{
    float4x4 g_mBoneWorld[255];         // Offset:    0, size: 16320
    float4x4 g_mBonePrev[255];          // Offset: 16320, size: 16320
}

cbuffer cb0
{
    float4x4 g_mWorld;                  // Offset:    0, size:   64
}

cbuffer cbPerFrame
{
    int     g_NumParticles;             // Offset:    0, size:    4
    int     g_ParticleStart;            // Offset:    4, size:    4
    int     g_ParticleStep;             // Offset:    8, size:    4
    float   g_fParticleRadiusSq;        // Offset:   12, size:    4
    float4  g_vParticleColor = { 0, 1, 0, 1 };// Offset:   16, size:   16
}

//
// 10 local object(s)
//
Buffer  g_ParticleBuffer;
Texture2D g_txDiffuse;
SamplerState g_samLinear
{
    Filter   = uint(MIN_MAG_MIP_LINEAR /* 21 */);
    AddressU = uint(CLAMP /* 3 */);
    AddressV = uint(CLAMP /* 3 */);
};
SamplerState g_samPoint
{
    Filter   = uint(MIN_MAG_MIP_POINT /* 0 */);
    AddressU = uint(CLAMP /* 3 */);
    AddressV = uint(CLAMP /* 3 */);
};
BlendState NoBlending
{
    AlphaToCoverageEnable = bool(FALSE /* 0 */);
    BlendEnable[0] = bool(FALSE /* 0 */);
};
BlendState PaintBlending
{
    AlphaToCoverageEnable = bool(FALSE /* 0 */);
    BlendEnable[0] = bool(TRUE /* 1 */);
    SrcBlend[0] = uint(SRC_ALPHA /* 5 */);
    DestBlend[0] = uint(INV_SRC_ALPHA /* 6 */);
    BlendOp[0] = uint(ADD /* 1 */);
    SrcBlendAlpha[0] = uint(SRC_ALPHA /* 5 */);
    DestBlendAlpha[0] = uint(INV_SRC_ALPHA /* 6 */);
    BlendOpAlpha[0] = uint(ADD /* 1 */);
    RenderTargetWriteMask[0] = byte(0x0f);
};
DepthStencilState EnableDepth
{
    DepthEnable = bool(TRUE /* 1 */);
    DepthWriteMask = uint(ALL /* 1 */);
};
DepthStencilState DisableDepth
{
    DepthEnable = bool(FALSE /* 0 */);
    DepthWriteMask = uint(ZERO /* 0 */);
};
RasterizerState CullBack
{
    CullMode = uint(BACK /* 3 */);
};
RasterizerState CullNone
{
    CullMode = uint(NONE /* 1 */);
};

//
// 3 technique(s)
//
technique10 RenderToUV
{
    pass p0
    {
        VertexShader = asm {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 10.1
            //
            //
            // Buffer Definitions: 
            //
            // cbuffer cb0
            // {
            //
            //   float4x4 g_mWorld;                 // Offset:    0 Size:    64
            //
            // }
            //
            //
            // Resource Bindings:
            //
            // Name                                 Type  Format         Dim      HLSL Bind  Count
            // ------------------------------ ---------- ------- ----------- -------------- ------
            // cb0                               cbuffer      NA          NA            cb0      1 
            //
            //
            //
            // Input signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // POSITION                 0   xyz         0     NONE   float   xyz 
            // NORMAL                   0   xyz         1     NONE   float       
            // TEXCOORD                 0   xy          2     NONE   float   xy  
            //
            //
            // Output signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Position              0   xyzw        0      POS   float   xyzw
            // WORLDPOS                 0   xyzw        1     NONE   float   xyzw
            //
            vs_4_0
            dcl_constantbuffer CB0[4], immediateIndexed
            dcl_input v0.xyz
            dcl_input v2.xy
            dcl_output_siv o0.xyzw, position
            dcl_output o1.xyzw
            dcl_temps 1
            mad o0.xy, v2.xyxx, l(2.000000, 2.000000, 0.000000, 0.000000), l(-1.000000, -1.000000, 0.000000, 0.000000)
            mov o0.zw, l(0,0,0.500000,1.000000)
            mov r0.xyz, v0.xyzx
            mov r0.w, l(1.000000)
            dp4 o1.x, r0.xyzw, cb0[0].xyzw
            dp4 o1.y, r0.xyzw, cb0[1].xyzw
            dp4 o1.z, r0.xyzw, cb0[2].xyzw
            dp4 o1.w, r0.xyzw, cb0[3].xyzw
            ret 
            // Approximately 9 instruction slots used
                    
        };
        GeometryShader = NULL;
        PixelShader = asm {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 10.1
            //
            //
            //
            // Input signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Position              0   xyzw        0      POS   float       
            // WORLDPOS                 0   xyzw        1     NONE   float   xyzw
            //
            //
            // Output signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Target                0   xyzw        0   TARGET   float   xyzw
            //
            ps_4_0
            dcl_input_ps linear v1.xyzw
            dcl_output o0.xyzw
            mov o0.xyzw, v1.xyzw
            ret 
            // Approximately 2 instruction slots used
                    
        };
        AB_BlendFactor = float4(0, 0, 0, 0);
        AB_SampleMask = uint(0xffffffff);
        BlendState = NoBlending;
        DS_StencilRef = uint(0);
        DepthStencilState = DisableDepth;
        RasterizerState = CullNone;
    }

}

technique10 RenderAnimToUV
{
    pass p0
    {
        VertexShader = asm {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 10.1
            //
            //
            // Buffer Definitions: 
            //
            // cbuffer cbAnimMatrices
            // {
            //
            //   float4x4 g_mBoneWorld[255];        // Offset:    0 Size: 16320
            //   float4x4 g_mBonePrev[255];         // Offset: 16320 Size: 16320 [unused]
            //
            // }
            //
            //
            // Resource Bindings:
            //
            // Name                                 Type  Format         Dim      HLSL Bind  Count
            // ------------------------------ ---------- ------- ----------- -------------- ------
            // cbAnimMatrices                    cbuffer      NA          NA            cb0      1 
            //
            //
            //
            // Input signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // POSITION                 0   xyz         0     NONE   float   xyz 
            // WEIGHTS                  0   xyzw        1     NONE   float   xyzw
            // BONES                    0   xyzw        2     NONE    uint   xyzw
            // NORMAL                   0   xyz         3     NONE   float       
            // TEXCOORD                 0   xy          4     NONE   float   xy  
            // TANGENT                  0   xyz         5     NONE   float       
            // SV_INSTANCEID            0   x           6   INSTID    uint       
            //
            //
            // Output signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Position              0   xyzw        0      POS   float   xyzw
            // WORLDPOS                 0   xyzw        1     NONE   float   xyzw
            //
            vs_4_0
            dcl_constantbuffer CB0[1020], dynamicIndexed
            dcl_input v0.xyz
            dcl_input v1.xyzw
            dcl_input v2.xyzw
            dcl_input v4.xy
            dcl_output_siv o0.xyzw, position
            dcl_output o1.xyzw
            dcl_temps 4
            mad o0.xy, v4.xyxx, l(2.000000, 2.000000, 0.000000, 0.000000), l(-1.000000, -1.000000, 0.000000, 0.000000)
            mov o0.zw, l(0,0,0.500000,1.000000)
            ishl r0.xyzw, v2.xyzw, l(2)
            mov r1.xyz, v0.xyzx
            mov r1.w, l(1.000000)
            dp4 r2.x, r1.xyzw, cb0[r0.y + 0].xyzw
            dp4 r2.y, r1.xyzw, cb0[r0.y + 1].xyzw
            dp4 r2.z, r1.xyzw, cb0[r0.y + 2].xyzw
            dp4 r2.w, r1.xyzw, cb0[r0.y + 3].xyzw
            mul r2.xyzw, r2.xyzw, v1.yyyy
            dp4 r3.x, r1.xyzw, cb0[r0.x + 0].xyzw
            dp4 r3.y, r1.xyzw, cb0[r0.x + 1].xyzw
            dp4 r3.z, r1.xyzw, cb0[r0.x + 2].xyzw
            dp4 r3.w, r1.xyzw, cb0[r0.x + 3].xyzw
            mad r2.xyzw, v1.xxxx, r3.xyzw, r2.xyzw
            dp4 r3.x, r1.xyzw, cb0[r0.z + 0].xyzw
            dp4 r3.y, r1.xyzw, cb0[r0.z + 1].xyzw
            dp4 r3.z, r1.xyzw, cb0[r0.z + 2].xyzw
            dp4 r3.w, r1.xyzw, cb0[r0.z + 3].xyzw
            mad r2.xyzw, v1.zzzz, r3.xyzw, r2.xyzw
            dp4 r3.x, r1.xyzw, cb0[r0.w + 0].xyzw
            dp4 r3.y, r1.xyzw, cb0[r0.w + 1].xyzw
            dp4 r3.z, r1.xyzw, cb0[r0.w + 2].xyzw
            dp4 r3.w, r1.xyzw, cb0[r0.w + 3].xyzw
            mad o1.xyzw, v1.wwww, r3.xyzw, r2.xyzw
            ret 
            // Approximately 26 instruction slots used
                    
        };
        GeometryShader = NULL;
        PixelShader = asm {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 10.1
            //
            //
            //
            // Input signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Position              0   xyzw        0      POS   float       
            // WORLDPOS                 0   xyzw        1     NONE   float   xyzw
            //
            //
            // Output signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Target                0   xyzw        0   TARGET   float   xyzw
            //
            ps_4_0
            dcl_input_ps linear v1.xyzw
            dcl_output o0.xyzw
            mov o0.xyzw, v1.xyzw
            ret 
            // Approximately 2 instruction slots used
                    
        };
        AB_BlendFactor = float4(0, 0, 0, 0);
        AB_SampleMask = uint(0xffffffff);
        BlendState = NoBlending;
        DS_StencilRef = uint(0);
        DepthStencilState = DisableDepth;
        RasterizerState = CullNone;
    }

}

technique10 Paint
{
    pass p0
    {
        VertexShader = asm {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 10.1
            //
            //
            //
            // Input signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // POSITION                 0   xyz         0     NONE   float   xyz 
            // TEXCOORD                 0   xy          1     NONE   float   xy  
            //
            //
            // Output signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Position              0   xyzw        0      POS   float   xyzw
            // TEXCOORD                 0   xy          1     NONE   float   xy  
            //
            vs_4_0
            dcl_input v0.xyz
            dcl_input v1.xy
            dcl_output_siv o0.xyzw, position
            dcl_output o1.xy
            mov o0.xyz, v0.xyzx
            mov o0.w, l(1.000000)
            mov o1.xy, v1.xyxx
            ret 
            // Approximately 4 instruction slots used
                    
        };
        GeometryShader = NULL;
        PixelShader = asm {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 10.1
            //
            //
            // Buffer Definitions: 
            //
            // cbuffer cbPerFrame
            // {
            //
            //   int g_NumParticles;                // Offset:    0 Size:     4
            //   int g_ParticleStart;               // Offset:    4 Size:     4
            //   int g_ParticleStep;                // Offset:    8 Size:     4
            //   float g_fParticleRadiusSq;         // Offset:   12 Size:     4
            //   float4 g_vParticleColor;           // Offset:   16 Size:    16 [unused]
            //      = 0x00000000 0x3f800000 0x00000000 0x3f800000 
            //
            // }
            //
            //
            // Resource Bindings:
            //
            // Name                                 Type  Format         Dim      HLSL Bind  Count
            // ------------------------------ ---------- ------- ----------- -------------- ------
            // g_samPoint                        sampler      NA          NA             s0      1 
            // g_ParticleBuffer                  texture  float4         buf             t0      1 
            // g_txDiffuse                       texture  float4          2d             t1      1 
            // cbPerFrame                        cbuffer      NA          NA            cb0      1 
            //
            //
            //
            // Input signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Position              0   xyzw        0      POS   float       
            // TEXCOORD                 0   xy          1     NONE   float   xy  
            //
            //
            // Output signature:
            //
            // Name                 Index   Mask Register SysValue  Format   Used
            // -------------------- ----- ------ -------- -------- ------- ------
            // SV_Target                0   xyzw        0   TARGET   float   xyzw
            //
            ps_4_0
            dcl_constantbuffer CB0[1], immediateIndexed
            dcl_sampler s0, mode_default
            dcl_resource_buffer (float,float,float,float) t0
            dcl_resource_texture2d (float,float,float,float) t1
            dcl_input_ps linear v1.xy
            dcl_output o0.xyzw
            dcl_temps 5
            sample r0.xyzw, v1.xyxx, t1.xyzw, s0
            mov r1.xyzw, l(0,0,0,0)
            mov r0.w, cb0[0].y
            loop 
              ige r2.x, r0.w, cb0[0].x
              breakc_nz r2.x
              ishl r2.x, r0.w, l(2)
              ld r3.xyzw, r2.xxxx, t0.xyzw
              iadd r2.x, r2.x, l(2)
              ld r2.xyzw, r2.xxxx, t0.xyzw
              add r3.xyz, -r0.xyzx, r3.xyzx
              dp3 r3.x, r3.xyzx, r3.xyzx
              lt r3.x, r3.x, cb0[0].w
              add r3.y, -r2.w, l(1.000000)
              mul r2.xyz, r2.wwww, r2.xyzx
              mad r4.xyz, r1.xyzx, r3.yyyy, r2.xyzx
              add r4.w, r1.w, r2.w
              movc r1.xyzw, r3.xxxx, r4.xyzw, r1.xyzw
              iadd r0.w, r0.w, cb0[0].z
            endloop 
            mov_sat o0.xyzw, r1.xyzw
            ret 
            // Approximately 22 instruction slots used
                    
        };
        AB_BlendFactor = float4(0, 0, 0, 0);
        AB_SampleMask = uint(0xffffffff);
        BlendState = PaintBlending;
        DS_StencilRef = uint(0);
        DepthStencilState = DisableDepth;
        RasterizerState = CullNone;
    }

}
