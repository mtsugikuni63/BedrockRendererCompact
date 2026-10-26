# BedrockRendererCompat — starter scaffold

This is a **build-and-learning scaffold**, not a working Minecraft renderer replacement.

It contains:
- a tiny Objective-C iOS dynamic-library example;
- a GitHub Actions workflow that attempts to compile an unsigned iOS ARM64 `.dylib` on a macOS runner;
- notes explaining the current limitations.

## What it does not do
- It does not hook Minecraft Bedrock or RenderDragon.
- It does not switch RenderDragon, ANGLE, or MobileGlues.
- It does not convert shaders from GLSL to Metal.
- MobileGlues targets Java Edition and is not a drop-in Bedrock renderer.
- A successful compile does not prove the library can be loaded into Minecraft. The correct injection/loading method, app version, entitlements/signing, and tested Bedrock-specific hooks are still required.

## Build it from an iPad using Safari
1. Sign in at https://github.com/.
2. Create a new repository named `BedrockRendererCompat` (a public repo is simplest for this starter).
3. On the repository page, use **Add file → Upload files** and upload the contents of this ZIP, preserving the `.github/workflows/build.yml` path. If GitHub's mobile layout hides this, open Safari's page menu and choose **Request Desktop Website**.
4. Commit the files to the `main` branch.
5. Open the repository's **Actions** tab and select **Build iOS ARM64 dylib**. If prompted, enable workflows.
6. Wait for the run to finish. Open the completed run and download the `BedrockRendererCompat-unsigned-arm64` artifact.
7. The artifact is a test library only. Do not inject it into your game expecting renderer switching; no renderer hooks exist yet.

## If the build fails
Open the failed workflow run and copy the first actual error from the log. The workflow uses Apple's installed Xcode/SDK on GitHub's macOS runner, so availability can change over time.
