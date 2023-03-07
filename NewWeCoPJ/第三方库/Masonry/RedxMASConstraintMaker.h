#import "RedxMASConstraint.h"
#import "MASUtilities.h"
typedef NS_OPTIONS(NSInteger, MASAttribute) {
    MASAttributeLeft = 1 << NSLayoutAttributeLeft,
    MASAttributeRight = 1 << NSLayoutAttributeRight,
    MASAttributeTop = 1 << NSLayoutAttributeTop,
    MASAttributeBottom = 1 << NSLayoutAttributeBottom,
    MASAttributeLeading = 1 << NSLayoutAttributeLeading,
    MASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    MASAttributeWidth = 1 << NSLayoutAttributeWidth,
    MASAttributeHeight = 1 << NSLayoutAttributeHeight,
    MASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    MASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    MASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
#if TARGET_OS_IPHONE || TARGET_OS_TV
    MASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    MASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    MASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    MASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    MASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    MASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    MASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    MASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,
#endif
};
@interface RedxMASConstraintMaker : NSObject
@property (nonatomic, strong, readonly) RedxMASConstraint *left;
@property (nonatomic, strong, readonly) RedxMASConstraint *top;
@property (nonatomic, strong, readonly) RedxMASConstraint *right;
@property (nonatomic, strong, readonly) RedxMASConstraint *bottom;
@property (nonatomic, strong, readonly) RedxMASConstraint *leading;
@property (nonatomic, strong, readonly) RedxMASConstraint *trailing;
@property (nonatomic, strong, readonly) RedxMASConstraint *width;
@property (nonatomic, strong, readonly) RedxMASConstraint *height;
@property (nonatomic, strong, readonly) RedxMASConstraint *centerX;
@property (nonatomic, strong, readonly) RedxMASConstraint *centerY;
@property (nonatomic, strong, readonly) RedxMASConstraint *baseline;
#if TARGET_OS_IPHONE || TARGET_OS_TV
@property (nonatomic, strong, readonly) RedxMASConstraint *leftMargin;
@property (nonatomic, strong, readonly) RedxMASConstraint *rightMargin;
@property (nonatomic, strong, readonly) RedxMASConstraint *topMargin;
@property (nonatomic, strong, readonly) RedxMASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) RedxMASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) RedxMASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) RedxMASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) RedxMASConstraint *centerYWithinMargins;
#endif
@property (nonatomic, strong, readonly) RedxMASConstraint *(^attributes)(MASAttribute attrs);
@property (nonatomic, strong, readonly) RedxMASConstraint *edges;
@property (nonatomic, strong, readonly) RedxMASConstraint *size;
@property (nonatomic, strong, readonly) RedxMASConstraint *center;
@property (nonatomic, assign) BOOL updateExisting;
@property (nonatomic, assign) BOOL removeExisting;
- (id)initWithView:(MAS_VIEW *)view;
- (NSArray *)install;
- (RedxMASConstraint * (^)(dispatch_block_t))group;
@end
