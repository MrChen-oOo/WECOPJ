#import "MASUtilities.h"
#import "RedxMASConstraintMaker.h"
#import "RedxMASViewAttribute.h"
#ifdef MAS_VIEW_CONTROLLER
@interface MAS_VIEW_CONTROLLER (MASAdditions)
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_topLayoutGuide;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_bottomLayoutGuide;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_topLayoutGuideTop;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_bottomLayoutGuideBottom;
@end
#endif
