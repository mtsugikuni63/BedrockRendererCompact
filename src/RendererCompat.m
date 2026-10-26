#import <Foundation/Foundation.h>

// Demonstration-only entry point. This deliberately does not hook Minecraft.
// It is safe to compile as a minimal iOS ARM64 dylib, but it is not a renderer mod.
__attribute__((constructor))
static void BedrockRendererCompatLoaded(void) {
    NSLog(@"[BedrockRendererCompat] Demo library loaded. No renderer hooks are implemented.");
}

// Placeholder for a future settings/configuration layer.
// Do not claim that changing these values changes Minecraft's renderer.
static const char * const BRC_SUPPORTED_MODES[] = {
    "RenderDragon (default; not hooked)",
    "ANGLE (not integrated)",
    "MobileGlues (Java Edition; not a Bedrock backend)",
    "Experimental (not implemented)"
};

__attribute__((visibility("default")))
const char *BRC_GetStatus(void) {
    return "Demo only: no Minecraft/RenderDragon integration";
}

__attribute__((visibility("default")))
unsigned int BRC_GetModeCount(void) {
    return (unsigned int)(sizeof(BRC_SUPPORTED_MODES) / sizeof(BRC_SUPPORTED_MODES[0]));
}
