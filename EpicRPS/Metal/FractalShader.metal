//
//  FractalShader.metal
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
    float2 textureCoordinate [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float2 textureCoordinate;
};

struct Uniforms {
    float time;
    float2 resolution;
};

vertex VertexOut vertex_main(VertexIn in [[stage_in]]) {
    VertexOut out;
    out.position = in.position;
    out.textureCoordinate = in.textureCoordinate;
    return out;
}

float3 palette(float t) {
    float3 a = float3(0.5, 0.5, 0.5);
    float3 b = float3(0.5, 0.5, 0.5);
    float3 c = float3(1.0, 1.0, 1.0);
    float3 d = float3(0.263, 0.416, 0.557);
    return a + b * cos(6.28318 * (c * t + d));
}

fragment float4 fragment_main(VertexOut in [[stage_in]], constant Uniforms &uniforms [[buffer(1)]]) {
    float2 uv = (in.textureCoordinate * 2.0 - float2(1.0, 1.0)) * float2(uniforms.resolution.x / uniforms.resolution.y, 1.0);
    float2 uv0 = uv;
    float3 finalColor = float3(0.0, 0.0, 0.0);

    for (float i = 0.0; i < 4.0; i++) {
        uv = fract(uv * 1.5) - 0.5;
        float d = length(uv) * exp(-length(uv0));
        float3 col = palette(length(uv0) + i * 0.4 + uniforms.time * 0.4);
        d = sin(d * 8.0 + uniforms.time) / 8.0;
        d = abs(d);
        d = pow(0.01 / d, 1.2);
        finalColor += col * d;
    }

    return float4(finalColor, 1.0);
}


