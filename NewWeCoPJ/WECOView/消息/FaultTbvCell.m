//
//  FaultTbvCell.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/7.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "FaultTbvCell.h"

@implementation FaultTbvCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
   
//        [self createQuestionUI];
    }
    
    return self;
}
- (void)createUnEditUI{
    
    for (UILabel *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    for (UIImageView *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    for (UIView *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    
    UILabel *timelb = [self goToInitLable:CGRectMake(20*NOW_SIZE, 0, kScreenWidth-60*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorblack_154 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.contentView addSubview:timelb];
    _timeLB = timelb;
    
    UIView *noreadView = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE+(60*HEIGHT_SIZE-8*NOW_SIZE)/2, 8*NOW_SIZE, 8*NOW_SIZE)];
    noreadView.layer.cornerRadius = 4*HEIGHT_SIZE;
    noreadView.layer.masksToBounds = YES;
    [self.contentView addSubview:noreadView];
    _noReadVie = noreadView;
    
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(26*NOW_SIZE,CGRectGetMaxY(timelb.frame), kScreenWidth-26*NOW_SIZE*2, 60*HEIGHT_SIZE)];
    bgv.backgroundColor = backgroundNewColor;
    bgv.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgv.layer.masksToBounds = YES;
    [self.contentView addSubview:bgv];
    
    
    UILabel *contenlb = [self goToInitLable:CGRectMake(5*NOW_SIZE, 4*HEIGHT_SIZE, bgv.xmg_width-10*NOW_SIZE, bgv.xmg_height-8*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    contenlb.numberOfLines = 4;
    [bgv addSubview:contenlb];
    _contenLB = contenlb;
    
    
}

- (void)createEditUI{
    
    for (UILabel *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    for (UIImageView *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    for (UIView *onelb in self.contentView.subviews) {
        [onelb removeFromSuperview];
    }
    
    UILabel *timelb = [self goToInitLable:CGRectMake(5*NOW_SIZE, 0, kScreenWidth-60*NOW_SIZE, 20*HEIGHT_SIZE) textName:@"" textColor:colorblack_154 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.contentView addSubview:timelb];
    _timeLB = timelb;
    
//    UIView *noreadView = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 20*HEIGHT_SIZE+(60*HEIGHT_SIZE-8*NOW_SIZE)/2, 8*NOW_SIZE, 8*NOW_SIZE)];
//    noreadView.layer.cornerRadius = 4*HEIGHT_SIZE;
//    noreadView.layer.masksToBounds = YES;
//    [self.contentView addSubview:noreadView];
//    _noReadVie = noreadView;
    
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,CGRectGetMaxY(timelb.frame), kScreenWidth-10*NOW_SIZE*2-20*HEIGHT_SIZE-8*NOW_SIZE, 60*HEIGHT_SIZE)];
    bgv.backgroundColor = backgroundNewColor;
    bgv.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgv.layer.masksToBounds = YES;
    [self.contentView addSubview:bgv];
    
    
    UILabel *contenlb = [self goToInitLable:CGRectMake(5*NOW_SIZE, 4*HEIGHT_SIZE, bgv.xmg_width-10*NOW_SIZE, bgv.xmg_height-8*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    contenlb.numberOfLines = 4;
    [bgv addSubview:contenlb];
    _contenLB = contenlb;
    
    UIButton *selectbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bgv.frame)+8*NOW_SIZE, CGRectGetMaxY(timelb.frame)+(bgv.xmg_height-20*HEIGHT_SIZE)/2, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE)];
    [selectbtn setImage:IMAGE(@"MsgUnselect") forState:UIControlStateNormal];
    [selectbtn setImage:IMAGE(@"MsgSelect") forState:UIControlStateSelected];
    [selectbtn addTarget:self action:@selector(seleclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectbtn];
    _seleBtn = selectbtn;
    
    
}
- (void)seleclick:(UIButton *)seleBtn{
    
    seleBtn.selected = !seleBtn.selected;
    self.BtnClickBlock(seleBtn.selected);
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
