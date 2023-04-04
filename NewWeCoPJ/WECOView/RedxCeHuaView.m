

#import "RedxCeHuaView.h"
@interface RedxCeHuaView()

@property (nonatomic ,strong) NSMutableArray *namarr;
@property (nonatomic ,strong) NSMutableArray *imgarr;

@end


@implementation RedxCeHuaView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *bgclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgclick)];
        [self addGestureRecognizer:bgclick];
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = COLOR(0, 0, 0, 0.3);
    
}

-(void)createValueUIWith:(BOOL)isMgrn isHaveDevice:(BOOL)isHaveDevice {
    self.isMgrn = isMgrn;
    self.isHaveDevice = isHaveDevice;
    UIView *leftv = [[UIView alloc]initWithFrame:CGRectMake(-(kScreenWidth*2/3), 0, kScreenWidth*2/3, kScreenHeight)];
    leftv.backgroundColor = WhiteColor;//backgroundNewColor;
//    leftv.userInteractionEnabled = NO;
    [self addSubview:leftv];
    CGFloat leftwide = leftv.frame.size.width;
    _leftview = leftv;
    [UIView animateWithDuration:0.5 animations:^{
        
        leftv.xmg_x = 0;
        
    } completion:nil];
    
//    CGSize imgname = IMAGE(@"cehualogo").size;
//    CGFloat imgwide = imgname.width*40*HEIGHT_SIZE/imgname.height;
//    UIImageView *nameimg = [[UIImageView alloc]initWithFrame:CGRectMake(leftv.frame.size.width/2 - imgwide/2, k_Height_StatusBar+10*HEIGHT_SIZE, imgwide, 40*HEIGHT_SIZE)];
//    nameimg.image = IMAGE(@"cehualogo");
//    [leftv addSubview:nameimg];

    
    //
//    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nameimg.frame), leftwide, 60*HEIGHT_SIZE)];
//    userView.backgroundColor = mainColor;
//    UITapGestureRecognizer *uservtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uservieclick)];
//    [userView addGestureRecognizer:uservtap];
//    [leftv addSubview:userView];
    
    UIImageView *userHeaderIMG = [[UIImageView alloc]initWithFrame:CGRectMake(leftv.xmg_width/2-25*HEIGHT_SIZE, kNavBarHeight, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
    userHeaderIMG.image = IMAGE(@"WeHeaderIMG");
    userHeaderIMG.layer.cornerRadius = 25*HEIGHT_SIZE;
    userHeaderIMG.layer.masksToBounds = YES;
//    uitap
    [leftv addSubview:userHeaderIMG];
    
    // 加载图片
    NSString *iconstr = [RedxUserInfo defaultUserInfo].userIcon;
    [userHeaderIMG sd_setImageWithURL:[NSURL URLWithString:iconstr] placeholderImage:IMAGE(@"WeHeaderIMG")];
    
    
    UIButton *editbtn = [[UIButton alloc]initWithFrame:CGRectMake(5*NOW_SIZE, CGRectGetMaxY(userHeaderIMG.frame), 25*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    [editbtn setImage:IMAGE(@"weeditIMG") forState:UIControlStateNormal];
    [editbtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
//    [leftv addSubview:editbtn];
    
    
    UILabel *namelb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(editbtn.frame)+5*NOW_SIZE, CGRectGetMaxY(userHeaderIMG.frame), leftwide - CGRectGetMaxX(editbtn.frame)*2-10*NOW_SIZE, 25*HEIGHT_SIZE)];
    namelb.font = FontSize(16*HEIGHT_SIZE);
    namelb.textColor = colorBlack;
    namelb.adjustsFontSizeToFitWidth = YES;
    namelb.textAlignment = NSTextAlignmentCenter;
    namelb.text = [RedxUserInfo defaultUserInfo].email;
    [leftv addSubview:namelb];
    
    
    UIButton *LogOutbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelb.frame)+5*NOW_SIZE, CGRectGetMaxY(userHeaderIMG.frame), 25*HEIGHT_SIZE, 25*HEIGHT_SIZE)];
    [LogOutbtn setImage:IMAGE(@"weeditIMG") forState:UIControlStateNormal];
    [LogOutbtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
//    [leftv addSubview:LogOutbtn];
    
//    UILabel *phonelb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeaderIMG.frame)+5*NOW_SIZE,CGRectGetMaxY(namelb.frame), leftwide - CGRectGetMaxX(userHeaderIMG.frame)-5*NOW_SIZE - 5*NOW_SIZE - 8*HEIGHT_SIZE - 5*NOW_SIZE, 25*HEIGHT_SIZE)];
//    phonelb.font = FontSize(13*HEIGHT_SIZE);
//    phonelb.textColor = WhiteColor;
//    phonelb.adjustsFontSizeToFitWidth = YES;
//    NSString *lang = [self getTheLaugrage];
//    NSString *phonestr = [RedxUserInfo defaultUserInfo].email;
//    if ([lang isEqualToString:@"0"]) {
//        phonestr = [RedxUserInfo defaultUserInfo].TelNumber;
//    }
//    phonelb.text = phonestr;
//    [userView addSubview:phonelb];
//
//    UIImageView *rigimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(namelb.frame)+5*NOW_SIZE, (userView.frame.size.height-8*HEIGHT_SIZE)/2, 8*HEIGHT_SIZE, 8*HEIGHT_SIZE)];
//    rigimg.image = IMAGE(@"nav_ico_back2");
//    [userView addSubview:rigimg];
    
    NSArray *namArr = [NSMutableArray arrayWithObjects:home_CehuaList1,@"Device List",self.isMgrn == YES ? @"Inverter Setting" : @"Cabinet Setting", self.isMgrn == YES ? @"Inveter Runing Info" : @"Cabinet Runing Info",Me_SetName2,home_CehuaList3, nil]; //Me_SetName1,Me_SetName2,Me_SetName3
    NSArray *imgArr = [NSMutableArray arrayWithObjects:@"WePlanListIcon",@"deviceList",@"InverterSetting",@"InfoIcon",@"WeSetting",@"WeLogoutIMG", nil];
    
    NSArray *namArr1 = [NSMutableArray arrayWithObjects:home_CehuaList1,@"Device List",Me_SetName2,home_CehuaList3, nil]; //Me_SetName1,Me_SetName2,Me_SetName3
    NSArray *imgArr1 = [NSMutableArray arrayWithObjects:@"WePlanListIcon",@"deviceList",@"WeSetting",@"WeLogoutIMG", nil];
    if (self.isHaveDevice == YES) {
        [self.namarr addObjectsFromArray:namArr];
        [self.imgarr addObjectsFromArray:imgArr];
    } else {
        [self.namarr addObjectsFromArray:namArr1];
        [self.imgarr addObjectsFromArray:imgArr1];
    }
    
    for (int i = 0 ; i < self.namarr.count; i ++) {
        UIView *listv = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(namelb.frame)+20*HEIGHT_SIZE+50*HEIGHT_SIZE*i, leftwide, 50*HEIGHT_SIZE)];
        listv.tag = 100+i;
        [leftv addSubview:listv];
        UITapGestureRecognizer *funtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(functionClick:)];
        [listv addGestureRecognizer:funtap];
        
        
        UIImageView *iconimgv = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, (50*HEIGHT_SIZE - 20*HEIGHT_SIZE)/2, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
        iconimgv.image = IMAGE(self.imgarr[i]);
        iconimgv.contentMode = UIViewContentModeScaleAspectFit;
        [listv addSubview:iconimgv];
        
        UILabel *namelb22 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconimgv.frame)+5*NOW_SIZE, 5*HEIGHT_SIZE, leftwide - CGRectGetMaxX(iconimgv.frame)-5*NOW_SIZE-5*NOW_SIZE, 40*HEIGHT_SIZE)];
        namelb22.font = FontSize(14*HEIGHT_SIZE);
        namelb22.textColor = colorblack_51;
        namelb22.adjustsFontSizeToFitWidth = YES;
        namelb22.text = self.namarr[i];
        [listv addSubview:namelb22];
        
        UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, listv.xmg_height-1*HEIGHT_SIZE, leftwide, 1*HEIGHT_SIZE)];
        linev.backgroundColor = backgroundNewColor;
        [listv addSubview:linev];
        
        
//        if(i == 3){
            
//            UILabel *tipslb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconimgv.frame)+5*NOW_SIZE, 5*HEIGHT_SIZE, leftwide - CGRectGetMaxX(iconimgv.frame)-5*NOW_SIZE-5*NOW_SIZE, 40*HEIGHT_SIZE)];
//            tipslb.font = FontSize(14*HEIGHT_SIZE);
//            tipslb.textColor = colorblack_154;
//            tipslb.adjustsFontSizeToFitWidth = YES;
//            tipslb.text = Me_SetnotificationTips;
//            [listv addSubview:tipslb];
            
//            UILabel *tipslb = [self goToInitLable:CGRectMake(CGRectGetMaxX(imgv.frame)+5*NOW_SIZE, CGRectGetMaxY(titLb.frame), kScreenWidth-CGRectGetMaxX(imgv.frame)-10*NOW_SIZE-10*HEIGHT_SIZE-5*NOW_SIZE-50*HEIGHT_SIZE, 15*HEIGHT_SIZE) textName:Me_SetnotificationTips textColor:colorblack_154 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//            [onev addSubview:tipslb];
//            linev.xmg_y = CGRectGetMaxY(tipslb.frame);+5*HEIGHT_SIZE;
            
//            UIButton *onoffbtn = [[UIButton alloc]initWithFrame:CGRectMake(_leftview.xmg_width-10*NOW_SIZE-40*HEIGHT_SIZE,listv.xmg_height/2-30*HEIGHT_SIZE/2, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE)];//[self goToInitButton:CGRectMake(kScreenWidth-10*NOW_SIZE-40*HEIGHT_SIZE,0, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE) TypeNum:2 fontSize:13 titleString:@"" selImgString:@"weon" norImgString:@"weoff"];
//            [onoffbtn setImage:IMAGE(@"weon") forState:UIControlStateSelected];
//            [onoffbtn setImage:IMAGE(@"weoff") forState:UIControlStateNormal];
//
//            [onoffbtn addTarget:self action:@selector(onoffClick:) forControlEvents:UIControlEventTouchUpInside];
//            [listv addSubview:onoffbtn];
//        }
        
    }
    
    
    
    
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [appInfo objectForKey:@"CFBundleShortVersionString"];
    NSString *app_Name = [appInfo objectForKey:@"CFBundleDisplayName"];

    
    UILabel *Wenamelb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, kScreenHeight-40*HEIGHT_SIZE-30*HEIGHT_SIZE-40*HEIGHT_SIZE, leftwide - 20*NOW_SIZE, 40*HEIGHT_SIZE)];
    Wenamelb.font = FontSize(18*HEIGHT_SIZE);
    Wenamelb.textColor = colorBlack;
    Wenamelb.adjustsFontSizeToFitWidth = YES;
    Wenamelb.textAlignment = NSTextAlignmentCenter;
    Wenamelb.text = app_Name;
    [leftv addSubview:Wenamelb];
    
    UILabel *versionlb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(Wenamelb.frame), leftwide - 20*NOW_SIZE, 30*HEIGHT_SIZE)];
    versionlb.font = FontSize(16*HEIGHT_SIZE);
    versionlb.textColor = colorblack_154;
    versionlb.adjustsFontSizeToFitWidth = YES;
    versionlb.text = [NSString stringWithFormat:@"%@ %@",Me_SetVersion,app_Version];
    versionlb.textAlignment = NSTextAlignmentCenter;
    [leftv addSubview:versionlb];

}

- (void)onoffClick:(UIButton *)clickBtn{
    
    clickBtn.selected = !clickBtn.selected;
}

//
- (void)editClick{
    [self removeFromSuperview];
    self.selectBlock(10);//

    
}
- (void)logOutClick{
    self.selectBlock(105);//

    [self removeFromSuperview];
}

- (void)functionClick:(UITapGestureRecognizer*)tapg{
    self.selectBlock(tapg.view.tag);
    [self removeFromSuperview];

}

- (void)bgclick{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.leftview.xmg_x = - self.leftview.xmg_width;
        self.alpha = 0;

    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
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

-(NSMutableArray *)namarr {
    if (!_namarr){
        _namarr = [NSMutableArray array];
    }
    return _namarr;
}

-(NSMutableArray *)imgarr {
    if (!_imgarr){
        _imgarr = [NSMutableArray array];
    }
    return _imgarr;
}

@end
