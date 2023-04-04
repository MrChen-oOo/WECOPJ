//
//  RetrievePasswordVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/22.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeRegisterVC.h"
#import "RedxAnotherSearchViewController.h"
//#import "RedxloginViewController.h"
#import "CGXPickerView.h"
#import "WeProtocolVC.h"

@interface WeRegisterVC ()<UITextFieldDelegate>
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger numb;
@property (nonatomic, strong)NSString * yanzhengStr;
@property(nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong)UITextField * btnCty;
@property (nonatomic, strong)UIScrollView * bgscrollv;
@property (nonatomic, strong)UIButton * selectButton;
@property (nonatomic, strong)NSMutableArray * timeZoneArray;
@property (nonatomic, strong)NSDictionary * zoneCountDic;
@property (nonatomic, strong)NSMutableArray * timeZoneNameArray;


@end

@implementation WeRegisterVC

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = home_Register;
    
    _bgscrollv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    UITapGestureRecognizer *bgclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgclick)];
    [_bgscrollv addGestureRecognizer:bgclick];
    [self.view addSubview:_bgscrollv];
    
//    _timeZoneArray=[NSMutableArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"0",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    
    _timeZoneArray=[NSMutableArray arrayWithObjects:@"0",@"0.5",@"1",@"1.5",@"2",@"2.5",@"3",@"3.5",@"4",@"4.5",@"5",@"5.5",@"6",@"6.5",@"7",@"7.5",@"8",@"8.5",@"9",@"9.5",@"10",@"10.5",@"11",@"11.5",@"12",@"12.5",@"-0.5",@"-1",@"-1.5",@"-2",@"-2.5",@"-3",@"-3.5",@"-4",@"-4.5",@"-5",@"-5.5",@"-6",@"-6.5",@"-7",@"-7.5",@"-8",@"-8.5",@"-9",@"-9.5",@"-10",@"-10.5",@"-11",@"-11.5",@"-12", nil];
    _timeZoneNameArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < _timeZoneArray.count; i++) {
        
        float onezone = [_timeZoneArray[i] floatValue];
        if(onezone >= 0){
            
            [_timeZoneNameArray addObject:[NSString stringWithFormat:@"GMT+%@",_timeZoneArray[i]]];
        }else{
            [_timeZoneNameArray addObject:[NSString stringWithFormat:@"GMT%@",_timeZoneArray[i]]];

            
        }
        
    }
    
    
    _zoneCountDic = @{@"中国":@"8",@"Belarus":@"3",@"Philippines":@"8",@"SintMaarten":@"-4",@"Morocco":@"0",@"Kyrgyzstan":@"6",@"Afghanistan":@"4",@"Nicaragua":@"-6",@"Haiti":@"-5",@"France":@"1",@"MalvinasIslands(Falkland)":@"-4",@"PuertoRico":@"-4",@"Latvia":@"2",@"CaymanIslands":@"-4",@"Djibouti":@"3",@"Bangladesh":@"6",@"Panama":@"-5",@"Uzbekistan":@"5",@"Burundi":@"2",@"Guyana":@"-4",@"Kiribati":@"12",@"Mexico":@"-6",@"Laos":@"7",@"Canada":@"-5",@"MarshallIslands":@"12",@"Iceland":@"0",@"PitcairnIslands":@"-8",@"Guadeloupe":@"-4",@"Barbados":@"-4",@"Lebanon":@"2",@"EastTimor":@"9",@"Lesotho":@"2",@"NorfolkIsland":@"11",@"Liechtenstein":@"1",@"TheBritishVirginIslands":@"-4",@"CentralAfricanRepublic":@"-7",@"SaintKittsAndNevis":@"-4",@"Slovenia":@"1",@"Montserrat":@"-4",@"Macau(China)":@"8",@"Mongolia":@"8",@"Guatemala":@"-6",@"BosniaAndHerzegovina":@"1",@"Egypt":@"2",@"Russia":@"3",@"SriLanka":@"5",@"Angola":@"1",@"MIDE for SI":@"3",@"Taiwan(China)":@"8",@"Slovakia":@"1",@"Greece":@"2",@"Maldives":@"5",@"SvalbardAndJanMayen":@"1",@"Thailand":@"7",@"Ukraine":@"2",@"NewZealand":@"12",@"Italy":@"1",@"Iraq":@"3",@"Tonga":@"13",@"Moldova":@"2",@"PapuaNewGuinea":@"10",@"Guinea":@"0",@"Cyprus":@"2",@"FederatedStatesOfMicronesia":@"11",@"HongKong(China)":@"8",@"Denmark":@"1",@"Kuwait":@"3",@"SaintPierreAndMiquelon":@"-4",@"WallisAndFutuna":@"12",@"Ghana":@"0",@"Pakistan":@"5",@"SouthKorea":@"9",@"BurkinaFaso":@"0",@"CookIslands":@"10",@"Gabon":@"1",@"Montenegro":@"1",@"CongoDemocraticRepublic":@"2",@"Armenia":@"4",@"EquatorialGuinea":@"1",@"Croatia":@"1",@"Cameroon":@"1",@"Sweden":@"1",@"Zimbabwe":@"2",@"Serbia":@"1",@"Nigeria":@"1",@"Estonia":@"2",@"Martinique":@"-4",@"Bolivia":@"-4",@"Liberia":@"0",@"Turkmenistan":@"5",@"Kenya":@"3",@"TurksAndCaicosIslands":@"-5",@"FrenchPolynesia":@"-10",@"Peru":@"-5",@"Malawi":@"2",@"Dominica":@"-4",@"Tunisia":@"1",@"China":@"8",@"Gambia":@"0",@"Uganda":@"3",@"Togo":@"0",@"Seychelles":@"4",@"Sudan":@"2",@"Malta":@"1",@"Bahamas":@"-5",@"Cambodia":@"7",@"Zambia":@"2",@"SaudiArabia":@"3",@"Belgium":@"1",@"Anguilla":@"-4",@"SolomonIslands":@"11",@"DominicanRepublic":@"-4",@"RepublicOfTheCongo":@"1",@"Portugal":@"0",@"Tanzania":@"3",@"Mali":@"0",@"Ecuador":@"-5",@"Indonesia":@"7",@"SaintLucia":@"-4",@"SaintVincentAndtheGrenadines":@"-4",@"Luxembourg":@"1",@"Chile":@"-3",@"SouthAfrica":@"2",@"SanMarino":@"1",@"Bahrain":@"3",@"Fiji":@"12",@"Niue":@"-11",@"Palestine":@"2",@"Samoa":@"-11",@"Oman":@"4",@"Turkey":@"2",@"NewCaledonia":@"11",@"Niger":@"1",@"CzechRepublic":@"2",@"Guam":@"10",@"Chad":@"1",@"Mozambique":@"2",@"Benin":@"1",@"Romania":@"2",@"TrinidadAndTobago":@"-4",@"FrenchGuiana":@"-3",@"Algeria":@"1",@"Madagascar":@"3",@"Comoros":@"3",@"Belize":@"-6",@"Paraguay":@"-4",@"Syria":@"2",@"Ireland":@"0",@"Columbia":@"-5",@"Switzerland":@"1",@"SouthSudan":@"3",@"Yemen":@"3",@"Vanuatu":@"11",@"Malaysia":@"8",@"Aruba":@"-4",@"Albania":@"1",@"SierraLeone":@"0",@"SaintHelena":@"0",@"Austria":@"1",@"AmericanSamoa":@"-11",@"Monaco":@"1",@"Mauritania":@"0",@"UnitedStates":@"-8",@"Bermuda":@"-4",@"Hungary":@"1",@"Mauritius":@"4",@"Argentina":@"-3",@"Poland":@"1",@"Tokelau":@"-10",@"Georgia":@"4",@"Bulgaria":@"2",@"Germany":@"1",@"Norway":@"1",@"Japan":@"9",@"UnitedArabEmirates":@"4",@"Cuba":@"-5",@"Nauru":@"12",@"CostaRica":@"-6",@"Tajikistan":@"5",@"India":@"5",@"Greenland":@"-3",@"Macedonia":@"1",@"Jordan":@"2",@"Senegal":@"0",@"Eritrea":@"3",@"Namibia":@"1",@"Myanmar":@"6",@"Uruguay":@"-3",@"Libya":@"2",@"Andorra":@"1",@"Rwanda":@"2",@"FaroeIslands":@"0",@"Swaziland":@"2",@"NorthKorea":@"9",@"Brazil":@"-3",@"Venezuela":@"-4",@"Qatar":@"3",@"Tuvalu":@"12",@"Salvador":@"-6",@"Spain":@"1",@"Palau":@"9",@"Israel":@"2",@"Bhutan":@"6",@"BruneiDarussalam":@"8",@"Nepal":@"5",@"Azerbaijan":@"4",@"Vietnam":@"7",@"Ethiopia":@"3",@"Honduras":@"-6",@"Australia":@"10",@"NorthernMarianaIslands":@"10",@"Netherlands":@"1",@"Gibraltar":@"1",@"Somalia":@"3",@"CapeVerde":@"-1",@"AntiguaAndBarbuda":@"-3",@"UnitedStatesVirginIslands":@"-4",@"IsleOfMan":@"0",@"Finland":@"2",@"Lithuania":@"1",@"Suriname":@"-3",@"Jamaica":@"-5",@"UnitedKingdom":@"0",@"Grenada":@"-4",@"Singapore":@"8",@"Botswana":@"2",@"Kazakhstan":@"6",@"GuineaBissau":@"0",@"IvoryCoast":@"0"};

//    _timeZoneArray = [[NSMutableArray alloc]init];
//    for (float i = 1.0; i <= 12.0; i = i+0.5) {
//        [_timeZoneArray addObject:[NSString stringWithFormat:@"%.1f",i]];
//    }
//    for (float i = 1.0; i <= 12.0; i = i+0.5) {
//        [_timeZoneArray addObject:[NSString stringWithFormat:@"-%.1f",i]];
//    }
    [self getPickerData];
    [self registUI];
    // Do any additional setup after loading the view.
}

- (void)registUI{
    
    NSArray *placehNameArr = @[root_xuanzhe_country,root_WO_shiqu,root_dianzZiYouJian,verification_code,root_Alet_user_pwd,ConfirmPSW];
    NSArray *leftImVNameArr = @[@"WeCountry",@"Wetimezone",@"WEEmailLogo",@"WECodeIMG",@"WEPswIMG",@"WEPswConfIMG"];
    
    CGFloat viewY = 30*HEIGHT_SIZE;
    for (int i = 0; i < placehNameArr.count; i ++) {
        
        UITextField *TF = [[UITextField alloc]initWithFrame:CGRectMake(15*NOW_SIZE,viewY +(40*HEIGHT_SIZE + 15*HEIGHT_SIZE)*i, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE)];
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
        TF.delegate = self;
        [_bgscrollv addSubview:TF];
        
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
        
        if(i == 4){
            
            UILabel *agreeLB = [[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, CGRectGetMaxY(TF.frame),kScreenWidth-30*NOW_SIZE, 40*HEIGHT_SIZE)];
            agreeLB.font = FontSize(12*HEIGHT_SIZE);
            agreeLB.adjustsFontSizeToFitWidth = YES;
            agreeLB.textColor = colorblack_154;
            agreeLB.text = root_RetrieveTips;
            agreeLB.numberOfLines = 0;
        //    agreeLB.textAlignment = NSTextAlignmentCenter;
            [_bgscrollv addSubview:agreeLB];
            
            viewY = 70*HEIGHT_SIZE;
        }else{
            
            viewY = 30*HEIGHT_SIZE;
        }
        
        if (i == 4 || i == 5) {
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
        if (i == 3) {
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
        
        if(i == 0){
            UIView *rightv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
            
            UIImageView *rightIMV = [[UIImageView alloc]initWithFrame:CGRectMake((40-10)*HEIGHT_SIZE/2, (40-10)*HEIGHT_SIZE/2, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE)];
            rightIMV.image = IMAGE(@"rightBtn");
            [rightv addSubview:rightIMV];
            TF.rightViewMode = UITextFieldViewModeAlways;
            TF.rightView = rightv;
            
            _btnCty = TF;
        }
        if(i == 1){
            UIView *rightv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
            rightv.backgroundColor = WhiteColor;

            UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5*HEIGHT_SIZE, 60*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
            [codeBtn setTitle:home_Auto forState:UIControlStateNormal];
            [codeBtn setTitleColor:colorBlack forState:UIControlStateNormal];
            [codeBtn addTarget:self action:@selector(AutoClick) forControlEvents:UIControlEventTouchUpInside];
            codeBtn.titleLabel.font = FontSize(16*HEIGHT_SIZE);
            [rightv addSubview:codeBtn];
            codeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
            codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            TF.rightViewMode = UITextFieldViewModeAlways;
            TF.rightView = rightv;
            
        }
    }
    

    
    
    
    
    UIView* selectV=[self goToInitView:CGRectMake(0,  30*HEIGHT_SIZE +(40*HEIGHT_SIZE + 15*HEIGHT_SIZE)*placehNameArr.count+40*HEIGHT_SIZE+10*HEIGHT_SIZE, ScreenWidth, 30*HEIGHT_SIZE) backgroundColor:[UIColor clearColor]];
    [_bgscrollv addSubview:selectV];
    UIButton *selectButton= [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame=CGRectMake(40*NOW_SIZE,5*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE);
    [selectButton setImage:IMAGE(@"WeDisAgreeImg") forState:UIControlStateNormal];
    [selectButton setImage:IMAGE(@"WeAgreeImg") forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(selectGo:) forControlEvents:UIControlEventTouchUpInside];
    [selectV addSubview:selectButton];
    viewY += 15*HEIGHT_SIZE+15*HEIGHT_SIZE;
    _selectButton = selectButton;
    UILabel *userOk= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(selectButton.frame)+12*NOW_SIZE, 0,kScreenWidth-CGRectGetMaxX(selectButton.frame)-22*NOW_SIZE, 30*HEIGHT_SIZE)];
    userOk.text=Privacy_Policy;
    userOk.textColor=mainColor;
//    userOk.textAlignment=NSTextAlignmentCenter;
    userOk.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    userOk.adjustsFontSizeToFitWidth=YES;
    userOk.userInteractionEnabled=YES;
    UITapGestureRecognizer * demo1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GoUsert)];
    [userOk addGestureRecognizer:demo1];
    [selectV addSubview:userOk];
    
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*NOW_SIZE,CGRectGetMaxY(selectV.frame)+25*HEIGHT_SIZE, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE)];
    [sureBtn setTitle:root_RegisterNow forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = mainColor;
    sureBtn.layer.cornerRadius = 7*HEIGHT_SIZE;
    sureBtn.layer.masksToBounds = YES;
    [_bgscrollv addSubview:sureBtn];
    
    
    _bgscrollv.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(sureBtn.frame)+240*HEIGHT_SIZE+kNavBarHeight);
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

- (void)selectGo:(UIButton *)selePri{
    
    selePri.selected = !selePri.selected;
}
- (void)GoUsert{
    
//    WeProtocolVC *provc = [[WeProtocolVC alloc]init];
//    [self.navigationController pushViewController:provc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField.tag == 100){
        if(_provinceArray.count == 0){
            [self getPickerData];

        }else{
            
            [self pickadress];
        }
        
        return NO;
    }
    if(textField.tag == 101){
        
        
        [CGXPickerView showStringPickerWithTitle:root_WO_shiqu DataSource:_timeZoneNameArray DefaultSelValue:textField.text IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
            
            textField.text = selectValue;
        }];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if(textField.tag == 104 || textField.tag == 105){
        
        if([textField.text containsString:@" "]){
                
            [self showToastViewWithTitle:@"Password does not support spaces"];
            return NO;
        }
    }
    
    
    return YES;
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
    UITextField *tx1 = [self.view viewWithTag:102];


    
    if (tx1.text.length == 0) {
        [self showToastViewWithTitle:root_WO_shuru_youxiang];
        return;
    }
    
//    NSDictionary *dict = @{@"value":tx1.text,@"type":@"1"};
  
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/sendEmailCode" parameters:@{@"type":@"1",@"email":tx1.text} Method:HEAD_URL success:^(id responseObject) {
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

- (void)AutoClick{
    
    NSInteger offset2 = [NSTimeZone localTimeZone].secondsFromGMT;
    offset2 = offset2/3600; // +8 东八区, -8 西八区
    NSString *tzStr2 = [NSString stringWithFormat:@"%ld", (long)offset2];
    UITextField *textFd = [self.view viewWithTag:101];
    
    if (offset2 > 0) {
        textFd.text = [NSString stringWithFormat:@"GMT+%@", tzStr2];

    }else{
        textFd.text = [NSString stringWithFormat:@"GMT%@", tzStr2];

    }
    
}

#pragma mark -- 点击事件
-(void)pickadress{
    if(_provinceArray.count>0){
        RedxAnotherSearchViewController *another = [RedxAnotherSearchViewController new];
        [another didSelectedItem:^(NSString *item) {
            self.btnCty.text = item;
            
            UITextField *zoneTF = [self.view viewWithTag:101];
            NSString *zonestr = self.zoneCountDic[item];
            if(!kStringIsEmpty(zonestr)){
                
                if([zonestr floatValue] >= 0){
                    zoneTF.text = [NSString stringWithFormat:@"GMT+%@",zonestr];

                }else{
                    
                    zoneTF.text = [NSString stringWithFormat:@"GMT%@",zonestr];

                }
            }
            
        }];
        another.title =root_xuanzhe_country;
        another.dataSource=_provinceArray;
        
        [self.navigationController pushViewController:another animated:YES];
    }else{
        [self showToastViewWithTitle:root_Panel_shuju_jiazai];
    }
}

- (void)getPickerData{
    
    _provinceArray=[NSMutableArray array];
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/user/getCountryList" parameters:@{} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (datadic) {
            id objdic = datadic[@"obj"];
            if([objdic isKindOfClass:[NSArray class]]){
                
                NSArray *dataArr= datadic[@"obj"];//[NSArray arrayWithArray:content];
                if (dataArr.count>0) {
                    NSArray *countrysArr = dataArr;
                    for (int i=0; i<countrysArr.count; i++) {
                        NSString *DY=[NSString stringWithFormat:@"%@",countrysArr[i]];
                        [ _provinceArray addObject:DY];
                    }
                    [_provinceArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                        NSString *str1=(NSString *)obj1;
                        NSString *str2=(NSString *)obj2;
                        return [str1 compare:str2];
                    }];
                    //                [self.provinceArray insertObject:@"*Australia*" atIndex:0];
                    //                [self.provinceArray insertObject:@"*中国*" atIndex:0];
                    
                }
            }
        }


    } failure:^(NSError *error) {
        [self hideProgressView];
    
    }];
}

//去注册
- (void)sureBtnClick{
    
    if(!_selectButton.selected){
        [self showToastViewWithTitle:root_xuanze_yonghu_xieyi];
        return;
        
    }
    
    UITextField *countTF = [self.view viewWithTag:100];
    UITextField *timezongTF = [self.view viewWithTag:101];
    UITextField *EmialTF = [self.view viewWithTag:102];
    UITextField *codeTF = [self.view viewWithTag:103];
    UITextField *pswTF = [self.view viewWithTag:104];
    UITextField *confpswTF = [self.view viewWithTag:105];

    if(countTF.text.length == 0){
        
        [self showToastViewWithTitle:root_xuanzhe_country];
        return;
    }
    if(timezongTF.text.length == 0){
        
        [self showToastViewWithTitle:root_oss_1018];
        return;
    }
    if(EmialTF.text.length == 0){
        
        [self showToastViewWithTitle:oss_inputEmail];
        return;
    }
    if(codeTF.text.length == 0){
        
        [self showToastViewWithTitle:root_yanzhengma_cuowu];
        return;
    }
    if(pswTF.text.length == 0){
        
        [self showToastViewWithTitle:root_Alet_user_pwd];
        return;
    }
    if(![pswTF.text isEqualToString:confpswTF.text]){
        
        [self showToastViewWithTitle:root_xiangTong_miMa];
        return;
    }
    
    if(pswTF.text.length < 6 || pswTF.text.length >30){
        
        [self showAlertViewWithTitle:root_RetrieveTips message:@"" cancelButtonTitle:root_OK];
//        [self showToastViewWithTitle:root_RetrieveTips];
        return;
    }
    NSString *timezonestr = timezongTF.text;
    if([timezonestr containsString:@"GMT"]){
        
        NSArray *remogmtArr = [timezonestr componentsSeparatedByString:@"GMT"];
        if(remogmtArr.count > 1){
            
            timezonestr = remogmtArr[1];
        }
    }
    
    
    NSDictionary *pramDic = @{@"country":countTF.text,@"timeZone":timezonestr,@"email":EmialTF.text,@"verificationCode":codeTF.text,@"password":[self MD5:pswTF.text],@"installerCode":@""};
    [self showProgressView];
    [RedxBaseRequest myHttpPost:@"/v1/user/register" parameters:pramDic Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {
                
                [RedxUserInfo defaultUserInfo].email = EmialTF.text;
                [RedxUserInfo defaultUserInfo].userPassword = pswTF.text;
                [RedxUserInfo defaultUserInfo].isAutoLogin = YES;
                [[NSUserDefaults standardUserDefaults] synchronize];
           
                [self.navigationController popViewControllerAnimated:YES];
//                RedxloginViewController *loginvc = [[RedxloginViewController alloc]init];
//                [self.navigationController pushViewController:loginvc animated:YES];

            }
//
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];
   
        
    }];
    
}

- (void)bgclick{
    
    [self.view endEditing:YES];
}
@end
