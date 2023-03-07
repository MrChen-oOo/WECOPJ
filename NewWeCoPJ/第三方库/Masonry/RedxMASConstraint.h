#import "MASUtilities.h"
@interface RedxMASConstraint : NSObject
- (RedxMASConstraint * (^)(MASEdgeInsets insets))insets;
- (RedxMASConstraint * (^)(CGSize offset))sizeOffset;
- (RedxMASConstraint * (^)(CGPoint offset))centerOffset;
- (RedxMASConstraint * (^)(CGFloat offset))offset;
- (RedxMASConstraint * (^)(NSValue *value))valueOffset;
- (RedxMASConstraint * (^)(CGFloat multiplier))multipliedBy;
- (RedxMASConstraint * (^)(CGFloat divider))dividedBy;
- (RedxMASConstraint * (^)(MASLayoutPriority priority))priority;
- (RedxMASConstraint * (^)())priorityLow;
- (RedxMASConstraint * (^)())priorityMedium;
- (RedxMASConstraint * (^)())priorityHigh;
- (RedxMASConstraint * (^)(id attr))equalTo;
- (RedxMASConstraint * (^)(id attr))greaterThanOrEqualTo;
- (RedxMASConstraint * (^)(id attr))lessThanOrEqualTo;
- (RedxMASConstraint *)with;
- (RedxMASConstraint *)and;
- (RedxMASConstraint *)left;
- (RedxMASConstraint *)top;
- (RedxMASConstraint *)right;
- (RedxMASConstraint *)bottom;
- (RedxMASConstraint *)leading;
- (RedxMASConstraint *)trailing;
- (RedxMASConstraint *)width;
- (RedxMASConstraint *)height;
- (RedxMASConstraint *)centerX;
- (RedxMASConstraint *)centerY;
- (RedxMASConstraint *)baseline;
#if TARGET_OS_IPHONE || TARGET_OS_TV
- (RedxMASConstraint *)leftMargin;
- (RedxMASConstraint *)rightMargin;
- (RedxMASConstraint *)topMargin;
- (RedxMASConstraint *)bottomMargin;
- (RedxMASConstraint *)leadingMargin;
- (RedxMASConstraint *)trailingMargin;
- (RedxMASConstraint *)centerXWithinMargins;
- (RedxMASConstraint *)centerYWithinMargins;
#endif
- (RedxMASConstraint * (^)(id key))key;
- (void)setInsets:(MASEdgeInsets)insets;
- (void)setSizeOffset:(CGSize)sizeOffset;
- (void)setCenterOffset:(CGPoint)centerOffset;
- (void)setOffset:(CGFloat)offset;
#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
@property (nonatomic, copy, readonly) RedxMASConstraint *animator;
#endif
- (void)activate;
- (void)deactivate;
- (void)install;
- (void)uninstall;
@end
#define mas_equalTo(...)                 equalTo(MASBoxValue((__VA_ARGS__)))
#define mas_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(MASBoxValue((__VA_ARGS__)))
#define mas_lessThanOrEqualTo(...)       lessThanOrEqualTo(MASBoxValue((__VA_ARGS__)))
#define mas_offset(...)                  valueOffset(MASBoxValue((__VA_ARGS__)))
#ifdef MAS_SHORTHAND_GLOBALS
#define equalTo(...)                     mas_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        mas_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           mas_lessThanOrEqualTo(__VA_ARGS__)
#define offset(...)                      mas_offset(__VA_ARGS__)
#endif
@interface RedxMASConstraint (AutoboxingSupport)
- (RedxMASConstraint * (^)(id attr))mas_equalTo;
- (RedxMASConstraint * (^)(id attr))mas_greaterThanOrEqualTo;
- (RedxMASConstraint * (^)(id attr))mas_lessThanOrEqualTo;
- (RedxMASConstraint * (^)(id offset))mas_offset;
@end
