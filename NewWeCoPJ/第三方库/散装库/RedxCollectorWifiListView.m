#import "RedxCollectorWifiListView.h"
@implementation RedxCollectorWifiListView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *dataTBV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        dataTBV.delegate = self;
        dataTBV.dataSource = self;
        dataTBV.backgroundColor = WhiteColor;
        [self addSubview:dataTBV];
        _table = dataTBV;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40*HEIGHT_SIZE;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *wifilistCellID = @"wifilistCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wifilistCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wifilistCellID"];
    }
    cell.contentView.backgroundColor = backgroundNewColor;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataSource[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = FontSize(14*HEIGHT_SIZE);
    cell.textLabel.textColor = colorblack_102;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *backwifi = [NSString stringWithFormat:@"%@",_dataSource[indexPath.row]];
    _backwifi(backwifi);
    self.hidden = YES;
}
@end
