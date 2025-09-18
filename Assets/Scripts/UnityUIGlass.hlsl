#ifndef UNITYUIGLASS_HLSL_H
#define UNITYUIGLASS_HLSL_H
void gaussian_blur_float(Texture2D Texture, SamplerState Sampler, float2 UV,
                         float Sigma, int KernelRadius, float Downsample,
                         out float4 Out)
{
    float2 texture_size;
    Texture.GetDimensions(texture_size.x, texture_size.y);

    float downsample_factor = Downsample;
    float2 downsampled_uv = floor(UV * texture_size * downsample_factor) / (texture_size *
        downsample_factor);

    float4 color = float4(0, 0, 0, 0);
    float sum = 0.0;

    float2 pixel_size = 1.0 / (texture_size * downsample_factor);
    float denominator = 1 / (2.0 * Sigma * Sigma);

    for (int y = -KernelRadius; y <= KernelRadius; y++)
    {
        float weight_y = exp(-(y * y) * denominator);

        for (int x = -KernelRadius; x <= KernelRadius; x++)
        {
            float weight_x = exp(-(x * x) * denominator);
            float weight = weight_x * weight_y;

            float2 offset = float2(x, y) * pixel_size;
            color += Texture.SampleLevel(Sampler, downsampled_uv + offset, 0) * weight;
            sum += weight;
        }
    }

    if (sum > 0.0)
    {
        color /= sum;
    }

    Out = color;
}
#endif
