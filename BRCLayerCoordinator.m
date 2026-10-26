#import "BRCLayerCoordinator.h"

@interface BRCLayerCoordinator ()
@property (nonatomic, copy) NSArray<id<BRCCompatibilityLayer>> *layers;
@property (nonatomic, copy, readwrite) NSArray<NSDictionary<NSString *,id> *> *diagnostics;
@property (nonatomic, strong, readwrite, nullable) id<BRCCompatibilityLayer> activeLayer;
@end

@implementation BRCLayerCoordinator
- (instancetype)initWithLayers:(NSArray<id<BRCCompatibilityLayer>> *)layers {
    if ((self = [super init])) { _layers = [layers copy]; _diagnostics = @[]; }
    return self;
}

- (id<BRCCompatibilityLayer>)selectFirstWorkingLayer {
    [self shutdown];
    NSMutableArray *events = [NSMutableArray array];
    for (id<BRCCompatibilityLayer> layer in self.layers) {
        NSString *reason = nil;
        if (![layer isSupported:&reason]) {
            [events addObject:@{@"layer": layer.name, @"result": @"unsupported", @"reason": reason ?: @"Capability check failed"}];
            continue;
        }
        reason = nil;
        if (![layer initializeLayer:&reason]) {
            [events addObject:@{@"layer": layer.name, @"result": @"initialization_failed", @"reason": reason ?: @"Initialization failed"}];
            [layer shutdownLayer];
            continue;
        }
        self.activeLayer = layer;
        [events addObject:@{@"layer": layer.name, @"result": @"selected", @"reason": @"Probe and initialization succeeded"}];
        break;
    }
    if (!self.activeLayer) {
        [events addObject:@{@"layer": @"host", @"result": @"fallback", @"reason": @"No compatibility layer succeeded; keep the existing renderer"}];
    }
    self.diagnostics = [events copy];
    return self.activeLayer;
}

- (void)shutdown {
    [self.activeLayer shutdownLayer];
    self.activeLayer = nil;
}
@end

const char *BRCGetVersion(void) { return "0.1.0-starter"; }
const char *BRCGetDiagnosticsJSON(void) {
    static NSString *json;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ json = @"[]"; });
    return [json UTF8String];
}
