//
//  RetrievePasswordVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/22.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "RetrievePasswordVC.h"

@interface RetrievePasswordVC ()<UITextFieldDelegate>
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger numb;
@property (nonatomic, strong)NSString * yanzhengStr;
@end

@implementation RetrievePasswordVC

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = root_forget_pwd;
    
    [self registUI];
    // Do any additional setup after loading the view.
}

- (void)registUI{
    
    NSArray *placehNameArr = @[root_dianzZiYouJian,verification_code,root_Alet_user_pwd,ConfirmPSW];
    NSArray *leftImVNameArr = @[@"WEEmailLogo",@"WECodeIMG",@"WEPswIMG",@"WEPswConfIMG"];
    for (int i = 0; i < placehNameArr.count; i ++) {
        
        UITextField *TF = [[UITextField alloc]initWithFrame:CGRectMake(15*NOW_SIZE,30*HEIGHT_SIZE +(40*HEIGHT_SIZE + 15*HEIGHT_SIZE)*i, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE)];
        TF.backgroundColor = WhiteColor;
        TF.layer.cornerRadius = 7*HEIGHT_SIZE;
        TF.layer.masksToBounds = YES;
        TF.layer.borderColor = colorblack_102.CGColor;
        TF.layer.borderWidth = 0.8*HEIGHT_SIZE;
        TF.textColor = colorblack_51;
        TF.placeholder = placehNameArr[i];
        TF.tag = 100+i;
        TF.delegate = self;
        TF.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:TF];
        
        UIView *leftv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
        
        UIImageView *leftIMV = [[UIImageView alloc]initWithFrame:CGRectMake((40-15)*HEIGHT_SIZE/2, (40-15)*HEIGHT_SIZE/2, 15*HEIGHT_SIZE, 15*HEIGHT_SIZE)];
        leftIMV.image = IMAGE(leftImVNameArr[i]);
        [leftv addSubview:leftIMV];
        TF.leftViewMode = UITextFieldViewModeAlways;
        TF.leftView = leftv;
       
        
//        if (i == 0 || i == 1) {
//
//
//            UIView *rightv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
//
//            UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake((40-15)*HEIGHT_SIZE/2, (40-15)*HEIGHT_SIZE/2, 15*HEIGHT_SIZE, 15*HEIGHT_SIZE)];
//            [rightBtn setImage:IMAGE(@"icon_R") forState:UIControlStateNormal];
//            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            rightBtn.tag = 200 + i;
//            [rightv addSubview:rightBtn];
//            TF.rightViewMode = UITextFieldViewModeAlways;
//            TF.rightView = rightv;
//
//        }
        
        if (i == 2 || i == 3) {
            TF.secureTextEntry = YES;
            UIView *leftv3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];

                UIButton *showPassBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*HEIGHT_SIZE, 5*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
               showPassBtn.tag = 500+i;
                [leftv3 addSubview:showPassBtn];
                [showPassBtn setImage:IMAGE(@"Icon_signin_conceal") forState:UIControlStateNormal];
                [showPassBtn setImage:IMAGE(@"Icon_signin_see") forState:UIControlStateSelected];
                [showPassBtn addTarget:self action:@selector(isShowPassWClick:) forControlEvents:UIControlEventTouchUpInside];
                TF.rightView = leftv3;
                TF.rightViewMode = UITextFieldViewModeAlways;
        }
        if (i == 1) {
            UIView *rightv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
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
        }
    }
    

    
    UILabel *agreeLB = [[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 30*HEIGHT_SIZE +(40*HEIGHT_SIZE + 15*HEIGHT_SIZE)*placehNameArr.count,kScreenWidth-30*NOW_SIZE, 40*HEIGHT_SIZE)];
    agreeLB.font = FontSize(12*HEIGHT_SIZE);
    agreeLB.adjustsFontSizeToFitWidth = YES;
    agreeLB.textColor = colorblack_154;
    agreeLB.text = root_RetrieveTips;
    agreeLB.numberOfLines = 0;
//    agreeLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:agreeLB];

    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*NOW_SIZE,CGRectGetMaxY(agreeLB.frame)+15*HEIGHT_SIZE, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE)];
    [sureBtn setTitle:root_Submit forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = mainColor;
    sureBtn.layer.cornerRadius = 7*HEIGHT_SIZE;
    sureBtn.layer.masksToBounds = YES;
    [self.view addSubview:sureBtn];
    
    
    // 获取本地时区
    
//    offset2 = offset2/3600; // +8 东八区, -8 西八区
//    NSString *tzStr2 = [NSString stringWithFormat:@"%ld", (long)offset2];
//    UITextField *textFd = [self viewWithTag:101];
//
//    if (offset2 > 0) {
//        textFd.text = [NSString stringWithFormat:@"+%@", tzStr2];
//
//    }else{
//        textFd.text = [NSString stringWithFormat:@"%@", tzStr2];
//
//    }
    
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
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if(textField.tag == 102 || textField.tag == 103){
        
        if([textField.text containsString:@" "]){
                
            [self showToastViewWithTitle:@"Password does not support spaces"];
            return NO;
        }
    }
    
    
    return YES;
}

//验证码
- (void)codeBtnClick:(UIButton *)codeBtn{
    
    UITextField *tx1 = [self.view viewWithTag:100];

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
    UITextField *tx1 = [self.view viewWithTag:100];


    
    if (tx1.text.length == 0) {
        [self showToastViewWithTitle:root_WO_shuru_youxiang];
        return;
    }
    
//    NSDictionary *dict = @{@"value":tx1.text,@"type":@"1"};
  
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/sendEmailCode" parameters:@{@"type":@"2",@"email":tx1.text} Method:HEAD_URL success:^(id responseObject) {
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

- (void)sureBtnClick{
    
    UITextField *tx1 = [self.view viewWithTag:100];
    UITextField *tx2 = [self.view viewWithTag:101];
    UITextField *tx3 = [self.view viewWithTag:102];
    UITextField *tx4 = [self.view viewWithTag:103];

    if (tx1.text.length == 0) {
        [self showToastViewWithTitle:root_WO_shuru_youxiang];
        return;
    }
    if (tx2.text.length == 0) {
        [self showToastViewWithTitle:root_yanzhengma_cuowu];
        return;
    }
    if (tx3.text.length == 0) {
        [self showToastViewWithTitle:root_Alet_user_pwd];
        return;
    }
    if (![tx4.text isEqualToString:tx3.text]) {
        [self showToastViewWithTitle:root_xiangTong_miMa];
        return;
    }
    
    if(tx3.text.length < 6 || tx3.text.length >30){
        
        [self showAlertViewWithTitle:root_RetrieveTips message:@"" cancelButtonTitle:root_OK];
//        [self showToastViewWithTitle:root_RetrieveTips];
        return;
    }
    NSString *pswMD5 = [self MD5:tx3.text];
    NSDictionary *pramdic = @{@"email":tx1.text,@"emailCode":tx2.text,@"password":pswMD5};
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/modifyPassword" parameters:pramdic Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                [self.navigationController popViewControllerAnimated:YES];

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
@end
