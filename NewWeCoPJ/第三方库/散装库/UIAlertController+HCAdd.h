#import <UIKit/UIKit.h>
@interface UIAlertController (HCAdd)
+ (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message BtnTitles:(NSArray<NSString *> *)btnTitles ClickBtn:(void (^)(NSInteger index))clickBtnBlock;
+ (void)showActionSheetWithTitle:(NSString *)title Message:(NSString *)message cancelBtnTitle:(NSString *)cancelBtnTitle OtherBtnTitles:(NSArray<NSString *> *)otherBtnTitles ClickBtn:(void(^)(NSInteger index))clickBtnBlock;
@end
