// Copyright 2020 Google LLC

Texture2D textureColor : register(t0, space1);
SamplerState samplerColor : register(s0, space1);

Texture2D textureNormalMap : register(t1, space1);
SamplerState samplerNormalMap : register(s1, space1);

Texture2D textureMR : register(t2, space1);
SamplerState samplerMR : register(s2, space1);
struct VSOutput
{
	[[vk::location(0)]] float3 Normal : NORMAL0;
	[[vk::location(1)]] float2 UV : TEXCOORD0;
	[[vk::location(2)]] float3 Color : COLOR0;
	[[vk::location(3)]] float3 WorldPos : POSITION0;
	[[vk::location(4)]] float3 Tangent : TEXCOORD1;
};

struct FSOutput
{
	float4 Position : SV_TARGET0;
	float4 Normal : SV_TARGET1;
	float4 Albedo : SV_TARGET2;
	float4 MRAO : SV_TARGET3;
};

FSOutput main(VSOutput input)
{
	FSOutput output = (FSOutput)0;
	output.Position = float4(input.WorldPos, 1.0);

	// // Calculate normal in tangent space
	float3 N = normalize(input.Normal);
	float3 T = normalize(input.Tangent);
	float3 B = cross(N, T);
	float3x3 TBN = float3x3(T, B, N);
	float3 tnorm = mul(normalize(textureNormalMap.Sample(samplerNormalMap, input.UV).xyz * 2.0 - float3(1.0, 1.0, 1.0)), TBN);
	output.Normal = float4(tnorm, 1.0);

	output.Albedo = textureColor.Sample(samplerColor, input.UV);
	output.MRAO = textureMR.Sample(samplerMR, input.UV);
	return output;
}