#import <UIKit/UIKit.h>
#import "RedxRootNewViewController.h"
@interface RedxloginViewController : RedxRootNewViewController<UITextFieldDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate, UITabBarControllerDelegate>
@property (nonatomic, strong) UITabBarController *tabbar;
@property (nonatomic, strong) NSString *oldName;
@property (nonatomic, strong) NSString *oldPassword;
@property (nonatomic, strong) NSString *LogType;
@property (nonatomic, strong) NSString *demoName;
@property (nonatomic, strong) NSString *demoPassword;
@property (nonatomic, strong) NSString *demoServerURL;
@property (nonatomic, assign) NSInteger LogTypeForOSS;   
@property (nonatomic,assign) BOOL isFirstLogin;
@property (nonatomic, assign) NSInteger LogOssNum;   
@property (nonatomic, assign) NSString *demoPlantID;  
@property (nonatomic, strong) NSString *uidString;     
@property (nonatomic, strong) NSString *typeString;      
@property (nonatomic,assign) BOOL isLoginByPush;   
@property (nonatomic, strong)NSDictionary*pushInfoDic;  
@property (nonatomic, strong)NSString *isGroHomeIn;  
@property (nonatomic, strong)NSString *isJump;  
@end
