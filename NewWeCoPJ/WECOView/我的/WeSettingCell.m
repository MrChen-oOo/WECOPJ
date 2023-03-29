//
//  WeSettingCell.m
//  RedxPJ
//
//  Created by CBQ on 2022/12/8.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeSettingCell.h"

@implementation WeSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
   
        [self createQuestionUI];
    }
    
    return self;
}
- (void)createQuestionUI{
    UIImageView *imgv = [self goToInitImageView:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) imageString:@""];
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imgv];
    _logoImgv = imgv;
    
    UILabel *titLb = [self goToInitLable:CGRectMake(CGRectGetMaxX(imgv.frame)+5*NOW_SIZE, 0, kScreenWidth-CGRectGetMaxX(imgv.frame)-10*NOW_SIZE-10*HEIGHT_SIZE-10*NOW_SIZE-80*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
    [self.contentView addSubview:titLb];
    _titleLB = titLb;
    
    UILabel *valueLb = [self goToInitLable:CGRectMake(CGRectGetMaxX(titLb.frame)+5*NOW_SIZE, 0, 80*NOW_SIZE, 30*HEIGHT_SIZE) textName:@"" textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
    [self.contentView addSubview:valueLb];
    _contenLB = valueLb;
    
    UIImageView *rigimg = [self goToInitImageView:CGRectMake(kScreenWidth-10*NOW_SIZE-8*HEIGHT_SIZE, (30*HEIGHT_SIZE-8*HEIGHT_SIZE)/2, 8*HEIGHT_SIZE, 8*HEIGHT_SIZE) imageString:@"rightBtn"];
    [self.contentView addSubview:rigimg];
    
}
-(UIImageView*)goToInitImageView:(CGRect)imageFrame imageString:(NSString*)imageString{
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:imageFrame];
    [imageView setImage:[UIImage imageNamed:imageString]];
    return imageView;
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
