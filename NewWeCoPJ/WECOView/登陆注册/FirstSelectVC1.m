//
//  FirstSelectVC1.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/22.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "FirstSelectVC1.h"
#import "langShowView.h"
#import "RedxloginViewController.h"
#import "WeRegisterVC.h"

@interface FirstSelectVC1 ()
@property (nonatomic, strong) langShowView *langShowV;
@property (nonatomic, strong) UILabel *langLB;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;

@end

@implementation FirstSelectVC1

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;

}

-(void)getLoginType{
    
    
    BOOL isAutoLogin = [RedxUserInfo defaultUserInfo].isAutoLogin;
   
    
    if(isAutoLogin){
        

        [self loginClick];
        
    }else{
        [self createUI];
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorBlack;
    [self getLoginType];
    
    // Do any additional setup after loading the view.
}

- (void)createUI{
    
    UIImageView *logoimgv = [self goToInitImageView:CGRectMake(20*NOW_SIZE, kNavBarHeight, 60*HEIGHT_SIZE, 60*HEIGHT_SIZE) imageString:@"WELogo"];
    [self.view addSubview:logoimgv];
    
    UIView *langbgview = [self goToInitView:CGRectMake(kScreenWidth-10*NOW_SIZE-120*NOW_SIZE, kNavBarHeight+20*HEIGHT_SIZE, 120*NOW_SIZE, 25*HEIGHT_SIZE) backgroundColor:colorBlack];
//    langbgview.layer.cornerRadius = 25*HEIGHT_SIZE/2;
//    langbgview.layer.masksToBounds = YES;
    [self.view addSubview:langbgview];
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
    UILabel *langLB = [self goToInitLable:CGRectMake(5*NOW_SIZE, 0, langbgview.xmg_width-5*NOW_SIZE-10*NOW_SIZE-10*HEIGHT_SIZE-5*NOW_SIZE, 25*HEIGHT_SIZE) textName:nowlangstr textColor:WhiteColor fontFloat:16*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    langLB.userInteractionEnabled = YES;
    [langbgview addSubview:langLB];
    _langLB = langLB;
    
    UIImageView *downimg = [self goToInitImageView:CGRectMake(CGRectGetMaxX(langLB.frame)+5*NOW_SIZE, (langbgview.xmg_height - 8*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 8*HEIGHT_SIZE) imageString:@"downMore"];
    [langbgview addSubview:downimg];
    
    
    UIButton *loginBtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, kScreenHeight-50*HEIGHT_SIZE-45*HEIGHT_SIZE, (kScreenWidth-20*NOW_SIZE*3)/2, 45*HEIGHT_SIZE) TypeNum:1 fontSize:16*HEIGHT_SIZE titleString:root_log_in selImgString:@"" norImgString:@""];
    loginBtn.backgroundColor = WhiteColor;
    [loginBtn setTitleColor:colorBlack forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 8*HEIGHT_SIZE;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
    
    UIButton *RegisBtn = [self goToInitButton:CGRectMake(CGRectGetMaxX(loginBtn.frame)+20*NOW_SIZE, kScreenHeight-50*HEIGHT_SIZE-45*HEIGHT_SIZE, (kScreenWidth-20*NOW_SIZE*3)/2, 45*HEIGHT_SIZE) TypeNum:1 fontSize:16*HEIGHT_SIZE titleString:root_register selImgString:@"" norImgString:@""];
    RegisBtn.backgroundColor = colorBlack;
    [RegisBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    RegisBtn.layer.cornerRadius = 8*HEIGHT_SIZE;
    RegisBtn.layer.masksToBounds = YES;
    RegisBtn.layer.borderWidth = 0.8*HEIGHT_SIZE;
    RegisBtn.layer.borderColor = WhiteColor.CGColor;
    [RegisBtn addTarget:self action:@selector(RegisBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisBtn];
    _registBtn = RegisBtn;
    
}
- (void)loginClick{
    
    BOOL isback = NO;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if([vc isKindOfClass:[RedxloginViewController class]]){
            
            isback = YES;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
    if(!isback){
        RedxloginViewController *loginvc = [[RedxloginViewController alloc]init];
        
        [self.navigationController pushViewController:loginvc animated:YES];
        
    }
    
    
}
- (void)RegisBtnClick{
    WeRegisterVC *registvc = [[WeRegisterVC alloc]init];
    [self.navigationController pushViewController:registvc animated:YES];

}
#pragma mark -- 语言切换
- (void)changeLangClick{
    
    if (_langShowV) {
        [_langShowV removeFromSuperview];
    }
    
    _langShowV = [[langShowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _langShowV.dataArr = self.LangNameArr;
    _langShowV.keyArr = self.LangKey2Arr;
    _langShowV.keyArr22 = self.LangKeyArr;
    [KEYWINDOW addSubview:_langShowV];
    [_langShowV showView];
    __weak typeof(self)weakself = self;
    _langShowV.selectBlock = ^(NSString * _Nonnull seleText) {
        weakself.langLB.text = seleText;
        [weakself reloadTabBarVC];
    };
}
- (void)reloadTabBarVC{
    
    [_loginBtn setTitle:root_log_in forState:UIControlStateNormal];
    [_loginBtn setTitle:root_register forState:UIControlStateNormal];

    
}
@end
