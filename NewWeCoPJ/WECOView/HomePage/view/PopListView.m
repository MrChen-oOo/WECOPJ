//
//  PopListView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/31.
//

#import "PopListView.h"

@interface PopListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HomePageViewModel *homeVM;
@property (weak, nonatomic) IBOutlet UITableView *popTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;


@end

@implementation PopListView

-(instancetype)initWithViewModel:(HomePageViewModel *)viewModel {
    self = [[NSBundle mainBundle] loadNibNamed:@"PopListView" owner:nil options:nil].lastObject;
    if (self) {
        self.homeVM = viewModel;
        self.popTableView.delegate = self;
        self.popTableView.dataSource = self;
        [self.popTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"popList"];
    }
    return self;
}

- (void)reloadCellMessage {
    self.tableViewHeight.constant = self.homeVM.planListModel.obj.count * 40;
    [self.popTableView reloadData];
}


#pragma mark -UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.homeVM.planListModel.obj.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"popList" forIndexPath:indexPath];
        UILabel *centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.bounds.size.width, 39)];
        [centerLabel setTextAlignment:NSTextAlignmentCenter];
        centerLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        centerLabel.textColor = HexRGB(0x333333);
        centerLabel.backgroundColor = [UIColor whiteColor];
        centerLabel.text = self.homeVM.planListModel.obj[indexPath.row].plantName;
        
//        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, cell.frame.size.width, 1)];
//        lineLabel.backgroundColor = [UIColor colorWithRed:173 green:173 blue:173 alpha:0.5];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
//        [cell.contentView addSubview:lineLabel];
        [cell.contentView addSubview:centerLabel];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectCellBlock ? self.selectCellBlock(indexPath.row): nil;
}

- (IBAction)hiddenAction:(UIButton *)sender {
    self.hidden = YES;
}

-(HomePageViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomePageViewModel alloc]init];
    }
    return _homeVM;
}


@end
