//
//  DeviceInfoView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "DeviceInfoView.h"
#import "InfoTableViewCell.h"
#import "BaseSegmentView.h"
#import "SegmentThreeView.h"
#import "SegmentDoubleView.h"

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface DeviceInfoView()<UITableViewDelegate,UITableViewDataSource,SegmentSettingDelegate,SegmentThreeDelegate,SegmentDoubleDelegate>

@property (nonatomic, strong)UITableView * cabinetTableView;
@property (nonatomic, strong)CabinetViewModel *cabinetVM;
@property (nonatomic, strong)BaseSegmentView *segmentView;
@property (nonatomic, strong)SegmentThreeView *segmentThreeView;
@property (nonatomic, strong)SegmentDoubleView *segmentTwoView;


@end

@implementation DeviceInfoView

-(instancetype)initWithViewModel:(CabinetViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.cabinetVM = viewModel;
        [self creatUI];
       
    }
    return self;
}

- (void)creatUI {
    [self addSubview:self.cabinetTableView];
    // 下拉刷新
    @WeakObj(self)
    MJRefreshNormalHeader *reloadHeader  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        selfWeak.headerRealoadBlock ? selfWeak.headerRealoadBlock() : nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [selfWeak.cabinetTableView.mj_header endRefreshing];
        });
    }];
    reloadHeader.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    reloadHeader.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    reloadHeader.stateLabel.hidden = YES;
    self.cabinetTableView.mj_header = reloadHeader;
}

- (void)reloadTableView {
    [self.cabinetTableView reloadData];
}
#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cabinetVM.infoModel.cabinetKeyOneArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cabinetVM.infoModel.cabinetKeyOneArray[section].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  indexPath.row == 0 ? 50 : indexPath.row == (self.cabinetVM.infoModel.cabinetKeyOneArray[indexPath.section].count - 1) ? 60 : 40; // 60
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 1 ? 70 : 30; //: 20
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kScreenWidth,section == 1 ? 70 : 30);

    
    UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, kScreenWidth - 40, 20)];
    sectionName.textAlignment = NSTextAlignmentLeft;
    [sectionName setTextColor:[UIColor lightGrayColor]];
    [sectionName setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [sectionName setTextColor:HexRGB(0x999999)];
    sectionName.text = self.cabinetVM.infoModel.cabinetSectionOneArray[section];
    [view addSubview:sectionName];
    
    if (section == 1) {
        switch (self.cabinetVM.infoModel.cabinetModel.acModelList.count) {
            case 2:
                [view addSubview:self.segmentTwoView];
                break;
            case 3:
                [view addSubview:self.segmentThreeView];
                break;
            case 4:
                [view addSubview:self.segmentView];
                break;
            default:
                break;
        }
    }
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[InfoTableViewCell alloc] initWithReuseIdentifier:@"info" index:indexPath];
    }
    [cell setCellUIWithKey:self.cabinetVM.infoModel.cabinetKeyOneArray[indexPath.section][indexPath.row]
                     value:self.cabinetVM.infoModel.cabinetValueOneArray[indexPath.section][indexPath.row]
                    isLast:indexPath.row == (self.cabinetVM.infoModel.cabinetKeyOneArray[indexPath.section].count - 1) ? YES : NO
                   isFirst:indexPath.row == 0 ? YES : NO
                 isSegment:indexPath.section == 1 ? YES : NO
                      unit:[self.cabinetVM.infoModel.cabinetUnitOneArray[indexPath.section][indexPath.row] intValue] typeNum:1];
    return cell;
}

// 按钮点击刷新ui
-(void)segmentSelectWith:(NSInteger)index {
    [self.cabinetVM.infoModel addICabinetSectionOneArrayWithIndex:index];
    [self.cabinetTableView reloadData];
}

-(void)segmentThreeSelectWith:(NSInteger)index {
    [self.cabinetVM.infoModel addICabinetSectionOneArrayWithIndex:index];
    [self.cabinetTableView reloadData];
}

-(void)segmentDoubleSelectWith:(NSInteger)index {
    [self.cabinetVM.infoModel addICabinetSectionOneArrayWithIndex:index];
    [self.cabinetTableView reloadData];
}
#pragma mark - 懒加载

- (UITableView *) cabinetTableView {
    if (!_cabinetTableView) {
        _cabinetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight - 30) style:UITableViewStyleGrouped];
        _cabinetTableView.showsVerticalScrollIndicator = NO;
        _cabinetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cabinetTableView.delegate = self;
        _cabinetTableView.dataSource = self;
        _cabinetTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _cabinetTableView;
}


-(CabinetViewModel *)cabinetVM {
    if(!_cabinetVM) {
        _cabinetVM = [[CabinetViewModel alloc]initViewModel];
    }
    return _cabinetVM;
}

-(BaseSegmentView *)segmentView {
    if(!_segmentView) {
        NSArray *array = @[@"PCS-1",@"PCS-2",@"PCS-3",@"PCS-4"];
        _segmentView = [[BaseSegmentView alloc]initWithSegmentViewWithTitleArray:array];
        _segmentView.frame = CGRectMake(0, 40, kScreenWidth, 30);
        _segmentView.delegate = self;
    }
    return _segmentView;
}

-(SegmentThreeView *)segmentThreeView {
    if(!_segmentThreeView) {
        NSArray *array = @[@"PCS-1",@"PCS-2",@"PCS-3"];
        _segmentThreeView = [[SegmentThreeView alloc]initWithSegmentViewWithTitleArray:array];
        _segmentThreeView.frame = CGRectMake(0, 40, kScreenWidth, 30);
        _segmentThreeView.delegate = self;
    }
    return _segmentThreeView;
}

-(SegmentDoubleView *)segmentTwoView {
    if(!_segmentTwoView) {
        NSArray *array = @[@"PCS-1",@"PCS-2"];
        _segmentTwoView = [[SegmentDoubleView alloc]initWithSegmentViewWithDoubleArray:array];
        _segmentTwoView.frame = CGRectMake(0, 40, kScreenWidth, 30);
        _segmentTwoView.delegate = self;
    }
    return _segmentTwoView;
}

@end
