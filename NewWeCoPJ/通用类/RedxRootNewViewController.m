#import "RedxRootNewViewController.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>

@interface RedxRootNewViewController ()
@property (nonatomic, strong) NSMutableDictionary *Ov1Dic;
@property (nonatomic, strong) NSString *dateStr;
@end
@implementation RedxRootNewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:WhiteColor];
  
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:WhiteColor rect:CGRectMake(0, 0, ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.modalPresentationStyle=UIModalPresentationFullScreen;
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName :colorBlack}];

//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = colorBlack;
    self.navigationController.navigationBar.tintColor = colorBlack;//[UIColor whiteColor];
    
    self.view.backgroundColor=WhiteColor;//COLOR(232, 247, 239, 1);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    if (@available(iOS 11.0, *)) {
        self.navigationItem.backButtonTitle = @"";
    } else {
        self.navigationItem.backBarButtonItem = item;
    }
//    self.navigationItem.titleView.backgroundColor = WhiteColor;
    if (@available(iOS 15.0, *)) {

        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor=WhiteColor;
        appearance.titleTextAttributes = @{ NSForegroundColorAttributeName :colorBlack};
        [[UINavigationBar appearance] setStandardAppearance:appearance];
        [[UINavigationBar appearance] setScrollEdgeAppearance:appearance];


    }
    if (@available(iOS 15.0, *)) {
            UITabBarAppearance * appearance = [UITabBarAppearance new];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            appearance.backgroundImage = [self convertViewToImage:effectView];
            self.tabBarController.tabBar.scrollEdgeAppearance = appearance;
    }

//    UILabel *titlb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*NOW_SIZE, kNavBarHeight)];
//    titlb.font = FontSize(14*HEIGHT_SIZE);
//    titlb.textAlignment = NSTextAlignmentCenter;
//    titlb.textColor = WhiteColor;
//    titlb.backgroundColor = [UIColor clearColor];
//    titlb.text = @"sandklakldals";
//    self.navigationItem.titleView = titlb;
    
    NSArray *languages = [NSLocale preferredLanguages];
    if (languages.count>0) {
        NSString *currentLanguage = [languages objectAtIndex:0];
        if ([currentLanguage hasPrefix:@"zh-Hans"]) {
            _languageType=@"0";
        }else if ([currentLanguage hasPrefix:@"en"]) {
            _languageType=@"1";
        }else{
            _languageType=@"2";
        }
    }
    
    _Ov1Dic = [[NSMutableDictionary alloc]init];
    
//    _LangNameArr = @[@"Auto",@"English",@"简体中文",@"繁體中文",@"čeština",@"Deutsch",@"español",@"Français",@"Magyar",@"Italiano",@"한국인",@"Nederlands",@"Português",@"Polski",@"Română"];//(Hungary),(Portugal)
    _LangNameArr = @[@"English"];//(Hungary),(Portugal)//,@"简体中文"//@"Auto",


//    _LangKeyArr = @[@"",@"zh-Hans",@"zh-Hant",@"en",@"it",@"pl",@"nl",@"de",@"hu-HU",@"pt-PT",@"es",@"ko",@"fr",@"cs"];
//    _LangKeyArr = @[@"",@"en",@"zh-Hans",@"zh-Hant",@"cs",@"de",@"es",@"fr",@"hu-HU",@"it",@"ko",@"nl",@"pt-PT",@"pl",@"ro"];
    _LangKeyArr = @[@"en"];//@"",,@"zh-Hans"

//    _LangKey2Arr = @[@[@""],@[@"zh-Hans"],@[@"zh-Hant"],@[@"en"],@[@"it"],@[@"pl"],@[@"nl"],@[@"de"],@[@"hu-HU"],@[@"pt-PT"],@[@"es"],@[@"ko"],@[@"fr"],@[@"cs"]];
//    _LangKey2Arr = @[@[@""],@[@"en"],@[@"zh-Hans"],@[@"zh-Hant"],@[@"cs"],@[@"de"],@[@"es"],@[@"fr"],@[@"hu-HU"],@[@"it"],@[@"ko"],@[@"nl"],@[@"pt-PT"],@[@"pl"],@[@"ro"]];
    _LangKey2Arr = @[@[@""],@[@"en"],@[@"zh-Hans"]];

}
- (UIImage *)convertViewToImage:(UIView *)view {

   UIGraphicsBeginImageContext(view.bounds.size);
   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return image;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * currentdate = [NSDate date];
    _dateStr = [dateFormatter stringFromDate:currentdate];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RECORDALLTOUCHNUMB" object:nil];
}
- (void)savePageMassage:(NSString *)FreqKey TimeKey:(NSString *)timeKey{
    NSInteger second = [self getTimeInterval:_dateStr];
    NSString *freqNum = _Ov1Dic[FreqKey];
    freqNum = [NSString stringWithFormat:@"%ld",[freqNum integerValue]+1];
    NSString *timenum = _Ov1Dic[timeKey];
    NSString *allnum = [NSString stringWithFormat:@"%ld",[timenum integerValue]+second];
    [_Ov1Dic setObject:allnum forKey:timeKey];
    [_Ov1Dic setObject:freqNum forKey:FreqKey];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RECORDALLTOUCHNUMB" object:nil userInfo:_Ov1Dic];
    });
}
-(CGSize)getStringSize:(float)fontSize Wsize:(float)Wsize Hsize:(float)Hsize stringName:(NSString*)stringName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    CGSize size = [stringName boundingRectWithSize:CGSizeMake(Wsize, Hsize) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}
- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.detailsLabelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}
- (void)showProgressView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    
}
- (void)hideProgressView {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
- (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(UIScrollView*)goToInitScrollView:(CGRect)scrollFrame backgroundColor:(UIColor*)backgroundColor{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    scrollView.backgroundColor = backgroundColor;
    return scrollView;
}
-(UIView*)goToInitView:(CGRect)viewFrame backgroundColor:(UIColor*)backgroundColor{
    UIView *View = [[UIView alloc] initWithFrame:viewFrame];
    View.backgroundColor = backgroundColor;
    return View;
}
-(UILabel*)goToInitLable:(CGRect)lableFrame textName:(NSString*)textString textColor:(UIColor*)textColor fontFloat:(float)fontFloat AlignmentType:(int)AlignmentType isAdjust:(BOOL)isAdjust{
    UILabel *label= [[UILabel alloc] initWithFrame:lableFrame];
    label.text=textString;
    label.textColor=textColor;
    label.font = [UIFont systemFontOfSize:fontFloat];
    if (AlignmentType==1) {
        label.textAlignment = NSTextAlignmentLeft;
    }else if (AlignmentType==2) {
        label.textAlignment = NSTextAlignmentRight;
    }else{
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.adjustsFontSizeToFitWidth=isAdjust;
    return label;
}
-(UIImageView*)goToInitImageView:(CGRect)imageFrame imageString:(NSString*)imageString{
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:imageFrame];
    [imageView setImage:[UIImage imageNamed:imageString]];
    return imageView;
}
-(UIButton*)goToInitButton:(CGRect)buttonFrame TypeNum:(NSInteger)TypeNum fontSize:(float)fontSize titleString:(NSString*)titleString selImgString:(NSString*)selImgString norImgString:(NSString*)norImgString{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=buttonFrame;
    if (TypeNum==1 || TypeNum==3) {
        [button setTitle:titleString forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize: fontSize];
    }
    if (TypeNum==2 || TypeNum==3) {
        [button setImage:[UIImage imageNamed:selImgString] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:norImgString] forState:UIControlStateNormal];
    }
    return button;
}
//- (void)rightPressForShareFirst{
//    UIImage *image;
//    if (!_RedxCaptureScreen) {
//        _RedxCaptureScreen=[[RedxCaptureScreen alloc]init];
//    }
//    if (_isShareView) {
//        image = [_RedxCaptureScreen RedxCaptureScreenView:_shareFrameSize withView:_shareView];
//    }else{
//        image = [_RedxCaptureScreen RedxCaptureScreen:_shareFrameSize withView:_shareScrollView];
//    }
//    if (_isGoToShareTheView) {
//        [self addShareView:image];
//    }
//}
//-(void)addShareView:(UIImage*)image{
    
    
    
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        [self shareImageAndTextToPlatformType:platformType image:image];
//    }];
//}
-(UIButton*)createRadiusButtonWithFrame:(CGRect)rect titleString:(NSString *)titleString fontSize:(float)fontSize{
    UIButton *button=[[UIButton alloc]initWithFrame:rect];
    [button setBackgroundColor:MainColor];
    button.layer.cornerRadius = rect.size.height*0.5;
    button.layer.masksToBounds=YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:titleString forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: fontSize];
    button.titleLabel.adjustsFontSizeToFitWidth=YES;
    return button;
}
//- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType image:(UIImage *)image
//{
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    messageObject.text = @"分享图片";
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    shareObject.thumbImage = image;
//    [shareObject setShareImage:image];
//    messageObject.shareObject = shareObject;
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//        }
//    }];
//}
-(void)addRightItemForShare{
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:root_fenxiang style:UIBarButtonItemStyleDone target:self action:@selector(rightPressForShareFirst)];
//    if ([self.languageType isEqualToString:@"0"]) {
//        self.navigationItem.rightBarButtonItem = rightButtonItem;
//    }
}
-(NSString*)getValidCode:(NSString*)serialNum{
    if (serialNum==NULL||serialNum==nil) {
        return @"";
    }
    NSData *testData = [serialNum dataUsingEncoding: NSUTF8StringEncoding];
    int sum=0;
    Byte *snBytes=(Byte*)[testData bytes];
    for(int i=0;i<[testData length];i++)
    {
        sum+=snBytes[i]+i;
    }
    NSInteger B=sum%9;
    NSInteger NC=sum%5;

    NSString *B1= [NSString stringWithFormat: @"%ld", (long)B];
    NSString *NC1= [NSString stringWithFormat: @"%ld", (long)NC];

    int C=(sum+1)*(sum+2);
    NSString *text = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",C]];
    NSInteger length = [text length];
    NSString *resultTemp;
    NSString *resultTemp3;
    NSString *resultTemp2=[text substringWithRange:NSMakeRange(0, 2)];
    NSString *resultTemp1=[text substringWithRange:NSMakeRange(length - 2, 2)];
    resultTemp3= [resultTemp1 stringByAppendingString:resultTemp2];
    resultTemp=[resultTemp3 stringByAppendingString:B1];
    resultTemp=[resultTemp stringByAppendingString:NC1];
    NSString *result = @"";
    char *charArray = (char *)[resultTemp cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i=0; i<[resultTemp length]; i++) {
        if (charArray[i]==0x30||charArray[i]==0x4F||charArray[i]==0x4F) {
            charArray[i] += 2;
        }
        result=[result stringByAppendingFormat:@"%c",charArray[i]];
    }
    return [result uppercaseString];
}
-(NSString*)getTheLaugrage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *languageType = @"1";
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        languageType=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        languageType=@"1";
    }else if([currentLanguage hasPrefix:@"fr"]) {
        languageType=@"2";
    }else if([currentLanguage hasPrefix:@"ja"]) {
        languageType=@"3";
    }else if([currentLanguage hasPrefix:@"it"]) {
        languageType=@"4";
    }else if([currentLanguage hasPrefix:@"nl"]) {
        languageType=@"5";
    }else if([currentLanguage hasPrefix:@"tk"]) {
        languageType=@"6";
    }else if([currentLanguage hasPrefix:@"pl"]) {
        languageType=@"7";
    }else if([currentLanguage hasPrefix:@"el"]) {
        languageType=@"8";
    }else if([currentLanguage hasPrefix:@"de-CN"]) {
        languageType=@"9";
    }else if([currentLanguage hasPrefix:@"pt"]) {
        languageType=@"10";
    }else if([currentLanguage hasPrefix:@"es"]) {
        languageType=@"11";
    }else if([currentLanguage hasPrefix:@"vi"]) {
        languageType=@"12";
    }else if([currentLanguage hasPrefix:@"hu"]) {
        languageType=@"13";
    }else if([currentLanguage hasPrefix:@"zh-Hant"]) {
        languageType=@"14";
    }
    return languageType;
}
- (NSString *)MD5:(NSString *)str {
    if (str==nil) {
        str=@"";
    }
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *tStr = [NSString stringWithFormat:@"%02x", digest[i]];
//        if (tStr.length == 1) {
//            [result appendString:@"0"];
//        }
        [result appendFormat:@"%@", tStr];
    }
    return result;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [KEYWINDOW endEditing:YES];
}
- (NSInteger)getTimeInterval:(NSString *)sendDateString
{
    if(!kStringIsEmpty(sendDateString)){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate * currentdate = [NSDate date];
        NSDate * currentDate = [dateFormatter dateFromString:[dateFormatter stringFromDate: currentdate]];
        NSLog(@"---currentdate--%@",currentDate);
        NSDate * endDate = [dateFormatter dateFromString:sendDateString];
        NSLog(@"---endDate--%@",endDate);
        NSTimeInterval time = [currentDate timeIntervalSinceDate:endDate];
        NSLog(@"---time---%ld",(long)time);
        NSLog(@"--second--%ld",(long)time);
        return time;
    }else{
        return 0;
    }
}
-(void)set_TextColorForLabel:(UILabel *)label color:(UIColor *)color range:(NSRange)range{
    if (color) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        label.attributedText = attStr;
    }
}
-(void)set_DesignatedTextForLabel:(UILabel *)label text:(NSString *)text color:(UIColor *)color{
    if (color) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:[label.text rangeOfString:text]];
        label.attributedText = attStr;
    }
}
@end
