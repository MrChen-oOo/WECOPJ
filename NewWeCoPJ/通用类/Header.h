#ifndef Header_h
#define Header_h
#import "RedxUserInfo.h"
#import "RedxBaseRequest.h"
#import "MBProgressHUD.h"
#import "SafeObject.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "WeTitleView.h"



#define allAdjustCompanyName  @"Noor"
#define appNameForAll  @"Noor"
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
#define IMAGE(_NAME) [UIImage imageNamed:_NAME]
#define XLIMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:([_NAME hasSuffix:@".png"]||[_NAME hasSuffix:@".jpg"])?(_NAME):([_NAME stringByAppendingString:@".png"])]]
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]
#define ManagerObjectModelFileName @"deviceCore" 
#define LineWidth  [UIScreen mainScreen].bounds.size.height*0.5/560
#define MainColor COLOR(33, 33, 32, 1)
#define mainColor COLOR(33, 33, 32, 1)
#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define backgroundGrayColor COLOR(244, 243, 239, 1)
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define colorGary COLOR(222, 222, 222, 1)
#define textColorGray COLOR(154, 154, 154, 1)
#define textColorGray2 COLOR(102, 102, 102, 1)
#define colorBlack COLOR(51, 51, 51, 1)
#define colorblack_51  COLOR(51, 51, 51, 1) 
#define colorblack_102 COLOR(102, 102, 102, 1) 
#define colorblack_154 COLOR(154, 154, 154, 1) 
#define colorblack_186 COLOR(186, 186, 186, 1) 
#define colorblack_222 COLOR(222, 222, 222, 1) 
#define colorwhite_100  COLOR(242, 242, 242, 1) 
#define colorwhite_80 COLOR(242, 242, 242, 0.8) 
#define colorwhite_60 COLOR(242, 242, 242, 0.6) 
#define colorwhite_30 COLOR(242, 242, 242, 0.3) 
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define kiPhone6 ([UIScreen mainScreen].bounds.size.width==375)
#define frameMake(a,b,c,d) CGRectMake(a*NOW_SIZE,b*NOW_SIZE,c*NOW_SIZE,d*NOW_SIZE)
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define KNOTIFICATION_LOGINCHANGE                      @"loginStateChange"
 #define Get_Net_time  25.f
 #define TCP_hide_time  0.2f
 #define Head_Url_more  @"https://monitor.redxvpp.com/publish"
 #define Demo_Name  @"guest"
 #define Demo_password  @"123456"
#define worldServerUrl  @"http://monitor.redxvpp.com"
#define chinaServerUrl  @"http://monitor.redxvpp.com"


#define HEAD_URL_Demo  @"http://server-olp.shuoxd.com:8080"//@"http://monitor.redxvpp.com"
#define HEAD_URL_Demo_CN  @"http://server-olp.shuoxd.com:8080"//@"http://monitor.redxvpp.com"
#define HEAD_URL  @"http://server-olp.shuoxd.com:8080"//[RedxUserInfo defaultUserInfo].server
#define OSS_HEAD_URL_Demo  @""
#define OSS_HEAD_URL  [RedxUserInfo defaultUserInfo].OSSserver
#define OSS_HEAD_URL_Demo_2  @""



#define HttpHead  @"http://"

//#define HEAD_URL_Demo  @"http://20.60.5.193:8083"
//#define HEAD_URL_Demo_CN  @"http://20.60.5.193:8083"
//#define HEAD_URL  @"http://20.60.5.193:8083" //[RedxUserInfo defaultUserInfo].server

//#define HEAD_URL_Demo  @"http://cn.redxvpp.com"
//#define HEAD_URL_Demo_CN  @"http://cn.redxvpp.com"
//#define HEAD_URL  @"http://cn.redxvpp.com" //[RedxUserInfo defaultUserInfo].server

#define formal_Method @""
#define charge_Method @""



#define is_Test @"isTest"
#define textFiedMinFont 6
#define tcp_IP  @"192.168.10.100"
#define tcp_port  5280
#define fontTypeOne @"PingFangSC-Regular"
#define NavigationbarHeight  self.navigationController.navigationBar.frame.size.height
#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define deviceSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_Iphone_X IS_PhoneXAll
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49



#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_6sp ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_oldPhone (IS_IPHONE_4S || IS_IPHONE_5s || IS_IPHONE_6s || IS_IPHONE_6sp)


#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define IS_IPHONE_Xr2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)
#define DX_Is_iPhone12_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define DX_Is_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define DX_Is_iPhone12_ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define IS_Phone12 (DX_Is_iPhone12_Mini || DX_Is_iPhone12 || DX_Is_iPhone12_ProMax)
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xr2 || IS_IPHONE_Xs_Max || IS_Phone12)
#define k_Height_NavContentBar 44.0f
#define k_Height_StatusBar (IS_oldPhone ? 20.0 : 44.0)
#define kNavBarHeight (IS_oldPhone ? 64.0 : 88.0)
#define NaviHeight (IS_oldPhone ? 64.0 : 88.0)
#define TabbarHeight (IS_oldPhone ? 49 : 83)
#define kBottomBarHeight (IS_oldPhone ? 0 : 34.0)
#define kContentHeight (kScreenHeight - kNavBarHeight-kBottomBarHeight)
#define NOW_SIZE [UIScreen mainScreen].bounds.size.width/320
#define HEIGHT_SIZE1  ([UIScreen mainScreen].bounds.size.height/560)
#define HEIGHT_SIZE2  ([UIScreen mainScreen].bounds.size.height/780)
#define HEIGHT_SIZE  (IS_oldPhone ? HEIGHT_SIZE1 : HEIGHT_SIZE2)
#define Screen375        375.0
#define screenX0 10*NOW_SIZE
#define iPhoneX IS_PhoneXAll
#define XLscaleH HEIGHT_SIZE 
#define XLscaleW NOW_SIZE 
#define iphonexH 200*HEIGHT_SIZE
#define XLViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
#define KenergyColor COLOR(26, 216, 44, 1)
#define KcurrentColor COLOR(160, 120, 202, 1)
#define KvoltageColor COLOR(189, 165, 32, 1)
#define KpowerColor COLOR(54, 158, 224, 1)
#define KtemperatureColor COLOR(42, 189, 190, 1)
#define KrateColor COLOR(230, 170, 8, 1)
#define KexchangeColor COLOR(193, 200, 9, 1)
#define kClearColor [UIColor clearColor]
#define WhiteColor [UIColor whiteColor]
#define backgroundNewColor COLOR(247, 247, 247, 1) //COLOR(236, 239, 241, 1)
#define text51Color COLOR(51, 51, 51, 1)    
#define text102Color COLOR(102, 102, 102, 1)    
#define text153Color COLOR(153, 153, 153, 1)    
#define buttonColor COLOR(135, 135, 135, 1)
#define FontSize(x) [UIFont systemFontOfSize:x]
#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"null"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || str == nil || [str length] < 1 ? YES : NO ) 
#define HSStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"null"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || str == nil || [str length] < 1 ? @"" : str ) 
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0     \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define thermostatType  @"thermostat"  
#define socketType  @"socket"  
#define shineBoostType  @"shineBoot"
#define airConditionType  @"wukong" 
#define switchType  @"switch"  
#define ameterType @"ameter"   
#define chargerType @"charger"
#define boostLoad @"load"
#define stripType  @"strip"  
#define bulbType  @"bulb"  
#define fastMode @"fast"
#define pvLinkageMode @"pvLinkage"
#define offPeakMode @"offPeak"
#define GeneralModel @"General model"
#define isAgreeLookDevice @"isAgreeLookDevice"
#define DESKEY  @"Redx_Ev_ProjectEv"
#endif 
