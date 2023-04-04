//
//  BatteryInfoView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "BatteryInfoView.h"
#import "InfoTableViewCell.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface BatteryInfoView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * cabinetTableView;
@property (nonatomic, strong)CabinetViewModel *cabinetVM;
@property (nonatomic, strong) UIPageControl *basicPageC;

@end



@implementation BatteryInfoView


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
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [footView addSubview:self.basicPageC];
    self.cabinetTableView.tableFooterView  = footView;
    
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
    return self.cabinetVM.infoModel.cabinetKeyThreeArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cabinetVM.infoModel.cabinetKeyThreeArray[section].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  indexPath.row == 0 || indexPath.row == (self.cabinetVM.infoModel.cabinetKeyThreeArray[indexPath.section].count - 1) ? 60 : 40; // 60
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40; //: 20
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, kScreenWidth - 40, 29)];
    sectionName.textAlignment = NSTextAlignmentLeft;
    [sectionName setTextColor:[UIColor lightGrayColor]];
    [sectionName setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:16]];
    [sectionName setTextColor:HexRGB(0x999999)];
    sectionName.text = self.cabinetVM.infoModel.cabinetSectionThreeArray[section];
    [view addSubview:sectionName];
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[InfoTableViewCell alloc] initWithReuseIdentifier:@"info" index:indexPath];
    }
    [cell setCellUIWithKey:self.cabinetVM.infoModel.cabinetKeyThreeArray[indexPath.section][indexPath.row]
                     value:self.cabinetVM.infoModel.cabinetValueThreeArray[indexPath.section][indexPath.row]
                    isLast:indexPath.row == (self.cabinetVM.infoModel.cabinetKeyThreeArray[indexPath.section].count - 1) ? YES : NO
                   isFirst:indexPath.row == 0 ? YES : NO
                 isSegment:NO
                      unit:[self.cabinetVM.infoModel.cabinetUnitThreeArray[indexPath.section][indexPath.row] intValue] typeNum:3];

    return cell;
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

-(UIPageControl *)basicPageC {
    if(!_basicPageC) {
        _basicPageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _basicPageC.numberOfPages = 3;
        _basicPageC.backgroundColor = [UIColor whiteColor];
        _basicPageC.pageIndicatorTintColor = HexRGB(0xd8d8d8);
        _basicPageC.currentPageIndicatorTintColor = HexRGB(0x4776FF);
        _basicPageC.currentPage = 2;
        _basicPageC.userInteractionEnabled = NO;
    }
    return _basicPageC;
}
@end
