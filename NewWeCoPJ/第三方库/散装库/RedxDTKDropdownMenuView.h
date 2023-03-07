#import <UIKit/UIKit.h>
typedef void(^dropMenuCallBack)(NSUInteger index,id info);
typedef enum : NSUInteger {
    dropDownTypeTitle = 0,
    dropDownTypeLeftItem = 1,
    dropDownTypeRightItem = 2,
} DTKDropDownType;
@interface DTKDropdownButton : UIButton
@end
@interface RedxDTKDropdownMenuView : UIView
+ (instancetype)dropdownMenuViewWithType:(DTKDropDownType)dropDownType frame:(CGRect)frame dropdownItems:(NSArray *)dropdownItems icon:(NSString *)icon;
+ (instancetype)dropdownMenuViewForNavbarTitleViewWithFrame:(CGRect )frame dropdownItems:(NSArray *)dropdownItems;
-(void)pullTheTableView;
@property(weak ,nonatomic) UINavigationController *currentNav;
@property (strong ,nonatomic) DTKDropdownButton *titleButton;
@property (assign ,nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont  *titleFont;
@property (assign, nonatomic) CGFloat dropWidth;
@property (strong, nonatomic) UIColor *cellColor;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont  *textFont;
@property (strong, nonatomic) UIColor *cellSeparatorColor;
@property (strong, nonatomic) UIColor *cellAccessoryCheckmarkColor;
@property (assign, nonatomic) CGFloat cellHeight;
@property (assign, nonatomic) CGFloat animationDuration;
@property (assign, nonatomic) BOOL    showAccessoryCheckmark;
@property (assign, nonatomic) CGFloat backgroundAlpha;
@property(nonatomic, assign) CGSize intrinsicContentSize;
@end
@interface DTKDropdownItem : NSObject
@property (nonatomic, copy) dropMenuCallBack callBack;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *iconName;
@property (assign, nonatomic)  BOOL isSelected;
@property (strong, nonatomic) id info;
+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)iconName callBack:(dropMenuCallBack)callBack;
+ (instancetype)itemWithTitle:(NSString *)title callBack:(dropMenuCallBack)callBack;
+ (instancetype)Item;
@end
