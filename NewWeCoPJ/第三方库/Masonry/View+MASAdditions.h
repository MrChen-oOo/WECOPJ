#import "MASUtilities.h"
#import "RedxMASConstraintMaker.h"
#import "RedxMASViewAttribute.h"
@interface MAS_VIEW (MASAdditions)
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_centerY;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_baseline;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);
#if TARGET_OS_IPHONE || TARGET_OS_TV
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_leftMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_rightMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_topMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_bottomMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_leadingMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_trailingMargin;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) RedxMASViewAttribute *mas_centerYWithinMargins;
#endif
@property (nonatomic, strong) id mas_key;
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view;
- (NSArray *)mas_makeConstraints:(void(^)(RedxMASConstraintMaker *make))block;
- (NSArray *)mas_updateConstraints:(void(^)(RedxMASConstraintMaker *make))block;
- (NSArray *)mas_remakeConstraints:(void(^)(RedxMASConstraintMaker *make))block;
@end
