//
//  BluetoolsSeachDevVC.m
//  ShinePhone
//
//  Created by CBQ on 2022/4/12.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "BluetoolsSeachDevVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoolsManageVC.h"
#import "BluetoolsDataSetVC.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
//#import "BluetoolsScanAddVC.h"
#import "CollectorUpdataFirstVC.h"
#import "BlueToolsOpenSetTipsVC.h"
@interface BluetoolsSeachDevVC ()<UITableViewDelegate,UITableViewDataSource,BluetoolsManageVCDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int connectRow;

@property (nonatomic, strong) UIButton *startChargeBtn;


@property (nonatomic, strong) NSMutableArray *deviceArray;
@property (nonatomic, strong) NSMutableArray *deviceNameArray;

@property (nonatomic, assign) BOOL isConnectBlue;
@property (nonatomic, strong) UIView *succeView;
@property (nonatomic, strong) UILabel *numbDevLB;
@property (nonatomic, strong) UIView *seachBgView;
@property (nonatomic, assign) BOOL isINDataVC;
@property(nonatomic,assign) BOOL isInVC;
@property (nonatomic, strong) NSTimer *isSeachTimer;
@property (nonatomic, assign) int seachTimeNumb;
@property (nonatomic, strong) UIView *seachFailBgView;
@property (nonatomic, assign) BOOL isCanCelUpdataBack;
@property (nonatomic, strong) NSString *isBagG;
@property(nonatomic,assign) BOOL firstINConnect;

@end

@implementation BluetoolsSeachDevVC



- (NSMutableArray *)deviceArray{
    if (!_deviceArray) {
        _deviceArray = [[NSMutableArray alloc]init];
    }
    return _deviceArray;
}

- (NSMutableArray *)deviceNameArray{
    if (!_deviceNameArray) {
        _deviceNameArray = [[NSMutableArray alloc]init];
    }
    return _deviceNameArray;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [BluetoolsManageVC instance].delegate = self;
    if (!_isCanCelUpdataBack) {
        
        self.isINDataVC = NO;
        self.isConnectBlue = NO;
        self.isInVC = NO;
        [self.deviceArray removeAllObjects];
        [self.deviceNameArray removeAllObjects];
        _connectRow = -1;
        [self.tableView reloadData];
        [[BluetoolsManageVC instance] disconnectToPeripheral];
        [self scanForPeripherals];
    }else{
        _isCanCelUpdataBack = NO;
        
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [BluetoolsManageVC instance].delegate = nil;
    [[BluetoolsManageVC instance] StopScanForPeripherals];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = BlueSetSeach;
    self.isCanCelUpdataBack = NO;
    self.firstINConnect = YES;
    [self createBluetoolsListUI];
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"blueScan") style:UIBarButtonItemStylePlain target:self action:@selector(scanBlueTools)];
    
    UIView *backvie = [self goToInitView:CGRectMake(0, 0, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) backgroundColor:[UIColor clearColor]];
    UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backclick)];
    [backvie addGestureRecognizer:tapg];
    UIImageView *backimgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, (backvie.xmg_height - 14*HEIGHT_SIZE)/2, 24*HEIGHT_SIZE, 18*HEIGHT_SIZE)];
    backimgv.userInteractionEnabled = YES;
    backimgv.contentMode = UIViewContentModeScaleToFill;
    backimgv.image = IMAGE(@"back");
    [backvie addSubview:backimgv];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backvie];
    
    // 搜索蓝牙设备
   
    // Do any additional setup after loading the view.
}

- (void)backclick{
//    [[BluetoolsManageVC instance] stopHeartBeat];
    [BluetoolsManageVC instance].delegate = nil;
    [[BluetoolsManageVC instance] disconnectToPeripheral];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scanBlueTools{
    
//    BluetoolsScanAddVC *scanvc = [[BluetoolsScanAddVC alloc]init];
//
//    [self.navigationController pushViewController:scanvc animated:YES];
//
//    scanvc.backValuBlock = ^(NSString * _Nonnull SNStr) {
//
//        BOOL isHaveBT = NO;
//        for (int i = 0; i < self.deviceArray.count; i++) {
//            CBPeripheral *peripheral = self.deviceArray[i];
//
//            NSDictionary *namdic =self.deviceNameArray[i];
//            NSString *bluename = namdic[@"name"];
//
//            if ([SNStr isEqualToString:bluename]) {
//                isHaveBT = YES;
//                self.connectRow = i;
//                // 连接 or 切换新设备
//                self.isBagG = namdic[@"Auth"];//判断连接的是g:  还是G:
//
//                [self conectionWithDevice:peripheral];
//                break;
//            }
//
//        }
//        if (!isHaveBT) {//没有此蓝牙设备
//            [self showAlertViewWithTitle:BlueSetNoneSeachDev message:BlueSetSeachTips cancelButtonTitle:root_OK];
//        }
//
//    };
//
}

- (void)createSeachUI{
    if (_seachBgView) {
        [_seachBgView removeFromSuperview];
    }
    
    UIView *bgview = [self goToInitView:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) backgroundColor:WhiteColor];
    [self.view addSubview:bgview];
    _seachBgView = bgview;
    
    FLAnimatedImageView*  gifView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(20*NOW_SIZE,bgview.xmg_height/2 - (kScreenWidth-40*NOW_SIZE)/2-kNavBarHeight,kScreenWidth-40*NOW_SIZE,  kScreenWidth-40*NOW_SIZE)];
    gifView.contentMode = UIViewContentModeScaleAspectFit;
    gifView.clipsToBounds = YES;
    gifView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"BTSeach" withExtension:@"gif"]]];
    [bgview addSubview:gifView];
 
    UILabel *tipslb = [self goToInitLable:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(gifView.frame)+30*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 30*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@...",BlueSetSeaching] textColor:colorblack_154 fontFloat:15*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [bgview addSubview:tipslb];
    
    _seachTimeNumb = 0;
    if (_isSeachTimer) {
        [_isSeachTimer invalidate];
        _isSeachTimer = nil;
    }
    _isSeachTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(isSeachDevice) userInfo:nil repeats:YES];
}
//搜索设备计时
- (void)isSeachDevice{
    
    _seachTimeNumb ++;
    if (_seachTimeNumb > 10) {
        [_isSeachTimer invalidate];
        _isSeachTimer = nil;
        [_seachBgView removeFromSuperview];
        [[BluetoolsManageVC instance] StopScanForPeripherals];
        [self createSeachFailUI];
    }
    
}
//搜索失败UI
- (void)createSeachFailUI{
    
    if (_seachFailBgView) {
        [_seachFailBgView removeFromSuperview];
    }
    
    UIView *bgview = [self goToInitView:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) backgroundColor:WhiteColor];
    [self.view addSubview:bgview];
    _seachFailBgView = bgview;
    
    UIImageView *tipsimgv = [self goToInitImageView:CGRectMake(kScreenWidth/2-60*HEIGHT_SIZE, 40*HEIGHT_SIZE, 120*HEIGHT_SIZE, 120*HEIGHT_SIZE) imageString:@"seachBlueFailIMG"];
    [bgview addSubview:tipsimgv];
    
    UILabel *connlb = [self goToInitLable:CGRectMake(30*NOW_SIZE, CGRectGetMaxY(tipsimgv.frame)+20*HEIGHT_SIZE, kScreenWidth-60*NOW_SIZE, 40*HEIGHT_SIZE) textName:BlueSetNoneSeachDev textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [bgview addSubview:connlb];
    
    UILabel *faillb = [self goToInitLable:CGRectMake(30*NOW_SIZE, CGRectGetMaxY(connlb.frame)+20*HEIGHT_SIZE, kScreenWidth-60*NOW_SIZE, 120*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@\n%@\n%@",BlueSetTips1,BlueSetTips2,BlueSetTips3] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    faillb.numberOfLines = 0;
    [bgview addSubview:faillb];
    
    UIButton *resetbtn = [self goToInitButton:CGRectMake(30*NOW_SIZE, bgview.xmg_height-30*HEIGHT_SIZE-45*HEIGHT_SIZE, kScreenWidth-60*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:BlueSetreSeachDev selImgString:@"" norImgString:@""];
    resetbtn.backgroundColor = buttonColor;
    resetbtn.layer.cornerRadius = 45*HEIGHT_SIZE/2;
    resetbtn.layer.masksToBounds = YES;
    [bgview addSubview:resetbtn];
    [resetbtn addTarget:self action:@selector(resetBtnclick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)resetBtnclick{
    [_seachFailBgView removeFromSuperview];
    [self createSeachUI];
    self.isConnectBlue = NO;
    self.isInVC = NO;
    [self.deviceArray removeAllObjects];
    [self.deviceNameArray removeAllObjects];
    _connectRow = -1;
    [self.tableView reloadData];
    [[BluetoolsManageVC instance] disconnectToPeripheral];
    [self scanForPeripherals];
}

- (void)createBluetoolsListUI{
    
    UIImageView *headimg = [self goToInitImageView:CGRectMake(kScreenWidth/2-60*HEIGHT_SIZE, 20*HEIGHT_SIZE, 120*HEIGHT_SIZE, 120*HEIGHT_SIZE) imageString:@"bluetoolLogo"];
    [self.view addSubview:headimg];
    
    UIView *linev = [self goToInitView:CGRectMake(30*NOW_SIZE, CGRectGetMaxY(headimg.frame)+20*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:colorblack_186];
    [self.view addSubview:linev];
    
    UILabel *needBlue = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(linev.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 30*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@(0)",BlueSetCanUseDev] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.view addSubview:needBlue];
    _numbDevLB = needBlue;
    
    UILabel *tipsBlue = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(needBlue.frame)+5*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 40*HEIGHT_SIZE) textName:BlueSelecttips textColor:colorblack_186 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    tipsBlue.numberOfLines = 0;
    [self.view addSubview:tipsBlue];
    
    _connectRow = -1;
    CGFloat tabH = kScreenHeight - kNavBarHeight - CGRectGetMaxY(tipsBlue.frame)-10*HEIGHT_SIZE -10*HEIGHT_SIZE;
    UITableView *listTbv = [[UITableView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipsBlue.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, tabH) style:UITableViewStylePlain];
    listTbv.delegate = self;
    listTbv.dataSource = self;
    listTbv.backgroundColor = COLOR(246, 246, 246, 1);
    listTbv.bounces = NO;
    listTbv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listTbv];
    self.tableView = listTbv;
    listTbv.layer.cornerRadius = 15*HEIGHT_SIZE;
    listTbv.layer.masksToBounds = YES;
    
    [self createSeachUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.deviceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40*HEIGHT_SIZE;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BluetoothCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BluetoothCell"];
    }
    
    UIImageView *bluimgv = [self goToInitImageView:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE+(30*HEIGHT_SIZE - 12*HEIGHT_SIZE)/2, 24*HEIGHT_SIZE, 12*HEIGHT_SIZE) imageString:@"buleDevImg"];
    [cell.contentView addSubview:bluimgv];
    
    CBPeripheral *peripheral = self.deviceArray[indexPath.row];
    NSDictionary *onedic = self.deviceNameArray[indexPath.row];

//        cell.name = peripheral.name;
    UILabel *namelb = [self goToInitLable:CGRectMake(CGRectGetMaxX(bluimgv.frame)+5*NOW_SIZE, 5*HEIGHT_SIZE, _tableView.xmg_width - CGRectGetMaxX(bluimgv.frame)-25*NOW_SIZE-100*NOW_SIZE, 30*HEIGHT_SIZE) textName:onedic[@"name"] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [cell.contentView addSubview:namelb];
    

    UILabel *statelb = [self goToInitLable:CGRectMake(_tableView.xmg_width-10*NOW_SIZE - 100*NOW_SIZE, 5*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE) textName:root_wei_LianJie textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
    [cell.contentView addSubview:statelb];
    
    if (indexPath.row == self.connectRow) {// 判断选中，打钩
        self.connectRow = (int)indexPath.row;
        if (_isConnectBlue) {
            statelb.text = chargeHaveConnDev;
            statelb.textColor = colorblack_186;
        }else{
            statelb.text = BlueSetConnecting;
            statelb.textColor = buttonColor;
        }
    }
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//
//    if (indexPath.row != self.connectRow) {// 判断选中，打钩
//
//
//    }

    self.connectRow = (int)indexPath.row;
    // 连接 or 切换新设备
    CBPeripheral *peripheral = self.deviceArray[indexPath.row];
    NSDictionary *onedic = self.deviceNameArray[indexPath.row];
    self.isBagG = onedic[@"Auth"];//判断连接的是g:  还是G:
    
    [self conectionWithDevice:peripheral];
}
#pragma mark -- CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
}
// 搜索蓝牙设备
- (void)scanForPeripherals{
    [BluetoolsManageVC instance].ScanSn = _SNStr;
    [[BluetoolsManageVC instance] scanForPeripherals];
    
    __weak typeof(self) weakSelf = self;
   
    [BluetoolsManageVC instance].GetBluePeripheralBlock = ^(id  _Nonnull obj, NSDictionary * _Nonnull BlueDic) {
        if (![weakSelf.deviceArray containsObject:obj]){
            [weakSelf.deviceArray addObject:obj];
            [weakSelf.deviceNameArray addObject:BlueDic];
            if (_isSeachTimer) {
                [_isSeachTimer invalidate];
                _isSeachTimer = nil;
            }
            if (weakSelf.seachBgView) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    [weakSelf.seachBgView removeFromSuperview];
                });
             }
            

        }
        if (_firstINConnect) {
            _firstINConnect = NO;
            CBPeripheral *peripheral = (CBPeripheral *)obj;
            NSString *namestr = BlueDic[@"name"];
            if ([namestr isEqualToString:weakSelf.SNStr]) {
                weakSelf.connectRow = (int)(weakSelf.deviceArray.count-1);
                self.isBagG = BlueDic[@"Auth"];//判断连接的是g:  还是G:
                [[NSUserDefaults standardUserDefaults]setObject:self.isBagG forKey:@"ISBAGGSET"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self conectionWithDevice:peripheral];
            }
        }
        
        [weakSelf.tableView reloadData];
        weakSelf.numbDevLB.text = [NSString stringWithFormat:[NSString stringWithFormat:@"%@(%ld)",BlueSetCanUseDev,weakSelf.deviceArray.count]];
    };
   
}
// 连接切换设置
- (void)conectionWithDevice:(CBPeripheral *)device {
    
    [self showProgressView];// 开启菊花
    [[BluetoolsManageVC instance] connectToPeripheral:device];
    [BluetoolsManageVC instance].ConnectBluePeripheralBlock = ^(id obj){// 连接结果
        
        if ([obj isEqualToString:@"YES"]) {
            self.isConnectBlue = YES;
            [BluetoolsManageVC instance].delegate = self;
            [[NSUserDefaults standardUserDefaults]setObject:self.isBagG forKey:@"ISBAGGSET"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
//            if (![[BluetoolsManageVC instance] isHeartTimerValid]) {
//                [[BluetoolsManageVC instance] startHeartBeat];
//            }
            
        }else{
            [self hideProgressView]; // 关闭菊花

            self.isConnectBlue = NO;
//            [self showToastViewWithTitle:@"蓝牙已断开"];
//            [[BluetoolsManageVC instance] stopHeartBeat];
        }
        [self.tableView reloadData];

    };
    
}

//订阅的初值返回后才发密钥验证
//- (void)isBackValue:(BOOL)isBack{
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showProgressView];
//
//        NSString *authkkey = @"growatt_iot_device_common_key_01";
//        if ([self.isBagG isEqualToString:@"G:"]) {
//            if (!kStringIsEmpty(_AuthKey)) {
//                authkkey = _AuthKey;
//
//            }
//        }
//        NSDictionary *datadic = @{@"54":authkkey};
//
//        [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"keySet"];//发送密钥
//    });
//
//}
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
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:BlueTipsOpen message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:NewLocat_gotoSetWifi style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

//                BlueToolsOpenSetTipsVC *tipsvc = [[BlueToolsOpenSetTipsVC alloc]init];
//                [self.navigationController pushViewController:tipsvc animated:YES];
            }]];
            [self presentViewController:alvc animated:YES completion:nil];
//            [self showAlertViewWithTitle:BlueTipsOpen message:BlueTipsOpenWay2 cancelButtonTitle:root_OK];

        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"系统蓝牙关闭了，请先打开蓝牙");
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:BlueTipsOpen message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:NewLocat_gotoSetWifi style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

//                BlueToolsOpenSetTipsVC *tipsvc = [[BlueToolsOpenSetTipsVC alloc]init];
//                [self.navigationController pushViewController:tipsvc animated:YES];
            }]];
            [self presentViewController:alvc animated:YES completion:nil];
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

//数据超时
- (void)BTgetDataTimeOut{
    
//    [self showToastViewWithTitle:@"连接超时"];
    [self hideProgressView];
    
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
                    updata.SNStr = _SNStr;
                    updata.isBlueIN = @"1";
                    [self.navigationController pushViewController:updata animated:YES];
                    updata.NextBlock = ^{
                        self.isCanCelUpdataBack = YES;
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
    if (_succeView) {
        [_succeView removeFromSuperview];
    }
    
    UIView *succv = [self goToInitView:CGRectMake(0, 0, kScreenWidth, kScreenHeight) backgroundColor:COLOR(0, 0, 0, 0.3)];
    UITapGestureRecognizer *bgclick =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelclick)];
    [succv addGestureRecognizer:bgclick];
    [KEYWINDOW addSubview:succv];
    
    _succeView = succv;
    
    UIView *whiview = [self goToInitView:CGRectMake(kScreenWidth/2-100*HEIGHT_SIZE, kScreenHeight/2-100*HEIGHT_SIZE,200*HEIGHT_SIZE, 140*HEIGHT_SIZE) backgroundColor:WhiteColor];
    whiview.layer.cornerRadius = 10*HEIGHT_SIZE;
    whiview.layer.masksToBounds = YES;
    [succv addSubview:whiview];
    
    UIImageView *succIMG = [self goToInitImageView:CGRectMake(whiview.xmg_width/2-50*HEIGHT_SIZE/2, 10*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE) imageString:@"bluesuccesstip"];
    [whiview addSubview:succIMG];
    
    UILabel *conttiplb = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(succIMG.frame)+10*HEIGHT_SIZE, whiview.xmg_width-20*NOW_SIZE, 30*HEIGHT_SIZE) textName:BlueSetConnectSuccess textColor:buttonColor fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [whiview addSubview:conttiplb];
    
    UILabel *conttiplb2 = [self goToInitLable:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(conttiplb.frame)+10*HEIGHT_SIZE, whiview.xmg_width-20*NOW_SIZE, 20*HEIGHT_SIZE) textName:[NSString stringWithFormat:@"%@...",BlueSetWillPusPPZ] textColor:colorblack_102 fontFloat:12*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [whiview addSubview:conttiplb2];
    
//    UIButton *sendbtn = [self goToInitButton:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(conttiplb.frame)+10*HEIGHT_SIZE, whiview.xmg_width-20*NOW_SIZE, 20*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"发送" selImgString:@"" norImgString:@""];
//
//    [sendbtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    [sendbtn addTarget:self action:@selector(senddata2) forControlEvents:UIControlEventTouchUpInside];
//    [whiview addSubview:sendbtn];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [_succeView removeFromSuperview];
        
        [self gotoNextVC];
    });
}
- (void)cancelclick{
    
    [_succeView removeFromSuperview];

}

//- (void)senddata2{
//
//    [[BluetoolsManageVC instance] connectToDev:@[@"56",@"57"] devType:@"wifi19"];//devtype为当前发送的命令标号
//}
//
//- (void)TCPSocketReadData:(NSDictionary *)dataDic{
//
//    NSInteger cmd = [[NSString stringWithFormat:@"%@", dataDic[@"cmd"]] integerValue];
//    NSString *devtype = [NSString stringWithFormat:@"%@", dataDic[@"devType"]];
//
//    if (cmd == 19 && [devtype isEqualToString:@"wifi19"]) {
//        NSString *wifiname = [NSString stringWithFormat:@"%@",dataDic[@"56"]];
//        NSString *wifipsw = [NSString stringWithFormat:@"%@",dataDic[@"57"]];
//
//        [self showAlertViewWithTitle:[NSString stringWithFormat:@"WiFi名称:%@",wifiname] message:[NSString stringWithFormat:@"WiFi密码:%@",wifipsw] cancelButtonTitle:root_OK];
//
//    }
//}


- (void)gotoNextVC{
    
    if (_isINDataVC) {
        return;
    }
    _isINDataVC = YES;
    BluetoolsDataSetVC *connwifivc = [[BluetoolsDataSetVC alloc]init];
    connwifivc.buleDevice = self.deviceArray[_connectRow];
    NSDictionary *namdic = self.deviceNameArray[_connectRow];
    connwifivc.wifiName = namdic[@"name"];
    connwifivc.stationID = _stationID;
    connwifivc.codeStr = _codeStr;
    connwifivc.SnString = _SNStr;
 
    [self.navigationController pushViewController:connwifivc animated:YES];
}

- (void)getCLVersion{
    
    [self showProgressView];
//    获取版本号
    [[BluetoolsManageVC instance] connectToDev:@[@"21"] devType:@"UPDATA"];//devtype为当前发送的命令标号
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
