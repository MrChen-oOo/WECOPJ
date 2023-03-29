#import "TJChangePswordVC.h"
#import "RedxloginViewController.h"
@interface TJChangePswordVC ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton *CodeBtn;
@property (nonatomic, assign)int downInt;
@property (nonatomic, strong)NSTimer *codeTimer;
@end
@implementation TJChangePswordVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Password";
    self.view.backgroundColor = backgroundNewColor;
    [self createUI];
}
- (void)createUI{
//    NSString *userID = [RedxUserInfo defaultUserInfo].email;
//    NSArray *useidArr = [userID componentsSeparatedByString:@"@"];
//    NSString *usefirstID = @"";
//    if (useidArr.count > 1) {
//        NSString *seleurl = useidArr[0];
//        usefirstID = [NSString stringWithFormat:@"%@****%@",[seleurl substringToIndex:1],[seleurl substringFromIndex:seleurl.length-1]];
//        usefirstID = [NSString stringWithFormat:@"%@@%@",usefirstID,useidArr[1]];
//    }
//    NSString *codePlace = [NSString stringWithFormat:@"%@",usefirstID];
    NSArray *accountArr = @[@"Enter old password",@"Enter new password",@"Again enter new password"];
    for (int i = 0; i < accountArr.count; i++) {
        UITextField *onetf = [[UITextField alloc]initWithFrame:CGRectMake(30*NOW_SIZE, 40*HEIGHT_SIZE+(40*HEIGHT_SIZE+10*HEIGHT_SIZE)*i, kScreenWidth-60*NOW_SIZE, 40*HEIGHT_SIZE)];
        onetf.layer.cornerRadius = 10*HEIGHT_SIZE;
        onetf.layer.masksToBounds = YES;
//        onetf.layer.borderColor = mainColor.CGColor;
//        onetf.layer.borderWidth = 0.6*NOW_SIZE;
        onetf.tag = 100+i;
        onetf.font = FontSize(12*HEIGHT_SIZE);
        onetf.returnKeyType = UIReturnKeyDone;
        onetf.delegate = self;
        onetf.adjustsFontSizeToFitWidth = YES;
        onetf.backgroundColor = WhiteColor;
        onetf.secureTextEntry = YES;
        [self.view addSubview:onetf];
        onetf.placeholder = accountArr[i];
        UIView *leftv = [self goToInitView:CGRectMake(0, 0, 10*NOW_SIZE, 40*HEIGHT_SIZE) backgroundColor:[UIColor clearColor]];
        onetf.leftView = leftv;
        onetf.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *leftv3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];

            UIButton *showPassBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*HEIGHT_SIZE, 5*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
           showPassBtn.tag = 500+i;
            [leftv3 addSubview:showPassBtn];
            [showPassBtn setImage:IMAGE(@"Icon_signin_conceal") forState:UIControlStateNormal];
            [showPassBtn setImage:IMAGE(@"Icon_signin_see") forState:UIControlStateSelected];
            [showPassBtn addTarget:self action:@selector(isShowPassWClick:) forControlEvents:UIControlEventTouchUpInside];
        onetf.rightView = leftv3;
        onetf.rightViewMode = UITextFieldViewModeAlways;
        
//        if (i == 0) {
//            UIView *bgv = [self goToInitView:CGRectMake(0, 0, 60*HEIGHT_SIZE, 40*HEIGHT_SIZE) backgroundColor:[UIColor clearColor]];
//            UIButton *rigbtn = [self goToInitButton:CGRectMake(0, 0, 60*HEIGHT_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:12*HEIGHT_SIZE titleString:Smart_GetYZM selImgString:@"" norImgString:@""];
//            rigbtn.titleLabel.numberOfLines = 2;
//            rigbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//            [rigbtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
//            rigbtn.backgroundColor = mainColor;
//            _CodeBtn = rigbtn;
//            [bgv addSubview:rigbtn];
//            onetf.rightViewMode = UITextFieldViewModeAlways;
//            onetf.rightView = bgv;
//        }
    }
    UIButton *nextbtn = [self goToInitButton:CGRectMake(60*NOW_SIZE, 40*HEIGHT_SIZE+(40*HEIGHT_SIZE+10*HEIGHT_SIZE)*3+30*HEIGHT_SIZE, kScreenWidth-120*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Save" selImgString:@"" norImgString:@""];
    [nextbtn addTarget:self action:@selector(nextclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextbtn];
    nextbtn.layer.cornerRadius = 45*HEIGHT_SIZE/2;
    nextbtn.layer.masksToBounds = YES;
    nextbtn.backgroundColor = mainColor;
}

- (void)isShowPassWClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    UITextField *tex2 = [self.view viewWithTag:sender.tag-400];
    if (sender.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = tex2.text;
        tex2.text = @""; // 这句代码可以防止切换的时候光标偏移
        tex2.secureTextEntry = NO;
        tex2.text = tempPwdStr;
    } else { // 暗文
        
        NSString *tempPwdStr = tex2.text;
        tex2.text = @"";
        tex2.secureTextEntry = YES;
        tex2.text = tempPwdStr;
        
    }

    
}

- (void)sendCode:(UIButton *)codebtn{
    [self getCodeSet];
}
- (void)downNumb{
//    if (_downInt == 0) {
//        [_codeTimer invalidate];
//        _codeTimer = nil;
//        [_CodeBtn setTitle:Smart_GetYZM forState:UIControlStateNormal];
//        _CodeBtn.backgroundColor = mainColor;
//        _CodeBtn.enabled = YES;
//        return;
//    }
//    _downInt --;
//    [_CodeBtn setTitle:[NSString stringWithFormat:@"%d",_downInt] forState:UIControlStateNormal];
}
- (void)nextclick{
    [self changePSW];
}
- (void)changePSW{
    UITextField *oldPasswordTF = [self.view viewWithTag:100];
    UITextField *newPasswordTF = [self.view viewWithTag:101];
    UITextField *confirmPasswordTF = [self.view viewWithTag:102];
//    if (kStringIsEmpty(oldPasswordTF.text)) {
//        [self showToastViewWithTitle:@"Old password can not be empty"];
//        return;
//    }
    if (kStringIsEmpty(newPasswordTF.text)) {
        [self showToastViewWithTitle:@"New password can not be empty"];
        return;
    }
    if (kStringIsEmpty(confirmPasswordTF.text)) {
        [self showToastViewWithTitle:@"Confirm password can not be empty"];
        return;
    }
    if (![confirmPasswordTF.text isEqualToString:newPasswordTF.text]) {
        [self showToastViewWithTitle:@"Password does not match"];
        return;
    }
    [self showProgressView];
    [RedxBaseRequest myHttpPost:@"/v1/user/modifyPassword" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email,@"password":newPasswordTF.text} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];
            if ([result isEqualToString:@"0"]) {
                
                RedxloginViewController *login =[[RedxloginViewController alloc]init];
                [RedxUserInfo defaultUserInfo].userPassword = @"";
                [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
                nav.modalPresentationStyle=UIModalPresentationFullScreen;
                [self presentViewController:nav animated:YES completion:nil];

            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
- (void)getCodeSet{
//    [self showProgressView];
//    [FGCamBaseRequest myJsonPost:@"/v1/user/sendEmailCode" parameters:@{@"type":@"1",@"value":[FGCamUserInfo defaultUserInfo].userID} Method:HEAD_URL success:^(id responseObject) {
//        [self hideProgressView];
//        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        if (datadic) {
//            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showAlertViewWithTitle:msg message:@"" cancelButtonTitle:@"OK"];
//            if ([result isEqualToString:@"0"]) {
//                self.CodeBtn.backgroundColor = colorblack_186;
//                self.CodeBtn.enabled = NO;
//                if (self.codeTimer) {
//                    [self.codeTimer invalidate];
//                    self.codeTimer = nil;
//                }
//                    self.downInt = 60;
//                    [self.CodeBtn setTitle:[NSString stringWithFormat:@"%d",self.downInt] forState:UIControlStateNormal];
//                    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downNumb) userInfo:nil repeats:YES];
//            }
//        }
//    } failure:^(NSError *error) {
//        [self hideProgressView];
//    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.codeTimer invalidate];
    self.codeTimer = nil;
}
@end
