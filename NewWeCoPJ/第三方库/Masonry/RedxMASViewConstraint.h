#import "RedxMASViewAttribute.h"
#import "RedxMASConstraint.h"
#import "RedxMASLayoutConstraint.h"
#import "MASUtilities.h"
@interface RedxMASViewConstraint : RedxMASConstraint <NSCopying>
@property (nonatomic, strong, readonly) RedxMASViewAttribute *firstViewAttribute;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *secondViewAttribute;
- (id)initWithFirstViewAttribute:(RedxMASViewAttribute *)firstViewAttribute;
+ (NSArray *)installedConstraintsForView:(MAS_VIEW *)view;
@end
