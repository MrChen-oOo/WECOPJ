//
//  WeNewOverView.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/23.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeNewOverView.h"
#import "RedxMMScanViewController.h"
#import "WeSystemView.h"
#import "RedxDTKDropdownMenuView.h"
#import "RedxKTDropdownMenuView.h"
#import "WeOverDataVC.h"
#import "WeImpactVC.h"
#import "RedxCeHuaView.h"
#import "RedxloginViewController.h"
#import "WeMeVC.h"
#import "WePlantListVC.h"
#import "WeDeviceListVC.h"
#import "WeFultMessageVC.h"
#import "WeStationSetVC.h"
#import "WeMeSetting.h"
#import "WePlantSettingVC.h"


@interface WeNewOverView ()
@property (nonatomic, strong) UIScrollView *bgscrollv;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) WeSystemView *SystemView;
@property (nonatomic, strong) RedxDTKDropdownMenuView *titleMenuView;
@property (nonatomic, strong) RedxKTDropdownMenuView *menuView;
@property (nonatomic, strong) NSString *PlantID;
@property (nonatomic, strong) NSDictionary *overVDic;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *plantNameArr;
@property (nonatomic, strong) NSMutableArray *plantIdArr;
@property (nonatomic, strong) NSString *isFirstIN;//1第一次进来，0其他
@property (nonatomic, strong) UILabel *unreadNumbLB;
@property (nonatomic, strong) UIButton *addbtn1;
@property (nonatomic, strong) NSString *devCount;
@property (nonatomic, assign) BOOL isOutVC;
@property (nonatomic, strong) NSString *msgStr;
@property (nonatomic, strong) NSString *mainDeviceSn;
@property (nonatomic, strong) NSString *mainDeviceType;

@property (nonatomic, assign) int plantmode;
@property (nonatomic, strong) UIView *funcVIew;

@property (nonatomic, strong) WeTitleView *AllPlanistView;
@property (nonatomic, strong) NSString *codeStr;

@end

@implementation WeNewOverView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //    [self createDownList];
    //    _isOutVC = NO;
    //    [self getAllPlantdata];
    //    [self getOverdata];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
    }
    
    _isOutVC = NO;
    [self getAllPlantdata];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
    _isOutVC = YES;
    if (_menuView) {
        [_menuView removeFromSuperview];
        _menuView=nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backgroundNewColor;
    _isFirstIN = @"1";
    _isOutVC = NO;
    [self createUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginOutSet) name:@"LOGINOUTNOTIFSEND" object:nil];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
//登录异常退出到登录页面
- (void)loginOutSet{
    
    [self hideProgressView];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LOGINOUTNOTIFSEND" object:nil];
    
    [self logOutClick];
    
}

- (void)createUI{
    
    UIButton *leftBtn = [self goToInitButton:CGRectMake(0, 0, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:2 fontSize:14 titleString:@"" selImgString:@"OvervList" norImgString:@"OvervList"];
    [leftBtn addTarget:self action:@selector(leftbtnclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIView *rigbgview1 = [self goToInitView:CGRectMake(0, 0, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE) backgroundColor:WhiteColor];
    
    UIButton *rightBtn = [self goToInitButton:CGRectMake(0,5*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:2 fontSize:14 titleString:@"" selImgString:@"WEmessage" norImgString:@"WEmessage"];
    [rightBtn addTarget:self action:@selector(rightBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [rigbgview1 addSubview:rightBtn];
    
    UILabel*numblb = [self goToInitLable:CGRectMake(10*HEIGHT_SIZE, 0, 15*HEIGHT_SIZE, 15*HEIGHT_SIZE) textName:@"" textColor:[UIColor redColor] fontFloat:8*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    numblb.backgroundColor = WhiteColor;
    numblb.layer.cornerRadius = 15*HEIGHT_SIZE/2;
    numblb.layer.masksToBounds = YES;
    numblb.layer.borderColor = WhiteColor.CGColor;
    numblb.layer.borderWidth = 0.5*HEIGHT_SIZE;
    [rigbgview1 addSubview:numblb];
    _unreadNumbLB = numblb;
    _unreadNumbLB.hidden = YES;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rigbgview1];
    
    UIButton *rightBtn2 = [self goToInitButton:CGRectMake(15*NOW_SIZE, 10*HEIGHT_SIZE+k_Height_StatusBar+(40*HEIGHT_SIZE - 20*HEIGHT_SIZE)/2, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) TypeNum:2 fontSize:14 titleString:@"" selImgString:@"WEScanimg" norImgString:@"WEScanimg"];
    [rightBtn2 addTarget:self action:@selector(rightBtn2click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    
    
    _bgscrollv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_bgscrollv];
    
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        
        
        [self getOverdata];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.bgscrollv.mj_header endRefreshing];
        });
    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    
    header2.stateLabel.hidden = YES;
    
    //    MJRefreshBackNormalFooter *footer2 = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        weakSelf.numbpage2 = weakSelf.numbpage2 + 1;
    //
    //        [weakSelf getYuyueData];
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [weakSelf.yuyueTbv.mj_footer endRefreshing];
    //        });
    //    }];
    
    //    footer2.stateLabel.hidden = YES;
    
    self.bgscrollv.mj_header = header2;
    
    [self createSysmten];
}

//系统图
- (void)createSysmten{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE,ScreenWidth-20*NOW_SIZE,kScreenWidth-20*NOW_SIZE+40*HEIGHT_SIZE)];
    _headerView.backgroundColor=[UIColor whiteColor];
    _headerView.layer.cornerRadius = 20*HEIGHT_SIZE;
    _headerView.layer.masksToBounds = YES;
    [_bgscrollv addSubview:_headerView];
    
    UIImageView *nodataIMG = [self goToInitImageView:CGRectMake(_headerView.xmg_width/2-50*HEIGHT_SIZE, _headerView.xmg_height/2-50*HEIGHT_SIZE, 100*HEIGHT_SIZE, 100*HEIGHT_SIZE) imageString:@"WENoData"];
    [_headerView addSubview:nodataIMG];
    
    UILabel *tipslb = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(nodataIMG.frame), _headerView.xmg_width-20*NOW_SIZE, 20*HEIGHT_SIZE) textName:root_ScanTips textColor:colorblack_154 fontFloat:14*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];
    [_headerView addSubview:tipslb];
    
    UIButton *addBtn = [self goToInitButton:CGRectMake(_headerView.xmg_width/2-50*NOW_SIZE, CGRectGetMaxY(tipslb.frame)+4*HEIGHT_SIZE, 100*NOW_SIZE, 40*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Add Plant" selImgString:@"" norImgString:@""];
    [addBtn setTitleColor:colorblack_102 forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addbtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.cornerRadius = 5*HEIGHT_SIZE;
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.borderWidth = 0.8*HEIGHT_SIZE;
    addBtn.layer.borderColor = colorblack_102.CGColor;
    [_headerView addSubview:addBtn];
    _addbtn1 = addBtn;
    
    
    NSArray *namearr = @[home_Energy,home_Impact,home_DeviceList,home_PlantSetting];//,home_PlantSetting
    
    
    NSArray *detailarr = @[[NSString stringWithFormat:@"0 %@",home_GeneratedTD],[NSString stringWithFormat:@"0 Estimated Savings Today"],@"0 Devices Are Running",@"Work Model:"];//,@""
    
    UIView *funview = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(_headerView.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 50*HEIGHT_SIZE*namearr.count) backgroundColor:WhiteColor];
    funview.layer.cornerRadius = 15*HEIGHT_SIZE;
    funview.layer.masksToBounds = YES;
    [_bgscrollv addSubview:funview];
    _funcVIew = funview;
    
    for (int i = 0; i < namearr.count; i++) {
        UIView *onevie = [self goToInitView:CGRectMake(0, 50*HEIGHT_SIZE*i, funview.xmg_width, 50*HEIGHT_SIZE) backgroundColor:WhiteColor];
        onevie.tag = 100+i;
        UITapGestureRecognizer *tapge = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(funclick:)];
        [onevie addGestureRecognizer:tapge];
        [funview addSubview:onevie];
        
        UILabel *onelb = [self goToInitLable:CGRectMake(10*NOW_SIZE,0, funview.xmg_width-20*NOW_SIZE-10*HEIGHT_SIZE, 30*HEIGHT_SIZE) textName:namearr[i] textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        onelb.userInteractionEnabled = YES;
        [onevie addSubview:onelb];
        
        UILabel *detaillb = [self goToInitLable:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(onelb.frame), funview.xmg_width-20*NOW_SIZE-10*HEIGHT_SIZE, 20*HEIGHT_SIZE) textName:detailarr[i] textColor:colorblack_154 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        detaillb.userInteractionEnabled = YES;
        detaillb.tag = 6000+i;
        [onevie addSubview:detaillb];
        
        //        if(i > 2){
        //
        //            onelb.xmg_y = (onevie.xmg_height-30*HEIGHT_SIZE)/2;
        //            detaillb.hidden = YES;
        //        }
        
        UIView *linvv = [self goToInitView:CGRectMake(0, CGRectGetMaxY(detaillb.frame)-1.5*HEIGHT_SIZE,funview.xmg_width, 1.5*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
        [onevie addSubview:linvv];
        
        
        UIImageView *rigimgv = [self goToInitImageView:CGRectMake(onevie.xmg_width-8*NOW_SIZE-10*HEIGHT_SIZE, (onevie.xmg_height-10*HEIGHT_SIZE)/2, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE) imageString:@"rightBtn"];
        [onevie addSubview:rigimgv];
    }
    _bgscrollv.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(funview.frame)+10*HEIGHT_SIZE+kNavBarHeight);
    
    [self reloadSystemUI];
}

//添加电站/添加设备
- (void)addbtnClick{
    
    if(_datasource.count == 0){
        WeStationSetVC *setVC = [[WeStationSetVC alloc]init];
        setVC.EditType = @"0";
        [self.navigationController pushViewController:setVC animated:YES];
        
    }else{
        
        if([_devCount intValue] == 0 || [_codeStr isEqualToString:@"2"]){
            RedxMMScanViewController *scanVc = [[RedxMMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
                if (error) {
                    NSLog(@"error: %@",error);
                } else {
                    NSLog(@"扫描结果：%@",result);
                }
            }];
            scanVc.titleString=root_saomiao_sn;
            scanVc.scanBarType=2;
            scanVc.isDataloggerView=YES;
            scanVc.PlantID = _PlantID;
            [self.navigationController pushViewController:scanVc animated:YES];
            
        }
    }
    
}

- (void)createDownList{
    
    
    //    if (self.AllPlanistView) {
    //        [self.AllPlanistView removeFromSuperview];
    //        self.AllPlanistView = nil;
    //    }
    //
    //    self.AllPlanistView = [[WeTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    
    if (deviceSystemVersion>=11.0) {
        if (_menuView) {
            [_menuView removeFromSuperview];
            _menuView=nil;
        }
        
        if(self.datasource.count == 0){
            
            self.title = @"";
        }else{
            self.title = @"";
            
            _plantNameArr = [[NSMutableArray alloc]init];
            _plantIdArr = [[NSMutableArray alloc]init];
            
            int seleNumb = 0;
            for (int i = 0; i < _datasource.count; i++) {
                
                NSDictionary *onedic = _datasource[i];
                NSString *planname = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
                NSString *planId = [NSString stringWithFormat:@"%@",onedic[@"id"]];
                
                [_plantNameArr addObject:planname];
                [_plantIdArr addObject:planId];
                if([planId isEqualToString:_PlantID]){
                    seleNumb = i;
                    
                }
                
            }
            
//            _plantNameArr = [[NSMutableArray alloc]initWithArray:@[@"skandlaljdasjdjalhcfhaoidhisajdijsaidhiashiohfoahfijsaidjoiasjdasd",@"sahdohasdsaidas"]];
            _menuView = [[RedxKTDropdownMenuView alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 0,200, 44) titles:_plantNameArr];
            
            __weak typeof(self) weakSelf = self;
            _menuView.selectedAtIndex = ^(int index)
            {
                if(index < weakSelf.plantIdArr.count){
                    
                    weakSelf.PlantID = weakSelf.plantIdArr[index];
                    [weakSelf getOverdata];
                }
                
            };
            _menuView.width = 150.f;
            _menuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
            _menuView.cellColor=colorblack_102;
            _menuView.textColor =colorblack_51;
            _menuView.textFont = [UIFont systemFontOfSize:17.f];
            _menuView.cellHeight=40*HEIGHT_SIZE;
            _menuView.animationDuration = 0.2f;
            _menuView.selectedIndex = seleNumb;
            
            //            self.navigationItem.titleView = _menuView;
            if(!_isOutVC){
                [self.navigationController.navigationBar addSubview:_menuView];
                
                
            }
            
        }
        
        
        
        
    }else{
        if (_titleMenuView) {
            [_titleMenuView removeFromSuperview];
            _titleMenuView=nil;
        }
        
        if(self.datasource.count == 0){
            
            self.title = @"";
        }else{
            
            _plantNameArr = [[NSMutableArray alloc]init];
            _plantIdArr = [[NSMutableArray alloc]init];
            
            int seleNumb = 0;
            for (int i = 0; i < _datasource.count; i++) {
                
                NSDictionary *onedic = _datasource[i];
                NSString *planname = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
                NSString *planId = [NSString stringWithFormat:@"%@",onedic[@"id"]];
                
                [_plantNameArr addObject:planname];
                [_plantIdArr addObject:planId];
                if([planId isEqualToString:_PlantID]){
                    seleNumb = i;
                    
                }
                
            }
            
            _titleMenuView = [RedxDTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200*NOW_SIZE, UI_NAVIGATION_BAR_HEIGHT) dropdownItems:_plantNameArr];
            //  menuView.intrinsicContentSize=CGSizeMake(200*HEIGHT_SIZE, 44*HEIGHT_SIZE);
            //menuView.translatesAutoresizingMaskIntoConstraints=true;
            _titleMenuView.currentNav = self.navigationController;
            _titleMenuView.dropWidth = 150.f;
            _titleMenuView.titleColor=colorblack_51;
            _titleMenuView.titleFont = [UIFont systemFontOfSize:17.f];
            _titleMenuView.textColor =colorblack_102;
            _titleMenuView.textFont = [UIFont systemFontOfSize:13.f];
            _titleMenuView.cellSeparatorColor =COLOR(231, 231, 231, 1);
            _titleMenuView.textFont = [UIFont systemFontOfSize:14.f];
            _titleMenuView.animationDuration = 0.2f;
            _titleMenuView.selectedIndex = seleNumb;
            self.navigationItem.titleView = _titleMenuView;
        }
    }
    
}



//系统图
- (void)reloadSystemUI{
    
    if(_SystemView){
        
        [_SystemView removeFromSuperview];
        _SystemView = nil;
    }
    if(_overVDic.count > 0){
        _SystemView = [[WeSystemView alloc]initWithFrame:CGRectMake(0, 0, _headerView.xmg_width, _headerView.xmg_height)];
        
        _SystemView.dataDic = _overVDic;
        [_headerView addSubview:_SystemView];
        
        [_SystemView createSystemUI];
    }
    
    
}


//列表
- (void)leftbtnclick{
    
    RedxCeHuaView *cehuaview = [[RedxCeHuaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [KEYWINDOW addSubview:cehuaview];
    
    cehuaview.selectBlock = ^(NSInteger selectNumb) {//tag 100+
        
        if (selectNumb == 10) {//编辑
            //            RedxnewManagementViewController *aboutView = [[RedxnewManagementViewController alloc]init];
            //            aboutView.hidesBottomBarWhenPushed=YES;
            //            [self.navigationController pushViewController:aboutView animated:NO];
        }
        
        if (selectNumb == 100) {//
            WePlantListVC *deviceViewTwo=[[WePlantListVC alloc]init];
            
            [self.navigationController pushViewController:deviceViewTwo animated:YES];
            
            deviceViewTwo.seleClick = ^(NSString *plantID,NSString *plantName) {
                self.PlantID = plantID;
                
                //                [self createDownList];
                //                [self getOverdata];
            };
            
            
        }
        //        if (selectNumb == 101) {//
        //
        //            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"Going to the Weco Bluetooth download Page?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        //            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
        //            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        //
        //
        //            }]];
        //            [self presentViewController:alvc animated:YES completion:nil];
        //        }
        if (selectNumb == 101) {//
            
            WeMeSetting *settingvc = [[WeMeSetting alloc]init];
            [self.navigationController pushViewController:settingvc animated:YES];
            
            
        }
        
        
        if (selectNumb == 102) {//
            
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_tuichu_zhanghu message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self logOutClick];
                
            }]];
            [self presentViewController:alvc animated:YES completion:nil];
            
        }
        //        if (selectNumb == 104) {//关于
        //            RedxaboutViewController *aboutView = [[RedxaboutViewController alloc]init];
        //            aboutView.hidesBottomBarWhenPushed=YES;
        //            [self.navigationController pushViewController:aboutView animated:NO];
        //        }
        //        if (selectNumb == 105) {//退出登录
        //
        //
        //
        //        }
    };
}

//消息
- (void)rightBtnclick{
    
    WeFultMessageVC *fuMsgvc = [[WeFultMessageVC alloc]init];
    fuMsgvc.PlantID = _PlantID;
    [self.navigationController pushViewController:fuMsgvc animated:YES];
}

//扫描
- (void)rightBtn2click{
    
    if (kStringIsEmpty(_PlantID)) {
        
        [self showToastViewWithTitle:NewAPSet_AZplease_add_plant];
        return;
    }
    
    RedxMMScanViewController *scanVc = [[RedxMMScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
        if (error) {
            NSLog(@"error: %@",error);
        } else {
            NSLog(@"扫描结果：%@",result);
        }
    }];
    scanVc.titleString=root_saomiao_sn;
    scanVc.scanBarType=2;
    scanVc.isDataloggerView=YES;
    scanVc.PlantID = _PlantID;
    [self.navigationController pushViewController:scanVc animated:YES];
    
}


- (void)funclick:(UITapGestureRecognizer *)tapge{
    
    //Engery
    if(tapge.view.tag == 100){
        
        WeOverDataVC *overdatavc = [[WeOverDataVC alloc]init];
        overdatavc.PlantID = _PlantID;
        [self.navigationController pushViewController:overdatavc animated:YES];
    }
    if(tapge.view.tag == 101){
        
        WeImpactVC *impactvc = [[WeImpactVC alloc]init];
        impactvc.PlantID = _PlantID;
        [self.navigationController pushViewController:impactvc animated:YES];
        
    }
    if(tapge.view.tag == 102){
        
        WeDeviceListVC *devlistvc = [[WeDeviceListVC alloc]init];
        devlistvc.PlantID = _PlantID;
        //        devlistvc.addTipsStatus = _msgStr;//为0即时有正在添加的设备
        [self.navigationController pushViewController:devlistvc animated:YES];
    }
    
    if(tapge.view.tag == 103){
        
        
        WePlantSettingVC *devlistvc = [[WePlantSettingVC alloc]init];
        devlistvc.devSN = _mainDeviceSn;
        devlistvc.plantModel = _plantmode;
        [self.navigationController pushViewController:devlistvc animated:YES];
    }
}

- (void)logOutClick{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/logOut" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            //            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            //            [self showToastViewWithTitle:msg];
            
            if ([result isEqualToString:@"0"]) {
                
                
                
            }
            //
        }
        RedxloginViewController *login =[[RedxloginViewController alloc]init];
        [RedxUserInfo defaultUserInfo].userPassword = @"";
        [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        nav.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
        RedxloginViewController *login =[[RedxloginViewController alloc]init];
        [RedxUserInfo defaultUserInfo].userPassword = @"";
        [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        nav.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
}

//获取概览数据
- (void)getOverdata{
    
    _overVDic = [[NSDictionary alloc]init];
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/plant/getPlantOverviewData" parameters:@{@"plantId":_PlantID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.bgscrollv.mj_header endRefreshing];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"/v1/plant/getPlantOverviewData:%@",datadic);
        if (datadic) {
            NSString *codestr = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            //            NSString *msgstr = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            
            //            [self showToastViewWithTitle:msgstr];
            self.codeStr = codestr;
            if([codestr isEqualToString:@"0"]){
                
                id objdic = datadic[@"obj"];
                if([objdic isKindOfClass:[NSDictionary class]]){
                    self.overVDic = (NSDictionary *)objdic;
                    [self reloadSystemUI];
                    
                    UIView *energyV = [self.view viewWithTag:100];
                    UIView *impactV = [self.view viewWithTag:101];
                    UIView *devCountV = [self.view viewWithTag:102];
                    UIView *workmodelV = [self.view viewWithTag:103];
                    
                    UILabel *energyLB = [self.view viewWithTag:6000];
                    UILabel *impactLB = [self.view viewWithTag:6001];
                    UILabel *devCountLB = [self.view viewWithTag:6002];
                    UILabel *workmodelLB = [self.view viewWithTag:6003];
                    
                    NSString *incomeUnit = [NSString stringWithFormat:@"%@",self.overVDic[@"incomeUnit"]];
                    NSString *saveToday = [NSString stringWithFormat:@"%@",self.overVDic[@"saveToday"]];
                    
                    energyLB.text = [NSString stringWithFormat:@"%@ %@",self.overVDic[@"pvDayChargeTotal"],home_GeneratedTD];
                    impactLB.text = [NSString stringWithFormat:@"%@ %@ Estimated Savings Today",saveToday,incomeUnit];
                    NSString *unReadCount = [NSString stringWithFormat:@"%@",self.overVDic[@"unReadCount"]];
                    
                    NSString *deviceCount = [NSString stringWithFormat:@"%@",self.overVDic[@"deviceCount"]];
                    NSString *workModel = [NSString stringWithFormat:@"%@",self.overVDic[@"workModelText"]];
                    self.mainDeviceSn = [NSString stringWithFormat:@"%@",self.overVDic[@"mainDeviceSn"]];
                    NSString *workModelINT = [NSString stringWithFormat:@"%@",self.overVDic[@"workModel"]];
                    NSString *mainDeviceType = [NSString stringWithFormat:@"%@",self.overVDic[@"mainDeviceType"]];
                    self.mainDeviceType = mainDeviceType;
                    self.plantmode = [workModelINT intValue];
                    
                    
                    
                    
                    if([mainDeviceType isEqualToString:@"1"]){//逆变器暂不显示收益
                        
                        impactV.hidden = YES;
                        
                        devCountV.xmg_y = impactV.xmg_y;
                        workmodelV.xmg_y = CGRectGetMaxY(devCountV.frame);
                        _funcVIew.xmg_height = 3*50*HEIGHT_SIZE;
                        
                    }else{
                        
                        impactV.hidden = NO;
                        devCountV.xmg_y = CGRectGetMaxY(impactV.frame);
                        workmodelV.xmg_y = CGRectGetMaxY(devCountV.frame);
                        _funcVIew.xmg_height = 4*50*HEIGHT_SIZE;
                        
                    }
                    
                    devCountLB.text = [NSString stringWithFormat:@"%@ Devices Are Running",deviceCount];
                    workmodelLB.text = [NSString stringWithFormat:@"Work Model:%@",workModel];
                    self.devCount = deviceCount;
                    if([unReadCount intValue] > 0){
                        
                        if ([unReadCount intValue] > 99) {
                            self.unreadNumbLB.hidden = NO;
                            self.unreadNumbLB.text = @"99+";
                        }else{
                            self.unreadNumbLB.hidden = NO;
                            self.unreadNumbLB.text = unReadCount;
                        }
                        
                    }else{
                        self.unreadNumbLB.hidden = YES;
                        
                    }
                    if([deviceCount intValue] == 0){
                        
                        [self.addbtn1 setTitle:@"Add Device" forState:UIControlStateNormal];
                    }
                    
                }else{
                    if(_SystemView){
                        
                        [_SystemView removeFromSuperview];
                        _SystemView = nil;
                    }
                    
                    UILabel *energyLB = [self.view viewWithTag:6000];
                    UILabel *impactLB = [self.view viewWithTag:6001];
                    UILabel *devCountLB = [self.view viewWithTag:6002];
                    UILabel *workmodelLB = [self.view viewWithTag:6003];
                    
                    energyLB.text = [NSString stringWithFormat:@"%@ %@",@"0.0kWh",home_GeneratedTD];
                    impactLB.text = [NSString stringWithFormat:@"%@ %@",@"0%",home_SelfPower];
                    devCountLB.text = [NSString stringWithFormat:@"0 Devices Are Running"];
                    workmodelLB.text = [NSString stringWithFormat:@"Work Model:"];
                    
                    self.unreadNumbLB.hidden = YES;
                    self.devCount = 0;
                }
                
            }else if([codestr isEqualToString:@"2"]){
                if(_SystemView){
                    
                    [_SystemView removeFromSuperview];
                    _SystemView = nil;
                }
                id objdic = datadic[@"obj"];
                if([objdic isKindOfClass:[NSDictionary class]]){
                    self.overVDic = (NSDictionary *)objdic;
                    
                    UIView *energyV = [self.view viewWithTag:100];
                    UIView *impactV = [self.view viewWithTag:101];
                    UIView *devCountV = [self.view viewWithTag:102];
                    UIView *workmodelV = [self.view viewWithTag:103];
                    
                    UILabel *energyLB = [self.view viewWithTag:6000];
                    UILabel *impactLB = [self.view viewWithTag:6001];
                    UILabel *devCountLB = [self.view viewWithTag:6002];
                    UILabel *workmodelLB = [self.view viewWithTag:6003];
                    
                    NSString *incomeUnit = [NSString stringWithFormat:@"%@",self.overVDic[@"incomeUnit"]];
                    NSString *saveToday = [NSString stringWithFormat:@"%@",self.overVDic[@"saveToday"]];
                    
                    energyLB.text = [NSString stringWithFormat:@"%@ %@",self.overVDic[@"pvDayChargeTotal"],home_GeneratedTD];
                    impactLB.text = [NSString stringWithFormat:@"%@ %@ Estimated Savings Today",saveToday,incomeUnit];
                    NSString *unReadCount = [NSString stringWithFormat:@"%@",self.overVDic[@"unReadCount"]];
                    
                    NSString *deviceCount = [NSString stringWithFormat:@"%@",self.overVDic[@"deviceCount"]];
                    NSString *workModel = [NSString stringWithFormat:@"%@",self.overVDic[@"workModelText"]];
                    self.mainDeviceSn = [NSString stringWithFormat:@"%@",self.overVDic[@"mainDeviceSn"]];
                    NSString *workModelINT = [NSString stringWithFormat:@"%@",self.overVDic[@"workModel"]];
                    NSString *mainDeviceType = [NSString stringWithFormat:@"%@",self.overVDic[@"mainDeviceType"]];
                    self.mainDeviceType = mainDeviceType;
                    self.plantmode = [workModelINT intValue];
                    
                    
                    
                    
                    if([mainDeviceType isEqualToString:@"1"]){//逆变器暂不显示收益
                        
                        impactV.hidden = YES;
                        
                        devCountV.xmg_y = impactV.xmg_y;
                        workmodelV.xmg_y = CGRectGetMaxY(devCountV.frame);
                        _funcVIew.xmg_height = 3*50*HEIGHT_SIZE;
                        
                    }else{
                        
                        impactV.hidden = NO;
                        devCountV.xmg_y = CGRectGetMaxY(impactV.frame);
                        workmodelV.xmg_y = CGRectGetMaxY(devCountV.frame);
                        _funcVIew.xmg_height = 4*50*HEIGHT_SIZE;
                        
                    }
                    
                    devCountLB.text = [NSString stringWithFormat:@"%@ Devices Are Running",deviceCount];
                    workmodelLB.text = [NSString stringWithFormat:@"Work Model:%@",workModel];
                    self.devCount = deviceCount;
                    if([unReadCount intValue] > 0){
                        
                        if ([unReadCount intValue] > 99) {
                            self.unreadNumbLB.hidden = NO;
                            self.unreadNumbLB.text = @"99+";
                        }else{
                            self.unreadNumbLB.hidden = NO;
                            self.unreadNumbLB.text = unReadCount;
                        }
                        
                    }else{
                        self.unreadNumbLB.hidden = YES;
                        
                    }
                    if([deviceCount intValue] == 0){
                        
                        [self.addbtn1 setTitle:@"Add Device" forState:UIControlStateNormal];
                    }
                }
                
            }else{
                
                if(_SystemView){
                    
                    [_SystemView removeFromSuperview];
                    _SystemView = nil;
                }
                
                UILabel *energyLB = [self.view viewWithTag:6000];
                UILabel *impactLB = [self.view viewWithTag:6001];
                UILabel *devCountLB = [self.view viewWithTag:6002];
                UILabel *workmodelLB = [self.view viewWithTag:6003];
                
                energyLB.text = [NSString stringWithFormat:@"%@ %@",@"0.0kWh",home_GeneratedTD];
                impactLB.text = [NSString stringWithFormat:@"%@ %@",@"0%",home_SelfPower];
                devCountLB.text = [NSString stringWithFormat:@"0 Devices Are Running"];
                workmodelLB.text = [NSString stringWithFormat:@"Work Model:"];
                
                self.unreadNumbLB.hidden = YES;
                self.devCount = 0;
            }
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self.bgscrollv.mj_header endRefreshing];
        
    }];
}

//获取全部电站
- (void)getAllPlantdata{
    
    [self showProgressView];//_deviceNetDic
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/getPlantList" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            //            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            //            [self showToastViewWithTitle:msg];
            //            _msgStr = msg;
            if ([result isEqualToString:@"0"]) {
                
                
                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSArray class]]){
                    
                    NSArray *dataarr = [NSArray arrayWithArray:objarr];
                    
                    _datasource = [NSMutableArray arrayWithArray:dataarr];
                    if([_isFirstIN isEqualToString:@"1"]){
                        _isFirstIN = @"0";
                        if(_datasource.count > 0){
                            NSDictionary *onedic = _datasource[0];
                            self.PlantID = [NSString stringWithFormat:@"%@",onedic[@"id"]];
                            [self getOverdata];
                            
                        }
                        
                    }else{
                        
                        [self getOverdata];
                    }
                    if(_datasource.count > 0){
                        
                        [_addbtn1 setTitle:@"Add Device" forState:UIControlStateNormal];
                        
                    }else{
                        
                        [_addbtn1 setTitle:@"Add Plant" forState:UIControlStateNormal];
                        
                    }
                    
                }else{
                    if(_datasource.count > 0){
                        
                        [_addbtn1 setTitle:@"Add Device" forState:UIControlStateNormal];
                        
                    }else{
                        
                        [_addbtn1 setTitle:@"Add Plant" forState:UIControlStateNormal];
                        
                    }
                    
                }
                
            }
            //
        }else{
            
            [_addbtn1 setTitle:@"Add Plant" forState:UIControlStateNormal];
            
        }
        [self createDownList];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self createDownList];
        [_addbtn1 setTitle:@"Add Plant" forState:UIControlStateNormal];
        
    }];
}
@end
