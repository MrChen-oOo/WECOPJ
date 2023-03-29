#import "RedxloginViewController.h"
#import "LoginButton.h"
//#import "StTransitions.h"
#import "RedxUserInfo.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"
#import <sys/utsname.h>
#import "RetrievePasswordVC.h"
#import "FirstSelectVC1.h"
#import "WeNewOverView.h"
#import "WeRegisterVC.h"
#import "langShowView.h"

#define oldNameAndPassword @"oldNameAndPassword"
@interface RedxloginViewController ()<UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITabBarDelegate,UIGestureRecognizerDelegate>//,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) NSString *loginUserName;
@property (nonatomic, strong) NSString *loginUserPassword;
@property (nonatomic, strong) UILabel *alertLable;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UILabel *demoLable;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, strong) NSMutableDictionary *demoArray;
@property (nonatomic, strong) NSString *serverDemoAddress;
@property (nonatomic, strong) NSString *adNumber;
@property (nonatomic, strong)  NSString *languageValue;
@property (nonatomic, strong) NSString *OssFirst;
@property (nonatomic, strong) NSString *userNameGet;
@property (nonatomic) int getServerAddressNum;
@property (strong, nonatomic) UITableView *resultTableView;
@property (strong, nonatomic) NSMutableArray *resultArr;
@property (strong, nonatomic) NSArray *oldResultArr;
@property (strong, nonatomic) NSDictionary *oldNameAndPasswordDic;
@property (nonatomic, strong)UIImageView *userBgImageView;
@property (nonatomic, strong)UIImageView *pwdBgImageView;
@property (nonatomic, assign) NSInteger getNetForPlantType;   
@property (nonatomic, assign) NSInteger DemoLoginNum;   
@property (strong, nonatomic)NSString *testDemoString;
@property (strong ,nonatomic)UIViewController *currentViewController;
@property (nonatomic, strong) NSString *devicCount;
@property (nonatomic, strong) NSMutableDictionary *Ov1Dic;
@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) UIButton *remebBtn;
@property (nonatomic, strong) langShowView *langShowV;
@property (nonatomic, strong) UILabel *langLB;

@property (nonatomic, assign) CGFloat langY;

@end
@implementation RedxloginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    animated=NO;
//    if (_LogTypeForOSS!=1) {
//        [self.navigationController setNavigationBarHidden:YES];
//    }else{
//        [self.navigationController setNavigationBarHidden:NO];
//    }
//    if (!_isFirstLogin) {
    [self getLoginType];
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _devicCount = @"0";
    [self.navigationController setNavigationBarHidden:YES];
    [self addSubViews];
//    [self getLoginType];

}

-(void)getLoginType{
    
    
    BOOL isAutoLogin = [RedxUserInfo defaultUserInfo].isAutoLogin;
   
    
    if(isAutoLogin){
        NSString *reUsername=[RedxUserInfo defaultUserInfo].email;
        NSString *rePassword=[RedxUserInfo defaultUserInfo].userPassword;
        _loginUserName=reUsername;
        _loginUserPassword=rePassword;

        [self performSelectorOnMainThread:@selector(netRequest) withObject:nil waitUntilDone:NO];
        
    }else{
        
        
    }
    
    
}
- (void)addSubViews {
    
    
    NSString *reUsername=[RedxUserInfo defaultUserInfo].email;
    NSString *rePassword=[RedxUserInfo defaultUserInfo].userPassword;
    _loginUserName=reUsername;
    _loginUserPassword=rePassword;
    
//    CAGradientLayer *scroLayer = [CAGradientLayer layer];
//    scroLayer.frame = self.view.bounds;
//
//    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
//    [self.view.layer addSublayer:scroLayer];
//
//    //设置渐变区域的起始和终止位置（范围为0-1）
//    scroLayer.startPoint = CGPointMake(0, 0);
//    scroLayer.endPoint = CGPointMake(0, 1);
//
//    //设置颜色数组
//    scroLayer.colors = @[(__bridge id)COLOR(33, 33, 32, 1).CGColor,
//                                  (__bridge id)COLOR(35, 30, 32, 1).CGColor];
//
//    //设置颜色分割点（范围：0-1）
//    scroLayer.locations = @[@(0.5f), @(1.0f)];
    
    self.view.backgroundColor = WhiteColor;
    
    _oldNameAndPasswordDic=[[NSUserDefaults standardUserDefaults] objectForKey:oldNameAndPassword];
    NSMutableArray*addArray=[NSMutableArray array];
    if (_oldNameAndPasswordDic.allKeys.count>0) {
        for (NSString*keyString in _oldNameAndPasswordDic.allKeys) {
            [addArray addObject:keyString];
        }
    }
    _oldResultArr=addArray;
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView=nil;
    }
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.backgroundColor= [UIColor clearColor];//[UIColor yellowColor];
//    初始化CAGradientlayer对象，使它的大小为UIView的大小
    
    [self.view addSubview:_scrollView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    float Y0=-StatusHeight;
    float logoH=(240/375.0)*ScreenWidth;
    float phoneXstatueBar=40.0;
    if (IS_PhoneXAll) {
        logoH=logoH+phoneXstatueBar;
    }
    
    
//    UIButton *backbtn = [self goToInitButton:CGRectMake(10*NOW_SIZE, k_Height_StatusBar+10*HEIGHT_SIZE, 60*NOW_SIZE, 20*HEIGHT_SIZE) TypeNum:1 fontSize:15*HEIGHT_SIZE titleString:@"<——" selImgString:@"" norImgString:@""];
//    [backbtn setTitleColor:colorBlack forState:UIControlStateNormal];
//    [backbtn addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:backbtn];
    
    
    
//    UILabel *namlb00 = [self goToInitLable:CGRectMake(10*NOW_SIZE,k_Height_StatusBar+10*HEIGHT_SIZE, kScreenWidth - 20*NOW_SIZE, 45*HEIGHT_SIZE) textName:@"Redx" textColor:colorblack_51 fontFloat:26*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
//    [_scrollView addSubview:namlb00];
    
    CGSize namsize = IMAGE(@"loginUI2").size;
    CGFloat imgwide = (namsize.width* 50*HEIGHT_SIZE)/namsize.height;
    UIImageView *namelogoView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - imgwide/2, kNavBarHeight, imgwide, 50*HEIGHT_SIZE)];
    namelogoView.image = IMAGE(@"loginUI2");
    [_scrollView addSubview:namelogoView];
    
    
    UIImageView *logoBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Y0, ScreenWidth, logoH)];
    logoBackView.image = IMAGE(@"loginUI2.png");
    logoBackView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureRecognizerlogoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide2)];
    tapGestureRecognizerlogoTap.delegate = self;
    [_scrollView addGestureRecognizer:tapGestureRecognizerlogoTap];
//    [_scrollView addSubview:logoBackView];
    float logoY=(6/24.0)*logoH;
    float logoLableY=(70/240.0)*logoH;
//    float logoLableH=(24/240.0)*logoH;
    if (IS_PhoneXAll) {
        logoY=(7/24.0)*logoH;
        logoLableY=(80/240.0)*logoH;
    }
    float logoX=(16/375.0)*ScreenWidth;
//    float logoH1=(50/240.0)*logoH;
    float logoW1=(205/375.0)*ScreenWidth;
    float logoW_K1=(35/375.0)*ScreenWidth;
//    float lableW1=ScreenWidth-logoX-logoW1-logoW_K1-logoX;
//    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(logoX, logoY, logoW1, logoH1)];
//    logoView.image = IMAGE(@"loginUI2.png");
//    [logoBackView addSubview:logoView];
    UIFont *font1 = [UIFont fontWithName:fontTypeOne size:18.0f];
    if (font1==nil) {
        font1=[UIFont systemFontOfSize:18.0f];
    }
    //    NSString *lableNameString=[NSString stringWithFormat:@"%@>>",root_oss_526_tiyanGuan];
    //   NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    //  CGSize size = [lableNameString boundingRectWithSize:CGSizeMake(MAXFLOAT, logoLableH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    //    float x1=lableW1-size.width;
    //    if(x1<0){
    //        x1=0;
    //    }
    //    UILabel *loginLable= [[UILabel alloc] initWithFrame:CGRectMake(logoX+logoW1+logoW_K1, logoLableY, lableW1, logoLableH)];
    //        loginLable.font = font1;
    //    if (![_languageValue isEqualToString:@"0"]) {
    //        loginLable.frame=CGRectMake(logoX+logoW1+logoW_K1, logoLableY, lableW1, logoLableH*2);
    //    }
    //    loginLable.text=lableNameString;
    //    loginLable.textColor=[UIColor whiteColor];
    //    loginLable.textAlignment = NSTextAlignmentRight;
    //    loginLable.userInteractionEnabled=YES;
    //    loginLable.adjustsFontSizeToFitWidth=YES;
    //    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(demoTest)];
    //    [loginLable addGestureRecognizer:forget1];
    //    [logoBackView addSubview:loginLable];
    //    UIFont *font111 = [UIFont fontWithName:@"PingFangSC-Medium" size:10.0f];
    //    if (font111==nil) {
    //        font111=[UIFont systemFontOfSize:10.0f];
    //    }
    //       float lableW2=ScreenWidth-logoX-logoW1-logoW_K1-logoX-x1;
    //    UILabel *loginLable2= [[UILabel alloc] initWithFrame:CGRectMake(logoX+logoW1+logoW_K1+x1, logoLableY+logoLableH, lableW2, logoLableH*0.8)];
    //    loginLable2.text=root_oss_527_liuLangZhangHu;
    //    loginLable2.textColor=COLOR(255, 255, 255, 0.7);
    //    loginLable2.font = font111;
    //    loginLable2.textAlignment = NSTextAlignmentLeft;
    //    loginLable2.adjustsFontSizeToFitWidth=YES;
    //    UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forget2)];
    //    [loginLable2 addGestureRecognizer:forget2];
    //    if ([_languageValue isEqualToString:@"0"]) {
    //            [logoBackView addSubview:loginLable2];
    //    }
//    float Y1=Y0+(150/240.0)*logoH;
    float viewK=(20/375.0)*ScreenWidth;
    float viewW=ScreenWidth-viewK*2;
    float viewPt=302.0;
    float viewH=(viewPt/335.0)*viewW;
    UIView *ViewForLogin=[[UIView alloc]initWithFrame:CGRectMake(viewK,CGRectGetMaxY(namelogoView.frame)+15*HEIGHT_SIZE, viewW,viewH)];
    ViewForLogin.backgroundColor= [UIColor whiteColor];
//    [ViewForLogin.layer setCornerRadius:0.05*viewH];
//    ViewForLogin.layer.shadowOffset = CGSizeMake(0, 0);
//    ViewForLogin.layer.shadowOpacity = 1;
//    ViewForLogin.layer.shadowRadius = 40;
//    ViewForLogin.layer.shadowColor = COLOR(65,121,156, 1).CGColor;
    [_scrollView addSubview:ViewForLogin];
    
    
//    float view_lable_H=(14/viewPt)*viewH;
//    float view_lable_Y=(23/viewPt)*viewH;
    float view_textfield_H2=(18/viewPt)*viewH;
//    float view_line_H3=(1/viewPt)*viewH;
    float TextFieldW=viewW-viewK*2;
//    NSArray *nameArray=@[root_yongHuMing,root_Mima];
//    NSArray *picArray=@[@"nameLogin.png",@"passwordLogin.png"];
//    float imageH=(10/viewPt)*viewH;
//    float imageK=imageH*0.5;
//    float ViewForLogin_K1=(15/viewPt)*viewH;
//    float ViewForLogin_K2=(10/viewPt)*viewH;
//    float view_K=view_lable_H+view_textfield_H2+view_line_H3+(35/viewPt)*viewH+ViewForLogin_K1+ViewForLogin_K2;
//    for (int i=0; i<nameArray.count; i++) {
//        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(viewK, (view_lable_H-imageH)/2.0+view_lable_Y+view_K*i, imageH, imageH)];
//        imageV.image = IMAGE(picArray[i]);
//        [ViewForLogin addSubview:imageV];
//        UILabel *lableV= [[UILabel alloc] initWithFrame:CGRectMake(viewK+imageH+imageK, view_lable_Y+view_K*i, viewW/2.0,view_lable_H)];
//        lableV.text=nameArray[i];
//        lableV.textColor= colorblack_102;//COLOR(187, 187, 187, 1);
//        lableV.font = [UIFont systemFontOfSize:12.0f*HEIGHT_SIZE];
//        lableV.textAlignment = NSTextAlignmentLeft;
//        [ViewForLogin addSubview:lableV];
//        UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(viewK,view_lable_Y+view_lable_H+view_textfield_H2+view_K*i+ViewForLogin_K1+ViewForLogin_K2, TextFieldW,view_line_H3)];
//        lineV.backgroundColor=COLOR(187, 187, 187, 1);
//        [ViewForLogin addSubview:lineV];
//    }
    UIView *langbgview = [self goToInitView:CGRectMake(ViewForLogin.xmg_width-10*NOW_SIZE-120*NOW_SIZE, 0, 120*NOW_SIZE, 25*HEIGHT_SIZE) backgroundColor:WhiteColor];
//    langbgview.layer.cornerRadius = 25*HEIGHT_SIZE/2;
//    langbgview.layer.masksToBounds = YES;
//    [ViewForLogin addSubview:langbgview];
    UITapGestureRecognizer *tapg00 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeLangClick)];
    [langbgview addGestureRecognizer:tapg00];
    
    NSString *langstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"];//自定义的保存语言设置
    NSString *nowlangstr = @"Auto";
    if (langstr.length > 0) {
        //        NSArray *dataArr = @[@"默认（随系统语言）",@"中文",@"繁體中文",@"English",@"Italian",@"Polish",@"Dutch",@"German",@"Hungarian(Hungary)",@"Portuguese(Portugal)",@"Spanish",@"Korean",@"French",@"Czech"];
        //        NSArray *keyArr = @[@[@""],@[@"zh-Hans"],@[@"zh-Hant"],@[@"en"],@[@"it"],@[@"pl"],@[@"nl"],@[@"de-CN"],@[@"hu"],@[@"pt"],@[@"es"],@[@"ko"],@[@"fr"],@[@"cs"]];
        //        NSArray *keyArr22 = @[@"",@"zh-Hans",@"zh-Hant",@"en",@"it",@"pl",@"nl",@"de-CN",@"hu",@"pt",@"es",@"ko",@"fr",@"cs"];
        for (int i = 0; i < self.LangKeyArr.count; i++) {
            NSString *onekey = self.LangKeyArr[i];
            if ([onekey isEqualToString:langstr]) {
                nowlangstr = self.LangNameArr[i];
                break;
            }
        }
    }
    UILabel *langLB = [self goToInitLable:CGRectMake(5*NOW_SIZE, 0, langbgview.xmg_width-2*NOW_SIZE-10*NOW_SIZE-10*HEIGHT_SIZE-5*NOW_SIZE, 25*HEIGHT_SIZE) textName:nowlangstr textColor:colorblack_102 fontFloat:16*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
    langLB.userInteractionEnabled = YES;
//    [langbgview addSubview:langLB];
    _langLB = langLB;
    
    UIImageView *downimg = [self goToInitImageView:CGRectMake(CGRectGetMaxX(langLB.frame)+2*NOW_SIZE, (langbgview.xmg_height - 8*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 8*HEIGHT_SIZE) imageString:@"oss_more_down"];
//    [langbgview addSubview:downimg];
    
    _langY = ViewForLogin.xmg_y+25*HEIGHT_SIZE;
    
    
    if (_userTextField) {
        [_userTextField removeFromSuperview];
        _userTextField=nil;
    }
    UIView *leftvie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20*HEIGHT_SIZE+15*NOW_SIZE, 45*HEIGHT_SIZE)];
    
    UIImageView *userimgv = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, (45*HEIGHT_SIZE - 20*HEIGHT_SIZE)/2, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    userimgv.image = IMAGE(@"WEEmailLogo");
    [leftvie addSubview:userimgv];
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(viewK,CGRectGetMaxY(langbgview.frame)+20*HEIGHT_SIZE, TextFieldW, 45*HEIGHT_SIZE)];
    if (_loginUserName) {
        _userTextField.text = _loginUserName;
    }
    _userTextField.delegate=self;
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_userTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _userTextField.textAlignment= NSTextAlignmentLeft;
    _userTextField.textColor = COLOR(51, 51, 51, 1);
    _userTextField.layer.cornerRadius = 8*HEIGHT_SIZE;
    _userTextField.layer.masksToBounds = YES;
    _userTextField.backgroundColor = WhiteColor;
    _userTextField.layer.borderColor = colorblack_102.CGColor;
    _userTextField.layer.borderWidth = 0.8*HEIGHT_SIZE;
    _userTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:root_Alet_user_messge attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName: COLOR(187, 187, 187, 1)}];
    [_userTextField setMinimumFontSize:textFiedMinFont];
    [ViewForLogin addSubview:_userTextField];
    _userTextField.leftView = leftvie;
    _userTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIFont *font2 = [UIFont fontWithName:fontTypeOne size:13.0f*HEIGHT_SIZE];
    if (font2==nil) {
        font2=[UIFont systemFontOfSize:13.0f*HEIGHT_SIZE];
    }
//    float ViewForLogin_K3=(5/viewPt)*viewH;
//    if (_alertLable) {
//        [_alertLable removeFromSuperview];
//        _alertLable=nil;
//    }
//    _alertLable= [[UILabel alloc] initWithFrame:CGRectMake(viewK, CGRectGetMaxY(_userTextField.frame)+5*HEIGHT_SIZE, TextFieldW,view_textfield_H2)];
//    _alertLable.textColor=COLOR(238, 1, 1, 1);
//    _alertLable.font = font2;
//    _alertLable.textAlignment = NSTextAlignmentLeft;
//    [ViewForLogin addSubview:_alertLable];

    
    if (_pwdTextField) {
        [_pwdTextField removeFromSuperview];
        _pwdTextField=nil;
    }
    UIView *leftvie2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20*HEIGHT_SIZE+15*NOW_SIZE, 45*HEIGHT_SIZE)];

    UIImageView *pswimgv = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, (45*HEIGHT_SIZE - 20*HEIGHT_SIZE)/2, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    pswimgv.image = IMAGE(@"WEPswIMG");
    [leftvie2 addSubview:pswimgv];
    _pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(viewK, CGRectGetMaxY(_userTextField.frame)+10*HEIGHT_SIZE, TextFieldW, 45*HEIGHT_SIZE)];
    _pwdTextField.delegate=self;
    if (_loginUserPassword) {
        self.pwdTextField.text = _loginUserPassword;
    }
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.textColor = COLOR(51, 51, 51, 1);
    _pwdTextField.layer.cornerRadius = 8*HEIGHT_SIZE;
    _pwdTextField.layer.masksToBounds = YES;
    _pwdTextField.backgroundColor = WhiteColor;
    _pwdTextField.font = [UIFont systemFontOfSize:14.0f];
    _pwdTextField.layer.borderColor = colorblack_102.CGColor;
    _pwdTextField.layer.borderWidth = 0.8*HEIGHT_SIZE;
    _pwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:root_Alet_user_pwd attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:  COLOR(187, 187, 187, 1)}];
    [_pwdTextField setMinimumFontSize:textFiedMinFont];
    [ViewForLogin addSubview:_pwdTextField];
    _pwdTextField.leftView = leftvie2;
    _pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    
//    float pwdTextImageH=(9/viewPt)*viewH;
//    float pwdTextImageW=(16/viewPt)*viewH;
    
    UIView *rigview = [self goToInitView:CGRectMake(0, 0, 45*HEIGHT_SIZE, _pwdTextField.xmg_height) backgroundColor:[UIColor clearColor]];
    
    UIButton *isShowPwsBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*HEIGHT_SIZE,5*HEIGHT_SIZE, 35*HEIGHT_SIZE, 35*HEIGHT_SIZE)];
    [isShowPwsBtn setImage:IMAGE(@"weSeeEye") forState:UIControlStateSelected];
    [isShowPwsBtn setImage:IMAGE(@"weCloseEye") forState:UIControlStateNormal];
    [isShowPwsBtn addTarget:self action:@selector(isShowPwsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rigview addSubview:isShowPwsBtn];
    _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
    _pwdTextField.rightView = rigview;
    
//    float view_loginBtn_Y=(200/viewPt)*viewH;
    float view_loginBtn_H=(44/viewPt)*viewH;
    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(viewK, CGRectGetMaxY(_pwdTextField.frame)+30*HEIGHT_SIZE, TextFieldW, 45*HEIGHT_SIZE)];
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
//    gradientLayer0.cornerRadius = 4*HEIGHT_SIZE;
    gradientLayer0.masksToBounds = YES;
    gradientLayer0.frame = loginBtn.bounds;//COLOR(5, 195, 86, 1)
    gradientLayer0.colors = @[
        (id)[UIColor colorWithRed:102.0f/255.0f green:97.0f/255.0f blue:91.0f/255.0f alpha:1.0f].CGColor,
        (id)[UIColor colorWithRed:102.0f/255.0f green:97.0f/255.0f blue:86.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 1)];
    [loginBtn.layer addSublayer:gradientLayer0];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize: 18.0f];
    [loginBtn setTitle:root_log_in forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 8*HEIGHT_SIZE;
    loginBtn.titleLabel.textColor=[UIColor whiteColor];
//    loginBtn.layer.backgroundColor = [[UIColor colorWithRed:159.0f/255.0f green:173.0f/255.0f blue:184.0f/255.0f alpha:1.0f] CGColor];
    [loginBtn addTarget:self action:@selector(PresentCtrl:) forControlEvents:UIControlEventTouchUpInside];
    [ViewForLogin addSubview:loginBtn];
    
    UIButton *tiyanbtn = [[UIButton alloc]initWithFrame:CGRectMake(viewK, CGRectGetMaxY(loginBtn.frame)+10*HEIGHT_SIZE, TextFieldW, 45*HEIGHT_SIZE)];
    tiyanbtn.layer.cornerRadius = 8*HEIGHT_SIZE;
    tiyanbtn.layer.masksToBounds = YES;
    tiyanbtn.layer.borderWidth = 1*HEIGHT_SIZE;
    tiyanbtn.layer.borderColor = COLOR(102, 97, 91, 1).CGColor;
    [tiyanbtn setTitle:home_Register forState:UIControlStateNormal];
    [tiyanbtn setTitleColor:COLOR(102, 97, 91, 1) forState:UIControlStateNormal];
    [tiyanbtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [ViewForLogin addSubview:tiyanbtn];
    
    
//    float view_forgetLable_Y=(265/viewPt)*viewH;
    float view_forgetLable_H=(18/viewPt)*viewH;
    NSString *LableContent1=root_forget_pwd;
    NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f*HEIGHT_SIZE]};
    CGSize textSize1 = [LableContent1 boundingRectWithSize:CGSizeMake(MAXFLOAT,view_forgetLable_H) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
    NSString *LableContent2=RememberTips;
    CGSize textSize2 = [LableContent2 boundingRectWithSize:CGSizeMake(MAXFLOAT,view_forgetLable_H) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;

    UILabel* _forgetLable= [[UILabel alloc] initWithFrame:CGRectMake(viewW-viewK-textSize1.width,CGRectGetMaxY(tiyanbtn.frame)+20*HEIGHT_SIZE, textSize1.width, view_forgetLable_H)];
    _forgetLable.text=root_forget_pwd;
    _forgetLable.adjustsFontSizeToFitWidth=YES;
    _forgetLable.textColor=MainColor;
    _forgetLable.font = font2;
    _forgetLable.textAlignment = NSTextAlignmentLeft;
    _forgetLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * forgetF=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forget2)];
    [_forgetLable addGestureRecognizer:forgetF];
    [ViewForLogin addSubview:_forgetLable];
    
    UIButton *RemeBtn = [self goToInitButton:CGRectMake(viewK, CGRectGetMaxY(tiyanbtn.frame)+20*HEIGHT_SIZE, view_forgetLable_H, view_forgetLable_H) TypeNum:2 fontSize:12 titleString:@"" selImgString:@"WESelect1" norImgString:@"WEUnSelect1"];
    [RemeBtn addTarget:self action:@selector(RememberClick:) forControlEvents:UIControlEventTouchUpInside];
    [ViewForLogin addSubview:RemeBtn];
    _remebBtn = RemeBtn;
    BOOL isSave = [RedxUserInfo defaultUserInfo].isRemeMe;
    _remebBtn.selected = isSave;
    
    UILabel*   _registLable= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(RemeBtn.frame)+2*NOW_SIZE, CGRectGetMaxY(tiyanbtn.frame)+20*HEIGHT_SIZE, textSize2.width, view_forgetLable_H)];
    _registLable.text=RememberTips;
    _registLable.textColor=MainColor;
    _registLable.adjustsFontSizeToFitWidth=YES;
    _registLable.font = font2;
    _registLable.textAlignment = NSTextAlignmentRight;
    _registLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * _registLableTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable2)];
    [_registLable addGestureRecognizer:_registLableTap];
    [ViewForLogin addSubview:_registLable];
    
    
    
    
    
    ViewForLogin.xmg_height = CGRectGetMaxY(_forgetLable.frame)+30*HEIGHT_SIZE;
    
    
    self.resultArr = [NSMutableArray array];
    if (_resultTableView) {
        [_resultTableView removeFromSuperview];
        _resultTableView=nil;
    }
    self.resultTableView  = [[UITableView alloc] initWithFrame:CGRectMake(_userTextField.frame.origin.x, _userTextField.frame.origin.y + _userTextField.frame.size.height + 3, _userTextField.frame.size.width, 200) style:UITableViewStylePlain];
    self.resultTableView.hidden = YES;
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    self.resultTableView.backgroundView.tintColor=[UIColor whiteColor];
    self.resultTableView.backgroundColor=COLOR(221, 221, 221, 1);
    self.resultTableView.showsVerticalScrollIndicator = NO;
    [ViewForLogin addSubview:self.resultTableView];
//    float allH=ViewForLogin.frame.origin.y+ViewForLogin.frame.size.height;
 
}


//- (void)backclick{
//
//    BOOL isback = NO;
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//
//        if([vc isKindOfClass:[FirstSelectVC1 class]]){
//
//            isback = YES;
//            [self.navigationController popToViewController:vc animated:YES];
//        }
//    }
//
//    if(!isback){
//        FirstSelectVC1 *firstvc = [[FirstSelectVC1 alloc]init];
//        [self.navigationController pushViewController:firstvc animated:YES];
//
//    }
//}
#pragma mark -- 语言切换
- (void)changeLangClick{
    
    if (_langShowV) {
        [_langShowV removeFromSuperview];
    }
    
    _langShowV = [[langShowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _langShowV.dataArr = self.LangNameArr;
    _langShowV.keyArr = self.LangKey2Arr;
    _langShowV.keyArr22 = self.LangKeyArr;
    _langShowV.tabvY = _langY;
    [KEYWINDOW addSubview:_langShowV];
    [_langShowV showView];
    __weak typeof(self)weakself = self;
    _langShowV.selectBlock = ^(NSString * _Nonnull seleText) {
        weakself.langLB.text = seleText;
        [weakself reloadTabBarVC];
    };
}
- (void)reloadTabBarVC{
    
 
    [self addSubViews];

    
}
- (void)tapLable2{
    
    _remebBtn.selected = !_remebBtn.selected;

}
- (void)RememberClick:(UIButton *)remeBtnclick{
    
    remeBtnclick.selected = !remeBtnclick.selected;
}
-(void)changeThePassword{
    _pwdTextField.secureTextEntry = !_pwdTextField.secureTextEntry;
}
- (void)isShowPwsBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSString *tempPwdStr = _pwdTextField.text;
        _pwdTextField.text = @"";
        _pwdTextField.secureTextEntry = NO;
        _pwdTextField.text = tempPwdStr;
    } else {
        NSString *tempPwdStr = _pwdTextField.text;
        _pwdTextField.text = @"";
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.text = tempPwdStr;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textcell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textcell"];
    }
    cell.textLabel.text = self.resultArr[indexPath.row];
    cell.textLabel.textColor=COLOR(51, 51, 51, 1);
    cell.backgroundColor=COLOR(221, 221, 221, 1);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _userTextField.text = _resultArr[indexPath.row];
    _pwdTextField.text=_oldNameAndPasswordDic[_resultArr[indexPath.row]];
    self.resultTableView.hidden = YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.resultTableView.hidden = YES;
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_userTextField) {
        [_userTextField resignFirstResponder];
    }
    if (_pwdTextField) {
        [_pwdTextField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _alertLable.text=@"";
    if (textField==_userTextField) {
        if (textField.text != nil) {
            [self textFileSearch:textField.text];
        }
    }
}
-(void)textFieldDidChange:(UITextField *)TextField{
    if (TextField.markedTextRange == nil) {
        [self textFileSearch:TextField.text];
    }
}
-(void)textFileSearch:(NSString *)TextField{
    if (TextField == nil || [TextField isEqualToString:@""]) {
        if (_oldResultArr.count>0) {
            _resultArr=[NSMutableArray arrayWithArray:_oldResultArr];
            self.resultTableView.hidden = NO;
            [self.resultTableView reloadData];
        }else{
            self.resultTableView.hidden = YES;
        }
    }else{
        [self.resultArr removeAllObjects];
        int k = 0;
        for (NSString *str in _oldResultArr) {
            NSString *ste = [NSString stringWithFormat:@"%@",str];
            NSRange range = [ste rangeOfString:TextField];
            if (range.length) {
                [self.resultArr addObject:_oldResultArr[k]];
            }
            k++;
        }
        if (self.resultArr.count>0) {
            self.resultTableView.hidden = NO;
            [self.resultTableView reloadData];
        }else{
            self.resultTableView.hidden = YES;
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_userTextField) {
        [_userTextField resignFirstResponder];
    }
    if (_pwdTextField) {
        [_pwdTextField resignFirstResponder];
    }
    self.resultTableView.hidden = YES;
}

-(UIImage *)changeAlphaOfImageWith:(CGFloat)alpha withImage:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (_pwdTextField) {
        [_pwdTextField resignFirstResponder];
    }
}
-(void)keyboardHide2{
    if (_userTextField) {
        [_userTextField resignFirstResponder];
    }
    if (_pwdTextField) {
        [_pwdTextField resignFirstResponder];
    }
}
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}
-(void)forget2{
    
    
    RetrievePasswordVC *registerRoot=[[RetrievePasswordVC alloc]init];
    [self.navigationController pushViewController:registerRoot animated:YES];
}


- (void)PresentCtrl:(LoginButton *)loginBtn {
    typeof(self) __weak weak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weak loginBtnAction:loginBtn];
    });
}
- (void)loginBtnAction:(LoginButton *)loginBtn {
    if (_userTextField.text == nil || _userTextField.text == NULL || [_userTextField.text isEqualToString:@""]) {
        [loginBtn ErrorRevertAnimationCompletion:nil];
        [self performSelector:@selector(userAlertAction) withObject:nil afterDelay:1.0];
    }else if (_pwdTextField.text == nil || _pwdTextField.text == NULL || [_pwdTextField.text isEqualToString:@""]) {
        [loginBtn ErrorRevertAnimationCompletion:nil];
        [self performSelector:@selector(passWordAlertAction) withObject:nil afterDelay:1.0];
    }else {
        [loginBtn ExitAnimationCompletion:^{
            
            
            _loginUserName=_userTextField.text ;
            _loginUserPassword=_pwdTextField.text;
            
            if([_loginUserPassword containsString:@" "]){
                
                [self showToastViewWithTitle:@"Password does not support spaces"];
                return;
            }
            [self netRequest];
            
            //              [self getOSSnet];
        }];
    }
}
-(void)netRequest{
//    NSString *registID = [[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceRegistrationID"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *iphoneType = [self iphoneType];
    if (kStringIsEmpty(iphoneType)) {
        iphoneType = @"iphone";
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:iphoneType forKey:@"phoneMode"];
    [[NSUserDefaults standardUserDefaults]setObject:app_Version forKey:@"appVer"];

//    NSString *laugrageString=[self getTheLaugrage];
//    _getNetForPlantType=1;
    NSDictionary *netDic=@{@"email":_loginUserName, @"password":[self MD5:_loginUserPassword],@"phoneMode":iphoneType,@"phoneOSType":@"ios",@"appVer":app_Version};
    
    NSString*netUrl=@"/v1/user/login";
    [self netForLoginAll:netDic netUrl:netUrl netType:1];
}
- (NSString *)getDayTime{
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    dayFormatter .locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dayFormatter   setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *daytime = [dayFormatter stringFromDate:[NSDate date]];
    return daytime;
}

#pragma mark -- server监控登录入口
-(void)netForLoginAll:(NSDictionary*)netDic netUrl:(NSString*)netUrl netType:(NSInteger)netType{
    [self showProgressView];
    
    [self showProgressView];
    [RedxBaseRequest myHttpPost:netUrl parameters:netDic Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];
            NSLog(@"/v1/user/login=%@",datadic);
            if ([result isEqualToString:@"0"]) {
                
                [RedxUserInfo defaultUserInfo].isAutoLogin = _remebBtn.selected;
                [RedxUserInfo defaultUserInfo].isRemeMe = _remebBtn.selected;

                NSDictionary *oldDic=[[NSUserDefaults standardUserDefaults] objectForKey:oldNameAndPassword];
                NSMutableDictionary *newNewDic=[NSMutableDictionary dictionaryWithDictionary:oldDic];
                [newNewDic setObject:_loginUserPassword forKey:_loginUserName];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:newNewDic forKey:oldNameAndPassword];
                [defaults synchronize];
                
                id objdic = datadic[@"obj"];
                if([objdic isKindOfClass:[NSDictionary class]]){
                    self.dataSource = [NSDictionary dictionaryWithDictionary:objdic];

                    NSString *counrtyName=[NSString stringWithFormat:@"%@",_dataSource[@"country"]];
                    NSString *timezone=[NSString stringWithFormat:@"%@",_dataSource[@"timeZone"]];
                    NSString *username=[NSString stringWithFormat:@"%@",_dataSource[@"username"]];

                    if([timezone floatValue] >= 0){
                        timezone = [NSString stringWithFormat:@"GMT+%@",_dataSource[@"timeZone"]];
                    }else{
                        
                        timezone = [NSString stringWithFormat:@"GMT%@",_dataSource[@"timeZone"]];

                    }
//                    NSString *email=[NSString stringWithFormat:@"%@",_dataSource[@"email"]];
                    NSString *installerCode=[NSString stringWithFormat:@"%@",_dataSource[@"installerCode"]];
//                    NSString *password=[NSString stringWithFormat:@"%@",_dataSource[@"password"]];
                    NSString *phone=[NSString stringWithFormat:@"%@",_dataSource[@"phone"]];
                    NSString *picAddress=[NSString stringWithFormat:@"%@",_dataSource[@"picAddressText"]];
                    NSString *userType=[NSString stringWithFormat:@"%@",_dataSource[@"type"]];

                    [[NSUserDefaults standardUserDefaults]setObject:userType forKey:@"userType"];
                    
                    
                    [RedxUserInfo defaultUserInfo].country = counrtyName;
                    [RedxUserInfo defaultUserInfo].timezone = timezone;
                    [RedxUserInfo defaultUserInfo].email = _loginUserName;
                    [RedxUserInfo defaultUserInfo].agentCode = installerCode;
                    [RedxUserInfo defaultUserInfo].userPassword = _loginUserPassword;
                    [RedxUserInfo defaultUserInfo].TelNumber = phone;
                    [RedxUserInfo defaultUserInfo].userIcon = picAddress;
                    [RedxUserInfo defaultUserInfo].userName = username;

                    [self didPresentControllerButtonTouch];

                }

            }else{
                if (!_scrollView) {
                    [self addSubViews];
                }
                
            }
//
        }else{
            if (!_scrollView) {
                [self addSubViews];
            }
            
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
        if (!_scrollView) {
            [self addSubViews];
        }
        
    }];
    
    
    
    
   
}

-(void)showTheErrorAlert:(NSString*)alertString{
    _alertLable.text=alertString;
}
-(void)hideTheErrorAlert{
}


- (void)userAlertAction {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:root_Alet_user message:root_Alet_user_messge preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btnAction = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCtrl addAction:btnAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
- (void)passWordAlertAction {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:root_Alet_user message:root_Alet_user_pwd preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btnAction = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCtrl addAction:btnAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

//注册
- (void)registerClick{
    
    WeRegisterVC *registvc = [[WeRegisterVC alloc]init];
    [self.navigationController pushViewController:registvc animated:YES];
    
}
- (void)didPresentControllerButtonTouch {
    //    [self uploadAPModeErrorAndStateTime];
    NSMutableArray *stationID1=_dataSource[@"data"];
    NSMutableArray *stationID=[NSMutableArray array];
    if (stationID1.count>0) {
        for(int i=0;i<stationID1.count;i++){
            NSString *a=stationID1[i][@"plantId"];
            [stationID addObject:a];
        }
    }
    NSMutableArray *stationName1=_dataSource[@"data"];
    NSMutableArray *stationName=[NSMutableArray array];
    if (stationID1.count>0) {
        for(int i=0;i<stationID1.count;i++){
            NSString *a=stationName1[i][@"plantName"];
            [stationName addObject:a];
        }
    }

    
    
    
    WeNewOverView *newovervc = [[WeNewOverView alloc]init];
    UINavigationController *overvc = [[UINavigationController alloc]initWithRootViewController:newovervc];
    overvc.modalPresentationStyle=UIModalPresentationFullScreen;
//    tabbar.tabBar.translucent = NO;
//    tabbar.tabBar.tintColor = mainColor;
//    RedxAppDelegate *appdele = (RedxAppDelegate *)[UIApplication sharedApplication].delegate;
//    appdele.window.rootViewController = over
    [self presentViewController:overvc animated:YES completion:nil];

}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
//                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    return [[StTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
//}
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    return [[StTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
//}


-(void)changeTabbar:(NSNotification*)notification{
    NSMutableDictionary *firstDic=[NSMutableDictionary dictionaryWithDictionary:[notification object]];
    NSInteger selectNum=[[firstDic objectForKey:@"index"] integerValue];
    [_tabbar setSelectedIndex:selectNum];
}
#pragma mark -- UITabBarDelegate 防止重复点击tabBar
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (id)jwtDecodeWithJwtString22:(NSString *)jwtStr {
    NSArray * segments = [jwtStr componentsSeparatedByString:@"."];
    NSString * base64String = [segments objectAtIndex:1];
    int requiredLength = (int)(4 *ceil((float)[base64String length]/4.0));
    int nbrPaddings = requiredLength - (int)[base64String length];
    if(nbrPaddings > 0) {
        NSString * pading = [[NSString string] stringByPaddingToLength:nbrPaddings withString:@"=" startingAtIndex:0];
        base64String = [base64String stringByAppendingString:pading];
    }
    base64String = [base64String stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedData:[base64String dataUsingEncoding:NSUTF8StringEncoding] options:0];
    NSString * decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[decodeString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return jsonDict;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    
    //截获Touch事件
    return  YES;
    
}


- (NSString *)iphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([deviceModel isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";
    if ([deviceModel isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
    if ([deviceModel isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    if ([deviceModel isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    if ([deviceModel isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return @"iPhone";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
