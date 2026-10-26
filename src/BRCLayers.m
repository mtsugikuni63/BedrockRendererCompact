#import "BRCLayers.h"
#import <TargetConditionals.h>

@implementation BRCMetalAdapter
- (BRCBackendKind)kind { return BRCBackendKindMetal; }
- (NSString *)name { return @"Native Metal (probe only)"; }
- (BOOL)isSupported:(NSString **)reason {
#if TARGET_OS_IOS
    if (reason) *reason = @"Metal availability probe passed; no game rendering bridge is implemented";
    return YES;
#else
    if (reason) *reason = @"This starter adapter targets iOS";
    return NO;
#endif
}
- (BOOL)initializeLayer:(NSString **)reason { if (reason) *reason = @"No Metal shader translator or Bedrock render hook is included"; return NO; }
- (void)shutdownLayer {}
@end

@implementation BRCAngleAdapter
- (BRCBackendKind)kind { return BRCBackendKindANGLE; }
- (NSString *)name { return @"ANGLE (integration placeholder)"; }
- (BOOL)isSupported:(NSString **)reason { if (reason) *reason = @"Requires a separately built ANGLE library and a supported integration point"; return NO; }
- (BOOL)initializeLayer:(NSString **)reason { if (reason) *reason = @"ANGLE adapter is not linked in this starter"; return NO; }
- (void)shutdownLayer {}
@end

@implementation BRCMobileGluesAdapter
- (BRCBackendKind)kind { return BRCBackendKindMobileGlues; }
- (NSString *)name { return @"MobileGlues (unsupported platform placeholder)"; }
- (BOOL)isSupported:(NSString **)reason { if (reason) *reason = @"MobileGlues is primarily for Java Edition on Android, not iOS Bedrock"; return NO; }
- (BOOL)initializeLayer:(NSString **)reason { if (reason) *reason = @"No compatible iOS Bedrock implementation exists in this starter"; return NO; }
- (void)shutdownLayer {}
@end

@implementation BRCRenderDragonAdapter
- (BRCBackendKind)kind { return BRCBackendKindRenderDragon; }
- (NSString *)name { return @"RenderDragon (host-owned fallback)"; }
- (BOOL)isSupported:(NSString **)reason { if (reason) *reason = @"No verified RenderDragon hook is provided; leave the host renderer untouched"; return NO; }
- (BOOL)initializeLayer:(NSString **)reason { if (reason) *reason = @"Cannot initialize a game-owned renderer without a verified integration"; return NO; }
- (void)shutdownLayer {}
@end

NSArray<id<BRCCompatibilityLayer>> *BRCDefaultLayerOrder(void) {
    // Try independent layers in order. Unsupported placeholders are skipped safely.
    return @[[BRCMetalAdapter new], [BRCAngleAdapter new], [BRCMobileGluesAdapter new], [BRCRenderDragonAdapter new]];
}
