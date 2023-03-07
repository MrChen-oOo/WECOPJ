//
//  USSet1Cell.m
//  LocalDebug
//
//  Created by CBQ on 2021/4/28.
//

#import "USSet1Cell.h"

@implementation USSet1Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCell];
    }
    return self;
}

- (void)createCell{
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 2.5*HEIGHT_SIZE, kScreenWidth/2 + 20*NOW_SIZE, 40*HEIGHT_SIZE)];
    titleLB.textColor = colorBlack;
    titleLB.adjustsFontSizeToFitWidth = YES;
    titleLB.font = FontSize(15*HEIGHT_SIZE);
    titleLB.numberOfLines = 0;
    [self.contentView addSubview:titleLB];
    _titleLB = titleLB;
    
    UILabel *detailLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(titleLB.frame), kScreenWidth-60*NOW_SIZE, 25*HEIGHT_SIZE)];
    detailLB.textColor = colorblack_154;
    detailLB.adjustsFontSizeToFitWidth = YES;
    detailLB.font = FontSize(12*HEIGHT_SIZE);
    detailLB.numberOfLines = 0;
    [self.contentView addSubview:detailLB];
    detailLB.hidden = YES;
    _detailLB = detailLB;
    
    
    UIButton *onoffBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 10*NOW_SIZE - 40*HEIGHT_SIZE, (45*HEIGHT_SIZE - 30*HEIGHT_SIZE)/2, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [onoffBtn setImage:IMAGE(@"weoff") forState:UIControlStateNormal];
    [onoffBtn setImage:IMAGE(@"weon") forState:UIControlStateSelected];
    [self.contentView addSubview:onoffBtn];
    _onoffBtn = onoffBtn;
    
    UILabel *valueLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLB.frame)+10*NOW_SIZE, (45*HEIGHT_SIZE - 40*HEIGHT_SIZE)/2, kScreenWidth-CGRectGetMaxX(titleLB.frame)-10*NOW_SIZE-10*NOW_SIZE-16*NOW_SIZE, 40*HEIGHT_SIZE)];
    valueLB.adjustsFontSizeToFitWidth = YES;
    valueLB.textAlignment = NSTextAlignmentRight;
    valueLB.font = FontSize(14*HEIGHT_SIZE);
    valueLB.textColor = colorblack_102;
    valueLB.numberOfLines = 0;
    [self.contentView addSubview:valueLB];
    _valueLB = valueLB;
    
    UIImageView *rigIMG = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 10*NOW_SIZE - 16*HEIGHT_SIZE, (45*HEIGHT_SIZE - 16*HEIGHT_SIZE)/2, 16*HEIGHT_SIZE, 16*HEIGHT_SIZE)];
    rigIMG.image = IMAGE(@"prepare_more");
    rigIMG.userInteractionEnabled = YES;
    [self.contentView addSubview:rigIMG];
    _rightIMG = rigIMG;
}
@end
