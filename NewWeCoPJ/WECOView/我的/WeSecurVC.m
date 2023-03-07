//
//  SettingVC.m
//  TrailPJ
//
//  Created by CBQ on 2022/6/7.
//

#import "WeSecurVC.h"
#import "RedxloginViewController.h"

@interface WeSecurVC ()<UITextFieldDelegate>
@property (nonatomic, strong)NSString *operationType;
@property (nonatomic, strong)NSString *tipsstr11;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger numb;
@end

@implementation WeSecurVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Me_SetTing2;
    self.view.backgroundColor = backgroundNewColor;
    [self zhuxiaozhanhUI];
    // Do any additional setup after loading the view.
}

- (void)zhuxiaozhanhUI{
    _tipsstr11 = My_DeleteAccountTips;
//    _operationType = @"remove";
    NSString *tipsstr = Me_SetTing2;
//    NSString *usertype = [[NSUserDefaults standardUserDefaults]objectForKey:@"userType"];
//    if ([usertype isEqualToString:@"1"]) {//表示用户已请求删除，但服务器未执行
//        tipsstr = My_RecoverAccount;
//        _operationType = @"recover";
//        _tipsstr11 = My_RecoverAccountTips;
//    }
    
    UILabel *titllb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 0, 200*NOW_SIZE, 45*HEIGHT_SIZE) textName:tipsstr textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.view addSubview:titllb];
    
    UILabel *namelb = [self goToInitLable:CGRectMake(0,CGRectGetMaxY(titllb.frame), kScreenWidth, 45*HEIGHT_SIZE) textName:[RedxUserInfo defaultUserInfo].email textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    namelb.tag = 100;
    [self.view addSubview:namelb];
    namelb.backgroundColor = WhiteColor;
    
    
    UITextField *TF = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(namelb.frame)+10*HEIGHT_SIZE, kScreenWidth, 45*HEIGHT_SIZE)];
    TF.backgroundColor = WhiteColor;
//    TF.layer.cornerRadius = 7*HEIGHT_SIZE;
//    TF.layer.masksToBounds = YES;
//    TF.layer.borderColor = colorblack_102.CGColor;
//    TF.layer.borderWidth = 0.8*HEIGHT_SIZE;
    TF.textColor = colorblack_51;
    TF.placeholder = verification_code;
    TF.tag = 101;
    TF.delegate = self;
    TF.returnKeyType = UIReturnKeyDone;
    TF.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:TF];
    UIView *rightv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
    rightv.backgroundColor = WhiteColor;

    UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5*HEIGHT_SIZE, 60*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [codeBtn setTitle:root_Send forState:UIControlStateNormal];
    [codeBtn setTitleColor:colorBlack forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.titleLabel.font = FontSize(16*HEIGHT_SIZE);
    codeBtn.tag = 205;
    [rightv addSubview:codeBtn];
//            codeBtn.layer.cornerRadius = 15*HEIGHT_SIZE;
//            codeBtn.layer.masksToBounds = YES;
//            codeBtn.layer.borderColor = mainColor.CGColor;
//            codeBtn.layer.borderWidth = 0.3*HEIGHT_SIZE;
    codeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    TF.rightViewMode = UITextFieldViewModeAlways;
    TF.rightView = rightv;
    
    UIView *lefttv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
    lefttv.backgroundColor = WhiteColor;
    TF.leftViewMode = UITextFieldViewModeAlways;
    TF.leftView = lefttv;
    
    UIButton *zhuxiaoBtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(TF.frame)+60*HEIGHT_SIZE, kScreenWidth - 40*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:tipsstr selImgString:@"" norImgString:@""];
    [zhuxiaoBtn addTarget:self action:@selector(zhuxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuxiaoBtn];
    zhuxiaoBtn.backgroundColor = mainColor;
    zhuxiaoBtn.layer.cornerRadius = 5*HEIGHT_SIZE;
    zhuxiaoBtn.layer.masksToBounds = YES;
    
//    UILabel *tipslb = [self goToInitLable:CGRectMake(0,CGRectGetMaxY(zhuxiaoBtn.frame)+20*HEIGHT_SIZE, kScreenWidth, 80*HEIGHT_SIZE) textName:_tipsstr11 textColor:[UIColor redColor] fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//    [self.view addSubview:tipslb];
}

//验证码
- (void)codeBtnClick:(UIButton *)codeBtn{
    
    UILabel *tx1 = [self.view viewWithTag:100];

     if (tx1.text.length == 0) {
         [self showToastViewWithTitle:root_WO_shuru_youxiang];
         return;
     }
    
    [self getEmilCode];
    codeBtn.enabled = NO;
    
    _numb = 60;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdoumTime) userInfo:nil repeats:YES];

//    else{
//        [_timer fire];
//    }
   
}
- (void)countdoumTime{
    
    _numb -- ;
    UIButton *btnn = [self.view viewWithTag:205];
    [btnn setTitle:[NSString stringWithFormat:@"%ld",_numb] forState:UIControlStateNormal];
    if (_numb == 0) {
        
        [_timer invalidate];
        _timer = nil;
        btnn.enabled = YES;
        [btnn setTitle:root_Send forState:UIControlStateNormal];

    }
    
}

- (void)getEmilCode{
    UILabel *tx1 = [self.view viewWithTag:100];


    
    if (tx1.text.length == 0) {
        [self showToastViewWithTitle:root_WO_shuru_youxiang];
        return;
    }
    
//    NSDictionary *dict = @{@"value":tx1.text,@"type":@"1"};
  
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/sendEmailCode" parameters:@{@"type":@"3",@"email":tx1.text} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            if ([result isEqualToString:@"0"]) {

                [self showToastViewWithTitle:msg];


            }else{
                [self showToastViewWithTitle:root_youJian_shiBai];
                [self.timer invalidate];
                UIButton *btnn = [self.view viewWithTag:205];

                btnn.enabled = YES;
                [btnn setTitle:root_Send forState:UIControlStateNormal];
            }
//
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_youJian_shiBai];
        [self.timer invalidate];
        UIButton *btnn = [self.view viewWithTag:205];

        btnn.enabled = YES;
        [btnn setTitle:root_Send forState:UIControlStateNormal];
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
}

- (void)zhuxiaoClick{
    
    UITextField *codetf = [self.view viewWithTag:101];
    if(kStringIsEmpty(codetf.text)){
        
        [self showToastViewWithTitle:verification_code];
        return;
    }
    
    [self registUser];

//    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:_tipsstr11 message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
//    [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        [self registUser];
//
//
//    }]];
//    [self presentViewController:alvc animated:YES completion:nil];
}

- (void)registUser{
    
    
    UITextField *codetf = [self.view viewWithTag:101];

    
    [self showProgressView];
    
    NSString *userName = [RedxUserInfo defaultUserInfo].email;
    [RedxBaseRequest myHttpPost:@"/v1/user/removeUser" parameters:@{@"email":userName,@"emailCode":codetf.text} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];

            [self showToastViewWithTitle:msg];
            if ([result isEqualToString:@"0"]) {
                
                [self logOutClick];
            }
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];

        
    }];
    
}

- (void)logOutClick{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/logOut" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {

                

            }
//
        }
        RedxloginViewController *login =[[RedxloginViewController alloc]init];
         [RedxUserInfo defaultUserInfo].userPassword = @"";
         [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
         [[NSUserDefaults standardUserDefaults] synchronize];

         [[NSUserDefaults standardUserDefaults] synchronize];
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
         nav.modalPresentationStyle=UIModalPresentationFullScreen;
         [self presentViewController:nav animated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
        RedxloginViewController *login =[[RedxloginViewController alloc]init];
         [RedxUserInfo defaultUserInfo].userPassword = @"";
         [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
         [[NSUserDefaults standardUserDefaults] synchronize];

         [[NSUserDefaults standardUserDefaults] synchronize];
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
         nav.modalPresentationStyle=UIModalPresentationFullScreen;
         [self presentViewController:nav animated:YES completion:nil];
    }];
    
}
@end
