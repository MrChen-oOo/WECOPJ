//
//  langShowView.m
//  ShinePhone
//
//  Created by CBQ on 2022/4/26.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeRightItemView.h"
@implementation WeRightItemView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR(0, 0, 0, 0.4);
        UITapGestureRecognizer *bgclick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgclick)];
        bgclick.delegate = self;
        [self addGestureRecognizer:bgclick];
//        [self showView];
    }
    
    return self;
}
- (void)bgclick{
    
    [self removeFromSuperview];
}
- (void)showView{


    
    UITableView *tablev = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth-10*NOW_SIZE-120*NOW_SIZE, _tabvY, 120*NOW_SIZE, _dataArr.count*45*HEIGHT_SIZE) style:UITableViewStylePlain];
    tablev.delegate = self;
    tablev.dataSource = self;
    [self addSubview:tablev];
    tablev.layer.cornerRadius = 10*HEIGHT_SIZE;
    tablev.layer.masksToBounds = YES;
    tablev.layer.borderWidth = 1*NOW_SIZE;
    tablev.layer.borderColor = colorblack_102.CGColor;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"langCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = FontSize(13*HEIGHT_SIZE);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectBlock(_dataArr[indexPath.row],(int)indexPath.row);
    [self removeFromSuperview];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

        if ([NSStringFromClass([touch.view class])                                                               isEqualToString:@"UITableViewCellContentView"]) {

       //判断如果点击的是tableView的cell，就把手势给关闭了

        return NO;

        //关闭手势

        }

    //否则手势存在

    return YES;

}
@end
