#import "View+MASAdditions.h"
#import <objc/runtime.h>
@implementation MAS_VIEW (MASAdditions)
- (NSArray *)mas_makeConstraints:(void(^)(RedxMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    RedxMASConstraintMaker *constraintMaker = [[RedxMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}
- (NSArray *)mas_updateConstraints:(void(^)(RedxMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    RedxMASConstraintMaker *constraintMaker = [[RedxMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}
- (NSArray *)mas_remakeConstraints:(void(^)(RedxMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    RedxMASConstraintMaker *constraintMaker = [[RedxMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}
#pragma mark - NSLayoutAttribute properties
- (RedxMASViewAttribute *)mas_left {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}
- (RedxMASViewAttribute *)mas_top {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}
- (RedxMASViewAttribute *)mas_right {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}
- (RedxMASViewAttribute *)mas_bottom {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}
- (RedxMASViewAttribute *)mas_leading {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}
- (RedxMASViewAttribute *)mas_trailing {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}
- (RedxMASViewAttribute *)mas_width {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}
- (RedxMASViewAttribute *)mas_height {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}
- (RedxMASViewAttribute *)mas_centerX {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}
- (RedxMASViewAttribute *)mas_centerY {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}
- (RedxMASViewAttribute *)mas_baseline {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}
- (RedxMASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}
#if TARGET_OS_IPHONE || TARGET_OS_TV
- (RedxMASViewAttribute *)mas_leftMargin {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}
- (RedxMASViewAttribute *)mas_rightMargin {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}
- (RedxMASViewAttribute *)mas_topMargin {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}
- (RedxMASViewAttribute *)mas_bottomMargin {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}
- (RedxMASViewAttribute *)mas_leadingMargin {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}
- (RedxMASViewAttribute *)mas_trailingMargin {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}
- (RedxMASViewAttribute *)mas_centerXWithinMargins {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}
- (RedxMASViewAttribute *)mas_centerYWithinMargins {
    return [[RedxMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}
#endif
#pragma mark - associated properties
- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}
- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - heirachy
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;
    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}
@end
