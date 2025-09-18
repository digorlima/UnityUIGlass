# UI Blur Shader for Unity URP

This repository provides a UI Blur Shader designed for Unity's Universal Render Pipeline (URP) **UNTESTED ON HDRP**. It allows you to apply dynamic blur effects to UI elements, with customizable parameters such as blur strength, kernel size, and alpha blending. Follow the steps below to integrate it into your project.
This shader allows you to apply **different blur effects to individual UI elements** simultaneously in Unity URP. Perfect for creating depth in menus or highlighting specific components.
Is WAY more demanding, if you use to much objects, so, for a global solution, consider [Unified Universal Blur](https://github.com/lukakldiashvili/Unified-Universal-Blur).

---

## Prerequisites
- Unity 6.0 or later.
- Universal Render Pipeline (URP) configured in your project.

---

## Installation & Usage

### 1. Import the Unity Package
1. Download the `UIBlurShader.unitypackage` from the [Releases](https://github.com/yourusername/your-repo/releases) section.
2. In Unity, navigate to **Assets > Import Package > Custom Package**.
3. Select the downloaded `.unitypackage` and import all files.

### 2. Create a Material from the UnityUIGlass Shader
1. Right-click in the Project window and select **Create > Material**.
2. Name the material (e.g., `UI_GlassMaterial`).
3. In the material inspector, click the Shader dropdown and select **UnityUIGlass** from the list.

### 3. Apply the UIBlur Material to a UI Element
1. Select a UI element (e.g., a `Panel`, `Image`, or `RawImage`) in your scene.
2. In the Inspector window, locate the **Material** field (under the component's properties).
3. Assign the `UI_BlurMaterial` you created.

### 4. Adjust Material/Element Parameters
Customize the blur effect using the following parameters in the material or UI element:
- **Size**: Controls the kernel size of the blur (higher values = wider blur spread).
- **Strength**: Adjusts the Gaussian weights for blur intensity (higher values = stronger blur).
- **Downsample**: Adjust the resolution of the source texture (lower values = lower resolution).

### 5. Example Configuration
![Exemplo de Blur UI](example.gif)

```yaml
- Element Color: (0, 0, 0, 0.15)
- Size: 5.0
- Strength: 5.0
- Downsample: 1.0
