//
//  GridInfoView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "GridInfoView.h"
#import "InfoTableViewCell.h"
#import "BaseSegmentView.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface GridInfoView()<UITableViewDelegate,UITableViewDataSource,SegmentSettingDelegate>

@property (nonatomic, strong)UITableView * cabinetTableView;
@property (nonatomic, strong)CabinetViewModel *cabinetVM;
@property (nonatomic, strong)BaseSegmentView *segmentView;
@property (nonatomic, strong) UIPageControl *basicPageC;


@end

@implementation GridInfoView

-(instancetype)initWithViewModel:(CabinetViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.cabinetVM = viewModel;
        [self creatUI];
       
    }
    return self;
}

- (void)creatUI {
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [footView addSubview:self.basicPageC];
    self.cabinetTableView.tableFooterView  = footView;
    [self addSubview:self.cabinetTableView];
    
    // 下拉刷新
    @WeakObj(self)
    MJRefreshNormalHeader *reloadHeader  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        selfWeak.headerRealoadBlock ? selfWeak.headerRealoadBlock() : nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    return self.cabinetVM.infoModel.cabinetKeyTwoArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cabinetVM.infoModel.cabinetKeyTwoArray[section].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  indexPath.row == 0 || indexPath.row == (self.cabinetVM.infoModel.cabinetKeyTwoArray[indexPath.section].count - 1) ? 60 : 40; // 60
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 70 : 30; //: 20
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kScreenWidth,section == 0 ? 70 : 30);

    
    UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, kScreenWidth - 40, 20)];
    sectionName.textAlignment = NSTextAlignmentLeft;
    [sectionName setTextColor:[UIColor lightGrayColor]];
    [sectionName setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [sectionName setTextColor:HexRGB(0x999999)];
    sectionName.text = self.cabinetVM.infoModel.cabinetSectionOneArray[section];
    [view addSubview:sectionName];
    
    if (section == 0) {
        [view addSubview:self.segmentView];
    }
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[InfoTableViewCell alloc] initWithReuseIdentifier:@"info" index:indexPath];
    }
    [cell setCellUIWithKey:self.cabinetVM.infoModel.cabinetKeyTwoArray[indexPath.section][indexPath.row]
                     value:self.cabinetVM.infoModel.cabinetValueTwoArray[indexPath.section][indexPath.row]
                    isLast:indexPath.row == (self.cabinetVM.infoModel.cabinetKeyTwoArray[indexPath.section].count - 1) ? YES : NO
                   isFirst:indexPath.row == 0 ? YES : NO
                 isSegment:indexPath.section == 0 ? YES :NO
                      unit:[self.cabinetVM.infoModel.cabinetUnitTwoArray[indexPath.section][indexPath.row] intValue] typeNum:2];

    return cell;
}

-(void)segmentSelectWith:(NSInteger)index {
    [self.cabinetVM.infoModel addICabinetSectionTwoArrayWithIndex:index];
    [self.cabinetTableView reloadData];
}

#pragma mark - 懒加载

- (UITableView *) cabinetTableView {
    if (!_cabinetTableView) {
        _cabinetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
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
        NSArray *array = @[@"MPTT-1",@"MPTT-2",@"MPTT-3",@"MPTT-4"];
        _segmentView = [[BaseSegmentView alloc]initWithSegmentViewWithTitleArray:array];
        _segmentView.frame = CGRectMake(0, 40, kScreenWidth, 30);
        _segmentView.delegate = self;
    }
    return _segmentView;
}


-(UIPageControl *)basicPageC {
    if(!_basicPageC) {
        _basicPageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _basicPageC.numberOfPages = 3;
        _basicPageC.backgroundColor = [UIColor whiteColor];
        _basicPageC.pageIndicatorTintColor = HexRGB(0xd8d8d8);
        _basicPageC.currentPageIndicatorTintColor = HexRGB(0x4776FF);
        _basicPageC.currentPage = 1;
        _basicPageC.userInteractionEnabled = NO;
    }
    return _basicPageC;
}

@end
