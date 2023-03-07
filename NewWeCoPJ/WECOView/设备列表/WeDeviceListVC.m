//
//  WeDeviceListVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/28.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeDeviceListVC.h"
#import "RedxDTKDropdownMenuView.h"
#import "RedxKTDropdownMenuView.h"
#import "WeDevlistCell.h"
#import "WeDeviceDetailVC.h"

@interface WeDeviceListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RedxDTKDropdownMenuView *titleMenuView;
@property (nonatomic, strong) RedxKTDropdownMenuView *menuView;

@property (nonatomic, strong) UITableView *devTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *allPlantArr;
@property (nonatomic, strong) NSMutableArray *plantNameArr;
@property (nonatomic, strong) NSMutableArray *plantIdArr;
@property (nonatomic, strong) NSString *addTipsStatus;

@end

@implementation WeDeviceListVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self createDownList];
    [self getAllPlantdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:home_Log style:UIBarButtonItemStylePlain target:self action:@selector(LogClick)];
    [self createTable];
    
//    [self getAllDevicedata];
    // Do any additional setup after loading the view.
}
- (void)createDownList{
    
    if (deviceSystemVersion>=11.0) {
        if (_menuView) {
            [_menuView removeFromSuperview];
            _menuView=nil;
        }
        
        if(self.allPlantArr.count == 0){
            
            self.title = @"";
        }else{
            self.title = @"";
            
            _plantNameArr = [[NSMutableArray alloc]init];
            _plantIdArr = [[NSMutableArray alloc]init];

            int seleNumb = 0;
            for (int i = 0; i < _allPlantArr.count; i++) {
                
                NSDictionary *onedic = _allPlantArr[i];
                NSString *planname = [NSString stringWithFormat:@"%@",onedic[@"plantName"]];
                NSString *planId = [NSString stringWithFormat:@"%@",onedic[@"id"]];

                [_plantNameArr addObject:planname];
                [_plantIdArr addObject:planId];
                if([planId isEqualToString:_PlantID]){
                    seleNumb = i;
                    
                }

            }
            
            
            
            _menuView = [[RedxKTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,200, 44) titles:_plantNameArr];
            
            __weak typeof(self) weakSelf = self;
            _menuView.selectedAtIndex = ^(int index)
            {
                if(index < weakSelf.plantIdArr.count){
                    
                    weakSelf.PlantID = weakSelf.plantIdArr[index];
//                    [weakSelf getOverdata];
                    [weakSelf getAllDevicedata];
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
            self.navigationItem.titleView = _menuView;
            
        }
        
        
        
        
    }else{
        if (_titleMenuView) {
            [_titleMenuView removeFromSuperview];
            _titleMenuView=nil;
        }
        
        if(_allPlantArr.count == 0){
            
            self.title = @"";
        }else{
            
            _plantNameArr = [[NSMutableArray alloc]init];
            _plantIdArr = [[NSMutableArray alloc]init];

            int seleNumb = 0;
            for (int i = 0; i < _allPlantArr.count; i++) {
                
                NSDictionary *onedic = _allPlantArr[i];
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


- (void)createTable{
    
    
    self.devTableView = [[UITableView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, kScreenHeight - kNavBarHeight-10*HEIGHT_SIZE) style:UITableViewStylePlain];
    self.devTableView.delegate = self;
    self.devTableView.dataSource = self;
    [self.view addSubview:self.devTableView];
    self.devTableView.backgroundColor = WhiteColor;
    self.devTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.devTableView registerClass:[WeDevlistCell class] forCellReuseIdentifier:@"supportCellID"];
    
    MJRefreshNormalHeader *header2  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{

  
        [self getAllDevicedata];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.devTableView.mj_header endRefreshing];
        });
    }];
    header2.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header2.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间

    header2.stateLabel.hidden = YES;
    self.devTableView.mj_header = header2;
    
//    _addTipsStatus = @"0";
//    if([_addTipsStatus isEqualToString:@"0"]){
//
//        UIView *tipsview = [self goToInitView:CGRectMake(0, 0, kScreenWidth, 80*HEIGHT_SIZE) backgroundColor:WhiteColor];
//        UILabel *tipslb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 60*HEIGHT_SIZE) textName:@"The current device is not online and cannot beviewed temporarily. Please check whether the device is connected to the Internet" textColor:colorBlack fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
//        tipslb.backgroundColor = backgroundNewColor;
//        tipslb.numberOfLines = 0;
//        [tipsview addSubview:tipslb];
//        tipslb.layer.cornerRadius = 10*HEIGHT_SIZE;
//        tipslb.layer.masksToBounds = YES;
//        self.devTableView.tableFooterView = tipsview;
//    }
    
}
//tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
 
    return _dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *cellID = [NSString stringWithFormat:@"supportCellID%d",indexPath.row];
    
    WeDevlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"supportCellID" forIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:@"supportCellID"];
    if (!cell) {
        cell = [[WeDevlistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"supportCellID"];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *oneDic = _dataSource[indexPath.row];
    NSString *deviceType = [NSString stringWithFormat:@"%@",oneDic[@"deviceType"]];
    NSString *deviceTypeText = [NSString stringWithFormat:@"%@",oneDic[@"deviceTypeText"]];
    NSString *deviceSn = [NSString stringWithFormat:@"%@",oneDic[@"deviceSn"]];
    NSString *devStatus = [NSString stringWithFormat:@"%@",oneDic[@"deviceStatus"]];
    NSString *workModel = [NSString stringWithFormat:@"%@",oneDic[@"workModel"]];

    if([deviceType isEqualToString:@"1"]){
        
        cell.logoImgv.image = IMAGE(@"PCSIcon");
        
    }
    if([deviceType isEqualToString:@"2"]){
        
        cell.logoImgv.image = IMAGE(@"XPIcon");
        
    }
    if([deviceType isEqualToString:@"3"]){
        
        cell.logoImgv.image = IMAGE(@"HVBOXIcon");
        
    }
    if([deviceType isEqualToString:@"4"]){
        
        cell.logoImgv.image = IMAGE(@"XPIcon");
        
    }
    cell.titleLB.text = deviceSn;
    cell.devTypeLB.text = [NSString stringWithFormat:@"Device type:%@",deviceTypeText];
    cell.statuLB.text = devStatus;
    cell.batLB.text = [NSString stringWithFormat:@"Work Model:%@",workModel];

    if ([devStatus isEqualToString:@"Offline"]) {
        cell.statuLB.textColor = colorblack_154;
    }else{
        cell.statuLB.textColor = [UIColor greenColor];

    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *oneDic = _dataSource[indexPath.row];

    WeDeviceDetailVC *detailvc = [[WeDeviceDetailVC alloc]init];
    detailvc.deviceType = [NSString stringWithFormat:@"%@",oneDic[@"deviceType"]];
    detailvc.deviceSn = [NSString stringWithFormat:@"%@",oneDic[@"deviceSn"]];

    [self.navigationController pushViewController:detailvc animated:YES];

}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了编辑");
            NSDictionary *oneDic = _dataSource[indexPath.row];
            NSString *deviceSn = [NSString stringWithFormat:@"%@",oneDic[@"deviceSn"]];
            
            [self DeleteSet:deviceSn];

        }];
        deleteAction.backgroundColor = [UIColor redColor];
        
        return @[deleteAction];
}

//log
- (void)LogClick{
    
    
}


//获取设备列表
- (void)getAllDevicedata{
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/getDeviceList" parameters:@{@"plantId":_PlantID} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        [self.devTableView.mj_header endRefreshing];
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];
            _addTipsStatus = msg;
            if([_addTipsStatus isEqualToString:@"0"]){
                
                UIView *tipsview = [self goToInitView:CGRectMake(0, 0, self.devTableView.xmg_width, 120*HEIGHT_SIZE) backgroundColor:WhiteColor];
                UILabel *tipslb = [self goToInitLable:CGRectMake(0, 30*HEIGHT_SIZE, self.devTableView.xmg_width, 80*HEIGHT_SIZE) textName:@"The current device is not online and cannot beviewed temporarily. Please check whether the device is connected to the Internet" textColor:colorBlack fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
                tipslb.backgroundColor = backgroundNewColor;
                tipslb.numberOfLines = 0;
                [tipsview addSubview:tipslb];
                tipslb.layer.cornerRadius = 10*HEIGHT_SIZE;
                tipslb.layer.masksToBounds = YES;
                self.devTableView.tableFooterView = tipsview;
            }else{
                self.devTableView.tableFooterView = nil;

            }
            
            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSArray class]]){
                    
                    NSArray *dataarr = [NSArray arrayWithArray:objarr];
                        
                    _dataSource = [NSMutableArray arrayWithArray:dataarr];

                    [self.devTableView reloadData];

                }

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
        [self.devTableView.mj_header endRefreshing];
        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
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

            if ([result isEqualToString:@"0"]) {


                id objarr = datadic[@"obj"];
                if([objarr isKindOfClass:[NSArray class]]){
                    
                    NSArray *dataarr = [NSArray arrayWithArray:objarr];
                        
                    _allPlantArr = [NSMutableArray arrayWithArray:dataarr];

                    [self getAllDevicedata];
                }

            }
//
        }
        [self createDownList];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self createDownList];
        if (error) {
            [self showToastViewWithTitle:linkTimeOut1];

        }
    }];
}

//删除
- (void)DeleteSet:(NSString *)devSN{
 
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/plant/delDeviceInfo" parameters:@{@"deviceSn":devSN} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
     
        
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
//            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
//            [self showToastViewWithTitle:msg];

            if ([result isEqualToString:@"0"]) {


                [self showToastViewWithTitle:@"Delete Success"];
                [self getAllDevicedata];

            }
//
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}
@end
