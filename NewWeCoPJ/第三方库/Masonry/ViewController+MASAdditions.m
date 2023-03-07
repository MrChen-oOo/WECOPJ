#import "ViewController+MASAdditions.h"
#ifdef MAS_VIEW_CONTROLLER
@implementation MAS_VIEW_CONTROLLER (MASAdditions)
- (RedxMASViewAttribute *)mas_topLayoutGuide {
    return [[RedxMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (RedxMASViewAttribute *)mas_topLayoutGuideTop {
    return [[RedxMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (RedxMASViewAttribute *)mas_topLayoutGuideBottom {
    return [[RedxMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (RedxMASViewAttribute *)mas_bottomLayoutGuide {
    return [[RedxMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (RedxMASViewAttribute *)mas_bottomLayoutGuideTop {
    return [[RedxMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (RedxMASViewAttribute *)mas_bottomLayoutGuideBottom {
    return [[RedxMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
@end
#endif
