//
//  AppDelegate.m
//  NewWeCoPJ
//
//  Created by CBQ on 2023/2/1.
//

#import "AppDelegate.h"
#import "RedxloginViewController.h"
#import "NTVLocalized.h"
#import "AFNetworking.h"
#import "ZYNetworkAccessibility.h"


@interface AppDelegate ()
@property (nonatomic, strong)UIView *netBGView;
@property (nonatomic, strong)NSString *typestr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self getNetworkReachability];
    [ZYNetworkAccessibility start];
    // Override point for customization after application launch.
    [[NSUserDefaults standardUserDefaults] setValue:@[@"en"] forKey:@"AppleLanguages"];
//            [[NSUserDefaults standardUserDefaults] setValue:_keyArr22[indexPath.row] forKey:@"LocalLanguageKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NTVLocalized sharedInstance] setLanguage:@"en"];
    
//    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:NO];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    NSUserDefaults *picName1=[NSUserDefaults standardUserDefaults];
//    NSString *picName=[picName1 objectForKey:@"firstPic"];
//    if ([picName length]==0) {
//             [[RedxUserInfo defaultUserInfo]setFirstPic:@"OK"];
//        RedxLZQStratViewController_25 *lzqStartViewController = [[RedxLZQStratViewController_25 alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:lzqStartViewController];
//        self.window.rootViewController = nav;
//    }else{
    RedxloginViewController *root=[[RedxloginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];
    self.window.rootViewController=nav;
//    }
   
     [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibilityChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createTipsView00) name:@"APPNetworkRestrictedNotif" object:nil];

    
    

    return YES;
}

- (void)networkChanged:(NSNotification *)notification {
    
    ZYNetworkAccessibleState state = ZYNetworkAccessibility.currentState;

    if (state == ZYNetworkRestricted) {
        NSLog(@"网络权限被关闭");
        [[NSUserDefaults standardUserDefaults]setObject:@"ZYNetworkRestricted" forKey:@"NetworkRestricted"];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        [ZYNetworkAccessibility setAlertEnable:YES];
//        [self createTipsView];
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"otherNetError" forKey:@"NetworkRestricted"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

- (void)getNetworkReachability{
    
    AFNetworkReachabilityManager *reachMag = [AFNetworkReachabilityManager sharedManager];
    [reachMag setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态发生改变的时候调用这个block

            switch (status) {

                case AFNetworkReachabilityStatusReachableViaWiFi:

                    NSLog(@"WIFI");
                    [[NSUserDefaults standardUserDefaults]setObject:@"WiFi" forKey:@"NetworkStatus"];


                    break;

                case AFNetworkReachabilityStatusReachableViaWWAN:

                    NSLog(@"自带网络");
                    [[NSUserDefaults standardUserDefaults]setObject:@"WAN" forKey:@"NetworkStatus"];


                    break;

                case AFNetworkReachabilityStatusNotReachable:

                    NSLog(@"没有网络");

//                    [self createTipsView:@"2"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"NotReachable" forKey:@"NetworkStatus"];


                    break;
                    
                case AFNetworkReachabilityStatusUnknown:

                    NSLog(@"未知网络!");
                    [[NSUserDefaults standardUserDefaults]setObject:@"Unknown" forKey:@"NetworkStatus"];


                    break;

                default:

                    break;

            }
    }];
    // 开始监控
    [reachMag startMonitoring];
}

- (void)createTipsView00{
    
    [self createTipsView:@"1"];
}

- (void)createTipsView:(NSString *)typestr{
    
    
    if (self.netBGView) {
        [self.netBGView removeFromSuperview];
        self.netBGView = nil;
    }
    _typestr = typestr;
    UIView *netShowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    netShowView.backgroundColor = COLOR(0, 0, 0, 0.3);
    [KEYWINDOW addSubview:netShowView];
    self.netBGView = netShowView;
    
    NSString *tipsStr = @"Network permission required, please go to setting and enable usage.";
    if ([typestr isEqualToString:@"2"]) {
        tipsStr = @"Network exception, please check the network";
    }
    CGSize strsize = [self getStringSize:21*HEIGHT_SIZE Wsize:netShowView.xmg_width-20*NOW_SIZE Hsize:200*HEIGHT_SIZE stringName:tipsStr];
    UIView *whiView = [[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE, (kScreenHeight-kNavBarHeight)/2-100*HEIGHT_SIZE, kScreenWidth-60*NOW_SIZE, strsize.height+40*HEIGHT_SIZE+45*HEIGHT_SIZE)];
    whiView.layer.cornerRadius = 15*HEIGHT_SIZE;
    whiView.layer.masksToBounds = YES;
    whiView.backgroundColor = WhiteColor;
    [netShowView addSubview:whiView];
    
    UILabel *titLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, whiView.xmg_width-20*NOW_SIZE, strsize.height)];
    titLB.text = tipsStr;
    titLB.font = FontSize(21*HEIGHT_SIZE);
    titLB.textColor = colorblack_51;
    titLB.numberOfLines = 0;
    titLB.adjustsFontSizeToFitWidth = YES;
    [whiView addSubview:titLB];
    
    NSArray *namarr = @[root_cancel,NewLocat_gotoSetWifi];
    
    if ([typestr isEqualToString:@"2"]) {
        namarr = @[root_cancel,root_OK];
    }
    for (int i = 0; i < namarr.count; i++) {
        UIButton *onebtn = [[UIButton alloc]initWithFrame:CGRectMake(-1*NOW_SIZE+(whiView.xmg_width/2+1*NOW_SIZE)*i, CGRectGetMaxY(titLB.frame)+20*HEIGHT_SIZE, (whiView.xmg_width/2+1*NOW_SIZE), 45*HEIGHT_SIZE)];
        [onebtn setTitle:namarr[i] forState:UIControlStateNormal];
        onebtn.layer.borderColor = backgroundNewColor.CGColor;
        onebtn.layer.borderWidth = 1*NOW_SIZE;
        [whiView addSubview:onebtn];
        if (i == 0) {
            [onebtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
            [onebtn setTitleColor:colorblack_51 forState:UIControlStateNormal];
            

        }
        if (i == 1) {
            [onebtn addTarget:self action:@selector(gotoClick) forControlEvents:UIControlEventTouchUpInside];
            [onebtn setTitleColor:buttonColor forState:UIControlStateNormal];
            

        }
    }
    
}
- (void)cancelClick{
    
    if (_netBGView) {
        [_netBGView removeFromSuperview];
        _netBGView = nil;
    }
}

- (void)gotoClick{
    if (_netBGView) {
        [_netBGView removeFromSuperview];
        _netBGView = nil;
    }
    if (![_typestr isEqualToString:@"2"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

    }

    
}
-(CGSize)getStringSize:(float)fontSize Wsize:(float)Wsize Hsize:(float)Hsize stringName:(NSString*)stringName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [stringName boundingRectWithSize:CGSizeMake(Wsize, Hsize) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {

}
- (void)applicationWillEnterForeground:(UIApplication *)application {
   NSLog(@"\n ===> 程序进入前台 !");
    [self getNetworkReachability];

}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    int badge =[userInfo[@"aps"][@"badge"] intValue];
//    badge--;
//    [JPUSHService setBadge:badge];
//    [UIApplication sharedApplication].applicationIconBadgeNumber =badge;
//    NSDateFormatter *format=[[ NSDateFormatter alloc]init];
//    format .locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    [format setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
//    _messegeDic=[NSMutableDictionary new];
//    if ([userInfo.allKeys containsObject:@"type"]) {
//        [self JpushGoToView:userInfo];
//    }
//    if ([userInfo[@"type"] intValue]==0) {
//        format. dateFormat = @"yyyy-MM-dd hh:mm:ss" ;
//        NSDate *date1=[ NSDate date ];
//        NSString *date=[format stringFromDate:date1];
//        [_messegeDic setValue:userInfo[@"content"] forKeyPath:@"content"];
//        [_messegeDic setValue:userInfo[@"title"] forKeyPath:@"title"];
//        [_messegeDic setValue:date forKeyPath:@"time"];
//        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//        [userDefaultes setObject:_messegeDic forKey:@"MessageDic"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//    }else if ([userInfo[@"type"] intValue]==1){
//    }
//        [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    int badge =[userInfo[@"aps"][@"badge"] intValue];
//    badge--;
//    [JPUSHService setBadge:0];
//    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
//     _messegeDic=[NSMutableDictionary new];
//    if ([userInfo.allKeys containsObject:@"type"]) {
//     [self JpushGoToView:userInfo];
//    }
////    UIApplicationState state = [UIApplication sharedApplication].applicationState;
////     if(state == UIApplicationStateBackground){
////            NSLog(@"后台");
////     }else if (state == UIApplicationStateActive){
////            NSLog(@"前台");
////     }else if(state == UIApplicationStateInactive){
////         NSLog(@"前台");
////         [[NSNotificationCenter defaultCenter]postNotificationName:@"OPENMSGCENTERSET" object:nil userInfo:@{}];
////     }
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
//    [self saveContext];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{// 禁止横屏
    return UIInterfaceOrientationMaskPortrait;
}
@end
