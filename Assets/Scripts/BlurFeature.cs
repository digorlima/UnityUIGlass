using UnityEngine.Rendering.Universal;

public class BlurFeature : ScriptableRendererFeature
{
    public RenderPassEvent renderPassEvent = RenderPassEvent.BeforeRenderingPostProcessing;
    private BlurPass _blurPass;

    public override void Create()
    {
        _blurPass = new BlurPass
                    {
                        renderPassEvent = RenderPassEvent.BeforeRenderingPostProcessing
                    };
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        _blurPass.renderPassEvent = renderPassEvent;
        renderer.EnqueuePass(_blurPass);
    }
}