//
//  BDCMassageCell.m
//  LocalDebug
//
//  Created by CBQ on 2021/7/12.
//

#import "BDCMassageCell.h"

@implementation BDCMassageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        
    }
    
    return self;
}
- (void)reloadBDCMessageCell{
    
    if (_bgview) {
        
        [_bgview removeFromSuperview];
    }
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 10*HEIGHT_SIZE, kScreenWidth - 40*NOW_SIZE, 70*HEIGHT_SIZE)];
    bgview.backgroundColor = WhiteColor;
//    bgview.layer.cornerRadius = 10*HEIGHT_SIZE;
//    bgview.layer.masksToBounds = YES;
    [self.contentView addSubview:bgview];
    _bgview = bgview;

    UILabel *oneLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
    oneLB.adjustsFontSizeToFitWidth = YES;
    oneLB.font = FontSize(14*HEIGHT_SIZE);
    oneLB.textColor = colorblack_102;
    oneLB.textAlignment = NSTextAlignmentCenter;

    if(_NameSource.count > 0){
        oneLB.text = _NameSource[0];

    }
    oneLB.numberOfLines = 0;
    [bgview addSubview:oneLB];
    
    UILabel *valueLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLB.frame),bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
    valueLB.adjustsFontSizeToFitWidth = YES;
    valueLB.font = FontSize(14*HEIGHT_SIZE);
    valueLB.textColor = colorBlack;
    valueLB.textAlignment = NSTextAlignmentCenter;
    if(_dataSource.count >0){
        NSString *keystr = _dataSource[0];
        
        NSString *valustr = [NSString stringWithFormat:@"%@",_deviceAllDic[keystr]];
        if(kStringIsEmpty(valustr)){
            valustr = @"--";
        }
        
        valueLB.text = valustr;

    }
    valueLB.numberOfLines = 0;
    [bgview addSubview:valueLB];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(valueLB.frame)+9*HEIGHT_SIZE, valueLB.xmg_width, 1*HEIGHT_SIZE)];
    linev.backgroundColor = colorblack_186;
    [bgview addSubview:linev];
    
    if(_NameSource.count > 1){

        UILabel *twoLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oneLB.frame)+20*NOW_SIZE, 0,bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
        twoLB.adjustsFontSizeToFitWidth = YES;
        twoLB.font = FontSize(14*HEIGHT_SIZE);
        twoLB.textColor = colorblack_102;
        twoLB.textAlignment = NSTextAlignmentCenter;
        twoLB.text = _NameSource[1];
        twoLB.numberOfLines = 0;
        [bgview addSubview:twoLB];
        
        UILabel *valueLB2 = [[UILabel alloc]initWithFrame:CGRectMake(twoLB.xmg_x, CGRectGetMaxY(twoLB.frame),bgview.xmg_width/2-10*NOW_SIZE, 30*HEIGHT_SIZE)];
        valueLB2.adjustsFontSizeToFitWidth = YES;
        valueLB2.font = FontSize(14*HEIGHT_SIZE);
        valueLB2.textColor = colorBlack;
        valueLB2.textAlignment = NSTextAlignmentCenter;

        if(_dataSource.count > 1){
    //        valueLB2.text = _dataSource[1];
            NSString *keystr2 = _dataSource[1];
            NSString *valustr2 = [NSString stringWithFormat:@"%@",_deviceAllDic[keystr2]];

            if(kStringIsEmpty(valustr2)){
                valustr2 = @"--";
            }
            valueLB2.text = valustr2;//[NSString stringWithFormat:@"%@",_deviceAllDic[keystr2]];
        }
        valueLB2.numberOfLines = 0;
        [bgview addSubview:valueLB2];
        
        UIView *linev2 = [[UIView alloc]initWithFrame:CGRectMake(twoLB.xmg_x, CGRectGetMaxY(valueLB2.frame)+9*HEIGHT_SIZE, valueLB2.xmg_width, 1*HEIGHT_SIZE)];
        linev2.backgroundColor = colorblack_186;

        [bgview addSubview:linev2];
    }
    
    
    
    
    
}
@end
