//
//  WeDevlistCell.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/28.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeDevlistCell.h"

@implementation WeDevlistCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
   
        [self createQuestionUI];
    }
    
    return self;
}
- (void)createQuestionUI{
    
    for (UILabel *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    for (UIImageView *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    for (UIView *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }

    
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth-20*NOW_SIZE, 80*HEIGHT_SIZE)];
    bgv.backgroundColor = backgroundNewColor;
    bgv.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgv.layer.masksToBounds = YES;
    [self.contentView addSubview:bgv];
    
    UIImageView *logoimgv = [[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 50*HEIGHT_SIZE, 60*HEIGHT_SIZE)];
    logoimgv.contentMode = UIViewContentModeScaleAspectFit;
    [bgv addSubview:logoimgv];
    _logoImgv = logoimgv;
    
    UILabel *titlb2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(logoimgv.frame)+10*NOW_SIZE,0,bgv.xmg_width-CGRectGetMaxX(logoimgv.frame)-10*NOW_SIZE-5*NOW_SIZE-60*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"" textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];//-20*HEIGHT_SIZE-10*NOW_SIZE
    titlb2.numberOfLines = 0;
//    titlb2.lineBreakMode = NSLineBreakByCharWrapping;
    [bgv addSubview:titlb2];
    _titleLB = titlb2;
    
    
    
    UILabel *titlb4 = [self goToInitLable:CGRectMake(CGRectGetMaxX(logoimgv.frame)+10*NOW_SIZE,CGRectGetMaxY(titlb2.frame),bgv.xmg_width-CGRectGetMaxX(logoimgv.frame)-10*NOW_SIZE-5*NOW_SIZE-60*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];//-20*HEIGHT_SIZE-10*NOW_SIZE
    titlb4.numberOfLines = 0;
//    titlb2.lineBreakMode = NSLineBreakByCharWrapping;
    [bgv addSubview:titlb4];
    _batLB = titlb4;
    
    
    
    UILabel *titlb3 = [self goToInitLable:CGRectMake(CGRectGetMaxX(logoimgv.frame)+10*NOW_SIZE,CGRectGetMaxY(titlb4.frame),bgv.xmg_width-CGRectGetMaxX(logoimgv.frame)-10*NOW_SIZE-5*NOW_SIZE-60*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];//-20*HEIGHT_SIZE-10*NOW_SIZE
    titlb3.numberOfLines = 0;
//    titlb2.lineBreakMode = NSLineBreakByCharWrapping;
    [bgv addSubview:titlb3];
    _devTypeLB = titlb3;
    
    
    
//    UIView *pointv = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlb2.frame), (30*HEIGHT_SIZE-5*HEIGHT_SIZE)/2, 5*HEIGHT_SIZE, 5*HEIGHT_SIZE)];
//    [bgv addSubview:pointv];
//    _pointV = pointv;
//
    UILabel *statuLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(titlb2.frame)+5*NOW_SIZE,5*HEIGHT_SIZE,50*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorBlack fontFloat:12*HEIGHT_SIZE AlignmentType:3 isAdjust:YES];//-20*HEIGHT_SIZE-10*NOW_SIZE
    statuLB.numberOfLines = 0;
//    titlb2.lineBreakMode = NSLineBreakByCharWrapping;
    [bgv addSubview:statuLB];
    _statuLB = statuLB;
    
}

-(UILabel*)goToInitLable:(CGRect)lableFrame textName:(NSString*)textString textColor:(UIColor*)textColor fontFloat:(float)fontFloat AlignmentType:(int)AlignmentType isAdjust:(BOOL)isAdjust{
    UILabel *label= [[UILabel alloc] initWithFrame:lableFrame];
    label.text=textString;
    label.textColor=textColor;
    label.font = [UIFont systemFontOfSize:fontFloat];
    if (AlignmentType==1) {
        label.textAlignment = NSTextAlignmentLeft;
    }else if (AlignmentType==2) {
        label.textAlignment = NSTextAlignmentRight;
    }else{
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.adjustsFontSizeToFitWidth=isAdjust;
    return label;
}
@end
