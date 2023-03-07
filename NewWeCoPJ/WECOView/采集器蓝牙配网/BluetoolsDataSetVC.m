//
//  NewBiaoZhunModeNetWifiSetVC.m
//  ShinePhone
//
//  Created by CBQ on 2021/1/11.
//  Copyright © 2021 qwl. All rights reserved.
//

#import "BluetoolsDataSetVC.h"
#import <SystemConfiguration/CaptiveNetwork.h>//获取wifi名称
#import "BluetoolsMoreSetVC.h"
#import "BluetoolsManageVC.h"
#import "RedxCollectorWifiListView.h"
#import "RedxcollectorDownLoad.h"
//#import "NormalQuestionVC.h"
#import "WeNewOverView.h"

@interface BluetoolsDataSetVC ()<BluetoolsManageVCDelegate>
@property (nonatomic, strong)UITextField *wifiNameTF;
@property (nonatomic, strong)UITextField *wifiPswTF;
@property (nonatomic, strong)UIImageView *roadIMGV;
@property (nonatomic, strong)UILabel *precentLB;
@property (nonatomic, strong)UIView *settingView;
@property (nonatomic, strong)NSTimer *dataSetTimer;

@property (nonatomic, assign)BOOL isSuccess;
@property (nonatomic, assign)int addNumb;

@property (nonatomic, strong)NSTimer *runWifiIsConnect;

@property(nonatomic,strong) NSDictionary *TCPGetDataDic;
@property(nonatomic,assign) BOOL isConnect;
@property(nonatomic,assign) int connectNum;
@property(nonatomic,strong) UILabel *connWIFILB;
@property(nonatomic,assign) int getNetNum;
@property(nonatomic,assign) BOOL isresetSuccess;
@property (nonatomic, strong)NSArray *wifiListArr;
@property (nonatomic, strong)RedxCollectorWifiListView *wifiListView;
@property(nonatomic,assign) BOOL isAddtoSever;
@property(nonatomic,assign) BOOL isCanReConnect;
@property(nonatomic,assign) BOOL isHaveJump;
@property(nonatomic,strong) NSTimer *getNetTimer;
//@property(nonatomic,assign) BOOL isServerReset;

//分析失败在哪一步
@property(nonatomic,assign) BOOL failste1;//读取采集器wifi数据是否成功
@property(nonatomic,assign) BOOL failste2;//第一步设置采集器wifi是否返回成功
@property(nonatomic,assign) BOOL failste3;//第二步等待配置是否成功
@property(nonatomic,assign) BOOL failste4;//第三步成功后是否返回来60wifi的状态
@property (nonatomic, strong)NSString *wifiConnectFaile;//wifi连接状态失败

@property(nonatomic,assign) int disconnNumb;//蓝牙设备掉线次数
@property(nonatomic,assign) BOOL isbackStatus;

@property (nonatomic, strong)UIView *linew;
@property (nonatomic, strong)UIView *threeView;
@property (nonatomic, strong)UIImageView *StatuIMG;
@property (nonatomic, strong)UILabel *connLB;
@property (nonatomic, strong)UIButton *reConnectBtn;
@property (nonatomic, strong)UIView *failBgView;

@property (nonatomic, strong)NSString *isBackStr;
@property (nonatomic, assign)BOOL isFail;


@end

@implementation BluetoolsDataSetVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 建立连接
    [BluetoolsManageVC instance].delegate = self;
//    if (!_isConnect) {
//        [[CollectorTestTCP1 instance] connectToHost:@"192.168.10.100"];
//
//    }
    if (_roadIMGV) {
        [self RoationAnimationIMG];
       
    }
    _isHaveJump = NO;
    _isbackStatus = NO;
    _isBackStr = @"1";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = BL_TitleSetUP;
    _isConnect = YES;
    _connectNum = 0;
    _isSuccess = NO;
    _isresetSuccess = NO;
    _isAddtoSever = NO;
    _addNumb = 0;
    _getNetNum = 0;
    _isCanReConnect = NO;
    _isFail = NO;
//    _isServerReset = NO;

    //
    _failste1 = NO;
    _failste2 = NO;
    _failste3 = NO;
    _failste4 = NO;
    [self createScrollV];

//    [self biaozhunModeAUI];
//    if ([_wifiOrApMode isEqualToString:@"1"]) {
//        [self tcpGetData];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TCPDisConnect) name:@"COLLECTTCPDISCONNECT" object:nil];

//    }
    [self tcpGetData];
//    ENTERFOREGROUND1
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ENTERFOREGROUND) name:@"ENTERFOREGROUND1" object:nil];
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn addTarget:self action:@selector(questionClick) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImage:IMAGE(@"help233") forState:UIControlStateNormal];
//    [rightBtn sizeToFit]; // 手动计算大小
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:root_tools_1215 style:UIBarButtonItemStylePlain target:self action:@selector(ceshishengjiClick)];

    // Do any additional setup after loading the view.
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20*NOW_SIZE, 20*NOW_SIZE)];
    //设置UIButton的图像
//    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backButton setTitle:root_back forState:UIControlStateNormal];
    [backButton setTitleColor:colorblack_51 forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
}

//常见问题
- (void)questionClick{
    
//    NormalQuestionVC *norque = [[NormalQuestionVC alloc]init];
//    [self.navigationController pushViewController:norque animated:YES];
}
- (void)backItemClick{
    
    
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_isBack message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
    [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BluetoolsManageVC instance].delegate = nil;

        [[BluetoolsManageVC instance] disconnectToPeripheral];
        
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
    }]];
    
    [self presentViewController:alvc animated:YES completion:nil];

    
}

//进入前台
- (void)ENTERFOREGROUND{
    
    if (_settingView) {
        [self RoationAnimationIMG];

        [self dataSetConnect];
    }


}
- (void)wifigetList{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showProgressView];
        [[BluetoolsManageVC instance] connectToDev:@[@"75"] devType:@"WIFILIST"];//devtype为当前发送的命令标号

    });
    
}
- (void)tcpGetData{
    
    // 建立连接
//    [CollectorTestTCP1 instance].delegate = self;
    
    [self showProgressView];
//    if (_isConnect) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self showProgressView];
            //8序列号，56wifi名字，57wifi密码
            [[BluetoolsManageVC instance] connectToDev:@[@"56",@"57"] devType:@"wifi19"];//devtype为当前发送的命令标号
//        });
//    }
    
}


- (void)TCPSocketReadData:(NSDictionary *)dataDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideProgressView];
        NSInteger cmd = [[NSString stringWithFormat:@"%@", dataDic[@"cmd"]] integerValue];
        NSString *devtype = [NSString stringWithFormat:@"%@", dataDic[@"devType"]];

        if (cmd == 19 && [devtype isEqualToString:@"wifi19"]) {
            // 记录全部参数

            _TCPGetDataDic = dataDic;
            self.wifiNameTF.text = [NSString stringWithFormat:@"%@",dataDic[@"56"]];
            NSString *wifiname = [RedxcollectorDownLoad fetchSSIDInfo];
            if (kStringIsEmpty(self.wifiNameTF.text)) {
                if (kStringIsEmpty(wifiname)) {
                    self.wifiNameTF.text = @"";

                }else{
                    self.wifiNameTF.text = wifiname;

                }
            }
            self.wifiPswTF.text = [NSString stringWithFormat:@"%@",dataDic[@"57"]];
            if (kStringIsEmpty(self.wifiPswTF.text)) {
                self.wifiPswTF.text = @"";
            }
            
        }
        if (cmd == 19 && [devtype isEqualToString:@"wifiSuccess19"]) {
            
            // 记录全部参数
            _TCPGetDataDic = dataDic;
            self.wifiNameTF.text = [NSString stringWithFormat:@"%@",dataDic[@"56"]];
            if (kStringIsEmpty(self.wifiNameTF.text)) {
                self.wifiNameTF.text = @"";
            }
            self.wifiPswTF.text = [NSString stringWithFormat:@"%@",dataDic[@"57"]];
            if (kStringIsEmpty(self.wifiPswTF.text)) {
                self.wifiPswTF.text = @"";
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //        [self showProgressView];
                   //重启32

                [[BluetoolsManageVC instance] connectToDev:@[@"55"] devType:@"ConnectStatus"];//蓝牙读取设置是否成功
//                        _isChongQiSuccess = YES;
                if (self.getNetTimer) {
                                    [self.getNetTimer invalidate];
                                    self.getNetTimer = nil;
                                }
                  self.getNetTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getConnectState) userInfo:nil repeats:YES];
            });
        }
        if (cmd == 19 && [devtype isEqualToString:@"ConnectStatus"]) {//读取连接状态
            
//            NSLog(@"读取的状态:%@",[NSString stringWithFormat:@"%@",dataDic[@"55"]]);
            self.isbackStatus = YES;
            
                
            NSString *wifiStatus = [NSString stringWithFormat:@"%@",dataDic[@"55"]];
            NSLog(@"wifi状态:%@",wifiStatus);
            if (kStringIsEmpty(wifiStatus) || wifiStatus.length == 0) {
                return;
            }
            if ([wifiStatus isEqualToString:@"255"]) {//采集器在配置，继续查询
                
                if(_isCanReConnect){
                    if (self.getNetTimer) {
                        [self.getNetTimer invalidate];
                        self.getNetTimer = nil;
                    }
                    
                }
                
                
                return;
            }
            

//            if (self.getNetTimer) {
//                [self.getNetTimer invalidate];
//                self.getNetTimer = nil;
//            }
            _isresetSuccess = NO;
            
                if ([wifiStatus isEqualToString:@"0"]) {
                    
                    _failste1 = YES;//

//                    _isSuccess = YES;

//                    self.settingView.hidden = YES;
//                    [self gotoSuccessVC];
                    
                    if (self.getNetTimer) {
                        [self.getNetTimer invalidate];
                        self.getNetTimer = nil;
                    }
                    self.getNetTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getIsConnectToServer) userInfo:nil repeats:YES];//读取是否连接上服务器状态

                }else{

                    _isSuccess = NO;
//                    self.settingView.hidden = YES;
                    [_dataSetTimer invalidate];
                    _dataSetTimer = nil;
                    
//                    [self showAlertViewWithTitle:@"设置的wifi连接错误" message:@"请检查设置的wifi名称或者密码是否正确并重新配置" cancelButtonTitle:root_OK];
                    if ([wifiStatus isEqualToString:@"201"]) {
                        _wifiConnectFaile = wifiStatus;//@"路由名字错误";
                    }
                    if ([wifiStatus isEqualToString:@"204"]) {
                        _wifiConnectFaile = wifiStatus;//@"路由密码错误";

                    }
                    [self gotoFaileVC];

                }
        }
        
        if (cmd == 19 && [devtype isEqualToString:@"WIFILIST"]) {//75wifi列表
            
            NSArray *wifilistArr = dataDic[@"75"];
            _wifiListArr = wifilistArr;
            if (_wifiListArr.count > 0) {
                _wifiListView.dataSource = _wifiListArr;
                [_wifiListView.table reloadData];
            }
           
            NSLog(@"wifi列表:%@",wifilistArr);
        }
        if (cmd == 19 && [devtype isEqualToString:@"ConnectServerState"]) {//读取连接状态
            
            self.isbackStatus = YES;
            NSString *wifiStatus = [NSString stringWithFormat:@"%@",dataDic[@"60"]];
            NSLog(@"wifi状态:%@",wifiStatus);
            if (kStringIsEmpty(wifiStatus) || wifiStatus.length == 0) {
                return;
            }
            if (![wifiStatus isEqualToString:@"4"] && ![wifiStatus isEqualToString:@"16"]) {//采集器在配置，继续查询
                
                
                return;
            }
            _failste2 = YES;

            _isSuccess = YES;
            
            //保存服务器返回来的密钥
            NSString *authStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"AUTHKEYSTR"];

            if (!kStringIsEmpty(authStr)) {
                NSDictionary *datadic = @{@"54":authStr};
                [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"AUTHkeySet"];//发送密钥
            }else{
                
                NSDictionary *datadic = @{@"32":@"1"};
                [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"chongqi32"];
                
                if (self.getNetTimer) {
                    [self.getNetTimer invalidate];
                    self.getNetTimer = nil;
                }
//                self.settingView.hidden = YES;
                [self gotoSuccessVC];
            }
                        
            
        }
        


    });
}

//蓝牙读取设置是否成功
- (void)getConnectState{
    
    if (self.isbackStatus) {
        self.isbackStatus = NO;
        [[BluetoolsManageVC instance] connectToDev:@[@"55"] devType:@"ConnectStatus"];
    }
    
    
}

//蓝牙读取连接服务器设置是否成功
- (void)getIsConnectToServer{
    //已经失败了就关闭
    if (_isFail) {
        if (self.getNetTimer) {
            [self.getNetTimer invalidate];
            self.getNetTimer = nil;
        }
        
    }else{
        if (self.isbackStatus) {
            self.isbackStatus = NO;
            [[BluetoolsManageVC instance] connectToDev:@[@"60"] devType:@"ConnectServerState"];
        }
    }
    
    
    
}

// 是否操作成功
- (void)TCPSocketActionSuccess:(BOOL)isSuccess CMD:(int)cmd devtype:(nonnull NSString *)devtype{
    dispatch_async(dispatch_get_main_queue(), ^{

    [self hideProgressView];
   
    
    if (cmd == 18 && [devtype isEqualToString:@"AUTHkeySet"]) {//设置密钥成功
        
        NSDictionary *datadic = @{@"32":@"1"};
        [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"chongqi32"];
        
        if (self.getNetTimer) {
            [self.getNetTimer invalidate];
            self.getNetTimer = nil;
        }
//        self.settingView.hidden = YES;
        [self gotoSuccessVC];
    }
        
    if (cmd == 18 && [devtype isEqualToString:@"wifi18"]) {

        NSLog(@"设置wifi账号密码成功");
        [[BluetoolsManageVC instance] connectToDev:@[@"56",@"57"] devType:@"wifiSuccess19"];
        
        
    }
    if (cmd == 18 && [devtype isEqualToString:@"chongqi32"]) {
        
        NSLog(@"重置成功");
        _isresetSuccess = YES;
        
    }
    
//    if (!isSuccess) {
//        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_device_246 message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *okaction = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:nil];
//        [alvc addAction:okaction];
//        [self presentViewController:alvc animated:YES completion:nil];
//    }
    NSLog(@"TCPSocketActionSuccess cmd: **%ld**", (long)cmd);
    });


}



-(void)viewWillDisappear:(BOOL)animated{
    
    [_dataSetTimer invalidate];
    [_runWifiIsConnect invalidate];

}
//- (void)biaozhunModeAUI{
//
//    NSArray *numArr = @[@"2",@"3",@"4"];
//    CGFloat labelWide = 35*HEIGHT_SIZE;
//    CGFloat spacewide = (kScreenWidth - 3*35*HEIGHT_SIZE)/3;
//    for (int i = 0; i < numArr.count; i++) {
//
//
//        if (i == 1) {
//            UIView *firstStV = [[UIView alloc]initWithFrame:CGRectMake(spacewide/2 + (labelWide + spacewide)*i-5*HEIGHT_SIZE, 10*HEIGHT_SIZE, 45*HEIGHT_SIZE, 45*HEIGHT_SIZE)];
//            firstStV.backgroundColor = [UIColor colorWithRed:55/255.0 green:143/255.0 blue:250/255.0 alpha:0.2];
//            firstStV.layer.cornerRadius = 22*HEIGHT_SIZE;
//            firstStV.layer.masksToBounds = YES;
//            [self.view addSubview:firstStV];
//        }
//        UILabel *firstLB0 = [[UILabel alloc]initWithFrame:CGRectMake(spacewide/2 + (labelWide + spacewide)*i, 15*HEIGHT_SIZE, 35*HEIGHT_SIZE, 35*HEIGHT_SIZE)];
//        firstLB0.backgroundColor = colorGary;
//        firstLB0.layer.cornerRadius = 35*HEIGHT_SIZE/2;
//        firstLB0.layer.masksToBounds = YES;
//        firstLB0.textAlignment = NSTextAlignmentCenter;
//        firstLB0.font = FontSize(14*HEIGHT_SIZE);
//        firstLB0.text = numArr[i];
//        firstLB0.textColor = WhiteColor;
//        [self.view addSubview:firstLB0];
//
//        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstLB0.frame), firstLB0.frame.origin.y+firstLB0.frame.size.height/2-0.5*HEIGHT_SIZE/2, spacewide, 1*HEIGHT_SIZE)];
////        [self drawDashLine:lineV lineLength: spacewide lineSpacing:2*NOW_SIZE lineColor:colorblack_186];
//        lineV.backgroundColor = colorblack_186;
//        [self.view addSubview:lineV];
//        if (i == 0) {
//            UIView *lineV0 = [[UIView alloc]initWithFrame:CGRectMake(0, firstLB0.frame.origin.y+firstLB0.frame.size.height/2-0.5*HEIGHT_SIZE/2, spacewide/2, 1*HEIGHT_SIZE)];
//            lineV0.backgroundColor = buttonColor;
//            [self.view addSubview:lineV0];
//            lineV.backgroundColor = buttonColor;
//            firstLB0.backgroundColor = buttonColor;
//        }
//        if (i == numArr.count - 1) {
////            lineV.frame = CGRectMake(CGRectGetMaxX(firstLB0.frame), firstLB0.frame.origin.y+firstLB0.frame.size.height/2-0.5*HEIGHT_SIZE/2, spacewide/2, 1*HEIGHT_SIZE);
//            [lineV removeFromSuperview];
//        }
//
//        if (i == 1) {
//            firstLB0.backgroundColor = buttonColor;
//            UILabel *firstntipsLB = [[UILabel alloc]initWithFrame:CGRectMake(50*NOW_SIZE, CGRectGetMaxY(firstLB0.frame)+3*HEIGHT_SIZE, kScreenWidth - 100*NOW_SIZE, 25*HEIGHT_SIZE)];
//            firstntipsLB.text = NewAPSet_APNetSetTips;
//            firstntipsLB.font = FontSize(12*HEIGHT_SIZE);
//            firstntipsLB.adjustsFontSizeToFitWidth = YES;
//            firstntipsLB.textAlignment = NSTextAlignmentCenter;
//            firstntipsLB.textColor = colorblack_102;
//            [self.view addSubview:firstntipsLB];
//        }
//
//    }
//    [self createScrollV];
//}

- (void)createScrollV{
    
    UILabel *tipslb1 = [self goToInitLable:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 25*HEIGHT_SIZE) textName:BL_Tips1 textColor:colorBlack fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.view addSubview:tipslb1];
    UILabel *tipslb2 = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipslb1.frame), kScreenWidth-20*NOW_SIZE, 20*HEIGHT_SIZE) textName:BL_Tips2 textColor:colorblack_186 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.view addSubview:tipslb2];
    
    
    UIImageView *imgv = [self goToInitImageView:CGRectMake(kScreenWidth/2-15*HEIGHT_SIZE,CGRectGetMaxY(tipslb2.frame)+10*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"wifiEB55"];
    [self.view addSubview:imgv];
    UILabel *tipslb3 = [self goToInitLable:CGRectMake(kScreenWidth/2-25*HEIGHT_SIZE, CGRectGetMaxY(imgv.frame), 50*HEIGHT_SIZE, 40*HEIGHT_SIZE) textName:@"EB55\n2.4G" textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    tipslb3.numberOfLines = 0;
    [self.view addSubview:tipslb3];
    
    UIImageView *imgv22 = [self goToInitImageView:CGRectMake(kScreenWidth/2-15*HEIGHT_SIZE,CGRectGetMaxY(tipslb3.frame)+10*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) imageString:@"yesSelect"];
    [self.view addSubview:imgv22];
    
    UILabel *firstntipsLB = [[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE,CGRectGetMaxY(imgv22.frame)+10*HEIGHT_SIZE, kScreenWidth - 100*NOW_SIZE, 25*HEIGHT_SIZE)];
    firstntipsLB.text = [NSString stringWithFormat:@"%@:%@",root_buletouch_ssid,_wifiName];
    firstntipsLB.font = FontSize(13*HEIGHT_SIZE);
    firstntipsLB.adjustsFontSizeToFitWidth = YES;
//    firstntipsLB.textAlignment = NSTextAlignmentCenter;
    firstntipsLB.textColor = colorblack_154;
    [self.view addSubview:firstntipsLB];
    _connWIFILB = firstntipsLB;
    
    UIView *wifiView = [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(firstntipsLB.frame)+2*HEIGHT_SIZE, kScreenWidth - 40*NOW_SIZE, 100*HEIGHT_SIZE)];
    wifiView.layer.cornerRadius = 10*HEIGHT_SIZE;
    wifiView.layer.masksToBounds = YES;
    wifiView.backgroundColor = backgroundNewColor;
    [self.view addSubview:wifiView];
    
    UITextField *wifinametf = [[UITextField alloc]initWithFrame:CGRectMake(0,5*HEIGHT_SIZE, wifiView.frame.size.width, 40*HEIGHT_SIZE)];
    wifinametf.textColor = colorblack_51;
    wifinametf.adjustsFontSizeToFitWidth = YES;
    wifinametf.placeholder = root_wifi_ssid;
//    wifinametf.text = self.wifiName;
//    wifinametf.layer.borderWidth = 0.6*NOW_SIZE;
//    wifinametf.layer.borderColor = colorblack_154.CGColor;
    [wifiView addSubview:wifinametf];
    _wifiNameTF = wifinametf;
    
    UIView *lefv = [[UIView alloc]initWithFrame:CGRectMake(0, 0,40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
    
    UIImageView *wifiimg = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    wifiimg.image= IMAGE(@"Icon_wifi");
    [lefv addSubview:wifiimg];
    wifinametf.leftViewMode = UITextFieldViewModeAlways;
    wifinametf.leftView = lefv;
    
    UIView *righv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];
    UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wifinameClick)];
    [righv addGestureRecognizer:tapg];
    
    UIImageView *downimg = [[UIImageView alloc]initWithFrame:CGRectMake(10*HEIGHT_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    downimg.image = IMAGE(@"wifiListdown");
    downimg.userInteractionEnabled = YES;
    [righv addSubview:downimg];
    
//    UIButton *downBtn = [[UIButton alloc]initWithFrame:CGRectMake(10*HEIGHT_SIZE, 10*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
//    [downBtn setImage:IMAGE(@"wifiListdown") forState:UIControlStateNormal];
//    downBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//    downBtn.titleLabel.font = FontSize(13*HEIGHT_SIZE);
//    [downBtn setTitleColor:buttonColor forState:UIControlStateNormal];
//    [downBtn addTarget:self action:@selector(wifinameClick) forControlEvents:UIControlEventTouchUpInside];
//    [righv addSubview:downBtn];
    wifinametf.rightView = righv;
    wifinametf.rightViewMode = UITextFieldViewModeAlways;

    
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(wifinametf.frame), wifiView.frame.size.width, 0.6*HEIGHT_SIZE)];
    linev.backgroundColor = WhiteColor;
    [wifiView addSubview:linev];
    //密码
    UITextField *passwtf = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(linev.frame)+5*HEIGHT_SIZE, wifiView.frame.size.width, 40*HEIGHT_SIZE)];
    passwtf.textColor = colorblack_51;
    passwtf.adjustsFontSizeToFitWidth = YES;
    passwtf.placeholder = root_wifi_key;
//    passwtf.layer.borderWidth = 0.6*NOW_SIZE;
//    passwtf.layer.borderColor = colorblack_154.CGColor;
    [wifiView addSubview:passwtf];
    _wifiPswTF = passwtf;
    
    UIView *lefv22 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];

    UIImageView *wifiimg22 = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    wifiimg22.image= IMAGE(@"Icon_password");
    [wifiView addSubview:wifiimg22];
    [lefv22 addSubview:wifiimg22];
    passwtf.leftView = lefv22;
    passwtf.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *righv22 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*HEIGHT_SIZE, 40*HEIGHT_SIZE)];

    UIButton *passwBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*HEIGHT_SIZE,5*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [passwBtn setImage:IMAGE(@"Icon_signin_see") forState:UIControlStateNormal];
    [passwBtn addTarget:self action:@selector(downBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [righv22 addSubview:passwBtn];
    passwtf.rightView = righv22;
    passwtf.rightViewMode = UITextFieldViewModeAlways;
    
    
//    if ([_wifiOrApMode isEqualToString:@"0"]) {//标准模式提示
//
//        UILabel *tipsLB = [[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(wifiView.frame)+10*HEIGHT_SIZE, kScreenWidth - 40*NOW_SIZE,60*HEIGHT_SIZE)];
//        tipsLB.text = @"温馨提示:\n1.路由器名字和密码支持数字/字母/英文标点符号 \n2.路由器名字和密码不支持空格符号和以下符号:€%¥﹉…•'\\\"\"";
//        tipsLB.font = FontSize(14*HEIGHT_SIZE);
//        tipsLB.adjustsFontSizeToFitWidth = YES;
//        tipsLB.numberOfLines = 0;
//        tipsLB.textColor = colorblack_102;
//        [self.view addSubview:tipsLB];
//    }
    
//    if ([_wifiOrApMode isEqualToString:@"1"]) {//AP模式
        
    UIButton *SetBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE, CGRectGetMaxY(wifiView.frame) + 30*HEIGHT_SIZE,kScreenWidth - 80*NOW_SIZE, 30*HEIGHT_SIZE)];
    [SetBtn setTitle:[NSString stringWithFormat:@"%@>",root_MAX_286] forState:UIControlStateNormal];
    [SetBtn setTitleColor:buttonColor forState:UIControlStateNormal];
    SetBtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    SetBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
//        SetBtn.layer.cornerRadius = 15*HEIGHT_SIZE;
//        SetBtn.layer.masksToBounds = YES;
    [SetBtn addTarget:self action:@selector(SetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SetBtn];
//    }

    
    
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE, CGRectGetMaxY(SetBtn.frame)+20*HEIGHT_SIZE,kScreenWidth - 80*NOW_SIZE, 40*HEIGHT_SIZE)];
    [nextBtn setTitle:NewAPSet_APModeNowSet forState:UIControlStateNormal];
    [nextBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    nextBtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    nextBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    nextBtn.backgroundColor = buttonColor;
    nextBtn.layer.cornerRadius = 20*HEIGHT_SIZE;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
}


//点击获取wifi名字
- (void)wifinameClick{
    
   
    
  
        if (!_wifiListView) {
            _wifiListView = [[RedxCollectorWifiListView alloc]initWithFrame:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(_connWIFILB.frame)+2*HEIGHT_SIZE+6*HEIGHT_SIZE + 40*HEIGHT_SIZE, kScreenWidth - 40*NOW_SIZE, kScreenHeight - (CGRectGetMaxY(_connWIFILB.frame)+2*HEIGHT_SIZE+6*HEIGHT_SIZE + 40*HEIGHT_SIZE) - kNavBarHeight - 25*HEIGHT_SIZE)];
//            _wifiListView.layer.cornerRadius = 10*HEIGHT_SIZE;
//            _wifiListView.layer.masksToBounds = YES;
            _wifiListView.backgroundColor = backgroundNewColor;
            [self.view addSubview:_wifiListView];
            _wifiListView.hidden = NO;
            __weak typeof(self) weakself = self;
        
            _wifiListView.backwifi = ^(NSString * _Nonnull backStr) {
                
                weakself.wifiNameTF.text = backStr;
                if (kStringIsEmpty(backStr)) {
                    weakself.wifiNameTF.text = @"";
                }
                weakself.wifiPswTF.text = @"";
            };
            
        }else{
          
            _wifiListView.hidden = !_wifiListView.hidden;
        }
       
        
    if (!_wifiListView.hidden) {
        
        if(_wifiListArr.count > 0){
            [self hideProgressView];
            
        }else{
            
            [self showProgressView];
        }
        
        
        [[BluetoolsManageVC instance] connectToDev:@[@"75"] devType:@"WIFILIST"];//devtype为当前发送的命令标号
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hideProgressView];
        });

    }

    
}

//密码
- (void)downBtnclick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = self.wifiPswTF.text;
        self.wifiPswTF.text = @""; // 这句代码可以防止切换的时候光标偏移
        self.wifiPswTF.secureTextEntry = NO;
        self.wifiPswTF.text = tempPwdStr;
        
    } else { // 暗文
        
        NSString *tempPwdStr = self.wifiPswTF.text;
        self.wifiPswTF.text = @"";
        self.wifiPswTF.secureTextEntry = YES;
        self.wifiPswTF.text = tempPwdStr;
    }
}

//高级设置
- (void)SetBtnClick{
//    if (!_isConnect) {
//        [[CollectorTestTCP1 instance] connectToHost:@"192.168.10.100"];
//
//    }
    BluetoolsMoreSetVC *apsetVC = [[BluetoolsMoreSetVC alloc]init];
    apsetVC.password = @"123456";
//    apsetVC.whereIN = _whereIN;
    apsetVC.SNStr = _SnString;
    [self.navigationController pushViewController:apsetVC animated:YES];
}

//立即配置
- (void)nextBtnClick{
    
    if (_wifiNameTF.text.length == 0) {
        [self showToastViewWithTitle:root_wifiSet_563];
        return;
    }
    if (_wifiPswTF.text.length == 0) {
        [self showToastViewWithTitle:root_peizhi_shinewifi_shuru_wifi_mima];
        return;
    }
    if ([self isHaveIllegalChar:_wifiNameTF.text]) {
        [self showAlertViewWithTitle:root_tlx_set_654 message:@"" cancelButtonTitle:root_OK];
        return;
    }
    if ([self isHaveIllegalChar:_wifiPswTF.text]) {
        [self showAlertViewWithTitle:root_tlx_set_654 message:@"" cancelButtonTitle:root_OK];
        return;
    }
    if (_settingView) {
        
     [_settingView removeFromSuperview];
        
    }
    
    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    loadingView.backgroundColor = WhiteColor;
    [self.view addSubview:loadingView];
    _settingView = loadingView;
    
    UILabel *conntipslb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 30*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"Connecting..." textColor:colorBlack fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_settingView addSubview:conntipslb];
    
    UILabel *conntipslb2 = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(conntipslb.frame), kScreenWidth-40*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"Please wait a moment" textColor:colorblack_154 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_settingView addSubview:conntipslb2];
    
    UIView *firVie = [self goToInitView:CGRectMake(kScreenWidth/2-10*HEIGHT_SIZE-100*NOW_SIZE-20*HEIGHT_SIZE, CGRectGetMaxY(conntipslb2.frame)+40*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) backgroundColor:WhiteColor];
    firVie.layer.cornerRadius = 10*HEIGHT_SIZE;
    firVie.layer.masksToBounds = YES;
    firVie.layer.borderColor = colorBlack.CGColor;
    firVie.layer.borderWidth = 2*HEIGHT_SIZE;
    [_settingView addSubview:firVie];
    
    UIView *ling1V = [self goToInitView:CGRectMake(CGRectGetMaxX(firVie.frame), firVie.xmg_y + (firVie.xmg_height-1*HEIGHT_SIZE)/2, 100*HEIGHT_SIZE, 1*HEIGHT_SIZE) backgroundColor:colorBlack];
    [_settingView addSubview:ling1V];
    
    UIView *twoVie = [self goToInitView:CGRectMake(CGRectGetMaxX(ling1V.frame), CGRectGetMaxY(conntipslb2.frame)+40*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) backgroundColor:WhiteColor];
    twoVie.layer.cornerRadius = 10*HEIGHT_SIZE;
    twoVie.layer.masksToBounds = YES;
    twoVie.layer.borderColor = colorBlack.CGColor;
    twoVie.layer.borderWidth = 2*HEIGHT_SIZE;
    [_settingView addSubview:twoVie];
    
    UIView *ling2V = [self goToInitView:CGRectMake(CGRectGetMaxX(twoVie.frame), firVie.xmg_y + (firVie.xmg_height-1*HEIGHT_SIZE)/2, 100*HEIGHT_SIZE, 1*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [_settingView addSubview:ling2V];
    _linew = ling2V;
    
    UIView *threeVie = [self goToInitView:CGRectMake(CGRectGetMaxX(ling2V.frame), CGRectGetMaxY(conntipslb2.frame)+40*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    threeVie.layer.cornerRadius = 10*HEIGHT_SIZE;
    threeVie.layer.masksToBounds = YES;
//    threeVie.layer.borderColor = colorBlack.CGColor;
//    threeVie.layer.borderWidth = 2*HEIGHT_SIZE;
    [_settingView addSubview:threeVie];
    _threeView = threeVie;
    
    
    CGSize imgsiz = IMAGE(@"WeConnectIMG").size;
    CGFloat imgHeig2 = (imgsiz.height*100*NOW_SIZE)/imgsiz.height;
    UIImageView *conIMGV = [self goToInitImageView:CGRectMake(kScreenWidth/2-50*NOW_SIZE, CGRectGetMaxY(firVie.frame)+50*HEIGHT_SIZE, 100*NOW_SIZE, imgHeig2) imageString:@"WeConnectIMG"];
    [_settingView addSubview:conIMGV];
    _StatuIMG = conIMGV;
    
    
//    UIView *setvie = [[UIView alloc]initWithFrame:CGRectMake(40*NOW_SIZE, (kScreenHeight - kNavBarHeight)/2 - 160*HEIGHT_SIZE/2, kScreenWidth - 80*NOW_SIZE, 160*HEIGHT_SIZE)];
//    setvie.backgroundColor = WhiteColor;
//    setvie.layer.cornerRadius = 10*HEIGHT_SIZE;
//    setvie.layer.masksToBounds = YES;
//    [loadingView addSubview:setvie];
    
    UIImageView *roadIMG = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40*NOW_SIZE, CGRectGetMaxY(conIMGV.frame)+5*HEIGHT_SIZE+(20*HEIGHT_SIZE-10*HEIGHT_SIZE)/2, 10*NOW_SIZE, 10*NOW_SIZE)];
    roadIMG.image = IMAGE(@"peizhizhong");
    [_settingView addSubview:roadIMG];
    _roadIMGV = roadIMG;
    
    UILabel *tipslb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(roadIMG.frame)+5*NOW_SIZE, CGRectGetMaxY(conIMGV.frame)+5*HEIGHT_SIZE, kScreenWidth-CGRectGetMaxX(roadIMG.frame)-20*NOW_SIZE, 20*HEIGHT_SIZE)];
    tipslb.adjustsFontSizeToFitWidth = YES;
    tipslb.font = FontSize(12*HEIGHT_SIZE);
//    tipslb.textAlignment = NSTextAlignmentCenter;
    tipslb.textColor = colorblack_154;
    tipslb.text = @"Connecting...";
    [_settingView addSubview:tipslb];
    _connLB = tipslb;
    
    UILabel *pres = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50*NOW_SIZE, CGRectGetMaxY(roadIMG.frame)+3*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
    pres.adjustsFontSizeToFitWidth = YES;
    pres.font = FontSize(16*HEIGHT_SIZE);
    pres.textAlignment = NSTextAlignmentCenter;
    pres.textColor = buttonColor;
    pres.text = @"0%";
    [_settingView addSubview:pres];
    _precentLB = pres;
    _addNumb = 0;
    _dataSetTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(datatimesetAdd) userInfo:nil repeats:YES];
    
    
    UIButton *reNetBtn = [self goToInitButton:CGRectMake(10*NOW_SIZE, kScreenHeight-50*HEIGHT_SIZE-45*HEIGHT_SIZE-kNavBarHeight, kScreenWidth-20*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Rewiring the network" selImgString:@"" norImgString:@""];
    reNetBtn.backgroundColor = buttonColor;
    reNetBtn.layer.cornerRadius = 10*HEIGHT_SIZE;
    reNetBtn.layer.masksToBounds = YES;
    [reNetBtn addTarget:self action:@selector(renetClick) forControlEvents:UIControlEventTouchUpInside];
    [_settingView addSubview:reNetBtn];
    _reConnectBtn = reNetBtn;
    reNetBtn.hidden = YES;
   
    [self dataSetConnect];
    [self RoationAnimationIMG];
    
}

//重新配网
- (void)renetClick{
    _isCanReConnect = NO;
    [self nextBtnClick];
    
}
//判断字符
- (BOOL)isHaveIllegalChar:(NSString *)str{
    
    for (int i = 0; i < str.length; i++) {
        NSString *ch = [str substringWithRange:NSMakeRange(i, 1)];
        NSString * regex = @"^[A-Za-z0-9]$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:ch];
        if (isMatch) {
            continue;
        }else{
            NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@".,?!:@;+=#/()_-`^*&..$<>[]{}"];
            NSRange range = [ch rangeOfCharacterFromSet:doNotWant];
            if (range.location<ch.length) {
                continue;
            }else{
                return YES;

            }
        }
    }
    return NO;
    
//    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"€%¥﹉…•'\\\"\""];
//    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
//    return range.location<str.length;


}

//旋转图片
- (void)RoationAnimationIMG{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 5000;
    [_roadIMGV.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
//设置参数
- (void)dataSetConnect{
         
    
            NSDictionary *datadic = @{@"56":_wifiNameTF.text,@"57":_wifiPswTF.text};
            [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"wifi18"];

    
}
//倒计时
- (void)datatimesetAdd{
    
    _addNumb ++;
    if (_addNumb > 99) {
//        _settingView.hidden = YES;
        [_dataSetTimer invalidate];
        _dataSetTimer = nil;
        if (!_isSuccess) {
            [self gotoFaileVC];
        }else{
            [self gotoSuccessVC];
        }
    }
    if (_isSuccess) {
        if (_addNumb > 70) {
            
//            _settingView.hidden = YES;
            [_dataSetTimer invalidate];
            _dataSetTimer = nil;
            [self gotoSuccessVC];

        }
    }

    _precentLB.text = [NSString stringWithFormat:@"%d%%",_addNumb];


}

//跳转设置成功界面
- (void)gotoSuccessVC{
//    if (_isHaveJump) {
//        return;
//    }else{
//
//        _isHaveJump = YES;
//    }
    [[BluetoolsManageVC instance] disconnectToPeripheral];
//    [self addDeviceNet];
    
    self.linew.backgroundColor = colorBlack;
    self.threeView.backgroundColor = WhiteColor;
    self.threeView.layer.borderColor = colorBlack.CGColor;
    self.threeView.layer.borderWidth = 2*HEIGHT_SIZE;
    self.StatuIMG.image = IMAGE(@"connSuccess");
    self.roadIMGV.hidden = YES;
    self.precentLB.hidden = YES;

    self.connLB.frame = CGRectMake(40*NOW_SIZE, CGRectGetMaxY(_StatuIMG.frame)+30*HEIGHT_SIZE, _settingView.xmg_width-80*NOW_SIZE, 40*HEIGHT_SIZE);

    self.connLB.text = @"Success";
    self.connLB.font = FontSize(24*HEIGHT_SIZE);
    if ([UIFont fontWithName:@"HelveticaNeue-Bold" size:24.f]) {
        self.connLB.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.f];
    }
    self.connLB.textAlignment = NSTextAlignmentCenter;
    _reConnectBtn.hidden = YES;
    
    
    
//    connSuccess
    [self showProgressView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self hideProgressView];
        
        for (UIViewController *homevc in self.navigationController.viewControllers) {

            if([homevc isKindOfClass:[WeNewOverView class]]){

                [self.navigationController popToViewController:homevc animated:YES];
            }
        }
    });

}



//跳转失败界面
- (void)gotoFaileVC{

    _isFail = YES;
    self.StatuIMG.image = IMAGE(@"WeNetSetFail");
    self.roadIMGV.hidden = YES;
    self.precentLB.hidden = YES;
    self.isCanReConnect = YES;
    
    self.connLB.frame = CGRectMake(40*NOW_SIZE, CGRectGetMaxY(_StatuIMG.frame)+10*HEIGHT_SIZE, _settingView.xmg_width-80*NOW_SIZE, 40*HEIGHT_SIZE);

    self.connLB.text = @"Failure";
    self.connLB.font = FontSize(24*HEIGHT_SIZE);
    self.connLB.textColor = colorBlack;
    if ([UIFont fontWithName:@"HelveticaNeue-Bold" size:24.f]) {
        self.connLB.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.f];
    }
    self.connLB.textAlignment = NSTextAlignmentCenter;
    _reConnectBtn.hidden = NO;

    [self createSeachFailUI:@"0"];
}






//添加设备
- (void)addDeviceNet{
    

        
    [self showProgressView];//_deviceNetDic
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/addDatalog" parameters:@{@"datalogSn":_SnString,@"plantId":_stationID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                self.linew.backgroundColor = colorBlack;
                self.threeView.backgroundColor = WhiteColor;
                self.threeView.layer.borderColor = colorBlack.CGColor;
                self.threeView.layer.borderWidth = 2*HEIGHT_SIZE;
                self.StatuIMG.image = IMAGE(@"connSuccess");
                self.roadIMGV.hidden = YES;
                self.precentLB.hidden = YES;

                self.connLB.frame = CGRectMake(40*NOW_SIZE, CGRectGetMaxY(_StatuIMG.frame)+30*HEIGHT_SIZE, _settingView.xmg_width-80*NOW_SIZE, 40*HEIGHT_SIZE);

                self.connLB.text = @"Success";
                self.connLB.font = FontSize(24*HEIGHT_SIZE);
                if ([UIFont fontWithName:@"HelveticaNeue-Bold" size:24.f]) {
                    self.connLB.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.f];
                }
                self.connLB.textAlignment = NSTextAlignmentCenter;
                _reConnectBtn.hidden = YES;

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
}

- (void)createSeachFailUI:(NSString *)typestr{
    [self hideProgressView];
    
    
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    
    if (![_isBackStr isEqualToString:@"1"]) {
        
        return;
    }
    
    UIView *failBgview = [self goToInitView:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backgroundColor:COLOR(0, 0, 0, 0.4)];
    [KEYWINDOW addSubview:failBgview];
    _failBgView = failBgview;
    
    UIView *toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-240*HEIGHT_SIZE,kScreenWidth,270*HEIGHT_SIZE)];
    toolsView.layer.cornerRadius = 20*HEIGHT_SIZE;
    toolsView.layer.masksToBounds = YES;
    toolsView.backgroundColor = [UIColor whiteColor];
    [_failBgView addSubview:toolsView];

//    float buttonW=50;
//    CGSize size = CGSizeMake(buttonW, buttonW);
    
    
    UIImageView *tipsIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-25*HEIGHT_SIZE, 10*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
    tipsIMGV.image = IMAGE(@"connectBLEFail");
    [toolsView addSubview:tipsIMGV];
    
    
    UILabel *scanLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipsIMGV.frame), kScreenWidth-20*NOW_SIZE, 50*HEIGHT_SIZE)];
    scanLB.text = @"Fail to network";
    scanLB.textAlignment = NSTextAlignmentCenter;
    scanLB.font = FontSize(14*HEIGHT_SIZE);
    scanLB.textColor = colorblack_154;
    scanLB.numberOfLines = 0;
    [toolsView addSubview:scanLB];
    
    if ([_wifiConnectFaile isEqualToString:@"201"]) {
        scanLB.text = @"Fail to network\nThe name of WiFi is incorrect,Please re-enter";

    }
    
    if ([_wifiConnectFaile isEqualToString:@"204"]) {
        scanLB.text = @"Fail to network\nThe password of WiFi is incorrect,Please re-enter";

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
    
    UIButton *photoButton = [[UIButton alloc]init];
    photoButton.frame = CGRectMake(CGRectGetMaxX(changeButton.frame)+5*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 40*HEIGHT_SIZE);
//    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [photoButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    [photoButton setImage:[UIImage imageNamed:@"WEPhotoScan"] forState:UIControlStateNormal];
    [photoButton setTitle:@"Try again" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    photoButton.backgroundColor = backgroundNewColor;
    photoButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    photoButton.layer.masksToBounds = YES;
    [toolsView addSubview:photoButton];
    
    
    
}
- (void)ManualInput{
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    [self hideProgressView];
    
    
        
    BOOL isback = NO;
    for (UIViewController *homevc in self.navigationController.viewControllers) {

        if([homevc isKindOfClass:[WeNewOverView class]]){

            isback = YES;
            [self.navigationController popToViewController:homevc animated:YES];
        }
    }

       
}
- (void)openPhoto{
    [self hideProgressView];
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    
    if (_settingView) {
        [_settingView removeFromSuperview];
        _settingView = nil;
    }
    _isFail = NO;
    [self nextBtnClick];

    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [_dataSetTimer invalidate];
    _dataSetTimer = nil;
    
    if (_getNetTimer) {
            [_getNetTimer invalidate];
            _getNetTimer = nil;
        }
    if(_failBgView){
        
        [_failBgView removeFromSuperview];
        _failBgView = nil;
    }
    _isBackStr = @"2";
}


@end
