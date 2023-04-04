//
//  InveterGridInfoView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/28.
//

#import "InveterGridInfoView.h"
#import "InfoTableViewCell.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface InveterGridInfoView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * inveterTableView;
@property (nonatomic, strong)InveterViewModel *inveterVM;
@property (nonatomic, strong) UIPageControl *basicPageC;

@end

@implementation InveterGridInfoView

-(instancetype)initWithViewModel:(InveterViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.inveterVM = viewModel;
        [self creatUI];
       
    }
    return self;
}

- (void)creatUI {
    [self addSubview:self.inveterTableView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [footView addSubview:self.basicPageC];
    self.inveterTableView.tableFooterView  = footView;
    
    // 下拉刷新
    @WeakObj(self)
    MJRefreshNormalHeader *reloadHeader  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        selfWeak.headerRealoadBlock ? selfWeak.headerRealoadBlock() : nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [selfWeak.inveterTableView.mj_header endRefreshing];
        });
    }];
    reloadHeader.automaticallyChangeAlpha = YES;    // 设置自动切换透明度(在导航栏下面自动隐藏)
    reloadHeader.lastUpdatedTimeLabel.hidden = YES;    // 隐藏时间
    reloadHeader.stateLabel.hidden = YES;
    self.inveterTableView.mj_header = reloadHeader;

}

- (void)reloadTableView {
    [self.inveterTableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.inveterVM.infoModel.inveterKeyTwoArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inveterVM.infoModel.inveterKeyTwoArray[section].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  indexPath.row == 0 || indexPath.row == (self.inveterVM.infoModel.inveterKeyTwoArray[indexPath.section].count - 1) ? 60 : 40; // 60
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30; //: 20
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
    view.frame = CGRectMake(0, 0, kScreenWidth,30);
    UILabel *sectionName = [[UILabel alloc]initWithFrame:CGRectMake(26, 10, kScreenWidth - 40, 20)];
    sectionName.textAlignment = NSTextAlignmentLeft;
    [sectionName setTextColor:[UIColor lightGrayColor]];
    [sectionName setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [sectionName setTextColor:HexRGB(0x999999)];
    sectionName.text = self.inveterVM.infoModel.inveterSectionTwoArray[section];
    [view addSubview:sectionName];

    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[InfoTableViewCell alloc] initWithReuseIdentifier:@"info" index:indexPath];
    }
    [cell setCellUIWithKey:self.inveterVM.infoModel.inveterKeyTwoArray[indexPath.section][indexPath.row]
                     value:self.inveterVM.infoModel.inveterValueTwoArray[indexPath.section][indexPath.row]
                    isLast:indexPath.row == (self.inveterVM.infoModel.inveterKeyTwoArray[indexPath.section].count - 1) ? YES : NO
                   isFirst:indexPath.row == 0 ? YES : NO
                 isSegment:NO
                      unit:[self.inveterVM.infoModel.inveterUnitTwoArray[indexPath.section][indexPath.row] intValue] typeNum:0];

    return cell;
}


#pragma mark - 懒加载

- (UITableView *) inveterTableView {
    if (!_inveterTableView) {
        _inveterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
        _inveterTableView.showsVerticalScrollIndicator = NO;
        _inveterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _inveterTableView.delegate = self;
        _inveterTableView.dataSource = self;
        _inveterTableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _inveterTableView;
}


-(InveterViewModel *)inveterVM {
    if(!_inveterVM) {
        _inveterVM = [[InveterViewModel alloc]initViewModel];
    }
    return _inveterVM;
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
