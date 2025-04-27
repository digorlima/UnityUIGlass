using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.RenderGraphModule;
using UnityEngine.Rendering.Universal;

public class BlurPass : ScriptableRenderPass
{
    private static readonly int BlurTexture = Shader.PropertyToID("_BlurTexture");
    private const string PassName = "Unity UI Glass";

    private class PassData
    {
        internal TextureHandle CopySourceTexture;
    }

    public override void RecordRenderGraph(RenderGraph renderGraph, ContextContainer frameData)
    {
        using IRasterRenderGraphBuilder builder = renderGraph.AddRasterRenderPass<PassData>(PassName, out var passData);

        UniversalResourceData resourceData = frameData.Get<UniversalResourceData>();
        passData.CopySourceTexture = resourceData.activeColorTexture;

        UniversalCameraData cameraData = frameData.Get<UniversalCameraData>();
        RenderTextureDescriptor desc = cameraData.cameraTargetDescriptor;
        desc.msaaSamples = 1;
        desc.depthBufferBits = 0;

        TextureHandle destination = UniversalRenderer.CreateRenderGraphTexture(renderGraph, desc, "CopyTexture", false);

        builder.UseTexture(passData.CopySourceTexture);
        builder.SetRenderAttachment(destination, 0);
        builder.AllowPassCulling(false);
        builder.SetRenderFunc((PassData data, RasterGraphContext context) => ExecutePass(data, context));
    }

    private static void ExecutePass(PassData data, RasterGraphContext context)
    {
        Shader.SetGlobalTexture(BlurTexture, data.CopySourceTexture);
        Blitter.BlitTexture(context.cmd, data.CopySourceTexture, new Vector4(1, 1, 0, 0), 0, false);
    }
}