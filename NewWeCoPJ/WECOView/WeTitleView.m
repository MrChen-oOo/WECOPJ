//
//  WeTitleView.m
//  NewWeCoPJ
//
//  Created by 啊清 on 2023/2/3.
//

#import "WeTitleView.h"

@implementation WeTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(0, 0, 0, 0.3);
        [self createTable];
    }
    
    return self;
}

- (void)createTable{
    
    
    self.devTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth/2-60*NOW_SIZE,0, 120*NOW_SIZE, 0) style:UITableViewStylePlain];
    self.devTableView.delegate = self;
    self.devTableView.dataSource = self;
    [self addSubview:self.devTableView];
    self.devTableView.backgroundColor = WhiteColor;
    self.devTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.devTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"plantListCellID"];
    
    
    
}

- (void)reloadTableVData{
    
    CGFloat tabH = 40*HEIGHT_SIZE*_dataSource.count;
    if(tabH > kScreenHeight - kNavBarHeight-10*HEIGHT_SIZE){
        tabH = kScreenHeight - kNavBarHeight-10*HEIGHT_SIZE;
        
    }
    self.devTableView.xmg_height = tabH;
    [self.devTableView reloadData];
}


//tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      
 
    return _dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *cellID = [NSString stringWithFormat:@"supportCellID%d",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plantListCellID" forIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:@"supportCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plantListCellID"];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *namestr = _dataSource[indexPath.row];
    cell.textLabel.text = namestr;
    cell.textLabel.textColor = colorblack_51;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    NSString *namestr = _dataSource[indexPath.row];
    
    self.SelectBlock(namestr, indexPath.row);

    [self removeFromSuperview];
    
    
}
@end
