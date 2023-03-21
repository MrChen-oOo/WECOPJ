//
//  GridStandardView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import "GridStandardView.h"
#import "GridStandardTableViewCell.h"

@interface GridStandardView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)INVSettingViewModel *invVM;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic, assign) NSInteger selectNum;
@property (weak, nonatomic) IBOutlet UILabel *titleLabe;

@property (nonatomic, strong) NSString * keyStr;
@end


@implementation GridStandardView

-(instancetype)initWithViewModel:(INVSettingViewModel *)viewModel {
    self = [[NSBundle mainBundle] loadNibNamed:@"GridStandardView" owner:nil options:nil].lastObject;
    if (self) {
        self.invVM = viewModel;
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        [self.listTableView registerNib:[UINib nibWithNibName:@"GridStandardTableViewCell" bundle:nil] forCellReuseIdentifier:@"grid"];
    }
    return self;
}


-(void)selectCellActionWith:(NSInteger)cellNum type:(NSString *)typeStr title:(NSString *)titleStr {
    
    [self.titleArray removeAllObjects];
    self.keyStr = typeStr;
    if ([typeStr isEqualToString:@"gridStandard"]) {
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.gridStandardsKeyArray];
    } else if ([typeStr isEqualToString:@"USA_STANDARD_CLASS"]) {
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.usaStandardClassArray];
    } else if ([typeStr isEqualToString:@"gridSet"]){
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.gridSetArray];
    } else if ([typeStr isEqualToString:@"pvInputType"]){
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.inputTypeArray];
    } else if ([typeStr isEqualToString:@"INV_PARALLEL_IDENTITY"]){
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.parallelArray];
    } else if ([typeStr isEqualToString:@"P_HASE_ENABLE"]){
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.phaseEnableArray];
    } else if ([typeStr isEqualToString:@"MOODBUS_BAUD"]) {
        [self.titleArray addObjectsFromArray:self.invVM.optionModel.modbusArray];
        if (cellNum != 0 && cellNum != 1){
            cellNum = 0;
        }
    }
    [self.listTableView reloadData];
    self.selectNum = cellNum;
    NSIndexPath *index = [NSIndexPath indexPathForRow:cellNum inSection:0];
    [self.listTableView selectRowAtIndexPath:index animated:YES scrollPosition:(UITableViewScrollPositionTop)];
    self.titleLabe.text = titleStr;
}

- (IBAction)selectfinishAction:(UIButton *)sender {
    
    NSDictionary *dic = @{@"deviceSn":self.invVM.deviceSnStr,@"code":self.keyStr,@"value":@(self.selectNum)} ;
    self.selectCellBlock ? self.selectCellBlock(dic) : nil;
    self.hidden = YES;
}

- (IBAction)cancelAction:(UIButton *)sender {
    self.hidden = YES;
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GridStandardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"grid" forIndexPath:indexPath];
    
    if ([self.keyStr isEqualToString:@"gridStandard"]) {
        cell.countryLabel.text = [NSString stringWithFormat:@"%@ : ",self.invVM.optionModel.gridStandardsKeyArray[indexPath.row]];
        cell.shorthandLabel.text = self.invVM.optionModel.gridStandardsValueArray[indexPath.row];
    } else {
        cell.countryLabel.text = [NSString stringWithFormat:@"%@",self.titleArray[indexPath.row]];
        cell.shorthandLabel.text = @"";
    }
    

    [cell selectCellWith:indexPath.row select:self.selectNum];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectNum = indexPath.row;
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionNone)];
    [self.listTableView reloadData];

}
- (IBAction)hiddenAction:(UIButton *)sender {
    self.hidden = YES;
}


-(NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


@end
