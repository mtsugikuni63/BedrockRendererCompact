#import "../BRCLayerCoordinator.h"

@interface BRCMetalAdapter : NSObject <BRCCompatibilityLayer> @end
@interface BRCAngleAdapter : NSObject <BRCCompatibilityLayer> @end
@interface BRCMobileGluesAdapter : NSObject <BRCCompatibilityLayer> @end
@interface BRCRenderDragonAdapter : NSObject <BRCCompatibilityLayer> @end
FOUNDATION_EXPORT NSArray<id<BRCCompatibilityLayer>> *BRCDefaultLayerOrder(void);
