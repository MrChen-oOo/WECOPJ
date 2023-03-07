#import <UIKit/UIKit.h>
@interface RedxKTDropdownMenuView : UIView
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UIColor *cellColor;
@property (nonatomic, strong) UIColor *cellSeparatorColor;
@property (nonatomic, strong) UIColor *cellAccessoryCheckmarkColor;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) CGFloat backgroundAlpha;
@property (nonatomic, copy) void (^selectedAtIndex)(int index);
@property (nonatomic, assign) NSUInteger selectedIndex;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles;
@end
