//
//  CollectorTCPUpDataVC.m
//  ShinePhone
//
//  Created by CBQ on 2021/1/19.
//  Copyright © 2021 qwl. All rights reserved.
//

#import "BluetoolsUpadtaDevVC.h"
#import "BluetoolsManageVC.h"
#import <SystemConfiguration/CaptiveNetwork.h>//获取wifi名称
//#import "NewColllectorConnWifiVC.h"
#import "RedxcollectorDownLoad.h"
#import "BluetoolsSeachDevVC.h"
#define TimeOut 10
#define pickSize 512

@interface BluetoolsUpadtaDevVC ()<BluetoolsManageVCDelegate>

@property (nonatomic, strong)NSData * readdata1;
@property (nonatomic, assign)int AllNumb;
@property (nonatomic, assign)int nowNumb;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *settingView;
@property (nonatomic, strong)UIImageView *upimgv;
@property (nonatomic, strong)UILabel *precentLB;
@property (nonatomic, strong)UILabel *textLB;
@property (nonatomic, strong)UILabel *textLB2;
@property (nonatomic, strong)UIButton *chongxBtn;
@property (nonatomic, strong)UIButton *jianchaBtn;

@property (nonatomic, strong)NSString *typeStr;

@property (nonatomic, assign)int addNumb;
@property (nonatomic, assign)int yichangNum1;
@property (nonatomic, assign)int yichangNum2;
@property (nonatomic, assign)int yichangNum3;
@property(nonatomic,assign) BOOL isConnect;
@property(nonatomic,assign) int connectNum;
@property (nonatomic, strong)NSTimer *BuleSendTimer;
@property(nonatomic,assign) int addTimeNumb;//记时
@property(nonatomic,assign) int AllTimeNumb;//次数
@property(nonatomic,assign) BOOL isDataBack;

@property (nonatomic, strong)NSDictionary *sendDict;
@property (nonatomic, strong)NSData *sendData;
@property(nonatomic,strong) NSString *sendType;//0是发送80设置命令,1是发送升级命令

@property (nonatomic, strong)NSTimer *ReadPrceTimer;

@end

@implementation BluetoolsUpadtaDevVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // 建立连接
    self.connectNum = 0;
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [BluetoolsManageVC instance].delegate = self;
    [self getUPLoadPickType];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReconnectSet) name:@"BLUERECONNECTNOTIF" object:nil];
    
    

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_BuleSendTimer) {
        [_BuleSendTimer invalidate];
        _BuleSendTimer = nil;
    }
    if (_ReadPrceTimer) {
        [_ReadPrceTimer invalidate];
        _ReadPrceTimer = nil;
    }
    _isDataBack = YES;
    [BluetoolsManageVC instance].delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"BLUERECONNECTNOTIF" object:nil];
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

}

//蓝牙掉线，自动重连后处理
- (void)ReconnectSet{
//    [self showToastViewWithTitle:@"掉线重连，重新发送数据"];
    [BluetoolsManageVC instance].delegate = self;
    [self getUPLoadPickType];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NewAPSet_CJQUpLoad;
    _isConnect = YES;
    _connectNum = 0;
    _yichangNum1 = 0;
    _yichangNum2 = 0;
    _yichangNum3 = 0;

    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28*NOW_SIZE, 22*NOW_SIZE)] ;//[self goToInitButton:CGRectMake(0, 0, 28*NOW_SIZE, 24*NOW_SIZE) TypeNum:2 fontSize:12 titleString:@"" selImgString:@"back" norImgString:@"back"];
    [backbtn setBackgroundImage:IMAGE(@"back") forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    
    [self createupdataUI];

}

- (void)backclick{
    
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_Alet_user message:NewAPSet_AZdatalog_updating_tips preferredStyle:UIAlertControllerStyleAlert];
    [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
    [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BOOL isback = NO;

        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[BluetoolsSeachDevVC class]])
            {
                BluetoolsSeachDevVC *A =(BluetoolsSeachDevVC *)controller;

                [self.navigationController popToViewController:A animated:YES];
                isback = YES;
           
            }

        }
        if (!isback) {
            [self.navigationController popViewControllerAnimated:YES];

        }
    }]];
    [self presentViewController:alvc animated:YES completion:nil];
}


//设置升级包类型
- (void)getUPLoadPickType{
    
    //用之前设置的下载名称读取保存文件的路径
    NSDictionary *pathdic = [RedxcollectorDownLoad getDatalastPath:@"X2UPDATA"];
    NSString *patchstr = @"";
    NSString *namestr = @"";
    if (pathdic) {
        namestr = pathdic[@"name"];
        patchstr = pathdic[@"path"];
    }
    if (patchstr.length == 0) {
        [self showToastViewWithTitle:Root_downLoadTips2];
        return;
    }
    NSData *readdata = [[NSFileManager defaultManager] contentsAtPath:patchstr];
    
    if (readdata) {
        _readdata1 = readdata;
        NSLog(@"读取的数据:%ld",_readdata1.length);
    }else{
        [self showToastViewWithTitle:Root_downLoadTips2];
        return;
    }
    
    
    //X#typeXX#
//    X=0 --> 只下载文件但不升级，等待升级触发命令;
//    X=1 --> 下载文件并马上进行升级;
//    X=2 --> 差分升级方式只下发文件，但是不升级，等待升级触发命令;(2022/04/24)
//    X=3 --> 差分升级方式下载文件并马上进行升级;(2022/04/24)
//    XX=00 --> 值设置路径不升级;
//    XX=01 --> 采集器bin文件;
//    XX=02 --> 逆变器hex文件;
//    XX=03 --> 逆变器bin文件;
//    XX=04 --> 逆变器mot文件;
//    XX=05 --> 逆变器out文件;
//    XX=06 --> 采集器RFstick bin文件;
//    XX=07 --> 采集器GroBoost bin文件;(20200727) XX=其他 --> 后续根据实际情况添加;
    NSArray *binOrhexArr = [namestr componentsSeparatedByString:@"."];
    NSString *typestr = @"1#type01";//02 hex,03bin
    
    if (binOrhexArr.count > 0) {
        NSString *laststr = binOrhexArr.lastObject;
        if ([laststr isEqualToString:@"patch"]) {
          
            typestr = @"3#type01";
        }else{
            if ([laststr isEqualToString:@"bin"]) {
                typestr = @"1#type01";

            }else{
                typestr = @"1#type02";

            }
            
        }
    }
    self.AllTimeNumb = 0;
    self.addTimeNumb = 0;
    self.sendType = @"0";
    self.isDataBack = NO;
    if (_BuleSendTimer) {
        [_BuleSendTimer invalidate];
        _BuleSendTimer = nil;
    }
    _BuleSendTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendDataIsTimerOut) userInfo:nil repeats:YES];
    NSDictionary *datadic = @{@"80":typestr};
    _sendDict = datadic;
    [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"updataType"];
//    [[BluetoolsManageVC instance]connectToDev:@[@"65"] devType:@"getType65"];
}

- (void)isloack{
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateInactive) {
        //iOS6锁屏事件
        NSLog(@"Sent to background by locking screen");
    } else if (state == UIApplicationStateBackground) {
        CGFloat screenBrightness = [[UIScreen mainScreen] brightness];
        NSLog(@"Screen brightness: %f", screenBrightness);
        if (screenBrightness > 0.0) {
            //iOS6&iOS7 Home事件
            NSLog(@"Sent to background by home button/switching to other app");
        } else {
            //iOS7锁屏事件
            NSLog(@"Sent to background by locking screen");
        }
    }
}

//升
- (void)tcpGetData{

    
   
    
    Byte *headerByte = (Byte *)[_readdata1 bytes];
    NSData *bytesData = [[NSData alloc]initWithBytes:headerByte length:20];//20,每次发送升级包的时候都需要先传包的前20个字节校验，
    int numb0 = (int)((_readdata1.length - 20)/pickSize);
    int numb1 = (int)((_readdata1.length - 20)%pickSize);
    if (numb1 > 0) {
        numb0 += 1;
    }
    _AllNumb = numb0;
    _nowNumb = 0;
//    [self showProgressView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showProgressView];
        
        self.AllTimeNumb = 0;
        self.isDataBack = NO;
        self.addTimeNumb = 0;
        self.sendData = bytesData;
        self.sendType = @"1";
        //upNumb 分的包个数，dataNum 当前的包编号
        [[BluetoolsManageVC instance] updataCollectorVersion:bytesData upNumb:numb0 dataNum:0];
    });
    
}
//发送数据是否超时
- (void)sendDataIsTimerOut{
    
    if (!self.isDataBack) {
        _addTimeNumb ++;
        if (_addTimeNumb > TimeOut) {//超时重发
            _AllTimeNumb ++;
            if ([self.sendType isEqualToString:@"0"]) {
                _addTimeNumb = 0;
                [[BluetoolsManageVC instance] dataSetWithDataDic:_sendDict devType:@"updataType"];

            }
            if ([self.sendType isEqualToString:@"1"]) {
                [[BluetoolsManageVC instance] updataCollectorVersion:_sendData upNumb:_AllNumb dataNum:_nowNumb];

            }
            if (_AllTimeNumb > 2) {
                [_BuleSendTimer invalidate];
                _BuleSendTimer = nil;
                _upimgv.image = IMAGE(@"seachBlueFailIMG");
                _bgView.hidden = YES;
                _precentLB.hidden = YES;
                _textLB.text = NewAPSet_CJQUpDataError;
                if (kStringIsEmpty(_SNStr)) {
                    _SNStr = @"";
                }
                _textLB2.text = @"";//[NSString stringWithFormat:@"%@，%@:%@",NewAPSet_CJQCheckWifi,NewAPSet_CJQCheckWifiNamew,_SNStr];
                _chongxBtn.hidden = NO;
                _jianchaBtn.hidden = NO;
            }
        }
    }else{
        _addTimeNumb = 0;
        _AllTimeNumb = 0;
    }
    
}
#pragma mark -- HSTCPWiFiManagerDelegate   socket 回调


- (void)TCPSocketReadData:(NSDictionary *)dataDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger cmd = [[NSString stringWithFormat:@"%@", dataDic[@"cmd"]] integerValue];
        NSString *devtype = [NSString stringWithFormat:@"%@", dataDic[@"devType"]];
//        if (cmd == 19 && [devtype isEqualToString:@"getType65"]) {
//            NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"65"]];
//            _typeStr = type;
//            [self tcpGetData];
//        }
        if (cmd == 19 && [devtype isEqualToString:@"readStatus"]) {//升级 状态
            NSString *type = [NSString stringWithFormat:@"%@",dataDic[@"101"]];
            int numb = [type intValue];
            if (numb == 100) {//升级成功
                [self UploadProgress:100];

                [self createSuccess];
            }else if(numb > 100){
                
                _upimgv.image = IMAGE(@"seachBlueFailIMG");
                _bgView.hidden = YES;
                _precentLB.hidden = YES;
                _textLB.text = NewAPSet_CJQUpDataError;
                if (kStringIsEmpty(_SNStr)) {
                    _SNStr = @"";
                }
//                _textLB2.text = @"升级错误";//[NSString stringWithFormat:@"%@，%@:%@",NewAPSet_CJQCheckWifi,NewAPSet_CJQCheckWifiNamew,_SNStr];
                _chongxBtn.hidden = NO;
                _jianchaBtn.hidden = NO;

            }else{
                [self UploadProgress:(float)(90 + (float)(numb/10))];
                
            }
//            else{
//
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    //读取101配置状态
//                    [[BluetoolsManageVC instance] connectToDev:@[@"101"] devType:@"readStatus"];
//                });
//            }
        }
    });
}
// 是否设置成功
- (void)TCPSocketActionSuccess:(BOOL)isSuccess CMD:(int)cmd devtype:(nonnull NSString *)devtype{
    dispatch_async(dispatch_get_main_queue(), ^{

    [self hideProgressView];
        
    if (cmd == 18 && [devtype isEqualToString:@"updataType"]) {
        
        self.isDataBack = YES;
        
        
        [self tcpGetData];
    }
    if ([devtype isEqualToString:@"keySet"]) {//密钥验证成功,重新发送数据
        [self hideProgressView];
        
    }
        
    if (!isSuccess) {
        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_device_246 message:nil preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okaction = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:nil];
        [alvc addAction:okaction];
        [self presentViewController:alvc animated:YES completion:nil];
    }
    NSLog(@"TCPSocketActionSuccess cmd: **%ld**", (long)cmd);
    });


}
//升级回调
- (void)TCPSocketUpDataReadDataStatus:(int)status AllNumb:(int)AllDataNumb nowData:(int)nowDataNumb{
    
    [self hideProgressView];
    
    self.isDataBack = YES;
    _AllNumb = AllDataNumb;

    if (status == 0) {//成功
        
        _yichangNum1 = 0;
        _yichangNum2 = 0;
        _yichangNum3 = 0;
        if (nowDataNumb == _AllNumb) {
            NSLog(@"完成");
            if (_BuleSendTimer) {
                [_BuleSendTimer invalidate];
                _BuleSendTimer = nil;
            }
            
//            if (_AllNumb != 0) {
//                _precentLB.text = [NSString stringWithFormat:@"%d%%",(int)(90*_nowNumb/_AllNumb)];
//                _settingView.frame = CGRectMake(0, 0, _nowNumb *_bgView.frame.size.width*0.9/_AllNumb, 10*HEIGHT_SIZE);
//                _textLB.text = NewAPSet_CJQUpDataNow;
//                _textLB2.text = NewAPSet_CJQUpDataTips;
//            }
            //读取101配置状态
            [[BluetoolsManageVC instance] connectToDev:@[@"101"] devType:@"readStatus"];
            if (_ReadPrceTimer) {
                [_ReadPrceTimer invalidate];
                _ReadPrceTimer = nil;
            }
            
            _ReadPrceTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(readPrceSet) userInfo:nil repeats:YES];
            
//            _textLB.text = [NSString stringWithFormat:@"已完成,当前包:%d",_nowNumb];
        }else{
            nowDataNumb += 1;
            _nowNumb = nowDataNumb;
            NSLog(@"当前包编号:%d",nowDataNumb);
            if (_AllNumb != 0) {
//                _precentLB.text = [NSString stringWithFormat:@"%d%%",(int)(90*_nowNumb/_AllNumb)];
//                _settingView.frame = CGRectMake(0, 0, _nowNumb *_bgView.frame.size.width*0.9/_AllNumb, 10*HEIGHT_SIZE);
                [self UploadProgress:(float)(90.0*_nowNumb/_AllNumb)];

                _textLB.text = root_SmartHome_483;
//                _textLB2.text = NewAPSet_CJQUpDataTips;
            }
          
            NSData *bydd = [[NSData alloc]init];

            if (_nowNumb == _AllNumb) {
                bydd = [self safe_subData:_readdata1 withRange:NSMakeRange(pickSize*(_nowNumb-1)+20,_readdata1.length - (pickSize*(_nowNumb-1)+20))];
                
//                [self createSuccess];
                //读取101配置状态
//                [[BluetoolsManageVC instance] connectToDev:@[@"101"] devType:@"readStatus"];

            }else{
                bydd = [self safe_subData:_readdata1 withRange:NSMakeRange(pickSize*(_nowNumb-1)+20, pickSize)];
            }
            self.AllTimeNumb = 0;
            self.isDataBack = NO;
            self.addTimeNumb = 0;
            self.sendData = bydd;
            self.sendType = @"1";
            [[BluetoolsManageVC instance] updataCollectorVersion:bydd upNumb:_AllNumb dataNum:nowDataNumb];
            
        }
        

        
    }else if(status == 1){//接收异常,服务器再次发送当前包
        NSLog(@"接收异常:status == 1");
        _yichangNum1 ++;
        if (_yichangNum1 < 5) {
            NSData *bydd = [[NSData alloc]init];
         
            if (nowDataNumb == _AllNumb) {
                bydd = [_readdata1 subdataWithRange:NSMakeRange(pickSize*(nowDataNumb-1)+20,_readdata1.length - (pickSize*(_nowNumb-1)+20))];

            }else{
                bydd = [_readdata1 subdataWithRange:NSMakeRange(pickSize*(nowDataNumb-1)+20, pickSize)];
            }
            [[BluetoolsManageVC instance] updataCollectorVersion:bydd upNumb:_AllNumb dataNum:nowDataNumb];
        }else{
            
            _upimgv.image = IMAGE(@"seachBlueFailIMG");
            _bgView.hidden = YES;
            _precentLB.hidden = YES;
            _textLB.text = NewAPSet_CJQUpDataError;
            if (kStringIsEmpty(_SNStr)) {
                _SNStr = @"";
            }
            _textLB2.text = @"";//[NSString stringWithFormat:@"%@，%@:%@",NewAPSet_CJQCheckWifi,NewAPSet_CJQCheckWifiNamew,_SNStr];
            _chongxBtn.hidden = NO;
            _jianchaBtn.hidden = NO;
        }
        

    }else if(status == 2){//整体检验错误,重新发送文件第一包
        _yichangNum2 ++;
        if (_yichangNum2 < 5) {
            NSLog(@"接收异常:status == 2");
            Byte *headerByte = (Byte *)[_readdata1 bytes];
            NSData *bytesData = [[NSData alloc]initWithBytes:headerByte length:20];
            [[BluetoolsManageVC instance] updataCollectorVersion:bytesData upNumb:_AllNumb dataNum:0];
        }else{
            _upimgv.image = IMAGE(@"seachBlueFailIMG");
            _bgView.hidden = YES;
            _precentLB.hidden = YES;
            _textLB.text = NewAPSet_CJQUpDataError;
            if (kStringIsEmpty(_SNStr)) {
                _SNStr = @"";
            }
            _textLB2.text = @"";//[NSString stringWithFormat:@"%@，%@:%@",NewAPSet_CJQCheckWifi,NewAPSet_CJQCheckWifiNamew,_SNStr];
            _chongxBtn.hidden = NO;
            _jianchaBtn.hidden = NO;
        }
        


    }else{//其他错误（采集器准备失败,重新发送文件第一包
        _yichangNum3 ++;
        if (_yichangNum3 < 5) {
            NSLog(@"接收异常:status == %d",status);
            Byte *headerByte = (Byte *)[_readdata1 bytes];
            NSData *bytesData = [[NSData alloc]initWithBytes:headerByte length:20];
            [[BluetoolsManageVC instance] updataCollectorVersion:bytesData upNumb:_AllNumb dataNum:0];
        }else{
            _upimgv.image = IMAGE(@"seachBlueFailIMG");
            _bgView.hidden = YES;
            _precentLB.hidden = YES;
            _textLB.text = NewAPSet_CJQUpDataError;
            if (kStringIsEmpty(_SNStr)) {
                _SNStr = @"";
            }
            _textLB2.text = @"";//[NSString stringWithFormat:@"%@，%@:%@",NewAPSet_CJQCheckWifi,NewAPSet_CJQCheckWifiNamew,_SNStr];
            _chongxBtn.hidden = NO;
            _jianchaBtn.hidden = NO;
            
        }
        

    }
}


- (void)ConnectBluetoolsLost{
    
//    [self showAlertViewWithTitle:NewAPSet_NetLost message:@"" cancelButtonTitle:root_OK];
}


//数据超时
- (void)BTgetDataTimeOut{
    
    [self showToastViewWithTitle:root_SmartHome_477];
    [self hideProgressView];
    
}

//读取进度
- (void)readPrceSet{
    
    //读取101配置状态
    [[BluetoolsManageVC instance] connectToDev:@[@"101"] devType:@"readStatus"];

}

//升级数据0-1
- (void)UploadProgress:(CGFloat)progress{
    
    
    _settingView.xmg_width = progress*_bgView.xmg_width/100;
    _precentLB.text = [NSString stringWithFormat:@"%.1f%%",progress];
    
 
}

- (void)createupdataUI{
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 70*HEIGHT_SIZE ,40*HEIGHT_SIZE, 140*HEIGHT_SIZE, 140*HEIGHT_SIZE)];
    imgv.image = IMAGE(@"shengjizhong");
    [self.view addSubview:imgv];
    _upimgv = imgv;
    
    
    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(50*NOW_SIZE, CGRectGetMaxY(imgv.frame)+10*HEIGHT_SIZE, kScreenWidth - 100*NOW_SIZE, 10*HEIGHT_SIZE)];
    loadingView.backgroundColor = [UIColor colorWithRed:216/255.0 green:237/255.0 blue:255/255.0 alpha:1.0];
    loadingView.layer.cornerRadius = 5*HEIGHT_SIZE;
    loadingView.layer.masksToBounds = YES;
    [self.view addSubview:loadingView];
    _bgView = loadingView;
    
    UIView *setvie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10*HEIGHT_SIZE)];
    setvie.layer.cornerRadius = 5*HEIGHT_SIZE;
    setvie.layer.masksToBounds = YES;
    setvie.backgroundColor = buttonColor;
    [loadingView addSubview:setvie];
    _settingView = setvie;
    
    UILabel *pres = [[UILabel alloc]initWithFrame:CGRectMake(50*NOW_SIZE, CGRectGetMaxY(loadingView.frame)+10*HEIGHT_SIZE, kScreenWidth - 100*NOW_SIZE, 30*HEIGHT_SIZE)];
    pres.adjustsFontSizeToFitWidth = YES;
    pres.font = FontSize(15*HEIGHT_SIZE);
    pres.textAlignment = NSTextAlignmentCenter;
    pres.textColor = buttonColor;
    pres.text = @"0%";//[NSString stringWithFormat:@"%d%%",(int)100*_nowNumb/_AllNumb];
    [self.view addSubview:pres];
    _precentLB = pres;
    _addNumb = 0;

    UILabel *tipslb = [[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE, CGRectGetMaxY(pres.frame)+20*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
    tipslb.adjustsFontSizeToFitWidth = YES;
    tipslb.numberOfLines = 0;
    tipslb.font = FontSize(16*HEIGHT_SIZE);
    tipslb.textAlignment = NSTextAlignmentCenter;
    tipslb.textColor = colorblack_51;
    tipslb.text = [NSString stringWithFormat:@"%@...",HEM_Preparing];
    [self.view addSubview:tipslb];
    _textLB = tipslb;
    
    UILabel *tipslb2 = [[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE, CGRectGetMaxY(tipslb.frame)+10*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 30*HEIGHT_SIZE)];
    tipslb2.adjustsFontSizeToFitWidth = YES;
    tipslb2.font = FontSize(15*HEIGHT_SIZE);
    tipslb2.textAlignment = NSTextAlignmentCenter;
    tipslb2.textColor = colorblack_102;
    tipslb2.numberOfLines = 0;
    tipslb2.text = NewAPSet_waitUpData;
    [self.view addSubview:tipslb2];
    _textLB2 = tipslb2;
    
    UIButton *reupload = [[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE, CGRectGetMaxY(tipslb2.frame)+30*HEIGHT_SIZE, kScreenWidth-80*NOW_SIZE, 30*HEIGHT_SIZE)];
    reupload.layer.cornerRadius = 15*HEIGHT_SIZE;
    reupload.layer.masksToBounds = YES;
    [reupload setTitle:NewAPSet_ReUpdata forState:UIControlStateNormal];
    reupload.backgroundColor = buttonColor;
    [reupload setTitleColor:WhiteColor forState:UIControlStateNormal];
    [reupload addTarget:self action:@selector(chongxingSJClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reupload];
    _chongxBtn = reupload;
    reupload.hidden = YES;
    
    UIButton *reupload22 = [[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE, CGRectGetMaxY(reupload.frame)+10*HEIGHT_SIZE, kScreenWidth-80*NOW_SIZE, 30*HEIGHT_SIZE)];
    reupload22.layer.cornerRadius = 15*HEIGHT_SIZE;
    reupload22.layer.masksToBounds = YES;
    reupload22.layer.borderWidth = 0.5*HEIGHT_SIZE;
    reupload22.layer.borderColor = colorblack_102.CGColor;
    [reupload22 setTitle:blueIsConneTips forState:UIControlStateNormal];
    reupload22.backgroundColor = WhiteColor;
    [reupload22 setTitleColor:colorblack_51 forState:UIControlStateNormal];
    [reupload22 addTarget:self action:@selector(reupload22Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reupload22];
    _jianchaBtn = reupload22;
    reupload22.hidden = YES;
}

//重新升级
- (void)chongxingSJClick{
    
    _upimgv.image = IMAGE(@"shengjizhong");
    _bgView.hidden = NO;
    _settingView.frame = CGRectMake(0, 0, 0, 10*HEIGHT_SIZE);
    _precentLB.hidden = NO;
    _precentLB.text = @"0%";
    _textLB.text = root_SmartHome_483;
//    _textLB2.text = NewAPSet_CJQUpDataTips;
    _chongxBtn.hidden = YES;
    _jianchaBtn.hidden = YES;
    [self tcpGetData];
}
//检查热点连接
- (void)reupload22Click{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//发送完成后
- (void)createSuccess{
    //发完最后一包直接判断成功
    if (_AllNumb != 0) {
        _precentLB.text = [NSString stringWithFormat:@"%d%%",(int)(100*_nowNumb/_AllNumb)];

    _settingView.frame = CGRectMake(0, 0, _nowNumb *_bgView.frame.size.width/_AllNumb, 10*HEIGHT_SIZE);
        
        _upimgv.image = IMAGE(@"updataIMG");
        _textLB.text = NewAPSet_CJQCQNow;
        _textLB2.text = NewAPSet_CJQCQTips;

    }
    [self showAlertViewWithTitle:NewAPSet_CJQUPSucc message:NewAPSet_CJQCQTips cancelButtonTitle:root_OK];
    
//            [self showProgressView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self hideProgressView];
//                    [self showToastViewWithTitle:NewAPSet_CJQUPSucc];
//        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:NewAPSet_CJQUPSucc message:[NSString stringWithFormat:@"%@",APMode_errorTips] preferredStyle:UIAlertControllerStyleAlert];
//                            UIAlertAction *ac1 = [UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil];
//                            UIAlertAction *ac2 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ >",NewLocat_gotoSetWifi] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                [collectorDownLoad wifiClick];
//                            }];
//                            [alvc addAction:ac1];
//                            [alvc addAction:ac2];
//                            [self presentViewController:alvc animated:YES completion:nil];
        BOOL isback = NO;

        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[BluetoolsSeachDevVC class]])
            {
                BluetoolsSeachDevVC *A =(BluetoolsSeachDevVC *)controller;

                [self.navigationController popToViewController:A animated:YES];
                isback = YES;
           
            }

        }
        if (!isback) {
            [self.navigationController popViewControllerAnimated:YES];

        }
    });
    
}


// 判读截取长度是否超出范围
- (NSData *)safe_subData:(NSData *)data withRange:(NSRange)range{
    int datalen = (int)data.length;
    int localINT = (int)range.location;
    int rangleng = (int)range.length;
    if (localINT < 0 || rangleng < 0) {
        return nil;
    }
    
    if ((datalen != 0) && (datalen >= localINT)) {
        if ((rangleng > 0) && (datalen >= (localINT+rangleng))) {
            return [data subdataWithRange:range];

        }
    } else {
        NSLog(@"超出data截取长度");
    }
    
    return nil; //[NSData data];//[NSData dataWithBytes:[@"" UTF8String] length:1];
}

@end
