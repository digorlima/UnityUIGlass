#ifndef PXHLSL_INCLUDED
#define PXHLSL_INCLUDED

void RealGaussianBlur_float(Texture2D Texture, SamplerState Sampler, float2 UV,
                        float Sigma, int KernelRadius, float Downsample, float2 TextureSize,
                        out float4 Out)
{
    float2 downsampleFactor = Downsample;
    float2 downsampledUV = floor(UV * TextureSize * downsampleFactor) / (TextureSize * downsampleFactor);

    float4 color = float4(0, 0, 0, 0);
    float sum = 0.0;

    float2 pixelSize = 1.0 / (TextureSize * downsampleFactor);
    float denominator = 2.0 * Sigma * Sigma;

    for (int y = -KernelRadius; y <= KernelRadius; y++)
    {
        for (int x = -KernelRadius; x <= KernelRadius; x++)
        {
            float2 offset = float2(x, y) * pixelSize;
            
            float weightX = exp(-(x * x) / denominator);
            float weightY = exp(-(y * y) / denominator);
            float weight = weightX * weightY;
            
            color += Texture.SampleLevel(Sampler, downsampledUV + offset, 0) * weight;
            sum += weight;
        }
    }

    if (sum > 0.0)
    {
        color /= sum;
    }

    Out = color;
}

void GaussianBlur_float(Texture2D Texture, SamplerState Sampler, float2 UV,
                         float Sigma, int KernelRadius, float Downsample, float2 TextureSize,
                         out float4 Out)
{
    float2 downsampleFactor = Downsample;
    float2 downsampledUV = floor(UV * TextureSize * downsampleFactor) / (TextureSize * downsampleFactor);

    float4 color = float4(0, 0, 0, 0);
    float sum = 0.0;

    float2 pixelSize = 1.0 / (TextureSize * downsampleFactor);
    float denominator = 9 * pow(Sigma, 2);

    for (int y = -KernelRadius; y <= KernelRadius; y++)
    {
        for (int x = -KernelRadius; x <= KernelRadius; x++)
        {
            float2 offset = float2(x, y) * pixelSize;

            float tx = -x * -x / denominator;
            float ty = -x * -x / denominator;
            float weightX = pow(1 + tx, 4);
            float weightY = pow(1 + ty, 4);
            float weight = weightX * weightY;

            color += Texture.SampleLevel(Sampler, downsampledUV + offset, 0) * weight;
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
