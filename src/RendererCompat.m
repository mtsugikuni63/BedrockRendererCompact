
#import <Foundation/Foundation.h>
#import "BRCLayerCoordinator.h"

__attribute__((visibility("default")))
const char *BRCGetVersion(void) {
    return "0.2.0";
}

__attribute__((visibility("default")))
const char *BRCGetStatus(void) {
    return "Compatibility framework loaded; renderer adapters require integration.";
}

__attribute__((visibility("default")))
int BRCInitialize(void) {
    @autoreleasepool {
        NSLog(@"[BedrockRendererCompat] Initializing compatibility framework");
        return 1;
    }
}
