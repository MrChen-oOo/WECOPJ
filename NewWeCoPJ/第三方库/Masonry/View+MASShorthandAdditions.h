#import "View+MASAdditions.h"
#ifdef MAS_SHORTHAND
@interface MAS_VIEW (MASShorthandAdditions)
@property (nonatomic, strong, readonly) RedxMASViewAttribute *left;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *top;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *right;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *bottom;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *leading;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *trailing;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *width;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *height;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *centerX;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *centerY;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *baseline;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *(^attribute)(NSLayoutAttribute attr);
#if TARGET_OS_IPHONE || TARGET_OS_TV
@property (nonatomic, strong, readonly) RedxMASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *centerYWithinMargins;
#endif
- (NSArray *)makeConstraints:(void(^)(RedxMASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(RedxMASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(RedxMASConstraintMaker *make))block;
@end
#define MAS_ATTR_FORWARD(attr)  \
- (RedxMASViewAttribute *)attr {    \
    return [self mas_##attr];   \
}
@implementation MAS_VIEW (MASShorthandAdditions)
MAS_ATTR_FORWARD(top);
MAS_ATTR_FORWARD(left);
MAS_ATTR_FORWARD(bottom);
MAS_ATTR_FORWARD(right);
MAS_ATTR_FORWARD(leading);
MAS_ATTR_FORWARD(trailing);
MAS_ATTR_FORWARD(width);
MAS_ATTR_FORWARD(height);
MAS_ATTR_FORWARD(centerX);
MAS_ATTR_FORWARD(centerY);
MAS_ATTR_FORWARD(baseline);
#if TARGET_OS_IPHONE || TARGET_OS_TV
MAS_ATTR_FORWARD(leftMargin);
MAS_ATTR_FORWARD(rightMargin);
MAS_ATTR_FORWARD(topMargin);
MAS_ATTR_FORWARD(bottomMargin);
MAS_ATTR_FORWARD(leadingMargin);
MAS_ATTR_FORWARD(trailingMargin);
MAS_ATTR_FORWARD(centerXWithinMargins);
MAS_ATTR_FORWARD(centerYWithinMargins);
#endif
- (RedxMASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self mas_attribute];
}
- (NSArray *)makeConstraints:(void(^)(RedxMASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}
- (NSArray *)updateConstraints:(void(^)(RedxMASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}
- (NSArray *)remakeConstraints:(void(^)(RedxMASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}
@end
#endif
