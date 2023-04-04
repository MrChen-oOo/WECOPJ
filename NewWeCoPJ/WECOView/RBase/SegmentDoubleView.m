//
//  SegmentDoubleView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/4/1.
//

#import "SegmentDoubleView.h"



@interface SegmentDoubleView()

@property (weak, nonatomic) IBOutlet UIView *mpptOneLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneHiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoHiddenLabel;
@property (weak, nonatomic) IBOutlet UIButton *mpptOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *mpptTwoBtn;

@end
@implementation SegmentDoubleView

-(instancetype)initWithSegmentViewWithDoubleArray:(NSArray *)titleArray{
    self = [[NSBundle mainBundle] loadNibNamed:@"SegmentDoubleView" owner:self options:nil].lastObject;;
    if (self) {
        [self setButtonSelectStatus];
        [self.mpptOneBtn setTitle:titleArray[0] forState:(UIControlStateNormal)];
        [self.mpptTwoBtn setTitle:titleArray[1] forState:(UIControlStateNormal)];
    }
    return self;
}


-(void)setButtonSelectStatus {

    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptOneBtn oneBtn:self.mpptTwoBtn
                                         SelectLabel:self.mpptOneLabel oneLabel:self.mpptTwoLabel
                                         hiddenLabel:self.oneHiddenLabel oneLabel:self.twoHiddenLabel ];
}
- (IBAction)mpptOneBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptOneBtn oneBtn:self.mpptTwoBtn
                                         SelectLabel:self.mpptOneLabel oneLabel:self.mpptTwoLabel
                                         hiddenLabel:self.oneHiddenLabel oneLabel:self.twoHiddenLabel];
    if ([self.delegate respondsToSelector:@selector(segmentDoubleSelectWith:)]) {
        [self.delegate segmentDoubleSelectWith:0];
    }
}
- (IBAction)mpptTwoBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptTwoBtn oneBtn:self.mpptOneBtn
                                         SelectLabel:self.mpptTwoLabel oneLabel:self.mpptOneLabel
                                         hiddenLabel:self.twoHiddenLabel oneLabel:self.oneHiddenLabel ];
    if ([self.delegate respondsToSelector:@selector(segmentDoubleSelectWith:)]) {
        [self.delegate segmentDoubleSelectWith:1];
    }
}


-(void)changeBtnStatusAndLableStatusWithSelectBtn:(UIButton *)selectBtn oneBtn:(UIButton *)oneBtn
                                      SelectLabel:(UIView *)selectLabel oneLabel:(UIView *)oneLabel
                                      hiddenLabel:(UILabel *)hiddenLabel oneLabel:(UILabel *)oneHiddenLabel{
    selectBtn.selected = YES;
    [selectBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:14]];
    oneBtn.selected = NO;
    [oneBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
  
  
    selectLabel.hidden = NO;
    oneLabel.hidden = YES;
    hiddenLabel.hidden = NO;
    oneHiddenLabel.hidden = YES;
}


@end
