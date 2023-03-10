#import "MASUtilities.h"
@interface RedxMASViewAttribute : NSObject
@property (nonatomic, weak, readonly) MAS_VIEW *view;
@property (nonatomic, weak, readonly) id item;
@property (nonatomic, assign, readonly) NSLayoutAttribute layoutAttribute;
- (id)initWithView:(MAS_VIEW *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute;
- (id)initWithView:(MAS_VIEW *)view item:(id)item layoutAttribute:(NSLayoutAttribute)layoutAttribute;
- (BOOL)isSizeAttribute;
@end
