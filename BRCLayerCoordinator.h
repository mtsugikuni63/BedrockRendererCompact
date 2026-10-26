#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BRCBackendKind) {
    BRCBackendKindRenderDragon = 0,
    BRCBackendKindMetal = 1,
    BRCBackendKindANGLE = 2,
    BRCBackendKindMobileGlues = 3,
};

@protocol BRCCompatibilityLayer <NSObject>
@property (nonatomic, readonly) BRCBackendKind kind;
@property (nonatomic, copy, readonly) NSString *name;
- (BOOL)isSupported:(NSString * _Nullable __autoreleasing *)reason;
- (BOOL)initializeLayer:(NSString * _Nullable __autoreleasing *)reason;
- (void)shutdownLayer;
@end

@interface BRCLayerCoordinator : NSObject
@property (nonatomic, copy, readonly) NSArray<NSDictionary<NSString *, id> *> *diagnostics;
@property (nonatomic, strong, readonly, nullable) id<BRCCompatibilityLayer> activeLayer;
- (instancetype)initWithLayers:(NSArray<id<BRCCompatibilityLayer>> *)layers;
- (nullable id<BRCCompatibilityLayer>)selectFirstWorkingLayer;
- (void)shutdown;
@end

FOUNDATION_EXPORT const char *BRCGetVersion(void);
FOUNDATION_EXPORT const char *BRCGetDiagnosticsJSON(void);

NS_ASSUME_NONNULL_END
