//
//  APSetNet3VC.m
//  ShinePhone
//
//  Created by 阳丹 on 2020/12/21.
//  Copyright © 2020 qwl. All rights reserved.
//

#import "BluetoolsMoreSetVC.h"
#import "BluetoolsManageVC.h"
#import "RedxCollectorShowAlertView.h"
//#import "RedxloginViewController.h"
//#import "deviceViewController.h"
//#import "StationCellectViewController.h"
#import "WeNewOverView.h"
#import "RedxcollectorDownLoad.h"
@interface BluetoolsMoreSetVC ()<UITextFieldDelegate,BluetoolsManageVCDelegate>
@property (nonatomic, strong)UIScrollView *bgscrollV;
@property (nonatomic, strong)UIView *LuyouSetV;
@property (nonatomic, strong)UIView *TimeSetV;
@property (nonatomic, strong)UIView *ServerSetV;
@property (nonatomic, strong)UIView *BaseSetV;
@property (nonatomic, strong)UIButton *saveBtn;
@property (nonatomic, strong)UIButton *chonglianBtn;

@property (nonatomic, strong)UIButton *canBtn;
@property (nonatomic, strong)UIView *LockV0;
//@property (nonatomic, strong)UIView *LockV;
//@property (nonatomic, strong)UIView *LockV22;
//@property (nonatomic, strong)UIView *LockV3;

@property (nonatomic, assign)BOOL isUnLock;
@property (nonatomic, strong)NSString *yumingStr;
@property (nonatomic, strong)NSString *ipStr;

@property (nonatomic, strong)UIView *passWV;
@property(nonatomic,assign) BOOL isConnect;
@property(nonatomic,assign) int connectNum;

@property (nonatomic, strong)UIButton *DHCPBtn;
@property (nonatomic, strong)UILabel *DHCPLB;

@property (nonatomic, strong)UIButton *tongbuBtn;
@property (nonatomic, strong)UIButton *yumingBtn;
@property (nonatomic, strong)UILabel *yumingLB;

@property (nonatomic, strong)NSMutableDictionary *mudic;
@property (nonatomic, strong)NSMutableDictionary *SetValueDic;
@property (nonatomic, strong)RedxCollectorShowAlertView *alerterV;
@property (nonatomic, strong)UIView *severListV;

@property(nonatomic,assign) BOOL isEdit1;
@property(nonatomic,assign) BOOL isEdit2;
@property(nonatomic,assign) BOOL isEdit3;
@property(nonatomic,assign) BOOL isEdit4;

@end

@implementation BluetoolsMoreSetVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 建立连接
    [BluetoolsManageVC instance].delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = root_MAX_286;
    _isConnect = YES;
    _connectNum = 0;
    _mudic = [[NSMutableDictionary alloc]init];
    _SetValueDic = [[NSMutableDictionary alloc]init];
    _isEdit1 = NO;
    _isEdit2 = NO;
    _isEdit3 = NO;
    _isEdit4 = NO;
    [self createGaoJiUI];
    [self tcpGetData];


}

- (void)tcpGetData{
 
    [self showProgressView];
    //71DHCP,14IP地址,26网关,25掩码
    [[BluetoolsManageVC instance] connectToDev:@[@"71",@"14",@"26",@"25"] devType:@"GetLuYouSet"];//,@"4",@"31",@"19",@"17",@"18",@"8",@"16",@"13",@"21"

    
}

- (void)TCPSocketReadData:(NSDictionary *)dataDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideProgressView];
        NSInteger cmd = [[NSString stringWithFormat:@"%@", dataDic[@"cmd"]] integerValue];
        
        // 记录全部参数
//        self.wifiNameTF.text = [NSString stringWithFormat:@"%@",dataDic[@"56"]];
//        self.wifiPSWTF.text = [NSString stringWithFormat:@"%@",dataDic[@"57"]];
        if (cmd == 19) {
            NSArray *keyarr = [dataDic allKeys];
            for (int i = 0; i < keyarr.count; i++) {
                [_mudic setObject:dataDic[keyarr[i]] forKey:keyarr[i]];
            }
           
            if (_mudic) {
                //路由器设置
                NSString *dhcp = [NSString stringWithFormat:@"%@",_mudic[@"71"]];
                _DHCPBtn.selected = [dhcp isEqualToString:@"1"]?YES:NO;
                if (_DHCPBtn.selected) {
                    
                    for (int i = 0; i < 3; i ++) {
                        UIImageView *rigimg = [self.view viewWithTag:1000+i+1000];
                        if (_LockV0) {
                            rigimg.hidden = YES;

                        }else{
                            rigimg.hidden = NO;

                        }
                        
                    }
                    _DHCPLB.text = @"DHCP";
                }else{
                    for (int i = 0; i < 3; i ++) {
                        UIImageView *rigimg = [self.view viewWithTag:1000+i+1000];
                        rigimg.hidden = YES;
                    }
                    _DHCPLB.text = @"STATIC";

                }
                NSArray *keySetArr = @[@"14",@"26",@"25"];
                for (int i = 0; i < keySetArr.count; i ++) {
                    UITextField *ipTF = [self.view viewWithTag:1000+i];
                    NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr[i]]];
                    if (kStringIsEmpty(valuStr)) {
                        ipTF.text = @"";
                    }else{
                        ipTF.text = valuStr;
                    }
                    
                }
    //            时间设置
    //            NSString *tongbu = [NSString stringWithFormat:@"%@",_mudic[@"71"]];
    //            _tongbuBtn.selected = [tongbu isEqualToString:@"1"]?YES:NO;
                NSArray *keySetArr2 = @[@"4",@"31"];
                for (int i = 0; i < keySetArr2.count; i ++) {
                    UITextField *ipTF = [self.view viewWithTag:1100+i];
                    NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr2[i]]];
                   
                    if (kStringIsEmpty(valuStr)) {
                        ipTF.text = @"";
                    }else{
                        ipTF.text = valuStr;
                    }

                }
                
                NSArray *keySetArr3 = @[@"19",@"17",@"18"];
                for (int i = 0; i < keySetArr3.count; i ++) {
                    UITextField *ipTF = [self.view viewWithTag:1200+i];
                    NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr3[i]]];
                    UIImageView *rightimg = [self.view viewWithTag:1200+1000];
                    UIImageView *rightimg1 = [self.view viewWithTag:1201+1000];
                    
                    if (kStringIsEmpty(valuStr) || [valuStr isEqualToString:@"0"]) {
                        ipTF.text = @"";
                    }else{
                        ipTF.text = valuStr;
                    }

                    if (i == 0) {
                        _yumingStr = ipTF.text;
                        if (kStringIsEmpty(_yumingStr)) {
                            _yumingBtn.selected = NO;
                            if (!_LockV0) {
                                rightimg.hidden = YES;
                                rightimg1.hidden = NO;

                            }
                            
                            
                        }else{
                            _yumingBtn.selected = YES;
                            if (!_LockV0) {
                                rightimg.hidden = NO;
                                rightimg1.hidden = YES;
                            }
                        }
                    
                    }
                    if (i == 1) {
                    
                        _ipStr = ipTF.text;
                        if (_yumingBtn.selected) {
                            ipTF.text = @"";
                        }
                    }
                   
                }
                
                NSArray *keySetArr4 = @[@"8",@"16",@"13",@"21"];
                for (int i = 0; i < keySetArr4.count; i ++) {
                    if (i == 0) {
                        UITextField *ipTF = [self.view viewWithTag:1400+i];
                        NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr4[i]]];
                        if (kStringIsEmpty(valuStr)) {
                            ipTF.text = @"";
                        }else{
                            ipTF.text = valuStr;
                        }
                    }else{
                        
                        UILabel *iplb2 = [self.view viewWithTag:1400+i];
                        NSString *valuStr2 = [NSString stringWithFormat:@"%@",_mudic[keySetArr4[i]]];
                        if (kStringIsEmpty(valuStr2)) {
                            iplb2.text = @"";
                        }else{
                            iplb2.text = valuStr2;
                        }
                    }
                    
                   

                }
                
            }
        }
        
        


    });
}

// 是否操作成功
- (void)TCPSocketActionSuccess:(BOOL)isSuccess CMD:(int)cmd devtype:(nonnull NSString *)devtype{
    dispatch_async(dispatch_get_main_queue(), ^{

    [self hideProgressView];
    if (cmd == 18) {
        if ([devtype isEqualToString:@"chongqi32"]) {
            [self backbtnClick];
            return;
        }
        [self showToastViewWithTitle:root_xiuGai_chengGong];

//        _isSuccess = isSuccess;
        if (isSuccess) {
            if (_isEdit1) {
                [self showProgressView];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //71DHCP,14IP地址,26网关,25掩码
                    [[BluetoolsManageVC instance] connectToDev:@[@"71",@"14",@"26",@"25"] devType:@"GetLuYouSet"];//,@"4",@"31",@"19",@"17",@"18",@"8",@"16",@"13",@"21"
                });
            }
            
            if (_isEdit2) {
                //时间设置
                [self showProgressView];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //04时间间隔,31采集器时间
                    [[BluetoolsManageVC instance] connectToDev:@[@"04",@"31"] devType:@"GetTimeSet"];
                });
            }
            
    //
            if (_isEdit3) {
                [self showProgressView];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //19域名,17IP地址,18端口
                    [[BluetoolsManageVC instance] connectToDev:@[@"19",@"17",@"18"] devType:@"GetServerSet"];
                });
            }
            
    //
            if (_isEdit4) {
                [self showProgressView];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //
                    [[BluetoolsManageVC instance] connectToDev:@[@"8",@"16",@"13",@"21"] devType:@"GetBaseSet"];
                });
            }
            
        }
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



- (void)createGaoJiUI{
    
    UIScrollView *bgscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgscrollClick)];
    [bgscroll addGestureRecognizer:taps];
    [self.view addSubview:bgscroll];
    _bgscrollV = bgscroll;
    
    NSArray *titarr = @[NewAPSet_wifiset2,NewAPSet_serverset2,root_oss_922,NewAPSet_timeset2];
    CGFloat btnwide = (kScreenWidth - 10*5*NOW_SIZE)/titarr.count;
    
    for (int i = 0; i < titarr.count; i ++) {
        UIButton *titbtn = [[UIButton alloc]initWithFrame:CGRectMake(10*NOW_SIZE + (btnwide + 10*NOW_SIZE)*i, 5*HEIGHT_SIZE, btnwide, 40*HEIGHT_SIZE)];
        [titbtn setTitle:titarr[i] forState:UIControlStateNormal];
        [titbtn setTitleColor:colorblack_154 forState:UIControlStateNormal];
        [titbtn setTitleColor:buttonColor forState:UIControlStateSelected];
        [titbtn addTarget:self action:@selector(titbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titbtn.tag = 100+i;
        titbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
        titbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        titbtn.titleLabel.numberOfLines = 0;
        [bgscroll addSubview:titbtn];
        
        UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(titbtn.frame.origin.x, CGRectGetMaxY(titbtn.frame), titbtn.frame.size.width, 1*HEIGHT_SIZE)];
        linev.backgroundColor = WhiteColor;
        linev.tag = 200+i;
        [bgscroll addSubview:linev];
        if (i == 0) {
            titbtn.selected = YES;
            linev.backgroundColor = buttonColor;
        }
        
    }
    
    UIView *tipsv = [[UIView alloc]initWithFrame:CGRectMake(0, 47*HEIGHT_SIZE, kScreenWidth, 50*HEIGHT_SIZE)];
    tipsv.backgroundColor = [UIColor colorWithRed:241/255.0 green:223/255.0 blue:209/255.0 alpha:0.9];
    [bgscroll addSubview:tipsv];
    
    UILabel *tipsLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE)];
    tipsLB.textColor = [UIColor colorWithRed:250/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
    tipsLB.text = NewAPSet_ChangeTips;
    tipsLB.font = FontSize(13*HEIGHT_SIZE);
    tipsLB.adjustsFontSizeToFitWidth = YES;
    tipsLB.numberOfLines = 0;
    [tipsv addSubview:tipsLB];
    //view
    //路由器
    [self createLuYouSet:CGRectGetMaxY(tipsv.frame)];
    //时间设置
    [self createtimeSet:CGRectGetMaxY(tipsv.frame)];
    //服务器设置
    [self createServerSet:CGRectGetMaxY(tipsv.frame)];
    //基本设置
    [self createBaseMassageSet:CGRectGetMaxY(tipsv.frame)];
    
    //
  
//    chonglianbtn.hidden = YES;
    //保存，取消
    UIButton *savebtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE,CGRectGetMaxY(_LuyouSetV.frame)+20*HEIGHT_SIZE+25*HEIGHT_SIZE+20*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
    [savebtn setTitle:root_baocun forState:UIControlStateNormal];
    [savebtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    savebtn.backgroundColor = buttonColor;
    savebtn.layer.cornerRadius = 20*HEIGHT_SIZE;
    savebtn.layer.masksToBounds = YES;
    [savebtn addTarget:self action:@selector(savebtn) forControlEvents:UIControlEventTouchUpInside];
    savebtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    [bgscroll addSubview:savebtn];
    _saveBtn = savebtn;
    savebtn.hidden = YES;
//    UIButton *cancelbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE,CGRectGetMaxY(savebtn.frame) + 15*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
//    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    cancelbtn.backgroundColor = colorGary;
//    [cancelbtn addTarget:self action:@selector(cancelbtn) forControlEvents:UIControlEventTouchUpInside];
//    cancelbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
//    [bgscroll addSubview:cancelbtn];
//    _canBtn = cancelbtn;
    
    bgscroll.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(savebtn.frame)+200*HEIGHT_SIZE);
    
    
    //锁

    UIView *lockView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(tipsv.frame), kScreenWidth, _LuyouSetV.frame.size.height+20*HEIGHT_SIZE+25*HEIGHT_SIZE+20*HEIGHT_SIZE+40*HEIGHT_SIZE)];
    lockView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *lockvclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locktouch)];
    [lockView addGestureRecognizer:lockvclick];
    [_bgscrollV addSubview:lockView];
    _LockV0 = lockView;
    
    UIButton *lockbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE, lockView.frame.size.height - 40*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
    [lockbtn setTitle:NewAPSet_UNLock forState:UIControlStateNormal];
    lockbtn.backgroundColor = buttonColor;
    lockbtn.layer.cornerRadius = 20*HEIGHT_SIZE;
    lockbtn.layer.masksToBounds = YES;
    [lockbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    lockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    [lockbtn addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [lockView addSubview:lockbtn];
    
    UIButton *chonglianbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE,CGRectGetMaxY(_LuyouSetV.frame)+20*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 25*HEIGHT_SIZE)];
    [chonglianbtn setTitle:[NSString stringWithFormat:@"%@ >",NewAPSet_backWifi] forState:UIControlStateNormal];
    [chonglianbtn setTitleColor:buttonColor forState:UIControlStateNormal];
//    chonglianbtn.backgroundColor = ;
//    chonglianbtn.layer.cornerRadius = 20*HEIGHT_SIZE;
//    chonglianbtn.layer.masksToBounds = YES;
    [chonglianbtn addTarget:self action:@selector(chonglianbtnClick) forControlEvents:UIControlEventTouchUpInside];
    chonglianbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    [bgscroll addSubview:chonglianbtn];
    _chonglianBtn = chonglianbtn;
    //弹框
    _alerterV = [[RedxCollectorShowAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _alerterV.backgroundColor = COLOR(0, 0, 0, 0.4);
    [self.view addSubview:_alerterV];
    _alerterV.hidden = YES;
}

- (void)locktouch{
    
    [self showToastViewWithTitle:NewAPSet_UNLock];
}

- (void)chonglianbtnClick{
    
    
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:NewAPSet_isOutPW message:NewAPSet_isOutPWTips preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showProgressView];
        
        
        NSDictionary *datadic = @{@"32":@"1"};
        [[BluetoolsManageVC instance] dataSetWithDataDic:datadic devType:@"chongqi32"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self hideProgressView];

            [self backbtnClick];

        });
    }];
    [alvc addAction:ac1];
    [alvc addAction:ac2];
    [self presentViewController:alvc animated:YES completion:nil];
    
    
}
- (void)backbtnClick{
 
        BOOL isback = NO;
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[WeNewOverView class]])
            {
                WeNewOverView *A =(WeNewOverView *)controller;

                [self.navigationController popToViewController:A animated:YES];
                isback = YES;
                
            }

        }
        if (!isback) {
            UIViewController *controller = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:controller animated:YES];

        }


}
- (void)titbtnClick:(UIButton *)setBtn{
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [self.view viewWithTag:100+i];
        btn.selected = NO;
        UIView *linev = [self.view viewWithTag:200+i];
        linev.backgroundColor = WhiteColor;
    }
    
    setBtn.selected = YES;
    UIView *linev1 = [self.view viewWithTag:setBtn.tag + 100];
    linev1.backgroundColor = buttonColor;
    
  
    
    //路由器
    if (setBtn.tag == 100) {
        _LuyouSetV.hidden = NO;
        _TimeSetV.hidden = YES;
        _ServerSetV.hidden = YES;
        _BaseSetV.hidden = YES;
        if (_LockV0) {
            _saveBtn.hidden = YES;
        }else{
            _saveBtn.hidden = NO;
        }
//        if (_isConnect) {
            [self showProgressView];

            [[BluetoolsManageVC instance] connectToDev:@[@"71",@"14",@"26",@"25"] devType:@"GetLuYouSet"];//,@"4",@"31",@"19",@"17",@"18",@"8",@"16",@"13",@"21"

//        }else{
//            _connectNum = 0;
//            [[BluetoolsManageVC instance] connectToHost:@"192.168.10.100"];
//
//        }
        
    }
    //时间
    if (setBtn.tag == 103) {
        _LuyouSetV.hidden = YES;
        _TimeSetV.hidden = NO;
        _ServerSetV.hidden = YES;
        _BaseSetV.hidden = YES;
  
        if (_LockV0) {
            _saveBtn.hidden = YES;
        }else{
            _saveBtn.hidden = NO;
        }
        //时间设置
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self showProgressView];
//        if (_isConnect) {
            //04时间间隔,31采集器时间
            [self showProgressView];

        [[BluetoolsManageVC instance] connectToDev:@[@"04",@"31"] devType:@"GetTimeSet"];

//        }else{
//            _connectNum = 0;
//            [[BluetoolsManageVC instance] connectToHost:@"192.168.10.100"];
//
//        }
//        });
//
    }
    //服务器
    if (setBtn.tag == 101) {
        _LuyouSetV.hidden = YES;
        _TimeSetV.hidden = YES;
        _ServerSetV.hidden = NO;
        _BaseSetV.hidden = YES;
        
        if (_LockV0) {
            _saveBtn.hidden = YES;
        }else{
            _saveBtn.hidden = NO;
        }
//        if (_isConnect) {
            //19域名,17IP地址,18端口
            [self showProgressView];

            [[BluetoolsManageVC instance] connectToDev:@[@"19",@"17",@"18"] devType:@"GetServerSet"];
//        }else{
//            _connectNum = 0;
//            [[BluetoolsManageVC instance] connectToHost:@"192.168.10.100"];
//
//        }
       
    }
    //基本信息
    if (setBtn.tag == 102) {
        _LuyouSetV.hidden = YES;
        _TimeSetV.hidden = YES;
        _ServerSetV.hidden = YES;
        _BaseSetV.hidden = NO;
        
        if (_LockV0) {
            _saveBtn.hidden = YES;
        }else{
            _saveBtn.hidden = NO;
        }
//        if (_isConnect) {
//            if (_isConnect) {
                [self showProgressView];

                [[BluetoolsManageVC instance] connectToDev:@[@"8",@"16",@"13",@"21"] devType:@"GetBaseSet"];

//            }else{
//                _connectNum = 0;
//                [[BluetoolsManageVC instance] connectToHost:@"192.168.10.100"];
//            }
//        }
    }
}
//路由器设置,tag 1000 - 1002
- (void)createLuYouSet:(CGFloat)tipsY{
    
    UIView *luyouv = [[UIView alloc]initWithFrame:CGRectMake(0, tipsY, kScreenWidth, 15*HEIGHT_SIZE + (30*HEIGHT_SIZE + 15*HEIGHT_SIZE)*4 + 30*HEIGHT_SIZE)];
    luyouv.backgroundColor = WhiteColor;
    [_bgscrollV addSubview:luyouv];
    _LuyouSetV = luyouv;
    //DHCP
    UILabel *dhcplb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 15*HEIGHT_SIZE, 70*NOW_SIZE, 30*HEIGHT_SIZE)];
    dhcplb.adjustsFontSizeToFitWidth = YES;
    dhcplb.font = FontSize(13*HEIGHT_SIZE);
    dhcplb.textColor = colorblack_102;
    dhcplb.text = @"DHCP";
    [luyouv addSubview:dhcplb];
    _DHCPLB = dhcplb;
    
    UIButton *onoffbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dhcplb.frame)+10*NOW_SIZE, 15*HEIGHT_SIZE, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [onoffbtn setImage:IMAGE(@"Grobutton_off") forState:UIControlStateNormal];
    [onoffbtn setImage:IMAGE(@"Grobutton_on") forState:UIControlStateSelected];
    [onoffbtn addTarget:self action:@selector(DHCPOnOff:) forControlEvents:UIControlEventTouchUpInside];
    [luyouv addSubview:onoffbtn];
    onoffbtn.selected = NO;
    _DHCPBtn = onoffbtn;
    
    NSArray *titarr = @[NewAPSet_IPSet,NewAPSet_MacSet,HEM_charge_yanma];
    for (int i = 0; i < titarr.count; i ++) {
        UILabel *otherlb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(dhcplb.frame) + 15*HEIGHT_SIZE + (30*HEIGHT_SIZE + 15*HEIGHT_SIZE)*i, 110*NOW_SIZE, 30*HEIGHT_SIZE)];
        otherlb.adjustsFontSizeToFitWidth = YES;
        otherlb.font = FontSize(13*HEIGHT_SIZE);
        otherlb.textColor = colorblack_102;
        otherlb.text = titarr[i];
        otherlb.tag = 5000+i;
        [luyouv addSubview:otherlb];
        
        UITextField *otherTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherlb.frame)+10*NOW_SIZE, CGRectGetMaxY(dhcplb.frame) + 15*HEIGHT_SIZE + (30*HEIGHT_SIZE + 15*HEIGHT_SIZE)*i, kScreenWidth - CGRectGetMaxX(otherlb.frame)- 25*NOW_SIZE - 10*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
//        otherTF.layer.borderColor = colorblack_102.CGColor;
//        otherTF.layer.borderWidth = 0.6*NOW_SIZE;
        otherTF.tag = 1000+i;
        otherTF.delegate = self;
        otherTF.textColor = colorblack_102;

        otherTF.textAlignment = NSTextAlignmentRight;
        [luyouv addSubview:otherTF];
        
        UIImageView *rigImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTF.frame)+5*NOW_SIZE, otherTF.mj_y+(30*HEIGHT_SIZE - 13*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 13*HEIGHT_SIZE)];
        rigImg.image = IMAGE(@"prepare_more");
        rigImg.userInteractionEnabled = YES;
        rigImg.tag = 1000+i+1000;
        [luyouv addSubview:rigImg];
        rigImg.hidden = YES;
    }
    
    
    
    
}
- (void)DHCPOnOff:(UIButton *)onoffbtn{
    
    onoffbtn.selected = !onoffbtn.selected;
    if (onoffbtn.selected) {
        _DHCPLB.text = @"DHCP";
        for (int i = 0; i < 3; i++) {
            UIImageView *rigimg = [self.view viewWithTag:1000+i+1000];
            rigimg.hidden = NO;
            
        }
    }else{
        _DHCPLB.text = @"STATIC";
        for (int i = 0; i < 3; i++) {
            UIImageView *rigimg = [self.view viewWithTag:1000+i+1000];
            rigimg.hidden = YES;
            
        }
    }
    
}
//时间设置,tag  1100,1101
- (void)createtimeSet:(CGFloat)tipsY{
    
    UIView *luyouv = [[UIView alloc]initWithFrame:CGRectMake(0, tipsY, kScreenWidth, 15*HEIGHT_SIZE)];
    luyouv.backgroundColor = WhiteColor;
    [_bgscrollV addSubview:luyouv];
    _TimeSetV = luyouv;
    _TimeSetV.hidden = YES;
     
    
    UILabel *otherlb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,15*HEIGHT_SIZE, 110*NOW_SIZE, 30*HEIGHT_SIZE)];
    otherlb.adjustsFontSizeToFitWidth = YES;
    otherlb.font = FontSize(13*HEIGHT_SIZE);
    otherlb.textColor = colorblack_102;
    otherlb.text = NewAPSet_TimeSet;
    otherlb.tag = 5100;
    [luyouv addSubview:otherlb];
    
    UITextField *otherTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherlb.frame)+10*NOW_SIZE, 15*HEIGHT_SIZE, kScreenWidth - CGRectGetMaxX(otherlb.frame)- 25*NOW_SIZE - 10*HEIGHT_SIZE-40*NOW_SIZE, 30*HEIGHT_SIZE)];
//    otherTF.layer.borderColor = colorblack_102.CGColor;
//    otherTF.layer.borderWidth = 0.6*NOW_SIZE;
    otherTF.textAlignment = NSTextAlignmentRight;
    otherTF.tag = 1100;
    otherTF.delegate = self;
    otherTF.textColor = colorblack_102;

    [luyouv addSubview:otherTF];
    //分钟
    UILabel *minlb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTF.frame),15*HEIGHT_SIZE, 40*NOW_SIZE, 30*HEIGHT_SIZE)];
    minlb.adjustsFontSizeToFitWidth = YES;
    minlb.font = FontSize(13*HEIGHT_SIZE);
    minlb.textColor = colorblack_102;
    minlb.textAlignment = NSTextAlignmentCenter;
    minlb.text = root_MAX_459;
    minlb.userInteractionEnabled = YES;
    UITapGestureRecognizer *mingtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(danweiTap)];
    [minlb addGestureRecognizer:mingtap];
    [luyouv addSubview:minlb];
    
    
    UIImageView *rigImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(minlb.frame)+5*NOW_SIZE, otherTF.mj_y+(30*HEIGHT_SIZE - 13*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 13*HEIGHT_SIZE)];
    rigImg.image = IMAGE(@"prepare_more");
    rigImg.userInteractionEnabled = YES;
    rigImg.tag = 1100+1000;
    [luyouv addSubview:rigImg];
    rigImg.hidden = YES;
//    UILabel *danweilb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTF.frame) + 10*NOW_SIZE,15*HEIGHT_SIZE, 60*NOW_SIZE, 30*HEIGHT_SIZE)];
//    danweilb.adjustsFontSizeToFitWidth = YES;
//    danweilb.font = FontSize(13*HEIGHT_SIZE);
//    danweilb.textColor = colorblack_102;
//    danweilb.text = @"分钟";
//    danweilb.textAlignment = NSTextAlignmentCenter;
//    [luyouv addSubview:danweilb];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(otherlb.frame)+15*HEIGHT_SIZE, kScreenWidth, 10*HEIGHT_SIZE)];
    linev.backgroundColor = backgroundNewColor;
    [luyouv addSubview:linev];
    
    //
    UILabel *timelb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(linev.frame) + 15*HEIGHT_SIZE, 110*NOW_SIZE, 30*HEIGHT_SIZE)];
    timelb.adjustsFontSizeToFitWidth = YES;
    timelb.font = FontSize(13*HEIGHT_SIZE);
    timelb.textColor = colorblack_102;
    timelb.text = NewAPSet_CollTimeSet;
    timelb.tag = 5101;
    [luyouv addSubview:timelb];
    
    UITextField *timeTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timelb.frame)+10*NOW_SIZE, CGRectGetMaxY(linev.frame) + 15*HEIGHT_SIZE, kScreenWidth - CGRectGetMaxX(timelb.frame)- 25*NOW_SIZE - 10*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
//    timeTF.layer.borderColor = colorblack_102.CGColor;
//    timeTF.layer.borderWidth = 0.6*NOW_SIZE;
    timeTF.textAlignment = NSTextAlignmentRight;
    timeTF.tag = 1101;
    timeTF.delegate = self;
    timeTF.textColor = colorblack_102;

    [luyouv addSubview:timeTF];
    UIImageView *rigImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeTF.frame)+5*NOW_SIZE, timeTF.mj_y+(30*HEIGHT_SIZE - 13*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 13*HEIGHT_SIZE)];
    rigImg2.image = IMAGE(@"prepare_more");
    rigImg2.userInteractionEnabled = YES;
    rigImg2.tag = 1101+1000;

    [luyouv addSubview:rigImg2];
    rigImg2.hidden = YES;
    
    UILabel *dhcplb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(timelb.frame) + 15*HEIGHT_SIZE, 110*NOW_SIZE, 30*HEIGHT_SIZE)];
    dhcplb.adjustsFontSizeToFitWidth = YES;
    dhcplb.font = FontSize(13*HEIGHT_SIZE);
    dhcplb.textColor = colorblack_102;
    dhcplb.text = Root_TongbuTime;
    [luyouv addSubview:dhcplb];
    
    UIButton *onoffbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dhcplb.frame)+10*NOW_SIZE, CGRectGetMaxY(timelb.frame) + 15*HEIGHT_SIZE, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [onoffbtn setImage:IMAGE(@"Grobutton_off") forState:UIControlStateNormal];
    [onoffbtn setImage:IMAGE(@"Grobutton_on") forState:UIControlStateSelected];
    [onoffbtn addTarget:self action:@selector(TongBuOnOff:) forControlEvents:UIControlEventTouchUpInside];
    [luyouv addSubview:onoffbtn];
    _tongbuBtn = onoffbtn;
    luyouv.frame = CGRectMake(0, tipsY, kScreenWidth,CGRectGetMaxY(onoffbtn.frame)+20*HEIGHT_SIZE);
    
    
    //锁

//    UIView *lockView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, luyouv.frame.size.height)];
//    lockView.backgroundColor = [UIColor clearColor];
//    [_TimeSetV addSubview:lockView];
//    _LockV3 = lockView;
//
//    UIButton *lockbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE, lockView.frame.size.height - 40*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
//    [lockbtn setTitle:@"点击锁按钮进行更改" forState:UIControlStateNormal];
//    lockbtn.backgroundColor = buttonColor;
//    lockbtn.layer.cornerRadius = 20*HEIGHT_SIZE;
//    lockbtn.layer.masksToBounds = YES;
//    [lockbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    lockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
//    [lockbtn addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [lockView addSubview:lockbtn];
    
}

- (void)TongBuOnOff:(UIButton *)tongbuBtn{
    
    tongbuBtn.selected = !tongbuBtn.selected;
    if (tongbuBtn.selected) {
        NSDateFormatter *dataFormatter= [[NSDateFormatter alloc] init];
        dataFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [ dataFormatter  setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
        
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [dataFormatter stringFromDate:[NSDate date]];
        UITextField *caijiTF = [self.view viewWithTag:1101];
        caijiTF.text = time;
    }else{
        NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[@"31"]];
        UITextField *caijiTF = [self.view viewWithTag:1101];

        if (kStringIsEmpty(valuStr)) {
            caijiTF.text = @"";
        }else{
            caijiTF.text = valuStr;
        }

        
    }
}

//服务器设置,tag 1200,1201,1202
- (void)createServerSet:(CGFloat)tipsY{
    
    UIView *luyouv = [[UIView alloc]initWithFrame:CGRectMake(0, tipsY, kScreenWidth, 15*HEIGHT_SIZE)];
    luyouv.backgroundColor = WhiteColor;
    [_bgscrollV addSubview:luyouv];
    _ServerSetV = luyouv;
    _ServerSetV.hidden = YES;
    
    //域名设置
    UILabel *dhcplb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 15*HEIGHT_SIZE, 100*NOW_SIZE, 30*HEIGHT_SIZE)];
    dhcplb.adjustsFontSizeToFitWidth = YES;
    dhcplb.numberOfLines = 0;
    dhcplb.font = FontSize(13*HEIGHT_SIZE);
    dhcplb.textColor = colorblack_102;
    dhcplb.text = NewAPSet_YMSet;
    [luyouv addSubview:dhcplb];
    _yumingLB = dhcplb;
    
    UIButton *onoffbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dhcplb.frame)+10*NOW_SIZE, 15*HEIGHT_SIZE, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [onoffbtn setImage:IMAGE(@"Grobutton_off") forState:UIControlStateNormal];
    [onoffbtn setImage:IMAGE(@"Grobutton_on") forState:UIControlStateSelected];
    [onoffbtn addTarget:self action:@selector(yumingOnOff:) forControlEvents:UIControlEventTouchUpInside];
    [luyouv addSubview:onoffbtn];
    onoffbtn.selected = YES;
    _yumingBtn = onoffbtn;

    CGFloat cent_Y = CGRectGetMaxY(dhcplb.frame)+15*HEIGHT_SIZE;
    //服务器域名
    [self NewView:NewAPSet_ServerYMSet TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:cent_Y tagnum:1200 addToView:luyouv danwei:@""];

    cent_Y += 45*HEIGHT_SIZE;
   
    //服务器IP
    [self NewView:root_oss_767 TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:cent_Y tagnum:1201 addToView:luyouv danwei:@""];

//    [self NewView2:@"服务器IP" TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:cent_Y addToView:luyouv conten:@"adsd" danwei:@"" tag:1201];
    cent_Y += 45*HEIGHT_SIZE;

    //服务器端口
   

    [self NewView:NewAPSet_ServerDKSet TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:cent_Y tagnum:1202 addToView:luyouv danwei:@""];
    cent_Y += 45*HEIGHT_SIZE;

    
    luyouv.frame = CGRectMake(0, tipsY, kScreenWidth, cent_Y+15*HEIGHT_SIZE + 40*HEIGHT_SIZE);
    
    //锁
//    UIView *lockView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, luyouv.frame.size.height)];
//    lockView.backgroundColor = [UIColor clearColor];
//    [_ServerSetV addSubview:lockView];
//    _LockV = lockView;
//
//    UIButton *lockbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE, lockView.frame.size.height - 40*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
//    [lockbtn setTitle:@"点击锁按钮进行更改" forState:UIControlStateNormal];
//    lockbtn.backgroundColor = buttonColor;
//    lockbtn.layer.cornerRadius = 20*HEIGHT_SIZE;
//    lockbtn.layer.masksToBounds = YES;
//    [lockbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    lockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
//    [lockbtn addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [lockView addSubview:lockbtn];
}

//域名设置
- (void)yumingOnOff:(UIButton *)yumingBtn{
    _severListV.hidden = YES;
    yumingBtn.selected = !yumingBtn.selected;
    UITextField *yuminFT = [self.view viewWithTag:1200];
    UITextField *ipTF = [self.view viewWithTag:1201];
    UIImageView *rightimg = [self.view viewWithTag:1200+1000];
    UIImageView *rightimg1 = [self.view viewWithTag:1201+1000];
    
    if (yumingBtn.selected) {
        
        rightimg.hidden = NO;
        rightimg1.hidden = YES;
         yuminFT.text = _yumingStr;
        _ipStr = ipTF.text;
        ipTF.text = @"";
       
        

    }else{
        
        rightimg.hidden = YES;
        rightimg1.hidden = NO;
        ipTF.text = _ipStr;
       _yumingStr = yuminFT.text;
        yuminFT.text = @"";
    }
}
//- (void)createLockView{
//
//    if (_LockV) {
//        [_LockV removeFromSuperview];
//    }
//    UIView *lockView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _ServerSetV.frame.size.height)];
//    lockView.backgroundColor = [UIColor clearColor];
//    [_ServerSetV addSubview:lockView];
//    _LockV = lockView;
//
//    UIButton *lockbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE, lockView.frame.size.height - 40*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
//    [lockbtn setTitle:@"点击锁按钮进行更改" forState:UIControlStateNormal];
//    lockbtn.backgroundColor = colorblack_186;
//    [lockbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    lockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
//    [lockbtn addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [lockView addSubview:lockbtn];
//
//}
//服务器设置解锁,密码tag 1300 - 1305
- (void)lockBtnClick{
  
    if (_passWV) {
        [_passWV removeFromSuperview];
    }
    
    UIView *passLockView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    passLockView.backgroundColor = COLOR(0, 0, 0, 0.2);
    passLockView.tag = 2200;
    UITapGestureRecognizer *pastapg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(paswbgClick)];
    [passLockView addGestureRecognizer:pastapg];
    [KEYWINDOW addSubview:passLockView];
    _passWV = passLockView;
    
    UIView *pasvie = [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE, kScreenHeight/2 - 200*HEIGHT_SIZE*2/3, kScreenWidth - 40*NOW_SIZE, 200*HEIGHT_SIZE)];
    pasvie.backgroundColor = WhiteColor;
    pasvie.layer.cornerRadius = 10*HEIGHT_SIZE;
    pasvie.layer.masksToBounds = YES;
    [passLockView addSubview:pasvie];
    
    UIButton *canbtn = [[UIButton alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [canbtn setTitle:@"X" forState:UIControlStateNormal];
    [canbtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
    [canbtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pasvie addSubview:canbtn];
    
    UILabel *pastips1lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(canbtn.frame),5*HEIGHT_SIZE,pasvie.frame.size.width - 2*CGRectGetMaxX(canbtn.frame), 30*HEIGHT_SIZE)];
    pastips1lb.adjustsFontSizeToFitWidth = YES;
    pastips1lb.font = FontSize(14*HEIGHT_SIZE);
    pastips1lb.textColor = colorblack_102;
    pastips1lb.text = root_Alet_user_pwd;
    pastips1lb.textAlignment = NSTextAlignmentCenter;
    [pasvie addSubview:pastips1lb];
    
    UILabel *tips2lb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(pastips1lb.frame)+5*HEIGHT_SIZE,pasvie.frame.size.width - 20*NOW_SIZE, 30*HEIGHT_SIZE)];
    tips2lb.adjustsFontSizeToFitWidth = YES;
    tips2lb.font = FontSize(14*HEIGHT_SIZE);
    tips2lb.textColor = colorblack_154;
    tips2lb.text = NewAPSet_putinPsw;
    tips2lb.textAlignment = NSTextAlignmentCenter;
    [pasvie addSubview:tips2lb];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tips2lb.frame)+10*HEIGHT_SIZE, pasvie.frame.size.width, 0.2*HEIGHT_SIZE)];
    linev.backgroundColor = backgroundNewColor;
    [pasvie addSubview:linev];
    
//    CGFloat spaceLeft = (pasvie.frame.size.width - 6*30*HEIGHT_SIZE - 5*6*NOW_SIZE)/2;
////    CGFloat pasWide = (pasvie.frame.size.width - 20*NOW_SIZE - 6*30*HEIGHT_SIZE)/5;
//    CGFloat space = 6*NOW_SIZE;
//    for (int i = 0; i < 6; i ++) {
        
//        UITextField *pastf = [[UITextField alloc]initWithFrame:CGRectMake(spaceLeft + (30*HEIGHT_SIZE + space)*i, CGRectGetMaxY(linev.frame)+20*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
//        pastf.adjustsFontSizeToFitWidth = YES;
////        pastf.layer.borderColor = colorblack_186.CGColor;
////        pastf.layer.borderWidth = 0.6*NOW_SIZE;
//        [pastf addTarget:self action:@selector(textContentChanged:) forControlEvents:UIControlEventEditingChanged];
//        pastf.tag = 1300+i;
////        pastf.delegate = self;
//        pastf.backgroundColor = backgroundNewColor;
//        pastf.textAlignment = NSTextAlignmentCenter;
//        [pasvie addSubview:pastf];
//        if (i == 0) {
//            [pastf becomeFirstResponder];
//        }
//    }
    UITextField *pastf = [[UITextField alloc]initWithFrame:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(linev.frame)+5*HEIGHT_SIZE, pasvie.frame.size.width - 40*NOW_SIZE, 40*HEIGHT_SIZE)];
//    pastf.layer.borderColor = backgroundNewColor.CGColor;
//    pastf.layer.borderWidth = 0.6*NOW_SIZE;
    pastf.backgroundColor = backgroundNewColor;
    pastf.textAlignment = NSTextAlignmentCenter;
    pastf.tag = 1300;
    [pasvie addSubview:pastf];
    [pastf becomeFirstResponder];

    UIButton *unlockbtn = [[UIButton alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(pastf.frame)+20*HEIGHT_SIZE, pasvie.frame.size.width - 20*NOW_SIZE, 40*HEIGHT_SIZE)];
    [unlockbtn setTitle:root_jiesuo forState:UIControlStateNormal];
    unlockbtn.backgroundColor = buttonColor;
    [unlockbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    unlockbtn.layer.cornerRadius = 20*HEIGHT_SIZE;
    unlockbtn.layer.masksToBounds = YES;
    unlockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
    [unlockbtn addTarget:self action:@selector(unlockbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pasvie addSubview:unlockbtn];
    
}

- (void)cancelBtnClick{
    
    [_passWV removeFromSuperview];
    [_passWV endEditing:YES];
   
}
//判断密码是否正确
- (void)unlockbtnClick{
    
//    NSString *paswStr = @"";
//    for (int i = 0; i < 6; i ++) {
    UITextField *pswTF = [_passWV viewWithTag:1300];
//        paswStr = [NSString stringWithFormat:@"%@%@",paswStr,pswTF.text];
//    }
    NSLog(@"正确密码:%@,输入密码是:%@",_password,pswTF.text);
    [_passWV removeFromSuperview];

    if ([pswTF.text isEqualToString:_password]) {
        //暂时
//        [_LockV removeFromSuperview];
//        _LockV = nil;
//        //暂时
//        [_LockV22 removeFromSuperview];
//        _LockV22 = nil;
        
        [_LockV0 removeFromSuperview];
        _LockV0 = nil;
        
//        [_LockV3 removeFromSuperview];
//        _LockV3 = nil;
        
        _saveBtn.hidden = NO;
        _chonglianBtn.hidden = NO;
        
        for (int i = 0; i < 3; i++) {
            UITextField *changTF = [self.view viewWithTag:1000+i];
            UIImageView *rigIMG = [self.view viewWithTag:1000+i+1000];
            changTF.textColor = colorblack_51;
            rigIMG.hidden = NO;
            if (_DHCPBtn.selected) {
                rigIMG.hidden = NO;
            }else{
                
                rigIMG.hidden = YES;
            }
        }
        for (int i = 0; i < 2; i++) {
            UITextField *changTF = [self.view viewWithTag:1100+i];
            UIImageView *rigIMG = [self.view viewWithTag:1100+i+1000];
            changTF.textColor = colorblack_51;
            rigIMG.hidden = NO;
        
        }
        
        
        for (int i = 0; i < 3; i++) {
            UITextField *changTF = [self.view viewWithTag:1200+i];
            UIImageView *rigIMG = [self.view viewWithTag:1200+i+1000];
            changTF.textColor = colorblack_51;
            rigIMG.hidden = NO;
            if (_yumingBtn.selected) {
                if (i == 1) {
                    rigIMG.hidden = YES;
                }
            }else{
                
                if (i == 0) {
                    rigIMG.hidden = YES;
                }
            }
        }
        UITextField *changTF2 = [self.view viewWithTag:1400];
        changTF2.textColor = colorblack_51;
        UIImageView *rigIMG2 = [self.view viewWithTag:1400+1000];
        rigIMG2.hidden = NO;
    }else{
        [self showToastViewWithTitle:NewAPSet_pswerror];
    }
    
}

//-(void)textContentChanged:(UITextField*)textFiled
//
//{
//
////    NSLog( @"text changed11: %@", textFiled.text);
//
//    UITextRange * selectedRange = [textFiled markedTextRange];
//
//    if(selectedRange == nil || selectedRange.empty){
//
////    NSLog( @"text changed222: %@", textFiled.text);
//        if (textFiled.text.length > 0 && textFiled.text.length < 2) {
//            if (textFiled.tag != 1305) {
//                UITextField *texf = [self.view viewWithTag:textFiled.tag + 1];
//                [texf becomeFirstResponder];
//            }else{
//
//                [self.passWV endEditing:YES];
//            }
//
//        }
//    }
//
//}


//基本信息1400，1401-1403LB
- (void)createBaseMassageSet:(CGFloat)tipsY{
    
    UIView *luyouv = [[UIView alloc]initWithFrame:CGRectMake(0, tipsY, kScreenWidth, 15*HEIGHT_SIZE)];
    luyouv.backgroundColor = WhiteColor;
    [_bgscrollV addSubview:luyouv];
    _BaseSetV = luyouv;
    _BaseSetV.hidden = YES;
    
    CGFloat vie_Y = 15*HEIGHT_SIZE;
    [self NewView:root_pay_1098 TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:vie_Y tagnum:1400 addToView:_BaseSetV danwei:@""];
    vie_Y += 45*HEIGHT_SIZE;
    [self NewView2:NewAPSet_MACDZ TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:vie_Y addToView:_BaseSetV conten:@"" danwei:@"" tag:1401];
    vie_Y += 45*HEIGHT_SIZE;

    [self NewView2:NewAPSet_SBType TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:vie_Y addToView:_BaseSetV conten:@"" danwei:@"" tag:1402];
    vie_Y += 45*HEIGHT_SIZE;

    [self NewView2:root_oss_795 TFWide:(kScreenWidth - 100*NOW_SIZE - 25*NOW_SIZE - 10*HEIGHT_SIZE) TF_Y:vie_Y addToView:_BaseSetV conten:@"" danwei:@"" tag:1403];
    vie_Y += 45*HEIGHT_SIZE;
    
    luyouv.frame = CGRectMake(0, tipsY, kScreenWidth, vie_Y+15*HEIGHT_SIZE + 40*HEIGHT_SIZE);
    
    //锁

//    UIView *lockView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, luyouv.frame.size.height)];
//    lockView.backgroundColor = [UIColor clearColor];
//    [_BaseSetV addSubview:lockView];
//    _LockV22 = lockView;
//
//    UIButton *lockbtn = [[UIButton alloc]initWithFrame:CGRectMake(30*NOW_SIZE, lockView.frame.size.height - 40*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE)];
//    [lockbtn setTitle:@"点击锁按钮进行更改" forState:UIControlStateNormal];
//    lockbtn.backgroundColor = buttonColor;
//    lockbtn.layer.cornerRadius = 20*HEIGHT_SIZE;
//    lockbtn.layer.masksToBounds = YES;
//    [lockbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    lockbtn.titleLabel.font = FontSize(14*HEIGHT_SIZE);
//    [lockbtn addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [lockView addSubview:lockbtn];
    

}

//textFielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_yumingBtn.selected) {
        if (textField.tag == 1201) {
            return NO;
        }
    }else{
        
        if (textField.tag == 1200) {
            return NO;
        }
    }
    if (!_DHCPBtn.selected) {
        if (textField.tag == 1000 || textField.tag == 1001 || textField.tag == 1002) {
            return NO;

        }
    }
    if (textField.tag == 1200) {
        if (!_severListV) {
            NSArray *severarr = @[root_MAX_499,HEAD_URL];
            [self createSeverList:severarr];
        }else{
            _severListV.hidden = !_severListV.hidden;
        }
        return NO;
    }
    
    UILabel *titlb = [self.view viewWithTag:5000+textField.tag - 1000];
    [_alerterV setViewValue:textField.text title:titlb.text];
    _alerterV.hidden = NO;
    if (textField.tag == 1100) {
        _alerterV.contenTF.keyboardType = UIKeyboardTypeDecimalPad;
    }else{
        _alerterV.contenTF.keyboardType = UIKeyboardTypeDefault;
        
    }
    _alerterV.backBlock = ^(NSString * _Nonnull backValue) {
        textField.text = backValue;
    };
    return NO;
    
}

- (void)danweiTap{
    
    UILabel *titlb = [self.view viewWithTag:5100];
    UITextField *minTF = [self.view viewWithTag:1100];

    [_alerterV setViewValue:minTF.text title:titlb.text];
    _alerterV.hidden = NO;
    _alerterV.contenTF.keyboardType = UIKeyboardTypeDecimalPad;
    _alerterV.backBlock = ^(NSString * _Nonnull backValue) {
        minTF.text = backValue;
    };
}


- (void)NewView:(NSString *)NameStr TFWide:(CGFloat)TFWide TF_Y:(CGFloat)TFY tagnum:(NSInteger)tagNum addToView:(UIView *)bgview danwei:(NSString *)danweiStr{
    
    UILabel *otherlb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,TFY, 110*NOW_SIZE, 30*HEIGHT_SIZE)];
    otherlb.adjustsFontSizeToFitWidth = YES;
    otherlb.font = FontSize(13*HEIGHT_SIZE);
    otherlb.textColor = colorblack_102;
    otherlb.text = NameStr;
    otherlb.tag = 4000 + tagNum;
    otherlb.numberOfLines = 0;
    [bgview addSubview:otherlb];
    
    UITextField *otherTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherlb.frame)+10*NOW_SIZE,TFY, kScreenWidth - CGRectGetMaxX(otherlb.frame) - 25*NOW_SIZE - 10*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
//    otherTF.layer.borderColor = colorblack_102.CGColor;
//    otherTF.layer.borderWidth = 0.6*NOW_SIZE;
    otherTF.tag = tagNum;
    otherTF.textAlignment = NSTextAlignmentRight;
    otherTF.textColor = colorblack_102;

    otherTF.delegate = self;
    [bgview addSubview:otherTF];
    
    UIImageView *rigImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTF.frame)+5*NOW_SIZE, otherTF.mj_y+(30*HEIGHT_SIZE - 13*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 13*HEIGHT_SIZE)];
    rigImg2.image = IMAGE(@"prepare_more");
    rigImg2.userInteractionEnabled = YES;
    rigImg2.tag = tagNum + 1000;
    [bgview addSubview:rigImg2];
    rigImg2.hidden = YES;
    
//    if (!kStringIsEmpty(danweiStr)) {
//        UILabel *danweilb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTF.frame) + 10*NOW_SIZE,TFY,kScreenWidth - CGRectGetMaxX(otherTF.frame)-10*NOW_SIZE, 30*HEIGHT_SIZE)];
//        danweilb.adjustsFontSizeToFitWidth = YES;
//        danweilb.font = FontSize(13*HEIGHT_SIZE);
//        danweilb.textColor = colorblack_102;
//        danweilb.text = danweiStr;
//        danweilb.textAlignment = NSTextAlignmentCenter;
//        [bgview addSubview:danweilb];
//    }
   
}

- (void)NewView2:(NSString *)NameStr TFWide:(CGFloat)TFWide TF_Y:(CGFloat)TFY addToView:(UIView *)bgview conten:(NSString *)conten  danwei:(NSString *)danweiStr tag:(NSInteger)tagNum{
    UILabel *otherlb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,TFY, 110*NOW_SIZE, 30*HEIGHT_SIZE)];
    otherlb.adjustsFontSizeToFitWidth = YES;
    otherlb.font = FontSize(13*HEIGHT_SIZE);
    otherlb.textColor = colorblack_102;
    otherlb.text = NameStr;
    otherlb.numberOfLines = 0;
    [bgview addSubview:otherlb];
    
    UILabel *otherTF = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherlb.frame)+10*NOW_SIZE,TFY , kScreenWidth - CGRectGetMaxX(otherlb.frame) - 25*NOW_SIZE - 10*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    
    otherTF.adjustsFontSizeToFitWidth = YES;
    otherTF.font = FontSize(13*HEIGHT_SIZE);
    otherTF.textColor = colorblack_102;
    otherTF.text = conten;
    otherTF.tag = tagNum;
    otherTF.textAlignment = NSTextAlignmentRight;
    [bgview addSubview:otherTF];
    
//    if (!kStringIsEmpty(danweiStr)) {
//        UILabel *danweilb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otherTF.frame) + 10*NOW_SIZE,TFY,kScreenWidth - CGRectGetMaxX(otherTF.frame)-10*NOW_SIZE, 30*HEIGHT_SIZE)];
//        danweilb.adjustsFontSizeToFitWidth = YES;
//        danweilb.font = FontSize(13*HEIGHT_SIZE);
//        danweilb.textColor = colorblack_102;
//        danweilb.text = danweiStr;
//        danweilb.textAlignment = NSTextAlignmentCenter;
//        [bgview addSubview:danweilb];
//    }
    
}
//调整位置
- (void)reloadFrame:(NSString *)ClickNum{
    
    if ([ClickNum isEqualToString:@"0"]) {//高度:
        _saveBtn.frame = CGRectMake(30*NOW_SIZE,CGRectGetMaxY(_LuyouSetV.frame)+30*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE);
        _canBtn.frame = CGRectMake(30*NOW_SIZE,CGRectGetMaxY(_saveBtn.frame)+15*HEIGHT_SIZE, kScreenWidth - 60*NOW_SIZE, 40*HEIGHT_SIZE);
        _bgscrollV.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_canBtn.frame)+200*HEIGHT_SIZE);
        
    }
    
}

//保存
- (void)savebtn{
    
    _SetValueDic = [[NSMutableDictionary alloc]init];
    _isEdit1 = NO;
    _isEdit2 = NO;
    _isEdit3 = NO;
    _isEdit4 = NO;
    
    if (_mudic) {
        //路由器设置
        NSString *dhcpStr = _DHCPBtn.selected ?@"1":@"0";
        NSString *dhcp = [NSString stringWithFormat:@"%@",_mudic[@"71"]];
        if (![dhcp isEqualToString:dhcpStr]) {
            _isEdit1 = YES;
            [_SetValueDic setObject:dhcpStr forKey:@"71"];
        }
        NSArray *keySetArr = @[@"14",@"26",@"25"];
        for (int i = 0; i < keySetArr.count; i ++) {
            UITextField *ipTF = [self.view viewWithTag:1000+i];
           
            NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr[i]]];
            NSString *SetvaluStr = ipTF.text;
            if (kStringIsEmpty(valuStr) || [valuStr isEqualToString:@"0"]) {
                valuStr = @"";//[self showToastViewWithTitle:@"参数未设置"];
//                return;
            }
            if (![valuStr isEqualToString:SetvaluStr]) {
                _isEdit1 = YES;
                [_SetValueDic setObject:SetvaluStr forKey:keySetArr[i]];

            }
            
        }
//            时间设置
//            NSString *tongbu = [NSString stringWithFormat:@"%@",_mudic[@"71"]];
//            _tongbuBtn.selected = [tongbu isEqualToString:@"1"]?YES:NO;
        NSArray *keySetArr2 = @[@"4",@"31"];
        for (int i = 0; i < keySetArr2.count; i ++) {
            UITextField *ipTF = [self.view viewWithTag:1100+i];
            NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr2[i]]];
            NSString *SetvaluStr = ipTF.text;
            if (kStringIsEmpty(valuStr) || [valuStr isEqualToString:@"0"]) {
                valuStr = @"";//[self showToastViewWithTitle:@"参数未设置"];
//                return;
            }
            if (![valuStr isEqualToString:SetvaluStr]) {
                _isEdit2 = YES;

                [_SetValueDic setObject:SetvaluStr forKey:keySetArr2[i]];

            }

        }
        
        NSArray *keySetArr3 = @[@"19",@"17",@"18"];
        for (int i = 0; i < keySetArr3.count; i ++) {
            UITextField *ipTF = [self.view viewWithTag:1200+i];
            NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr3[i]]];
            NSString *SetvaluStr = ipTF.text;
            if (kStringIsEmpty(valuStr) || [valuStr isEqualToString:@"0"]) {
                valuStr = @"";//[self showToastViewWithTitle:@"参数未设置"];
//                return;
            }
            if (![valuStr isEqualToString:SetvaluStr]) {
                _isEdit3 = YES;

                [_SetValueDic setObject:SetvaluStr forKey:keySetArr3[i]];

            }

        }
        
        NSArray *keySetArr4 = @[@"8"];//,@"16",@"13",@"21"
        for (int i = 0; i < keySetArr4.count; i ++) {
//            if (i == 0) {
                UITextField *ipTF = [self.view viewWithTag:1400+i];
                NSString *valuStr = [NSString stringWithFormat:@"%@",_mudic[keySetArr4[i]]];
                NSString *SetvaluStr = ipTF.text;
                if (kStringIsEmpty(valuStr) || [valuStr isEqualToString:@"0"]) {
                    valuStr = @"";//[self showToastViewWithTitle:@"参数未设置"];
//                    return;
                }
                if (![valuStr isEqualToString:SetvaluStr]) {
                    _isEdit4 = YES;

                    [_SetValueDic setObject:SetvaluStr forKey:keySetArr4[i]];

                }
//            }else{
                
//                UILabel *iplb2 = [self.view viewWithTag:1400+i];
//                NSString *valuStr2 = [NSString stringWithFormat:@"%@",_mudic[keySetArr4[i]]];
//                NSString *SetvaluStr = iplb2.text;
//                if (kStringIsEmpty(SetvaluStr)) {
//                    [self showToastViewWithTitle:@"参数未设置"];
//                    return;
//                }
//                if (![valuStr2 isEqualToString:SetvaluStr]) {
//                    [_SetValueDic setObject:keySetArr[i] forKey:SetvaluStr];
//
//                }
//            }
            
           

        }
        
    }
    
    
    if (_isEdit1 || _isEdit2 || _isEdit3 || _isEdit4) {
        
        if (_SetValueDic.count > 0) {
            [self showProgressView];

//            if (_isConnect) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        [self showProgressView];
                    [[BluetoolsManageVC instance] dataSetWithDataDic:_SetValueDic devType:@""];
//                });
//            }else{
//
//                [[CollectorTestTCP1 instance] connectToHost:@"192.168.10.100"];
//                if (_isConnect) {
//                    [[CollectorTestTCP1 instance] dataSetWithDataDic:_SetValueDic devType:@""];
//
//                }
//
//            }
        }
    }else{
        
        [self showToastViewWithTitle:NewAPSet_NOChange];
    }
    
}
////取消
//- (void)cancelbtn{
//
//
//}
//服务器列表
- (void)createSeverList:(NSArray *)severArr{
    UITextField *texf = [self.view viewWithTag:1200];
    UIView *val = [[UIView alloc]initWithFrame:CGRectMake(texf.frame.origin.x, CGRectGetMaxY(texf.frame), texf.frame.size.width, 30*HEIGHT_SIZE*severArr.count)];
    val.backgroundColor = WhiteColor;
    val.layer.cornerRadius = 5*HEIGHT_SIZE;
    val.layer.borderColor = colorblack_154.CGColor;
    val.layer.borderWidth = 1*NOW_SIZE;
    [_ServerSetV addSubview:val];
    _severListV = val;
    val.hidden = NO;
    
    for (int i = 0; i < severArr.count; i ++) {
        UILabel *titlb = [[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 30*HEIGHT_SIZE*i, val.frame.size.width-10*NOW_SIZE, 30*HEIGHT_SIZE)];
        titlb.adjustsFontSizeToFitWidth = YES;
        titlb.font = FontSize(13*HEIGHT_SIZE);
        titlb.textColor = colorblack_102;
        titlb.textAlignment = NSTextAlignmentRight;
        titlb.userInteractionEnabled = YES;
        titlb.tag = 3000+i;
        [val addSubview:titlb];
        titlb.text = severArr[i];
        UITapGestureRecognizer *lbtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listclick:)];
        [titlb addGestureRecognizer:lbtap];
    }
    
    
}

- (void)listclick:(UITapGestureRecognizer*)gest{
    
    if (gest.view.tag == 3000) {
        _severListV.hidden = YES;

        UITextField *textf = [self.view viewWithTag:1200];

        UILabel *titlb = [self.view viewWithTag:5000+1200 - 1000];
        [_alerterV setViewValue:textf.text title:titlb.text];
        _alerterV.hidden = NO;
        _alerterV.contenTF.keyboardType = UIKeyboardTypeDefault;
        _alerterV.backBlock = ^(NSString * _Nonnull backValue) {
            textf.text = backValue;
        };
    }else{
        UILabel *bglb = [self.view viewWithTag:gest.view.tag];
        UITextField *textf = [self.view viewWithTag:1200];
        textf.text = bglb.text;
        _severListV.hidden = YES;
    }
   
}

- (void)bgscrollClick{
    
    [self.view endEditing:YES];
}
- (void)paswbgClick{
    
    [KEYWINDOW endEditing:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
