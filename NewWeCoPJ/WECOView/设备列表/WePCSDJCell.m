//
//  WePCSDJCell.m
//  RedxPJ
//
//  Created by CBQ on 2023/1/8.
//  Copyright © 2023 qwl. All rights reserved.
//

#import "WePCSDJCell.h"

@implementation WePCSDJCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
   
        [self createQuestionUI];
    }
    
    return self;
}
- (void)createQuestionUI{
    
    CGSize imgsize = IMAGE(@"WemoneyIcon").size;
    CGFloat imgwide = imgsize.width*40*HEIGHT_SIZE/imgsize.height;
    UIImageView *imgvvv = [[UIImageView alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 5*HEIGHT_SIZE, imgwide, 40*HEIGHT_SIZE)];
    imgvvv.image = IMAGE(@"WemoneyIcon");
    [self.contentView addSubview:imgvvv];
    _headimg = imgvvv;
    
    UIView *moneyvie = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgvvv.frame)+15*NOW_SIZE, 0, 100*NOW_SIZE, 60*HEIGHT_SIZE)];
    UITapGestureRecognizer *tapge = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moneyClick)];
    [moneyvie addGestureRecognizer:tapge];
    [self.contentView addSubview:moneyvie];
    
    UILabel *peakLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, moneyvie.xmg_width, 20*HEIGHT_SIZE)];
    peakLB.textColor = colorblack_154;
//    peakLB.textAlignment = NSTextAlignmentCenter;
    peakLB.font = FontSize(13*HEIGHT_SIZE);
    peakLB.text = @"Off-peak Price";
    peakLB.adjustsFontSizeToFitWidth = YES;
    [moneyvie addSubview:peakLB];
    _leftNameLB = peakLB;
    
    UILabel *peakValueLB = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(peakLB.frame), moneyvie.xmg_width, 30*HEIGHT_SIZE)];
    peakValueLB.textColor = colorBlack;
//    peakLB.textAlignment = NSTextAlignmentCenter;
    peakValueLB.font = FontSize(15*HEIGHT_SIZE);
    peakValueLB.text = @"";
    peakValueLB.adjustsFontSizeToFitWidth = YES;
    if ([UIFont fontWithName:@"Helvetica-Bold" size:16*HEIGHT_SIZE]) {
        peakValueLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:16*HEIGHT_SIZE];
    }
    [moneyvie addSubview:peakValueLB];
    _peekLB = peakValueLB;
    
    
    UIView *timevie = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moneyvie.frame)+15*NOW_SIZE, 0, kScreenWidth-CGRectGetMaxX(moneyvie.frame)-25*NOW_SIZE, 60*HEIGHT_SIZE)];
    UITapGestureRecognizer *tapge22 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeClick)];
    [timevie addGestureRecognizer:tapge22];
    [self.contentView addSubview:timevie];
    
    UILabel *timeLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, moneyvie.xmg_width, 20*HEIGHT_SIZE)];
    timeLB.textColor = colorblack_154;
//    peakLB.textAlignment = NSTextAlignmentCenter;
    timeLB.font = FontSize(13*HEIGHT_SIZE);
    timeLB.text = @"Time";
    timeLB.adjustsFontSizeToFitWidth = YES;
    [timevie addSubview:timeLB];
    _RighLB = timeLB;
    
    UILabel *timeValueLB = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeLB.frame), moneyvie.xmg_width, 30*HEIGHT_SIZE)];
    timeValueLB.textColor = colorBlack;
//    peakLB.textAlignment = NSTextAlignmentCenter;
    timeValueLB.font = FontSize(16*HEIGHT_SIZE);
    timeValueLB.text = @"";
    if ([UIFont fontWithName:@"Helvetica-Bold" size:16*HEIGHT_SIZE]) {
        timeValueLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:16*HEIGHT_SIZE];
    }
    timeValueLB.adjustsFontSizeToFitWidth = YES;
    [timevie addSubview:timeValueLB];
    
    _timeLB = timeValueLB;
    
}

- (void)moneyClick{
    
    self.peekSendBlock(_peekLB);
}
- (void)timeClick{
    
    self.timeSendBlock(_timeLB);
}
@end
