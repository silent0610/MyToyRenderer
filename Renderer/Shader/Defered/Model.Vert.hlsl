struct VSInput
{
    [[vk::location(0)]] float4 Pos : POSITION0;
    [[vk::location(1)]] float2 UV : TEXCOORD0;
    [[vk::location(2)]] float3 Color : COLOR0;
    [[vk::location(3)]] float3 Normal : NORMAL0;
};

struct UBO
{
    float4x4 model;
    float4x4 view;
    float4x4 projection;
};
cbuffer ubo : register(b0) { UBO ubo; }

struct VSOutput
{
    float4 Pos : SV_POSITION;
    [[vk::location(0)]] float3 Normal : NORMAL0;
    [[vk::location(1)]] float2 UV : TEXCOORD0;
    [[vk::location(2)]] float3 Color : COLOR0;
    [[vk::location(3)]] float3 WorldPos : POSITION0;
};

VSOutput main(VSInput input, uint InstanceIndex : SV_InstanceID)
{
    VSOutput output = (VSOutput)0;

    output.Pos = mul(ubo.projection, mul(ubo.view, mul(ubo.model, input.Pos)));

    output.UV = input.UV;

    // Vertex position in world space
    output.WorldPos = mul(ubo.model, input.Pos).xyz;

    // Normal in world space
    output.Normal = normalize(input.Normal);

    // Currently just vertex color
    output.Color = input.Color;
    return output;
}
