//
//  WePlantListCell.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/2.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WePlantListCell.h"

@implementation WePlantListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self createCell];
    }
    
    return self;
}

- (void)createCell{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, (30+25*4)*HEIGHT_SIZE)];
    bgv.backgroundColor = backgroundNewColor;
    bgv.layer.cornerRadius = 10*HEIGHT_SIZE;
    bgv.layer.masksToBounds = YES;
    [self.contentView addSubview:bgv];
    
    UIImageView *logoimgv = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, bgv.xmg_height, bgv.xmg_height)];
    logoimgv.contentMode = UIViewContentModeScaleAspectFit;
    [bgv addSubview:logoimgv];
    _headIMGV = logoimgv;
    
    
    UIImageView *localimg = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,bgv.xmg_height-5*HEIGHT_SIZE-20*HEIGHT_SIZE, 10*HEIGHT_SIZE, 10*HEIGHT_SIZE)];
    localimg.contentMode = UIViewContentModeScaleAspectFit;
    localimg.image = IMAGE(@"welocalIMG");
    [logoimgv addSubview:localimg];
    
    UILabel *adreeLB = [self goToInitLable:CGRectMake(CGRectGetMaxX(localimg.frame),bgv.xmg_height-5*HEIGHT_SIZE-30*HEIGHT_SIZE,logoimgv.xmg_width-CGRectGetMaxX(localimg.frame)-10*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"" textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];//-20*HEIGHT_SIZE-10*NOW_SIZE
//    adreeLB.numberOfLines = 0;
//    titlb2.lineBreakMode = NSLineBreakByCharWrapping;
    [logoimgv addSubview:adreeLB];
    _localLB = adreeLB;
    
    UILabel *titlb2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(logoimgv.frame)+8*NOW_SIZE,0,(bgv.xmg_width-CGRectGetMaxX(logoimgv.frame)-8*NOW_SIZE)/2, 30*HEIGHT_SIZE) textName:@"" textColor:colorBlack fontFloat:15*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];//-20*HEIGHT_SIZE-10*NOW_SIZE
    titlb2.numberOfLines = 0;
//    titlb2.lineBreakMode = NSLineBreakByCharWrapping;
    [bgv addSubview:titlb2];
    _StaNameLB = titlb2;
    if ([UIFont fontWithName:@"Helvetica-Bold" size:15*HEIGHT_SIZE]) {
        titlb2.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*HEIGHT_SIZE];
    }
    
    UIButton *editbtn = [[UIButton alloc]initWithFrame:CGRectMake(bgv.xmg_width-5*NOW_SIZE-40*HEIGHT_SIZE, 0, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
    [editbtn setTitle:@"Edit" forState:UIControlStateNormal];
    [editbtn setTitleColor:colorBlack forState:UIControlStateNormal];
    editbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    editbtn.titleLabel.font = FontSize(15*HEIGHT_SIZE);
    [editbtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    [bgv addSubview:editbtn];
    if ([UIFont fontWithName:@"Helvetica-Bold" size:15*HEIGHT_SIZE]) {
        editbtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*HEIGHT_SIZE];
    }
    NSArray *listArr = @[root_Currencypower,root_Installation,root_PVcapacity,root_TodayOTT];

    for (int i = 0; i < listArr.count; i++) {
        
//        UILabel *aNameLb = NamelistArr[i];
//        UILabel *aValuLb = valuelistArr[i];

        UILabel *onelb = [self goToInitLable:CGRectMake(CGRectGetMaxX(logoimgv.frame)+8*NOW_SIZE,CGRectGetMaxY(titlb2.frame)+25*HEIGHT_SIZE*i,(bgv.xmg_width-CGRectGetMaxX(logoimgv.frame)-8*NOW_SIZE)/2, 25*HEIGHT_SIZE) textName:listArr[i] textColor:colorblack_154 fontFloat:13*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        [bgv addSubview:onelb];
//        aNameLb = onelb;
        
        UILabel *onelb2 = [self goToInitLable:CGRectMake(CGRectGetMaxX(onelb.frame),CGRectGetMaxY(titlb2.frame)+25*HEIGHT_SIZE*i,(bgv.xmg_width-CGRectGetMaxX(logoimgv.frame)-8*NOW_SIZE)/2-5*NOW_SIZE, 25*HEIGHT_SIZE) textName:@"" textColor:colorblack_154 fontFloat:13*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
        [bgv addSubview:onelb2];
        
        if(i == 0){
            
            _currPowerValuLB = onelb2;
        }
        if(i == 1){
            
            _DateValueLB = onelb2;
        }
        if(i == 2){
            
            _PVcapaValueLB = onelb2;
        }
        if(i == 3){
            
            _TodayTPValueLB = onelb2;
        }
    }
    
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

- (void)editClick{
    
    self.EditClickBlock();
}
@end
