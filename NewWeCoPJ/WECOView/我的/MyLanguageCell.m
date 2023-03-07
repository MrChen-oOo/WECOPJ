//
//  MyLanguageCell.m
//  ShinePhone
//
//  Created by CBQ on 2022/5/5.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "MyLanguageCell.h"

@implementation MyLanguageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI{
    float cellViewH = 45*HEIGHT_SIZE;
    float marginLF = 10*NOW_SIZE;
    self.contentView.backgroundColor=[UIColor whiteColor];

    
    // 标题
    float lableH = 25*HEIGHT_SIZE, lableW = ScreenWidth-3*marginLF-12*HEIGHT_SIZE;
    UILabel *lblT = [[UILabel alloc]initWithFrame:CGRectMake(marginLF, (cellViewH-lableH)/2, lableW, lableH)];
    lblT.textColor = colorblack_51;
    lblT.font = [UIFont systemFontOfSize:15*HEIGHT_SIZE];
    
    [self.contentView addSubview:lblT];
    self.titlb1 = lblT;

    UIImageView *seleimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblT.frame)+marginLF, (cellViewH-12*HEIGHT_SIZE)/2, 12*HEIGHT_SIZE, 12*HEIGHT_SIZE)];
    seleimg.image = IMAGE(@"selected_panel_1");
    [self.contentView addSubview:seleimg];
    seleimg.hidden = YES;
    self.seleimgv = seleimg;
}
@end
