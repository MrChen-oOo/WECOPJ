//
//  HomePageViewConViewController.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import "HomePageViewConViewController.h"
#import "INVSettingViewController.h"
#import "FlowDiagramTableViewCell.h"
#import "HomeInfoTableViewCell.h"
#import "HomePageViewModel.h"
#import "PopListView.h"
#import "RedxCeHuaView.h"
#import "WePlantListVC.h"
#import "CabinetViewController.h"
#import "InveterViewController.h"
#import "WeMeSetting.h"
#import "RedxloginViewController.h"
#import "ScanViewController.h"
#import "WeFultMessageVC.h"
#import "WeDeviceListVC.h"
#import "RedxNewAddCollector22VC.h"
#import "ChartsViewController.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface HomePageViewConViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *nameImage;

@property (nonatomic, strong)PopListView *popView;
@property (nonatomic, strong)HomePageViewModel *homeVM;
@property (nonatomic, strong)NSString *planId;          // 电站id
@property (nonatomic, assign)NSInteger planNum;         // 电站的index
@end

@implementation HomePageViewConViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"123";
    [self.homeTableView registerNib:[UINib nibWithNibName:@"FlowDiagramTableViewCell" bundle:nil] forCellReuseIdentifier:@"flowDiagram"];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"HomeInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"homeInfo"];
    [self.view addSubview:self.popView];
    self.navigationController.delegate = self;
    
    // 下拉刷新
    @WeakObj(self)
    MJRefreshNormalHeader *reloadHeader  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [selfWeak getPlanListWithHttp];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [selfWeak.homeTableView.mj_header endRefreshing];
        });
    }];
    reloadHeader.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    reloadHeader.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    reloadHeader.stateLabel.hidden = YES;
    self.homeTableView.mj_header = reloadHeader;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    if (!self.planNum) {
        self.planNum = 0;
    }
    [self getPlanListWithHttp];
}



#pragma mark -UITableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 431 : 382;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 针对特殊cell进行处理
    @WeakObj(self)
    if (indexPath.section == 0) {
        FlowDiagramTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[FlowDiagramTableViewCell alloc] initWithReuseIdentifier:@"flowDiagram" homeVM:self.homeVM];
        }
        [cell reloadCellMessage];
        cell.cellPushBlock = ^{
            // 跳转新增设备
            RedxNewAddCollector22VC *addvc = [[RedxNewAddCollector22VC alloc]init];
            addvc.stationId = selfWeak.planId;
            [selfWeak.navigationController pushViewController:addvc animated:YES];
        };
        return cell;
    } else {
        HomeInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[HomeInfoTableViewCell alloc] initWithReuseIdentifier:@"homeInfo" homeVM:self.homeVM];
        }
        [cell reloadCellMessage];
        cell.cellPushBlock = ^{
            // 跳转图表
//            ChartsViewController *chartsVC = [[ChartsViewController alloc]init];
//            [selfWeak.navigationController pushViewController:chartsVC animated:YES];
        };
        return cell;
    }
    
}

#pragma mark - UINavigationControllerDelegate

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
 // 判断要显示的控制器是否是自己
 BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
 [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark -网络请求

// 获取电站列表
- (void)getPlanListWithHttp {
    [self showProgressView];
    @WeakObj(self)
    [self.homeVM getPlanListCompleteBlock:^(NSString *resultStr) {
        
        if (resultStr.length == 0) {
            
            selfWeak.nameImage.hidden = selfWeak.homeVM.planListModel.obj.count == 0 ? YES : NO;
            selfWeak.nameBtn.hidden = selfWeak.homeVM.planListModel.obj.count == 0 ? YES : NO;
            // 无电站时直接返回
            if ( selfWeak.homeVM.planListModel.obj.count == 0) {
                [selfWeak hideProgressView];
                selfWeak.nameLabel.text = @"";
                [selfWeak.homeTableView reloadData];
                return;
            }
            selfWeak.planId = self.homeVM.planListModel.obj[self.planNum].ID;
            selfWeak.nameLabel.text = self.homeVM.planListModel.obj[self.planNum].plantName;
            [selfWeak getPowerStationWithHttp];
        } else {
            [selfWeak hideProgressView];
            [selfWeak showErrorViewWithResultStr:resultStr];
            [selfWeak.homeTableView reloadData];
        }
    }];
    
}

// 获取电站信息
- (void)getPowerStationWithHttp {
    @WeakObj(self)
    [self.homeVM getPowerStationMessageWith:self.planId completeBlock:^(NSString *resultStr, NSString *codeStr) {
        if (resultStr.length == 0) {
            if (self.homeVM.deviceModel.mgrnList.count == 0 && self.homeVM.deviceModel.pcsList.count == 0) {
                [selfWeak hideProgressView];
                [selfWeak.homeTableView reloadData];
            } else {
                [selfWeak getHomePageMessageWithHttp];
            }
        } else {
            [selfWeak hideProgressView];
            [selfWeak showErrorViewWithResultStr:resultStr];
            [selfWeak.homeTableView reloadData];
        }
        
        if ([codeStr isEqualToString:@"-1"]){
            [selfWeak pushLogin];
        }
    }];
}

// 获取首页流向图信息
- (void)getHomePageMessageWithHttp {
    @WeakObj(self)
    [self.homeVM getHomePageMessageWith:self.homeVM.deviceSnStr completeBlock:^(NSString *resultStr, NSString *codeStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            [selfWeak.homeTableView reloadData];
        } else {
            [selfWeak showErrorViewWithResultStr:resultStr];
        }
        [selfWeak hideProgressView];
        if ([codeStr isEqualToString:@"-1"]){
            [selfWeak pushLogin];
        }
    }];
}

// 提示错误信息
-(void)showErrorViewWithResultStr:(NSString *)resultStr {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showToastViewWithTitle:resultStr];
    });
}

#pragma mark -按钮点击方法

// 侧边栏
- (IBAction)sidebarAction:(UIButton *)sender {
    self.popView.hidden = YES;
    [self showSidebarListView];
}

// 下拉选项
- (IBAction)pullDownAction:(UIButton *)sender {
    if (self.popView.hidden == NO) {
        self.popView.hidden = YES;
    } else {
        self.popView.hidden = NO;
        [self.popView reloadCellMessage];
    }
}

// 通知
- (IBAction)noticeAction:(UIButton *)sender {
    [self rightBtnclick];
}

// 扫一扫
- (IBAction)scanAction:(UIButton *)sender {
    [self rightBtn2click];
}



#pragma mark - 外包的垃圾代码
- (void)showSidebarListView{

    RedxCeHuaView *cehuaview = [[RedxCeHuaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [cehuaview createValueUIWith:self.homeVM.deviceType isHaveDevice:self.homeVM.isHaveDevice];
    [KEYWINDOW addSubview:cehuaview];
    
    cehuaview.selectBlock = ^(NSInteger selectNumb) {//tag 100+
        
        if (selectNumb == 100) {//
            WePlantListVC *deviceViewTwo=[[WePlantListVC alloc]init];
            [self.navigationController pushViewController:deviceViewTwo animated:YES];
            deviceViewTwo.seleClick = ^(NSString *plantID,NSString *plantName) {
                self.planId = plantID;
            };
        }
        
        if (selectNumb == 101) {
            WeDeviceListVC *devlistvc = [[WeDeviceListVC alloc]init];
            devlistvc.PlantID = self.planId;
            //        devlistvc.addTipsStatus = _msgStr;//为0即时有正在添加的设备
            [self.navigationController pushViewController:devlistvc animated:YES];
        }
        
        if(selectNumb == 102){//INV Setting
            if (self.homeVM.isHaveDevice == YES) {
                INVSettingViewController *settingvc = [[INVSettingViewController alloc]init];
                settingvc.settingVM.deviceSnStr = self.homeVM.deviceSnStr;
                settingvc.settingVM.deviceType = self.homeVM.deviceType;
                [self.navigationController pushViewController:settingvc animated:YES];
            } else {
                WeMeSetting *settingvc = [[WeMeSetting alloc]init];
                [self.navigationController pushViewController:settingvc animated:YES];
            }
        }
        
        if (selectNumb == 103) {//
            if (self.homeVM.isHaveDevice == YES) {
                if (self.homeVM.deviceType == 0) {
                    CabinetViewController *cabinetVC = [[CabinetViewController alloc]init];
                    cabinetVC.deviceSnStr = self.homeVM.deviceSnStr;
                    [self.navigationController pushViewController:cabinetVC animated:YES];
                } else {
                    InveterViewController *inveter = [[InveterViewController alloc]init];
                    inveter.deviceSnStr = self.homeVM.deviceSnStr;
                    [self.navigationController pushViewController:inveter animated:YES];
                }
              
            } else {
                UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_tuichu_zhanghu message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
                [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self logOutClick];
                    
                }]];
                [self presentViewController:alvc animated:YES completion:nil];
            }
        }
        
        if (selectNumb == 104) {//
            WeMeSetting *settingvc = [[WeMeSetting alloc]init];
            [self.navigationController pushViewController:settingvc animated:YES];
        }
        if (selectNumb == 105) {//
            
            UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_tuichu_zhanghu message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
            [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self logOutClick];
                
            }]];
            [self presentViewController:alvc animated:YES completion:nil];
        }
    };
}

- (void)logOutClick{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/logOut" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            if ([result isEqualToString:@"0"]) {

            }
        }
        [self pushLogin];
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self pushLogin];
    }];
    
}

-(void)pushLogin {
    RedxloginViewController *login =[[RedxloginViewController alloc]init];
    [RedxUserInfo defaultUserInfo].userPassword = @"";
    [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
}


//消息
- (void)rightBtnclick{
    WeFultMessageVC *fuMsgvc = [[WeFultMessageVC alloc]init];
    fuMsgvc.PlantID = self.planId;
    [self.navigationController pushViewController:fuMsgvc animated:YES];
}

//扫描
- (void)rightBtn2click{
    if (kStringIsEmpty(self.planId)) {
        [self showToastViewWithTitle:NewAPSet_AZplease_add_plant];
        return;
    }
    ScanViewController *scanVc = [[ScanViewController alloc]init];
    scanVc.title=root_saomiao_sn;
    scanVc.PlantID = self.planId;
    scanVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVc animated:YES];

    scanVc.resultBlock = ^(NSString * _Nonnull scanResult) {
        
    };
}


#pragma mark -懒加载
-(HomePageViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomePageViewModel alloc]initViewModel];
    }
    return _homeVM;
}

-(PopListView *)popView {
    if (!_popView){
        @WeakObj(self)
        _popView = [[PopListView alloc]initWithViewModel:self.homeVM];
        
        NSInteger proHeight = kScreenHeight == 932 || kScreenHeight == 852 ? (kNavBarHeight + 16) : kNavBarHeight;
        
        _popView.frame = CGRectMake(0,  proHeight, kScreenWidth, kScreenHeight - proHeight);
        _popView.hidden = YES;
        _popView.selectCellBlock = ^(NSInteger index) {
            selfWeak.planNum = index;
            selfWeak.planId = selfWeak.homeVM.planListModel.obj[index].ID;
            selfWeak.nameLabel.text = selfWeak.homeVM.planListModel.obj[index].plantName;
            [selfWeak showProgressView];
            [selfWeak getPowerStationWithHttp];
            selfWeak.popView.hidden = YES;
        };
    }
    return _popView;
}

@end
