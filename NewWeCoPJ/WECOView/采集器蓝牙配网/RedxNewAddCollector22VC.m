#import "RedxNewAddCollector22VC.h"

#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoolsManageVC.h"
#import "BluetoolsDataSetVC.h"
#import "CollectorUpdataFirstVC.h"
#import "BlueToolsOpenSetTipsVC.h"
#import "RedxcollectorDownLoad.h"
#import "WeNewOverView.h"

@interface RedxNewAddCollector22VC ()<BluetoolsManageVCDelegate>
@property(nonatomic,strong)UITextField *cellectId;
@property(nonatomic,strong)UITextField *cellectNo;
@property(nonatomic,strong)UITextField *devNameTF;

@property(nonatomic,strong)NSString *param1;
@property(nonatomic,strong)NSString *param2;
@property(nonatomic,strong)NSString *param3;
@property(nonatomic,strong)NSString *param1Name;
@property(nonatomic,strong)NSString *param2Name;
@property(nonatomic,strong)NSString *param3Name;
@property(nonatomic,strong)NSString *param4Name;
@property(nonatomic,strong)NSString *param4;
@property (nonatomic, strong) NSString *SetName;
@property (nonatomic, strong) UIScrollView *bgscroll;
@property (nonatomic, strong) NSString *datalogType;
@property (nonatomic, strong) NSString *isWifiDatalog;
@property (nonatomic, strong) NSString *isNewDatalog;
//@property (nonatomic, strong)CLLocationManager *location;
//@property (nonatomic, strong)RedxuploadpressView *upprevie;
@property (nonatomic, assign)NSInteger pressNum;
@property (nonatomic, assign)NSInteger urlNum;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *isWifiXOrS;
@property (nonatomic, strong) NSTimer *isSeachTimer;
@property (nonatomic, assign) int seachTimeNumb;
@property (nonatomic, strong) UIView *failBgView;
@property (nonatomic, strong) NSString *failType;
@property(nonatomic,assign) BOOL isInVC;
@property (nonatomic, assign) BOOL isINDataVC;
@property (nonatomic, strong) CBPeripheral *ConnDevice;
@property (nonatomic, assign) BOOL isSeachDevSuccess;


@end
@implementation RedxNewAddCollector22VC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isInVC = NO;
    self.isINDataVC = NO;
    self.isSeachDevSuccess = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _param1=@"";
    _param2=@"";
    _param3=@"";
    _param1Name=@"";
    _param2Name=@"";
    _param3Name=@"";
    self.title = @"Add Device";
//    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"APModeSetNet"];
//    [self creatChongDx];
    [self initUI];
//    [self locationPower];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn addTarget:self action:@selector(questionClick) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImage:IMAGE(@"help233") forState:UIControlStateNormal];
//    [rightBtn sizeToFit];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadSuccess) name:@"UPLOADCOLLECTSUCCESS" object:nil];

}
//- (void)locationPower{
//    if (@available(iOS 13.0, *)) {
//        _location = [[CLLocationManager alloc]init];
//        _location.delegate = self;
//        if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
//            [_location requestWhenInUseAuthorization];
//        }
//        [_location startUpdatingLocation];
//    }
//}
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//}
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//}
//- (void)questionClick{
//    RedxNormalQuestionVC *norque = [[RedxNormalQuestionVC alloc]init];
//    [self.navigationController pushViewController:norque animated:YES];
//}
-(void)initUI{
    UIScrollView *bgscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgscrollClick)];
    [bgscroll addGestureRecognizer:tapg];
    [self.view addSubview:bgscroll];
    _bgscroll = bgscroll;
//    self.navigationItem.title = root_tianJia_sheBei;
    self.view.backgroundColor = WhiteColor;

//    NSArray *imageNameArray = @[@"add_tip_sn",@"add_tip_cc"];
//    NSArray *titleArray = @[root_xuleihao,[NSString stringWithFormat:@"%@(CC)", root_jiaoyanma_674]];
//    for (int i = 0; i < 2; i++) {
//        CGFloat imgX = ScreenWidth/2 - 80*NOW_SIZE;
//        if (i == 1) imgX = ScreenWidth/2;
//        UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(imgX, 20*HEIGHT_SIZE, 80*NOW_SIZE, 30*HEIGHT_SIZE)];
//        imgV1.image = IMAGE(imageNameArray[i]);
//        imgV1.contentMode = UIViewContentModeScaleAspectFit;
//        [_bgscroll addSubview:imgV1];
//        if(i == 1){
//            imgV1.frame = CGRectMake(imgX, 20*HEIGHT_SIZE, 80*NOW_SIZE, 20*HEIGHT_SIZE);
//        }
//        UILabel *lblN = [[UILabel alloc]initWithFrame:CGRectMake(imgX, CGRectGetMaxY(imgV1.frame), imgV1.xmg_width, 20*HEIGHT_SIZE)];
//        lblN.text = titleArray[i];
//        lblN.textColor = colorblack_102;
//        lblN.textAlignment = NSTextAlignmentCenter;
//        lblN.font = FontSize([NSString getFontWithText:lblN.text size:lblN.xmg_size currentFont:12*HEIGHT_SIZE]);
//        [_bgscroll addSubview:lblN];
//    }
    
    UIView *tipsviewb = [self goToInitView:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 160*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    tipsviewb.layer.cornerRadius = 10*HEIGHT_SIZE;
    tipsviewb.layer.masksToBounds = YES;
    [bgscroll addSubview:tipsviewb];
    
    UIImageView *erwemaImg = [self goToInitImageView:CGRectMake(tipsviewb.xmg_width/2-25*HEIGHT_SIZE, 15*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE) imageString:@"erweima"];
    [tipsviewb addSubview:erwemaImg];
    
    UILabel *tipslbb = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(erwemaImg.frame)+10*HEIGHT_SIZE, tipsviewb.xmg_width-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:@"Enter the device SN" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    tipslbb.numberOfLines = 0;
    [tipsviewb addSubview:tipslbb];
    
    
    NSArray *titleArray2 = @[[NSString stringWithFormat:@"%@:", root_xuleihao],@"Device name:"];//,[NSString stringWithFormat:@"%@:", root_jiaoyanma_674]
    NSArray *placeholderArray = @[root_caiJiQi,@"Enter device name"];//, root_jiaoYanMa
    CGFloat viewH = 45*HEIGHT_SIZE;
    for (int i = 0; i < titleArray2.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipsviewb.frame)+i*viewH+20*HEIGHT_SIZE+10*HEIGHT_SIZE, ScreenWidth, viewH)];
        view.backgroundColor = [UIColor whiteColor];
        [_bgscroll addSubview:view];
        float marginLF = 10*NOW_SIZE;
        float labelW = 80*NOW_SIZE;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginLF, 0, labelW, viewH)];
        titleLabel.text = titleArray2[i];
        titleLabel.textColor = colorblack_51;
        titleLabel.font = FontSize(13*HEIGHT_SIZE);
        titleLabel.adjustsFontSizeToFitWidth=YES;
        titleLabel.numberOfLines=0;
        [view addSubview:titleLabel];
        CGFloat labelW2 = ScreenWidth - labelW - 4*marginLF - 60*NOW_SIZE;
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+marginLF, 0, labelW2, viewH)];
        textField.textAlignment = NSTextAlignmentLeft;
        textField.placeholder = placeholderArray[i];
        textField.font = FontSize(13*HEIGHT_SIZE);
        if (!kStringIsEmpty(placeholderArray[i])) {
             textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderArray[i] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11*HEIGHT_SIZE]}];
               [textField setMinimumFontSize:textFiedMinFont];
        }
        textField.tag = 30 + i;
        textField.adjustsFontSizeToFitWidth = YES;
        [view addSubview:textField];
        if(i == 0){ 
            UIButton *btnScan = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame)+marginLF, (viewH-35*HEIGHT_SIZE)/2, 60*NOW_SIZE, 35*HEIGHT_SIZE)];
            [btnScan setTitle:root_YHQ_537 forState:UIControlStateNormal];
            [btnScan setImage:IMAGE(@"add_scan") forState:UIControlStateNormal];
            btnScan.titleLabel.font = FontSize([NSString getFontWithText:root_YHQ_537 size:CGSizeMake(35*NOW_SIZE, 35*HEIGHT_SIZE) currentFont:12*HEIGHT_SIZE]);
            [btnScan setTitleColor:mainColor forState:UIControlStateNormal];
            XLViewBorderRadius(btnScan, 5, 0.5, mainColor);
            [view addSubview:btnScan];
            [btnScan addTarget:self action:@selector(ScanQR) forControlEvents:UIControlEventTouchUpInside];
        }
        CALayer *lineLayer = [[CALayer alloc]init];
        lineLayer.frame = CGRectMake(0, viewH-1, ScreenWidth, 1);
        lineLayer.backgroundColor = COLOR(236, 239, 241, 1).CGColor;
        [view.layer addSublayer:lineLayer];
    }
    _cellectId = [_bgscroll viewWithTag:30]; 
//    _cellectNo = [_bgscroll viewWithTag:31];
    _devNameTF = [_bgscroll viewWithTag:31];
    UIButton *goBut = [self goToInitButton:CGRectMake(60*NOW_SIZE, kScreenHeight-kNavBarHeight-40*HEIGHT_SIZE-40*HEIGHT_SIZE-60*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Next" selImgString:@"" norImgString:@""];//[RedxRootNewView createButtonWithFrame:CGRectMake(60*NOW_SIZE, kScreenHeight-kNavBarHeight-40*HEIGHT_SIZE-40*HEIGHT_SIZE-60*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE) buttonType:@"0" isAdjWidth:NO];
//    goBut.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    goBut.layer.cornerRadius = 5*HEIGHT_SIZE;
    goBut.layer.masksToBounds = YES;
//    [goBut setTitle:@"Next" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    goBut.backgroundColor = buttonColor;
    [_bgscroll addSubview:goBut];
    
    
    
    
    
    
//    if (kScreenHeight - kNavBarHeight - CGRectGetMaxY(goBut.frame) < 220*HEIGHT_SIZE) {
//        bgscroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 100*HEIGHT_SIZE);
//    }
//    NSString *goThreeString=[NSString stringWithFormat:@"%@ >>", root_plant_1151];
//    CGSize buttonSize=[self getStringSize:13*HEIGHT_SIZE Wsize:MAXFLOAT Hsize:25*HEIGHT_SIZE stringName:goThreeString];
//    CGFloat btnW =buttonSize.width;
//    UIButton *btnOther = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-btnW)/2, ScreenHeight-kNavBarHeight-kBottomBarHeight-60*HEIGHT_SIZE, btnW, 25*HEIGHT_SIZE)];
//    [btnOther setTitle:goThreeString forState:UIControlStateNormal];
//    [btnOther setTitleColor:colorblack_102 forState:UIControlStateNormal];
//      btnOther.titleLabel.adjustsFontSizeToFitWidth=YES;
//    btnOther.titleLabel.font = FontSize(13*HEIGHT_SIZE);
//    [btnOther addTarget:self action:@selector(goToAddOtherDevice:) forControlEvents:UIControlEventTouchUpInside];
////    [_bgscroll addSubview:btnOther];
//    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:goThreeString];
//        [tncString addAttribute:NSUnderlineStyleAttributeName
//                          value:@(NSUnderlineStyleSingle)
//                          range:(NSRange){0,[tncString length]}];
//        [tncString addAttribute:NSForegroundColorAttributeName value:colorblack_51  range:NSMakeRange(0,[tncString length])];
//        [tncString addAttribute:NSUnderlineColorAttributeName value:colorblack_51 range:(NSRange){0,[tncString length]}];
//        [tncString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:(NSRange){0,[tncString length]}];
//        [btnOther setAttributedTitle:tncString forState:UIControlStateNormal];
    
    if (!kStringIsEmpty(_SNStr)) {
        [self ScanGoToNet:_SNStr];
    }
}


- (void)bgscrollClick{
    
    [self.view endEditing:YES];
}
//- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
//{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:lineView.bounds];
//    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//    [shapeLayer setStrokeColor:lineColor.CGColor];
//    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    [lineView.layer addSublayer:shapeLayer];
//}
//- (void)goToAddOtherDevice:(UIButton *)button{
//    RedxaddOtherDevice *vc = [[RedxaddOtherDevice alloc]init];
//    vc.isRegister=NO;
//    vc.stationId=self.stationId;
//    vc.goBackBlock = ^{
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
//}
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
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_cellectNo resignFirstResponder];
    [_cellectId resignFirstResponder];
}
-(void)ScanQR{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)ScanGoToNet:(NSString *)result {
//    if ((result.length==10)||(result.length==16)||(result.length==30)) {
//    }else{
//        [self showAlertViewWithTitle:Root_changeScanW message:Root_changeScanW22 cancelButtonTitle:root_Yes];
//        return;
//    }
//    _cellectNo.text=[self getValidCode:result];
    _cellectId.text=result;
//    NSLog(@"_cellectNo.text=%@",_cellectNo.text);
//    NSLog(@"_cellectId.text=%@",_cellectId.text);
}
-(void)addButtonPressed{
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:@"" message:root_caiJiQi_zhengque cancelButtonTitle:root_OK];
        return;
    }
    
    if(_devNameTF.text.length == 0){
        
        [self showAlertViewWithTitle:@"Enter device name" message:@"" cancelButtonTitle:root_OK];
        return;
    }
//    [self conntoBlue];
    [self addDeviceNet];

//    if ([_cellectNo.text isEqual:@""]) {
//        [self showAlertViewWithTitle:@"" message:root_jiaoYanMa_zhengQue cancelButtonTitle:root_OK];
//        return;
//    }
    
//    BluetoolsSeachDevVC *bluevc = [[BluetoolsSeachDevVC alloc]init];
//    bluevc.SNStr = _cellectId.text;
//    bluevc.codeStr = _cellectNo.text;
//    [self.navigationController pushViewController:bluevc animated:YES];
//    if(_cellectId.text.length == 10){
//        [self conntoBlue];
//
//
//    }else{
//        [self addDeviceNet];
//    }

//    [self createSeachFailUI:@"3"];
}

//添加设备
- (void)addDeviceNet{
    

    
        
    [self showProgressView];//_deviceNetDic
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/addDatalog" parameters:@{@"datalogSn":_cellectId.text,@"plantId":_stationId,@"alias":_devNameTF.text} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {
                
                
                if(_cellectId.text.length == 10){

                    [self createSeachFailUI:@"3"];
                    
                }else{
//                    [self addDeviceNet];
                    [self showToastViewWithTitle:msg];
                    for (UIViewController *homevc in self.navigationController.viewControllers) {

                        if([homevc isKindOfClass:[WeNewOverView class]]){

                            [self.navigationController popToViewController:homevc animated:YES];
                        }
                    }
                }

               

                

            }else if([result isEqualToString:@"10011"]){
                
                if(_cellectId.text.length == 10){
                    [self createSeachFailUI:@"4"];
                }else{
                    
                    [self createSeachFailUI:@"5"];

                }

                
            }else{
                
                [self showToastViewWithTitle:msg];

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
}






- (void)conntoBlue{
    
    [BluetoolsManageVC instance].delegate = self;
    [[BluetoolsManageVC instance] disconnectToPeripheral];
    [self scanForPeripherals];
    
    _seachTimeNumb = 0;
    if (_isSeachTimer) {
        [_isSeachTimer invalidate];
        _isSeachTimer = nil;
    }
    _isSeachTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(isSeachDevice) userInfo:nil repeats:YES];
}
//搜索设备计时
- (void)isSeachDevice{
    
    if(_isSeachDevSuccess){
        [_isSeachTimer invalidate];
        _isSeachTimer = nil;
        return;
    }
    _seachTimeNumb ++;
    if (_seachTimeNumb > 30) {
        [_isSeachTimer invalidate];
        _isSeachTimer = nil;
        [[BluetoolsManageVC instance] StopScanForPeripherals];
        [self createSeachFailUI:@"0"];
    }
    
}
- (void)createSeachFailUI:(NSString *)typestr{
    [self hideProgressView];
    _failType = typestr;
    if(![typestr isEqualToString:@"0"]){
        
        [_isSeachTimer invalidate];
        _isSeachTimer = nil;
    }
    
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    
    UIView *failBgview = [self goToInitView:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backgroundColor:COLOR(0, 0, 0, 0.4)];
    [self.view addSubview:failBgview];
    _failBgView = failBgview;
    
    UIView *toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-240*HEIGHT_SIZE,
                                                                   kScreenWidth,270*HEIGHT_SIZE)];
    toolsView.layer.cornerRadius = 20*HEIGHT_SIZE;
    toolsView.layer.masksToBounds = YES;
    toolsView.backgroundColor = [UIColor whiteColor];
    [_failBgView addSubview:toolsView];

//    float buttonW=50;
//    CGSize size = CGSizeMake(buttonW, buttonW);
    
    
    UIImageView *tipsIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-25*HEIGHT_SIZE, 10*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
    tipsIMGV.image = IMAGE(@"connectBLEFail");
    [toolsView addSubview:tipsIMGV];
    
    if([typestr isEqualToString:@"1"] || [typestr isEqualToString:@"2"]){
        tipsIMGV.image = IMAGE(@"WeblueIcon");
        
    }
    if([typestr isEqualToString:@"3"]){
        
        tipsIMGV.hidden = YES;
        UILabel *successLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE)];
        successLB.text = @"Successfully added";
        successLB.textAlignment = NSTextAlignmentCenter;
        successLB.font = FontSize(15*HEIGHT_SIZE);
        successLB.textColor = colorBlack;
        successLB.numberOfLines = 0;
        [toolsView addSubview:successLB];
        
    }
    if([typestr isEqualToString:@"4"]){
        
        tipsIMGV.hidden = YES;
        UILabel *successLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE)];
        successLB.text = @"The device has been added";
        successLB.textAlignment = NSTextAlignmentCenter;
        successLB.font = FontSize(15*HEIGHT_SIZE);
        successLB.textColor = colorBlack;
        successLB.numberOfLines = 0;
        [toolsView addSubview:successLB];
        
    }
    if([typestr isEqualToString:@"5"]){
        
        tipsIMGV.hidden = YES;
        UILabel *successLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE)];
        successLB.text = @"Note";
        successLB.textAlignment = NSTextAlignmentCenter;
        successLB.font = FontSize(15*HEIGHT_SIZE);
        successLB.textColor = colorBlack;
        successLB.numberOfLines = 0;
        [toolsView addSubview:successLB];
        
    }
    
    UILabel *scanLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipsIMGV.frame), kScreenWidth-20*NOW_SIZE, 50*HEIGHT_SIZE)];
    scanLB.text = @"Bluetooth connection failed,please scan the code again to add";
    scanLB.textAlignment = NSTextAlignmentCenter;
    scanLB.font = FontSize(14*HEIGHT_SIZE);
    scanLB.textColor = colorblack_154;
    scanLB.numberOfLines = 0;
    [toolsView addSubview:scanLB];
    
    if([typestr isEqualToString:@"1"] || [typestr isEqualToString:@"2"]){
        scanLB.text = @"Bluetooth permission required，Please go to Settings and enable use.";
        
    }
    if([typestr isEqualToString:@"3"]){
        scanLB.text = @"Please select your next action";

    }
    if([typestr isEqualToString:@"4"]){
        scanLB.text = @"Do you want to reconfigure the network?";

    }
    if([typestr isEqualToString:@"5"]){
        scanLB.text = @"The device cannot be added again because it has been added";

    }
//    WEPhotoScan
    
    UIButton *changeButton = [[UIButton alloc]init];
    changeButton.frame = CGRectMake(10*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 40*HEIGHT_SIZE);
//    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [changeButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    [changeButton setImage:[UIImage imageNamed:@"WEeditIM"] forState:UIControlStateNormal];
    [changeButton setTitle:root_cancel forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(ManualInput) forControlEvents:UIControlEventTouchUpInside];
    changeButton.backgroundColor = backgroundNewColor;
    changeButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    changeButton.layer.masksToBounds = YES;
    [toolsView addSubview:changeButton];
    if([typestr isEqualToString:@"3"]){
        [changeButton setTitle:@"Homepage" forState:UIControlStateNormal];

    }
    if([typestr isEqualToString:@"4"]){
        [changeButton setTitle:@"Homepage" forState:UIControlStateNormal];

    }
    UIButton *photoButton = [[UIButton alloc]init];
    photoButton.frame = CGRectMake(CGRectGetMaxX(changeButton.frame)+5*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 40*HEIGHT_SIZE);
//    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [photoButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    [photoButton setImage:[UIImage imageNamed:@"WEPhotoScan"] forState:UIControlStateNormal];
    [photoButton setTitle:root_OK forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    photoButton.backgroundColor = backgroundNewColor;
    photoButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    photoButton.layer.masksToBounds = YES;
    [toolsView addSubview:photoButton];
    
    
    if([typestr isEqualToString:@"1"] || [typestr isEqualToString:@"2"]){
        [photoButton setTitle:@"Open" forState:UIControlStateNormal];

    }
    if([typestr isEqualToString:@"3"]){
        [photoButton setTitle:@"Set-up-net" forState:UIControlStateNormal];

    }
    if([typestr isEqualToString:@"4"]){
        [photoButton setTitle:@"Set-up-net" forState:UIControlStateNormal];

    }
}
- (void)ManualInput{
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    [self hideProgressView];
    
    if([_failType isEqualToString:@"3"] || [_failType isEqualToString:@"4"]){//
        
        BOOL isback = NO;
        for (UIViewController *homevc in self.navigationController.viewControllers) {

            if([homevc isKindOfClass:[WeNewOverView class]]){

                isback = YES;
                [self.navigationController popToViewController:homevc animated:YES];
            }
        }

        if(!isback){
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        

    }
}
- (void)openPhoto{
    [self hideProgressView];
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    if([_failType isEqualToString:@"1"]){//蓝牙授权未开启
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

        
    }else if([_failType isEqualToString:@"2"]){//蓝牙未开启
        
        [RedxcollectorDownLoad wifiClick];
    }else if([_failType isEqualToString:@"3"] || [_failType isEqualToString:@"4"]){//去配网
        
        [self conntoBlue];


    }
    
    
    
}
// 搜索蓝牙设备
- (void)scanForPeripherals{
    
    [self showProgressView];// 开启菊花
    [BluetoolsManageVC instance].ScanSn = _cellectId.text;
    [[BluetoolsManageVC instance] scanForPeripherals];
    
    __weak typeof(self) weakSelf = self;
   
    [BluetoolsManageVC instance].GetBluePeripheralBlock = ^(id  _Nonnull obj, NSDictionary * _Nonnull BlueDic) {
        
            CBPeripheral *peripheral = (CBPeripheral *)obj;
            NSString *namestr = BlueDic[@"name"];
            if ([namestr isEqualToString:weakSelf.cellectId.text]) {
                
                self.isSeachDevSuccess = YES;
                if(self.isSeachTimer){
                    [self.isSeachTimer invalidate];
                    self.isSeachTimer = nil;
                }
                
//                NSString *isBagG = BlueDic[@"Auth"];//判断连接的是g:  还是G:
                [[NSUserDefaults standardUserDefaults]setObject:@"g:" forKey:@"ISBAGGSET"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self conectionWithDevice:peripheral];
            }
        
  
    };
   
}
// 连接切换设置
- (void)conectionWithDevice:(CBPeripheral *)device {
    
    
    [[BluetoolsManageVC instance] connectToPeripheral:device];
    [BluetoolsManageVC instance].ConnectBluePeripheralBlock = ^(id obj){// 连接结果

        if ([obj isEqualToString:@"YES"]) {
    
            self.ConnDevice = device;
        }else{
            [self hideProgressView]; // 关闭菊花

            [self createSeachFailUI:@"0"];
        }

    };
    
}

//验证成功
- (void)TCPSocketActionSuccess:(BOOL)isSuccess CMD:(int)cmd devtype:(NSString *)devtype{
    
    
    if ([devtype isEqualToString:@"keySet"]) {//密钥验证成功
        [self hideProgressView];
       
        if (isSuccess) {
            [self getCLVersion];//获取版本号

        }else{
            [[BluetoolsManageVC instance] disconnectToPeripheral];
            [self showAlertViewWithTitle:HEM_zanWuQuanXian message:@"" cancelButtonTitle:root_OK];
        }
    }
}
- (void)getCLVersion{
    
    [self showProgressView];
    [self createSuccessView];
//    获取版本号
//    [[BluetoolsManageVC instance] connectToDev:@[@"21"] devType:@"UPDATA"];//devtype为当前发送的命令标号
}
- (void)TCPSocketReadData:(NSDictionary *)dataDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideProgressView];
  
        NSInteger cmd = [[NSString stringWithFormat:@"%@", dataDic[@"cmd"]] integerValue];
        NSString *devtype = [NSString stringWithFormat:@"%@", dataDic[@"devType"]];

        if (cmd == 19 && [devtype isEqualToString:@"UPDATA"]) {//版本号
            NSString *oldwifiXVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"wifiX2Version"];
//            oldwifiXVersion = @"4.0.0.0";
            NSString *versionStr = [NSString stringWithFormat:@"%@",dataDic[@"21"]];
            if (!kStringIsEmpty(oldwifiXVersion) && [self compareVesionWithServerVersion:oldwifiXVersion compartStr:versionStr]) {

                if (!_isInVC) {
                    _isInVC = YES;
                      
                    CollectorUpdataFirstVC *updata = [[CollectorUpdataFirstVC alloc]init];
//                    updata.isWifiXOrS = _isWifiXOrS;
                    updata.SNStr = _cellectId.text;
                    updata.isBlueIN = @"1";
                    [self.navigationController pushViewController:updata animated:YES];
                    updata.NextBlock = ^{
                        [self createSuccessView];
//                        BluetoolsUpadtaDevVC *updatavc = [[BluetoolsUpadtaDevVC alloc]init];
//                        [self.navigationController pushViewController:updatavc animated:YES];
                        
                        
                    };
                }

                
            }else{
                if (!_isInVC) {
                    _isInVC = YES;
                    [self createSuccessView];
//                    [self gotoNextVC];
                }
                
            }
        }
    });
}

- (void)createSuccessView{
    
    if (_isINDataVC) {
        return;
    }
    _isINDataVC = YES;
    BluetoolsDataSetVC *connwifivc = [[BluetoolsDataSetVC alloc]init];
    connwifivc.wifiName = _cellectId.text;
    connwifivc.stationID = _stationId;
    connwifivc.codeStr = _cellectNo.text;
    connwifivc.SnString = _cellectId.text;
    connwifivc.buleDevice = _ConnDevice;
    [self.navigationController pushViewController:connwifivc animated:YES];
}

- (void)BTManageState:(CBManagerState)State{
    
    switch (State) {
        case CBManagerStateUnknown:{
            NSLog(@"系统蓝牙当前状态不明确");
        }
            break;
        case CBManagerStateResetting:
        {
            NSLog(@"重置状态");
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"系统蓝牙设备不支持");
        }
            break;
        case CBManagerStateUnauthorized:
        {
            NSLog(@"系统蓝未被授权");
            
            [self createSeachFailUI:@"1"];
            
//            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:BlueTipsOpen message:@"" preferredStyle:UIAlertControllerStyleAlert];
//            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
//            [alvc addAction:[UIAlertAction actionWithTitle:NewLocat_gotoSetWifi style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
//
////                BlueToolsOpenSetTipsVC *tipsvc = [[BlueToolsOpenSetTipsVC alloc]init];
////                [self.navigationController pushViewController:tipsvc animated:YES];
//            }]];
//            [self presentViewController:alvc animated:YES completion:nil];
//            [self showAlertViewWithTitle:BlueTipsOpen message:BlueTipsOpenWay2 cancelButtonTitle:root_OK];

        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"系统蓝牙关闭了，请先打开蓝牙");
            [self createSeachFailUI:@"2"];

//            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:BlueTipsOpen message:@"" preferredStyle:UIAlertControllerStyleAlert];
//            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
//            [alvc addAction:[UIAlertAction actionWithTitle:NewLocat_gotoSetWifi style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
//
////                BlueToolsOpenSetTipsVC *tipsvc = [[BlueToolsOpenSetTipsVC alloc]init];
////                [self.navigationController pushViewController:tipsvc animated:YES];
//            }]];
//            [self presentViewController:alvc animated:YES completion:nil];
//            [self showAlertViewWithTitle:BlueTipsOpen message:BlueTipsOpenWay1 cancelButtonTitle:root_OK];

        }
            break;
        case CBManagerStatePoweredOn:
        {
            NSLog(@"开启状态－可用状态");


        }
            break;
        default:
            break;
    }
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [BluetoolsManageVC instance].delegate = nil;
    [[BluetoolsManageVC instance] StopScanForPeripherals];
}

-(BOOL)compareVesionWithServerVersion:(NSString *)version compartStr:(NSString *)compStr{

    NSArray *versionArray = [version componentsSeparatedByString:@"."];//服务器返回版

    NSArray *currentVesionArray = [compStr componentsSeparatedByString:@"."];//当前版本

    NSInteger a = (versionArray.count> currentVesionArray.count)?currentVesionArray.count : versionArray.count;
    for (int i = 0; i< a; i++) {

        NSInteger a = [versionArray[i] integerValue];

        NSInteger b = [currentVesionArray[i] integerValue];

        if (a > b) {

            NSLog(@"有新版本");

            return YES;

        }else if(a < b){

            return NO;

        }
    }

        return NO;
        

}
@end
