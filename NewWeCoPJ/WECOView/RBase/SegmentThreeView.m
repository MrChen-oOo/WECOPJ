//
//  SegmentThreeView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/4/1.
//

#import "SegmentThreeView.h"

@interface SegmentThreeView()

@property (weak, nonatomic) IBOutlet UIView *mpptOneLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptTwoLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptThreeLabel;

@property (weak, nonatomic) IBOutlet UILabel *oneHiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoHiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeHiddenLabel;

@property (weak, nonatomic) IBOutlet UIButton *mpptOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *mpptTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *mpptThreeBtn;

@end

@implementation SegmentThreeView


-(instancetype)initWithSegmentViewWithTitleArray:(NSArray *)titleArray{
    self = [[NSBundle mainBundle] loadNibNamed:@"SegmentThreeView" owner:self options:nil].lastObject;;
    if (self) {
        [self setButtonSelectStatus];
        [self.mpptOneBtn setTitle:titleArray[0] forState:(UIControlStateNormal)];
        [self.mpptTwoBtn setTitle:titleArray[1] forState:(UIControlStateNormal)];
        [self.mpptThreeBtn setTitle:titleArray[2] forState:(UIControlStateNormal)];

    }
    return self;
}


-(void)setButtonSelectStatus {

    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptOneBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptThreeBtn
                                         SelectLabel:self.mpptOneLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptThreeLabel
                                         hiddenLabel:self.oneHiddenLabel oneLabel:self.twoHiddenLabel twoLabel:self.threeHiddenLabel];
}



- (IBAction)mpptOneBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptOneBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptThreeBtn
                                         SelectLabel:self.mpptOneLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptThreeLabel
                                         hiddenLabel:self.oneHiddenLabel oneLabel:self.twoHiddenLabel twoLabel:self.threeHiddenLabel ];
    if ([self.delegate respondsToSelector:@selector(segmentThreeSelectWith:)]) {
        [self.delegate segmentThreeSelectWith:0];
    }
    
}
- (IBAction)mpptTwoBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptTwoBtn oneBtn:self.mpptOneBtn twoBtn:self.mpptThreeBtn
                                         SelectLabel:self.mpptTwoLabel oneLabel:self.mpptOneLabel twoLabel:self.mpptThreeLabel
                                         hiddenLabel:self.twoHiddenLabel oneLabel:self.oneHiddenLabel twoLabel:self.threeHiddenLabel];
    if ([self.delegate respondsToSelector:@selector(segmentThreeSelectWith:)]) {
        [self.delegate segmentThreeSelectWith:1];
    }
}
- (IBAction)mpptThreeBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptThreeBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptOneBtn
                                         SelectLabel:self.mpptThreeLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptOneLabel
                                         hiddenLabel:self.threeHiddenLabel oneLabel:self.oneHiddenLabel twoLabel:self.twoHiddenLabel ];
    if ([self.delegate respondsToSelector:@selector(segmentThreeSelectWith:)]) {
        [self.delegate segmentThreeSelectWith:2];
    }

}



-(void)changeBtnStatusAndLableStatusWithSelectBtn:(UIButton *)selectBtn oneBtn:(UIButton *)oneBtn twoBtn:(UIButton *)twoBtn
                                      SelectLabel:(UIView *)selectLabel oneLabel:(UIView *)oneLabel twoLabel:(UIView *)twoLabel
                                      hiddenLabel:(UILabel *)hiddenLabel oneLabel:(UILabel *)oneHiddenLabel twoLabel:(UILabel *)twoHiddenLabel {
    selectBtn.selected = YES;
    [selectBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:14]];
    oneBtn.selected = NO;
    [oneBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    twoBtn.selected = NO;
    [twoBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
  
    selectLabel.hidden = NO;
    oneLabel.hidden = YES;
    twoLabel.hidden = YES;
    hiddenLabel.hidden = NO;
    oneHiddenLabel.hidden = YES;
    twoHiddenLabel.hidden = YES;
}

@end
