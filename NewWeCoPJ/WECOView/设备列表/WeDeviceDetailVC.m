//
//  WeDeviceDetailVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/13.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeDeviceDetailVC.h"
#import "BDCMassageCell.h"
#import "WeRightItemView.h"
#import "WeDeviceSetVC.h"
@interface WeDeviceDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UIButton *LeftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIScrollView *bgscrollv;
@property (nonatomic, strong)NSArray *leftNameArr;
@property (nonatomic, strong)NSArray *rightNameArr;
@property (nonatomic, strong)NSArray *leftValueArr;
@property (nonatomic, strong)NSArray *rightValueArr;
@property (nonatomic, strong)NSDictionary *XPDataDic;
@property (nonatomic, strong)UITableView *devTablev;
@property (nonatomic, strong)NSArray *titleName;
@property (nonatomic, strong)NSArray *HVBSubNumArr;
@property (nonatomic, strong)NSArray *HVBSubValueArr;
@property (nonatomic, strong)WeRightItemView *rightMenuView;

@property (nonatomic, assign)NSInteger HVBSeleNumb;
@property (nonatomic, strong)UIScrollView *HVBRightScrollv;
@property (nonatomic, assign)NSInteger PcsShowNumb;
@property (nonatomic, assign)NSInteger MPPTShowNumb;
@property (nonatomic, strong)NSArray *PCS1NamArr;
@property (nonatomic, strong)NSArray *MPPTNamArr;
@property (nonatomic, strong)UILabel *SecTitleLB;
@property (nonatomic, strong)NSString *PCS1Title;
@property (nonatomic, strong)NSString *Mppt1Title;

@end

@implementation WeDeviceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail";
    if([_deviceType isEqualToString:@"3"] || [_deviceType isEqualToString:@"2"]){
        
        [self HVBOXFirstSet];
    }else{
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"WeMoreList") style:UIBarButtonItemStylePlain target:self action:@selector(DevSetClick)];
        [self createBatUI];

    }
    
    [self getDevDetailNet];
    
    

    // Do any additional setup after loading the view.
    

}
- (void)DevSetClick{
    
    if(_rightMenuView){
        
        [_rightMenuView removeFromSuperview];
        _rightMenuView = nil;
    }
 
    NSArray *namearr = @[@"Setting"];//@"Edit Name",
    _rightMenuView = [[WeRightItemView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _rightMenuView.dataArr = namearr;
 
    _rightMenuView.tabvY = kNavBarHeight;
    [KEYWINDOW addSubview:_rightMenuView];
    [_rightMenuView showView];
    __weak typeof(self)weakself = self;
    _rightMenuView.selectBlock = ^(NSString * _Nonnull seleText, int numbSelect) {
        
//        if(numbSelect == 0){
//            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"Edit Name" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//            [alvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//                textField.placeholder = @"Please enter...";
//
//            }];
//            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//
//            }]];
//            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            }]];
//            [weakself presentViewController:alvc animated:YES completion:nil];
//
//        }
        if(numbSelect == 0){
            
         UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"Note" message:@"1. Not allowed for unauthorized personnel!\n2. The wrong setting may cause the system to stop working,please enter the password" preferredStyle:UIAlertControllerStyleAlert];
            UIView *subview1 = alvc.view.subviews[0];
            UIView *subview2 = subview1.subviews[0];
            UIView *subview3 = subview2.subviews[0];
            UIView *subview4 = subview3.subviews[0];
            UIView *subview5 = subview4.subviews[0];

            UILabel *messageLB = subview5.subviews[2];
            messageLB.textAlignment = NSTextAlignmentLeft;
            
            [alvc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"Please enter...";
            }];
            
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *firtext = alvc.textFields.firstObject;
                
                
                WeDeviceSetVC *devsetName = [[WeDeviceSetVC alloc]init];
                devsetName.devSN = weakself.deviceSn;
                devsetName.deviceType = weakself.deviceType;
                [weakself.navigationController pushViewController:devsetName animated:YES];
                
            }]];
            
            [weakself presentViewController:alvc animated:YES completion:nil];
            
        }
    };
 

}


- (void)createBatUI{
    
    if([_deviceType isEqualToString:@"2"]){//设备类型(1:PCS,2:XP,3:HVBOX,4:麦格瑞能逆变器)
        
        _titleName = @[@""];

        NSArray *nameArr = @[@[@[Dev_Model,Dev_SN],@[Dev_ID,Dev_BMSType],@[Dev_FWVersion,Dev_Protocol],@[Dev_Voltage,Dev_Current],@[Dev_MVolt,Dev_MinVolt],@[Dev_MaxTem,Dev_MinTem],@[Dev_CEnergy,Dev_DCEnergy],@[@"System SOC"]]];//Dev_DischargeP,
        _leftNameArr = nameArr;
        
        _leftValueArr = @[@[@[@"batteryMode",@"batterySn"],@[@"batteryId",@"bmsType"],@[@"fwVersion",@"actualProtocol"],@[@"totalVoltage",@"current"],@[@"maxVolt",@"minVolt"],@[@"maxTem",@"minTem"],@[@"chargeEnergy",@"dischargeEnergy"],@[@"batterySoc"]]];//@"dischargePower",
    }
    
    if([_deviceType isEqualToString:@"1"]){
        
        _PCS1NamArr = @[@"PCS Data 1",@"PCS Data 2",@"PCS Data 3",@"PCS Data 4"];
        _MPPTNamArr = @[@"MPPT Data 1",@"MPPT Data 2",@"MPPT Data 3",@"MPPT Data 4"];
        _PCS1Title = @"PCS Data 1";
        _Mppt1Title = @"MPPT Data 1";
        _titleName = @[@"",@"PCS Data 1",@"MPPT Data 1",@"Bat.Data"];

//        ELE_Model,,@[ELE_FVersion]
        NSArray *nameArr3 = @[
        @[@[ELE_DevSN,ELE_Rated],@[@"Software Version",ELE_FVersion]],
        @[@[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]]],
        @[@[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]]],
        @[@[ELE_BatVoltage,ELE_BRunStatus],@[ELE_BSOC,ELE_BCurrent],@[ELE_BMCurrent,ELE_BSOH],@[ELE_BMVoltage,ELE_BMDCurrent],@[ELE_BMCellTemp,ELE_BMinCellTemp],@[ELE_BMCellVolt]]
        ];//ELE_BForbidC,,@[ELE_BForbidDisc]
        _leftNameArr = nameArr3;
        
        //@"deviceType",,@[@"firmwareVersion"]
        NSArray *KeyArr3 = @[@[@[@"deviceSn",@"ratedPower"],@[@"softwareVersion",@"firmwareVersion"]],
            
            @[@[@[@"uPhaseVoltage1",@"uPhaseCurrent1"],@[@"vPhaseVoltage1",@"vPhaseCurrent1"],@[@"wPhaseVoltage1",@"wPhaseCurrent1"],@[@"activePower1",@"reactivePower1"],@[@"acFrequency1",@"workMode1"],@[@"deviceStatus1"]],
            @[@[@"uPhaseVoltage2",@"uPhaseCurrent2"],@[@"vPhaseVoltage2",@"vPhaseCurrent2"],@[@"wPhaseVoltage2",@"wPhaseCurrent2"],@[@"activePower2",@"reactivePower2"],@[@"acFrequency2",@"workMode2"],@[@"deviceStatus2"]],
            @[@[@"uPhaseVoltage3",@"uPhaseCurrent3"],@[@"vPhaseVoltage3",@"vPhaseCurrent3"],@[@"wPhaseVoltage3",@"wPhaseCurrent3"],@[@"activePower3",@"reactivePower3"],@[@"acFrequency3",@"workMode3"],@[@"deviceStatus3"]],
            @[@[@"uPhaseVoltage4",@"uPhaseCurrent4"],@[@"vPhaseVoltage4",@"vPhaseCurrent4"],@[@"wPhaseVoltage4",@"wPhaseCurrent4"],@[@"activePower4",@"reactivePower4"],@[@"acFrequency4",@"workMode4"],@[@"deviceStatus4"]]],
        @[@[@[@"inputVoltage1",@"inputTemp1"],@[@"inputPower1",@"inputCurrent1"],@[@"dcRunState1",@"dcAccessType1"],@[@"dcFaultStatus1",@"highSideVoltage1"]],
         @[@[@"inputVoltage2",@"inputTemp2"],@[@"inputPower2",@"inputCurrent2"],@[@"dcRunState2",@"dcAccessType2"],@[@"dcFaultStatus2",@"highSideVoltage2"]],
         @[@[@"inputVoltage3",@"inputTemp3"],@[@"inputPower3",@"inputCurrent3"],@[@"dcRunState3",@"dcAccessType3"],@[@"dcFaultStatus3",@"highSideVoltage3"]],
         @[@[@"inputVoltage4",@"inputTemp4"],@[@"inputPower4",@"inputCurrent4"],@[@"dcRunState4",@"dcAccessType4"],@[@"dcFaultStatus4",@"highSideVoltage4"]]],
        @[@[@"voltage",@"runStatus"],@[@"soc",@"current"],@[@"maxChargeCurrent",@"soh"],@[@"maxCellVoltege",@"maxDischargeCurrent"],@[@"maxCellTemp",@"minCellTemp"],@[@"minCellVoltage"]]];//@"forbidCharge",,@[@"forbidDischarge"]
        
        _leftValueArr = KeyArr3;
        
        
//        _titleName = @[@"",@"PCS Data 1",@"PCS Data 2",@"PCS Data 3",@"PCS Data 4",@"MPPT Data 1",@"MPPT Data 2",@"MPPT Data 3",@"MPPT Data 4",@"Bat.Data"];
//
////        ELE_Model,,@[ELE_FVersion]
//        NSArray *nameArr3 = @[
//        @[@[ELE_DevSN,ELE_Rated],@[@"Software Version",ELE_FVersion]],
//        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
//        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
//        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
//        @[@[ELE_UVoltage,ELE_UCurrent],@[ELE_VVoltage,ELE_VCurrent],@[ELE_WVoltage,ELE_WCurrent],@[ELE_ActiveP,ELE_Reactive],@[ELE_ACFrequency,ELE_OperatingM],@[ELE_DevStatu]],
//        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
//        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
//        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
//        @[@[@"Input Voltage",@"Input Temp."],@[@"Input Power",@"Input Current"],@[@"DC Run State",@"DC Access type"],@[@"DC Fault Status",@"High Side Voltage"]],
//        @[@[ELE_BatVoltage,ELE_BRunStatus],@[ELE_BSOC,ELE_BCurrent],@[ELE_BMCurrent,ELE_BSOH],@[ELE_BMVoltage,ELE_BMDCurrent],@[ELE_BMCellTemp,ELE_BMinCellTemp],@[ELE_BMCellVolt]]
//        ];//ELE_BForbidC,,@[ELE_BForbidDisc]
//        _leftNameArr = nameArr3;
//
//        //@"deviceType",,@[@"firmwareVersion"]
//        NSArray *KeyArr3 = @[@[@[@"deviceSn",@"ratedPower"],@[@"softwareVersion",@"firmwareVersion"]],
//
//            @[@[@"uPhaseVoltage1",@"uPhaseCurrent1"],@[@"vPhaseVoltage1",@"vPhaseCurrent1"],@[@"wPhaseVoltage1",@"wPhaseCurrent1"],@[@"activePower1",@"reactivePower1"],@[@"acFrequency1",@"workMode1"],@[@"deviceStatus1"]],
//            @[@[@"uPhaseVoltage2",@"uPhaseCurrent2"],@[@"vPhaseVoltage2",@"vPhaseCurrent2"],@[@"wPhaseVoltage2",@"wPhaseCurrent2"],@[@"activePower2",@"reactivePower2"],@[@"acFrequency2",@"workMode2"],@[@"deviceStatus2"]],
//            @[@[@"uPhaseVoltage3",@"uPhaseCurrent3"],@[@"vPhaseVoltage3",@"vPhaseCurrent3"],@[@"wPhaseVoltage3",@"wPhaseCurrent3"],@[@"activePower3",@"reactivePower3"],@[@"acFrequency3",@"workMode3"],@[@"deviceStatus3"]],
//            @[@[@"uPhaseVoltage4",@"uPhaseCurrent4"],@[@"vPhaseVoltage4",@"vPhaseCurrent4"],@[@"wPhaseVoltage4",@"wPhaseCurrent4"],@[@"activePower4",@"reactivePower4"],@[@"acFrequency4",@"workMode4"],@[@"deviceStatus4"]],
//        @[@[@"inputVoltage1",@"inputTemp1"],@[@"inputPower1",@"inputCurrent1"],@[@"dcRunState1",@"dcAccessType1"],@[@"dcFaultStatus1",@"highSideVoltage1"]],
//         @[@[@"inputVoltage2",@"inputTemp2"],@[@"inputPower2",@"inputCurrent2"],@[@"dcRunState2",@"dcAccessType2"],@[@"dcFaultStatus2",@"highSideVoltage2"]],
//         @[@[@"inputVoltage3",@"inputTemp3"],@[@"inputPower3",@"inputCurrent3"],@[@"dcRunState3",@"dcAccessType3"],@[@"dcFaultStatus3",@"highSideVoltage3"]],
//         @[@[@"inputVoltage4",@"inputTemp4"],@[@"inputPower4",@"inputCurrent4"],@[@"dcRunState4",@"dcAccessType4"],@[@"dcFaultStatus4",@"highSideVoltage4"]],
//        @[@[@"voltage",@"runStatus"],@[@"soc",@"current"],@[@"maxChargeCurrent",@"soh"],@[@"maxCellVoltege",@"maxDischargeCurrent"],@[@"maxCellTemp",@"minCellTemp"],@[@"minCellVoltage"]]];//@"forbidCharge",,@[@"forbidDischarge"]
//
//        _leftValueArr = KeyArr3;
    }
    if([_deviceType isEqualToString:@"4"]){//设备类型(1:PCS,2:XP,3:HVBOX,4:麦格瑞能逆变器)
        
        _titleName = @[@"",@"AC/DC Data",@"DC/DC Data",@"Bat.Data"];

        NSArray *nameArr3 = @[
        @[@[ELE_DevSN,ELE_Rated],@[@"Device Type",@"LCD Version"],@[@"INV Status",@"System Status"],@[@"DC Run Status",@"DSP versions"]],
        @[@[@"Grid_B Voltage",@"Grid_B Current"],@[@"Active Power",@"Reactive Power"],@[@"AC Frequency",@"Device status"]],
        @[@[@"Low Voltage 1",@"Low Voltage 2"],@[@"Low Current 1",@"Low Current 2"],@[@"Low Power 1",@"Low Power 2"],@[@"Low Voltage3",@"Low Voltage4"],@[@"Low Current 3",@"Low Current 4"],@[@"Low Power 3",@"Low Power 4"]],
        @[@[ELE_BatVoltage,ELE_BCurrent],@[ELE_BSOC,@"BAT Temp."],@[ELE_BMVoltage,ELE_BMCellVolt],@[@"Charge Voltage",@"Charge Current Limite"],@[@"Discharge Current Limite"]]
        ];
        _leftNameArr = nameArr3;
        
        NSArray *KeyArr3 = @[@[@[@"deviceSn",@"ratedPower"],@[@"deviceType",@"lcdVersions"],@[@"invStatus",@"systemStatus"],@[@"dcRunStatus",@"dspVersions"]],
            
            @[@[@"uPhaseVoltage",@"uPhaseCurrent"],@[@"activePower",@"reactivePower"],@[@"acFrequency",@"wPhaseCurrent1"],@[@"activePower1",@"reactivePower1"],@[@"acFrequency1",@"workMode"]],
            @[@[@"lowVoltage1",@"lowVoltage2"],@[@"lowCurrent1",@"lowCurrent2"],@[@"lowPower1",@"lowPower2"],@[@"lowVoltage3",@"lowVoltage4"],@[@"lowCurrent3",@"lowCurrent4"],@[@"lowPower3",@"lowPower4"]],
     
        @[@[@"batVoltage",@"batCurrent"],@[@"soc",@"batTemp"],@[@"maxCellVoltage",@"minCellVoltage"],@[@"chargeVoltage",@"chargeCurrentLimite"],@[@"dischargeCurrentLimite"]]];
        
        _leftValueArr = KeyArr3;
    }

    [self createTableVie];
    
}
- (void)createTableVie{
    
    UITableView *BDCTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight-kNavBarHeight) style:UITableViewStyleGrouped];
    BDCTable.delegate = self;
    BDCTable.dataSource = self;
    BDCTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:BDCTable];
//    _BDCTablev = BDCTable;
    
    [BDCTable registerClass:[BDCMassageCell class] forCellReuseIdentifier:@"BDCCELLID"];
    _devTablev = BDCTable;
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self getDevDetailNet];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.devTablev.mj_header endRefreshing];
        });
    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    header2.stateLabel.hidden = YES;
    _devTablev.mj_header = header2;

}

- (void)HVBOXFirstSet{
    
//    UILabel *headlb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"Series Battery Date" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
//    [self.view addSubview:headlb];

    UIScrollView *bgscrollv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*2, kScreenHeight-kNavBarHeight-60*HEIGHT_SIZE)];
    bgscrollv.pagingEnabled = YES;
    bgscrollv.scrollEnabled = YES;
    bgscrollv.showsVerticalScrollIndicator = NO;
    bgscrollv.showsHorizontalScrollIndicator = NO;
    bgscrollv.delegate = self;
    bgscrollv.bounces = NO;
    [self.view addSubview:bgscrollv];
    _bgscrollv = bgscrollv;
    _bgscrollv.contentSize = CGSizeMake(3*kScreenWidth, kScreenHeight-kNavBarHeight-100*HEIGHT_SIZE);
    
    
//    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
//
//        [self getDevDetailNet];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.bgscrollv.mj_header endRefreshing];
//        });
//    }];
//    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
//    header2.stateLabel.hidden = YES;
//    _bgscrollv.mj_header = header2;

    UIView *downView = [self goToInitView:CGRectMake(0, kScreenHeight-60*HEIGHT_SIZE-kNavBarHeight, kScreenWidth, 60*HEIGHT_SIZE) backgroundColor:WhiteColor];
    [self.view addSubview:downView];

    UIButton *pointbtn = [self goToInitButton:CGRectMake(kScreenWidth/2-5*NOW_SIZE-10*HEIGHT_SIZE, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) TypeNum:1 fontSize:14 titleString:@"" selImgString:@"" norImgString:@""];
    pointbtn.layer.cornerRadius = 5*HEIGHT_SIZE;
    pointbtn.layer.masksToBounds = YES;
    pointbtn.backgroundColor = colorBlack;
    [pointbtn addTarget:self action:@selector(leftPointClick:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:pointbtn];
    _LeftBtn = pointbtn;

    UIButton *rightbtn = [self goToInitButton:CGRectMake(kScreenWidth/2+5*NOW_SIZE, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) TypeNum:1 fontSize:14 titleString:@"" selImgString:@"" norImgString:@""];
    rightbtn.layer.cornerRadius = 5*HEIGHT_SIZE;
    rightbtn.layer.masksToBounds = YES;
    rightbtn.backgroundColor = backgroundNewColor;
    [rightbtn addTarget:self action:@selector(rightPointClick:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:rightbtn];
    _rightBtn = rightbtn;

//    UIButton *downBtn = [self goToInitButton:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(pointbtn.frame)+10*HEIGHT_SIZE, kScreenWidth-40*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:3 fontSize:14*HEIGHT_SIZE titleString:@"Download My Data" selImgString:@"WedownLoad" norImgString:@"WedownLoad"];
//    [downBtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
//    downBtn.backgroundColor = backgroundNewColor;
//    [downBtn addTarget:self action:@selector(downCLick) forControlEvents:UIControlEventTouchUpInside];
//    [downView addSubview:downBtn];
    
    [self createHVBOXUI];
    
    
}

//HVBOX界面
- (void)createHVBOXUI{
    
    _HVBSubNumArr = @[@[@"Sub1",@"Sub2",@"Sub3",@"Sub4"],@[@"Sub5",@"Sub6",@"Sub7",@"Sub8"],@[@"Sub9",@"Sub10",@"Sub11",@"Sub12"],@[@"Sub13",@"Sub14",@"Sub15",@"Sub16"]];
    
    _titleName = @[@""];

    NSArray *nameArr = @[@[@[Dev_Model,Dev_SN],@[Dev_ID,Dev_BMSType],@[Dev_FWVersion,Dev_Protocol],@[Dev_Voltage,Dev_Current],@[Dev_MVolt,Dev_MinVolt],@[Dev_MaxTem,Dev_MinTem],@[Dev_CEnergy,Dev_DCEnergy],@[@"System SOC"]]];//Dev_DischargeP,
    _leftNameArr = nameArr;
    
    _leftValueArr = @[@[@[@"batteryMode",@"batterySn"],@[@"batteryId",@"bmsType"],@[@"fwVersion",@"actualProtocol"],@[@"totalVoltage",@"current"],@[@"maxVolt",@"minVolt"],@[@"maxTem",@"minTem"],@[@"chargeEnergy",@"dischargeEnergy"],@[@"batterySoc"]]];//@"dischargePower",
    
    if ([_deviceType isEqualToString:@"2"]) {
        _titleName = @[@""];

        _leftNameArr = @[@[@[Dev_Model,Dev_SN],@[Dev_ID,Dev_BMSType],@[Dev_FWVersion,Dev_Protocol],@[Dev_Voltage,Dev_Current],@[Dev_MVolt,Dev_MinVolt],@[Dev_MaxTem,Dev_MinTem],@[Dev_CEnergy,Dev_DCEnergy],@[@"System SOC"]]];//Dev_DischargeP,
        
        _leftValueArr = @[@[@[@"batteryMode",@"batterySn"],@[@"batteryId",@"bmsType"],@[@"fwVersion",@"actualProtocol"],@[@"totalVoltage",@"current"],@[@"maxVolt",@"minVolt"],@[@"maxTem",@"minTem"],@[@"chargeEnergy",@"dischargeEnergy"],@[@"batterySoc"]]];//@"dischargePower",
    }
    
    UITableView *BDCTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight-kNavBarHeight-70*HEIGHT_SIZE) style:UITableViewStyleGrouped];
    BDCTable.delegate = self;
    BDCTable.dataSource = self;
//    BDCTable.bounces = NO;
    BDCTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    BDCTable.scrollEnabled = NO;
    [_bgscrollv addSubview:BDCTable];
//    _BDCTablev = BDCTable;
    [BDCTable registerClass:[BDCMassageCell class] forCellReuseIdentifier:@"BDCCELLID"];
    _devTablev = BDCTable;
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self getDevDetailNet];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.bgscrollv.mj_header endRefreshing];
        });
    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    header2.stateLabel.hidden = YES;
    BDCTable.mj_header = header2;

    
    
    UIScrollView *HVBGScrollv = [self goToInitScrollView:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kNavBarHeight-60*HEIGHT_SIZE) backgroundColor:WhiteColor];
//    HVBGScrollv.scrollEnabled = NO;
//    HVBGScrollv.bounces = NO;
    [_bgscrollv addSubview:HVBGScrollv];
    _HVBRightScrollv = HVBGScrollv;
    MJRefreshNormalHeader *header3  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

        [self getDevDetailNet];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.bgscrollv.mj_header endRefreshing];
        });
    }];
    header3.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header3.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    header3.stateLabel.hidden = YES;
    HVBGScrollv.mj_header = header3;
    
    
    
//    UILabel *titlb = [self goToInitLable:CGRectMake(15*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE) textName:@"Series Battery Date" textColor:colorblack_51 fontFloat:15*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
//    titlb.adjustsFontSizeToFitWidth = YES;
//    [HVBGScrollv addSubview:titlb];
    
//    NSArray *nameArr2 = @[Dev_MainRelay,Dev_CVoltage,home_BatteryCycles,home_ActyalCurrent];
    NSArray *nameArr2 = @[home_BatteryCycles,Dev_CVoltage];

    _rightNameArr = nameArr2;
    
    for (int i = 0; i < nameArr2.count; i ++) {
        
        int t = i/2;
        int L = i%2;
        
        //CGRectGetMaxY(titlb.frame)+
        UIView *oneview = [self goToInitView:CGRectMake(20*NOW_SIZE+((kScreenWidth-60*NOW_SIZE)/2 + 20*NOW_SIZE)*L, 10*HEIGHT_SIZE+70*HEIGHT_SIZE*t, (kScreenWidth-60*NOW_SIZE)/2, 70*HEIGHT_SIZE) backgroundColor:WhiteColor];
        [HVBGScrollv addSubview:oneview];
        
        UILabel *oneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,oneview.xmg_width, 30*HEIGHT_SIZE)];
        oneLB.adjustsFontSizeToFitWidth = YES;
        oneLB.font = FontSize(14*HEIGHT_SIZE);
        oneLB.textColor = colorblack_102;
        oneLB.textAlignment = NSTextAlignmentCenter;
        oneLB.text = nameArr2[i];
        oneLB.numberOfLines = 0;
        [oneview addSubview:oneLB];
        
        UILabel *valueLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLB.frame),oneview.xmg_width, 30*HEIGHT_SIZE)];
        valueLB.adjustsFontSizeToFitWidth = YES;
        valueLB.font = FontSize(14*HEIGHT_SIZE);
        valueLB.textColor = colorBlack;
        valueLB.textAlignment = NSTextAlignmentCenter;
        valueLB.text = @"0";
        valueLB.numberOfLines = 0;
        valueLB.tag = 100+i;
        [oneview addSubview:valueLB];
        
        UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(valueLB.frame)+9*HEIGHT_SIZE, valueLB.xmg_width, 1*HEIGHT_SIZE)];
        linev.backgroundColor = colorblack_186;
        [oneview addSubview:linev];
    }
    
    if ([_deviceType isEqualToString:@"3"]) {
        [self HVBSubUI];
    }
    if ([_deviceType isEqualToString:@"2"]) {
        [self XPBatVolUI];
    }
}

- (void)XPBatVolUI{
    
    UILabel *titlb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 70*HEIGHT_SIZE+25*HEIGHT_SIZE, kScreenWidth, 40*HEIGHT_SIZE) textName:@"Cell Vol/(V)" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [_HVBRightScrollv addSubview:titlb];
    
    CGFloat onelbWide = (kScreenWidth -6*10*NOW_SIZE)/5;
    
    NSArray *nameArr = @[@"1-4",@"5-8",@"9-12",@"13-16"];
    
    for (int i = 0; i < nameArr.count; i++) {
        UIView *onevv = [self goToInitView:CGRectMake(0, (40*HEIGHT_SIZE+10*HEIGHT_SIZE)*i+CGRectGetMaxY(titlb.frame)+10*HEIGHT_SIZE, kScreenWidth, 40*HEIGHT_SIZE) backgroundColor:WhiteColor];
        [_HVBRightScrollv addSubview:onevv];
        
        UILabel *namlb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 0, onelbWide, 40*HEIGHT_SIZE) textName:nameArr[i] textColor:colorblack_102 fontFloat:13*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
        [onevv addSubview:namlb];
        
        UIView*valuview = [self goToInitView:CGRectMake(CGRectGetMaxX(namlb.frame)+10*NOW_SIZE, 0, kScreenWidth-CGRectGetMaxX(namlb.frame)-20*NOW_SIZE, 40*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
        [onevv addSubview:valuview];
        
        for (int t = 0; t < 4; t++) {
            UILabel *valulb = [self goToInitLable:CGRectMake((onelbWide+10*NOW_SIZE)*t, 0, onelbWide, 40*HEIGHT_SIZE) textName:@"0" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
            valulb.tag = 20000+t+100*i;
            [valuview addSubview:valulb];
        }
    }
    
}

- (void)HVBSubUI{
    
    
    self.HVBSeleNumb = 0;
    NSArray *timarr = @[@"1-4",@"5-8",@"9-12",@"13-16"];
    float wide = ((kScreenWidth-40*NOW_SIZE)-3*10*NOW_SIZE)/4;
    
    for (int i = 0; i < timarr.count; i ++) {
        UIButton *onebtn = [self goToInitButton:CGRectMake(20*NOW_SIZE+(wide+10*NOW_SIZE)*i, 70*HEIGHT_SIZE+25*HEIGHT_SIZE, wide, 40*HEIGHT_SIZE) TypeNum:1 fontSize:13*HEIGHT_SIZE titleString:timarr[i] selImgString:@"" norImgString:@""];
        [onebtn setTitleColor:COLOR(218, 75, 68, 1) forState:UIControlStateSelected];
        [onebtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
        [onebtn addTarget:self action:@selector(hbNumbClick:) forControlEvents:UIControlEventTouchUpInside];
        onebtn.tag = 1000+i;
        [_HVBRightScrollv addSubview:onebtn];
        onebtn.selected = NO;
        
        UIView *onelinev = [self goToInitView:CGRectMake(onebtn.xmg_x+(wide-30*NOW_SIZE)/2, CGRectGetMaxY(onebtn.frame), 30*NOW_SIZE, 1*HEIGHT_SIZE) backgroundColor:COLOR(218, 75, 68, 1)];
        onelinev.tag = 1100+i;
        [_HVBRightScrollv addSubview:onelinev];
        
        onelinev.hidden = YES;
        if(i == 0){
            
            onebtn.selected = YES;
            onelinev.hidden = NO;
        }
    }
    
    
    NSArray *datanamearr = @[@"Max Voltage",@"Min Voltage",@"Max temperature",@"Min temperature"];
    
    NSArray *onearr = _HVBSubNumArr[_HVBSeleNumb];

    for (int i = 0; i < onearr.count; i++) {
        
        UIView *oneview = [self goToInitView:CGRectMake(20*NOW_SIZE, 70*HEIGHT_SIZE+25*HEIGHT_SIZE+45*HEIGHT_SIZE+(130*HEIGHT_SIZE+10*HEIGHT_SIZE)*i, kScreenWidth-40*NOW_SIZE, 130*HEIGHT_SIZE) backgroundColor:WhiteColor];
        oneview.layer.cornerRadius = 10*HEIGHT_SIZE;
        oneview.layer.masksToBounds = YES;
        oneview.layer.borderColor = COLOR(226, 212, 210, 1).CGColor;
        oneview.layer.borderWidth = 1*HEIGHT_SIZE;
        [_HVBRightScrollv addSubview:oneview];
        
        
        UILabel *titlb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE, 60*NOW_SIZE, 30*HEIGHT_SIZE) textName:onearr[i] textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        titlb.tag = 2000+i;
        [oneview addSubview:titlb];
        
        UILabel *valuLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(titlb.frame), 5*HEIGHT_SIZE, 60*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"0" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
        valuLB.backgroundColor = backgroundNewColor;
        valuLB.layer.cornerRadius = 5*HEIGHT_SIZE;
        valuLB.layer.masksToBounds = YES;
        valuLB.tag = 2100+i;
        [oneview addSubview:valuLB];
        
        UIView *presBgView = [self goToInitView:CGRectMake(CGRectGetMaxX(valuLB.frame)+10*NOW_SIZE, 5*HEIGHT_SIZE, oneview.xmg_width-CGRectGetMaxX(valuLB.frame)-20*NOW_SIZE, 30*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
        presBgView.layer.cornerRadius = 5*HEIGHT_SIZE;
        presBgView.layer.masksToBounds = YES;
        presBgView.tag = 2200+i;
        [oneview addSubview:presBgView];
        UIView *preconView = [self goToInitView:CGRectMake(0, 0, 0, presBgView.xmg_height) backgroundColor:COLOR(218, 75, 68, 1)];
        preconView.tag = 2300+i;
        [presBgView addSubview:preconView];
        
        UILabel *preSLB = [self goToInitLable:CGRectMake(10*NOW_SIZE, 0, presBgView.xmg_width-20*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"0.0%" textColor:WhiteColor fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        preSLB.tag = 2400+i;

        [presBgView addSubview:preSLB];
        
        CGFloat viewide = (oneview.xmg_width-20*NOW_SIZE-3*5*NOW_SIZE)/4;
        
        for (int D = 0; D < datanamearr.count; D ++) {
            UIView *onedatav = [self goToInitView:CGRectMake(10*NOW_SIZE+(viewide + 5*NOW_SIZE)*D, CGRectGetMaxY(titlb.frame)+5*HEIGHT_SIZE, viewide, 80*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
            onedatav.layer.cornerRadius = 6*HEIGHT_SIZE;
            onedatav.layer.masksToBounds = YES;
            [oneview addSubview:onedatav];
            
            UILabel *dataNameLB = [self goToInitLable:CGRectMake(0, 0, viewide, 40*HEIGHT_SIZE) textName:datanamearr[D] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
            dataNameLB.numberOfLines = 0;
            [onedatav addSubview:dataNameLB];
            
            UILabel *dataValueLB = [self goToInitLable:CGRectMake(0, CGRectGetMaxY(dataNameLB.frame), viewide, 40*HEIGHT_SIZE) textName:@"" textColor:colorBlack fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
            dataValueLB.numberOfLines = 0;
            dataValueLB.tag = 2500+i*100+D;
            [onedatav addSubview:dataValueLB];
        }
        
    }
    _HVBRightScrollv.contentSize = CGSizeMake(kScreenWidth, 70*HEIGHT_SIZE*2+10*HEIGHT_SIZE+45*HEIGHT_SIZE+(130*HEIGHT_SIZE+10*HEIGHT_SIZE)*4+50*HEIGHT_SIZE);

    
}

- (void)hbNumbClick:(UIButton *)clickBtn{
    
    for (int i = 0; i < 4; i ++) {
        UIButton *onebtn = [self.view viewWithTag:1000+i];
        onebtn.selected = NO;
        UIView *oneview = [self.view viewWithTag:1100+i];
        oneview.hidden = YES;
    }
    clickBtn.selected = YES;
    UIView *oneview = [self.view viewWithTag:clickBtn.tag+100];
    oneview.hidden = NO;
    _HVBSeleNumb = clickBtn.tag-1000;
    [self HVBDataSet];
    
}

- (void)leftPointClick:(UIButton *)leftBtn{
    
    leftBtn.backgroundColor = colorBlack;
    _rightBtn.backgroundColor = backgroundNewColor;
    
    [_bgscrollv setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
}
- (void)rightPointClick:(UIButton *)leftBtn{
    
    leftBtn.backgroundColor = colorBlack;
    _LeftBtn.backgroundColor = backgroundNewColor;
    [_bgscrollv setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    if(offsetX >= kScreenWidth){
        
        _rightBtn.backgroundColor = colorBlack;
        _LeftBtn.backgroundColor = backgroundNewColor;
    }else{
        
        _LeftBtn.backgroundColor = colorBlack;
        _rightBtn.backgroundColor = backgroundNewColor;
    }
    
}


- (void)downCLick{
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _leftNameArr.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 10*HEIGHT_SIZE;
    }
    return 60*HEIGHT_SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    NSString *titistr = _titleName[section];
    if(section == 1){
        titistr = _PCS1Title;
    }
    if(section == 2){
        titistr = _Mppt1Title;
    }
    UIView *headv = [self goToInitView:CGRectMake(0, 0, kScreenWidth, 60*HEIGHT_SIZE) backgroundColor:WhiteColor];
    UILabel *titlb = [self goToInitLable:CGRectMake(15*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth - 30*NOW_SIZE, 40*HEIGHT_SIZE) textName:titistr textColor:colorblack_51 fontFloat:15*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    titlb.adjustsFontSizeToFitWidth = YES;
    titlb.tag = 10000+section;
    [headv addSubview:titlb];
    
    UIView *linev = [self goToInitView:CGRectMake(20*NOW_SIZE, CGRectGetMaxY(titlb.frame), kScreenWidth-40*NOW_SIZE, 0.3*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [headv addSubview:linev];
    
    return headv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if ([_deviceType isEqualToString:@"1"]) {
        if(section == 1 || section == 2){
            return 1;
        }
    }
    
    
    NSArray *rowArr = _leftNameArr[section];
    return rowArr.count;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_deviceType isEqualToString:@"1"]) {
//        if(indexPath.section == 1 || indexPath.section == 2){
//            NSArray *allArr = _leftNameArr[indexPath.section];
//            if (allArr.count > 0) {
//                NSArray *onearr = allArr[0];
//
//                return 80*HEIGHT_SIZE*onearr.count;
//            }
//        }
        if(indexPath.section == 1){
            
            return 80*HEIGHT_SIZE*6;

        }
        if(indexPath.section == 2){
            
            return 80*HEIGHT_SIZE*4;

        }
        
    }
   

    return 80*HEIGHT_SIZE;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BDCMassageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BDCCELLID"];
    
    
    if (!cell) {
        cell = [[BDCMassageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BDCCELLID"];
    }else{

        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_deviceType isEqualToString:@"1"]) {
        if (indexPath.section == 1 || indexPath.section == 2) {
            
            cell.AllNameArr = _leftNameArr[indexPath.section];
            cell.AllKeyArr = _leftValueArr[indexPath.section];
            cell.AllValueDic = _XPDataDic;
            [cell createCellUI];
            
            cell.ScrollOffSetBlock = ^(int xoffSet) {
                UILabel *titlbb = [self.devTablev viewWithTag:10000+indexPath.section];
                if (indexPath.section == 1) {
                    
                    
                    if (xoffSet < self.PCS1NamArr.count) {
                        titlbb.text = self.PCS1NamArr[xoffSet];
                        _PCS1Title = self.PCS1NamArr[xoffSet];;
                    }
                }
                if (indexPath.section == 2) {
                    if (xoffSet < self.MPPTNamArr.count) {
                        titlbb.text = self.MPPTNamArr[xoffSet];
                        _Mppt1Title = self.MPPTNamArr[xoffSet];
                    }
                }
                
            };
            
            return cell;
        }
    }
    

    NSArray *dataNameArr = _leftNameArr[indexPath.section];
    NSArray *dataKeyArr = _leftValueArr[indexPath.section];

    cell.NameSource = dataNameArr[indexPath.row];
    cell.dataSource = dataKeyArr[indexPath.row];
    cell.deviceAllDic = _XPDataDic;
    [cell reloadBDCMessageCell];
    return cell;
}

- (void)getDevDetailNet{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/getDeviceDetails" parameters:@{@"deviceType":_deviceType,@"deviceSn":_deviceSn} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.devTablev.mj_header endRefreshing];
        [self.HVBRightScrollv.mj_header endRefreshing];

        [self.bgscrollv.mj_header endRefreshing];
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSDictionary class]]){
                    
                    NSDictionary *AlldataDic = [NSDictionary dictionaryWithDictionary:objarr];
                    
                    

                    self.XPDataDic = AlldataDic;
                    if([_deviceType isEqualToString:@"3"] || [_deviceType isEqualToString:@"2"]){//HvBox
                        
                        
                        [self HVBDataSet];
                        
                        
                    }else{
                        if([_deviceType isEqualToString:@"1"]){
                            NSString *pcsnum = [NSString stringWithFormat:@"%@",AlldataDic[@"pcsNum"]];
                            NSString *mpptnum = [NSString stringWithFormat:@"%@",AlldataDic[@"mpptNum"]];

                            self.PcsShowNumb = [pcsnum intValue];
                            self.MPPTShowNumb = [mpptnum intValue];
                            
                            NSMutableArray *mutitlearr = [[NSMutableArray alloc]initWithArray:_titleName];
                            NSMutableArray *muNamearr = [[NSMutableArray alloc]initWithArray:_leftNameArr];
                            NSMutableArray *muKeyarr = [[NSMutableArray alloc]initWithArray:_leftValueArr];

//                            if (_titleName.count > 0) {
//                                [mutitlearr addObject:_titleName[0]];
//                                [muNamearr addObject:_leftNameArr[0]];
//                                [muKeyarr addObject:_leftValueArr[0]];
//                            }
                            

                            //移除多余的PCS 1-4   mppt 5-8
                            NSArray *pcsNamaar22 = _leftNameArr[1];
                            NSArray *mpptNamaar22 = _leftNameArr[2];

                            NSMutableArray *pcs1Arr = [[NSMutableArray alloc]init];
                            NSMutableArray *mpptArr = [[NSMutableArray alloc]init];
                    

                            for (int i = 0; i < self.PcsShowNumb; i++) {
                                if (i < pcsNamaar22.count) {
                                    [pcs1Arr addObject:pcsNamaar22[i]];

                                }
                                
                            }
                            
                            for (int t = 0; t < self.MPPTShowNumb; t++) {
                                if (t < mpptNamaar22.count) {
                                    [mpptArr addObject:mpptNamaar22[t]];

                                }
                            }
                            if (muNamearr.count > 1) {
                                [muNamearr replaceObjectAtIndex:1 withObject:pcs1Arr];

                            }
                            if (muNamearr.count > 2) {
                                [muNamearr replaceObjectAtIndex:2 withObject:mpptArr];

                            }

                            
                            _titleName = [NSArray arrayWithArray:mutitlearr];
                            _leftNameArr = [NSArray arrayWithArray:muNamearr];
                            _leftValueArr = [NSArray arrayWithArray:muKeyarr];
                        }
                        

                        
                        [self.devTablev reloadData];

                    }

                }

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self.devTablev.mj_header endRefreshing];
        [self.bgscrollv.mj_header endRefreshing];
        [self.HVBRightScrollv.mj_header endRefreshing];

    }];
}

- (void)HVBDataSet{
    
    [self.devTablev reloadData];
    
//    NSArray *rightKeyArr = @[@"mainRelayStaues",@"chargedVoltage",@"batteryCycles",@"actualCurrent"];
    NSArray *rightKeyArr = @[@"batteryCycles",@"chargedVoltage"];

    for (int i = 0; i < _rightNameArr.count; i++) {
        
        UILabel *FirstValulb = [self.view viewWithTag:100+i];
        NSString *keystr = rightKeyArr[i];
        NSString *onevalustr = [NSString stringWithFormat:@"%@",_XPDataDic[keystr]];
        FirstValulb.text = onevalustr;
        
    }

    if ([_deviceType isEqualToString:@"2"]) {
        [self XPSubDataSet];
    }
    if ([_deviceType isEqualToString:@"3"]) {
        [self HVBDataSubSet];
    }
    
}

//xp
- (void)XPSubDataSet{
    
    for (int i = 0; i < 4; i ++) {
        
        for (int t = 0; t < 4; t++) {
            UILabel *onelb = [self.view viewWithTag:20000+t+100*i];
            NSString *keystr = [NSString stringWithFormat:@"batVol_%d",t+1+4*i];
            NSString *onevalustr = [NSString stringWithFormat:@"%@",_XPDataDic[keystr]];
            
            onelb.text = onevalustr;
        }
    }
}


- (void)HVBDataSubSet{
    
    
    NSArray *subarr = _HVBSubNumArr[_HVBSeleNumb];
    
    NSMutableArray *subvaluArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i ++) {
        
        int numb = 1+(int)_HVBSeleNumb*4+i;
        NSString *onekeystr = [NSString stringWithFormat:@"bms%dSoftWareVer",numb];
        [subvaluArr addObject:onekeystr];
    }
    NSMutableArray *bms1SocArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i ++) {
        
        int numb = 1+(int)_HVBSeleNumb*4+i;
        NSString *onekeystr = [NSString stringWithFormat:@"bms%dSoc",numb];
        [bms1SocArr addObject:onekeystr];
    }
    NSMutableArray *bms1MaxSingleArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i ++) {
        
        int numb = 1+(int)_HVBSeleNumb*4+i;
        NSArray *onearr = @[[NSString stringWithFormat:@"bms%dMaxSingleStringVol",numb],[NSString stringWithFormat:@"bms%dMinSingleStringVol",numb],[NSString stringWithFormat:@"bms%dMaxSingleStringTemp",numb],[NSString stringWithFormat:@"bms%dMinSingleStringTemp",numb]];
        [bms1MaxSingleArr addObject:onearr];
    }

    for (int i = 0; i < subarr.count; i ++) {
        UILabel *namlb = [self.view viewWithTag:2000+i];
        namlb.text = subarr[i];
        UILabel *valulb = [self.view viewWithTag:2100+i];
        NSString *sub1Valu1 = [NSString stringWithFormat:@"%@",_XPDataDic[subvaluArr[i]]];
        valulb.text = sub1Valu1;
        
        NSString *bms1SocValu1 = [NSString stringWithFormat:@"%@",_XPDataDic[bms1SocArr[i]]];

        UIView *presbgv = [self.view viewWithTag:2200+i];
        UIView *presconv = [self.view viewWithTag:2300+i];
        presconv.xmg_width = presbgv.xmg_width*[bms1SocValu1 floatValue]*0.01;
        
        UILabel *presconLB = [self.view viewWithTag:2400+i];
        presconLB.text = [NSString stringWithFormat:@"%@%%",bms1SocValu1];

        NSArray *onesingArr = bms1MaxSingleArr[i];
        for (int t = 0; t < onesingArr.count; t++) {
            UILabel *dataValuLB = [self.view viewWithTag:2500+i*100+t];
            NSString *signlValu1 = [NSString stringWithFormat:@"%@",_XPDataDic[onesingArr[t]]];
//            NSString *unit = @"V";
//            if(t > 1){
//                unit = @"°C";
//
//            }
            dataValuLB.text = [NSString stringWithFormat:@"%@",signlValu1];//,unit
        }
    }
}
@end
