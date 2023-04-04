//
//  BaseSegmentView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "BaseSegmentView.h"

@interface BaseSegmentView()

//@property (weak, nonatomic) IBOutlet UILabel *mpptOneLabel;
//@property (weak, nonatomic) IBOutlet UILabel *mpptTwoLabel;
//@property (weak, nonatomic) IBOutlet UILabel *mpptThreeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *mpptFourLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptOneLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptTwoLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptThreeLabel;
@property (weak, nonatomic) IBOutlet UIView *mpptFourLabel;

@property (weak, nonatomic) IBOutlet UILabel *oneHiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoHiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeHiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourHiddenLabel;

@property (weak, nonatomic) IBOutlet UIButton *mpptOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *mpptTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *mpptThreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *mpptFourBtn;

@end

@implementation BaseSegmentView

-(instancetype)initWithSegmentViewWithTitleArray:(NSArray *)titleArray{
    self = [[NSBundle mainBundle] loadNibNamed:@"BaseSegmentView" owner:self options:nil].lastObject;;
    if (self) {
        [self setButtonSelectStatus];
        
        [self.mpptOneBtn setTitle:titleArray[0] forState:(UIControlStateNormal)];
        [self.mpptTwoBtn setTitle:titleArray[1] forState:(UIControlStateNormal)];
        [self.mpptThreeBtn setTitle:titleArray[2] forState:(UIControlStateNormal)];
        [self.mpptFourBtn setTitle:titleArray[3] forState:(UIControlStateNormal)];
    }
    return self;
}


-(void)setButtonSelectStatus {

    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptOneBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptThreeBtn threeBtn:self.mpptFourBtn
                                         SelectLabel:self.mpptOneLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptThreeLabel threeLabel:self.mpptFourLabel
                                         hiddenLabel:self.oneHiddenLabel oneLabel:self.twoHiddenLabel twoLabel:self.threeHiddenLabel threeLabel:self.fourHiddenLabel];
}



- (IBAction)mpptOneBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptOneBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptThreeBtn threeBtn:self.mpptFourBtn
                                         SelectLabel:self.mpptOneLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptThreeLabel threeLabel:self.mpptFourLabel
                                         hiddenLabel:self.oneHiddenLabel oneLabel:self.twoHiddenLabel twoLabel:self.threeHiddenLabel threeLabel:self.fourHiddenLabel];
    if ([self.delegate respondsToSelector:@selector(segmentSelectWith:)]) {
        [self.delegate segmentSelectWith:0];
    }
    
}
- (IBAction)mpptTwoBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptTwoBtn oneBtn:self.mpptOneBtn twoBtn:self.mpptThreeBtn threeBtn:self.mpptFourBtn
                                         SelectLabel:self.mpptTwoLabel oneLabel:self.mpptOneLabel twoLabel:self.mpptThreeLabel threeLabel:self.mpptFourLabel
                                         hiddenLabel:self.twoHiddenLabel oneLabel:self.oneHiddenLabel twoLabel:self.threeHiddenLabel threeLabel:self.fourHiddenLabel];
    if ([self.delegate respondsToSelector:@selector(segmentSelectWith:)]) {
        [self.delegate segmentSelectWith:1];
    }
}
- (IBAction)mpptThreeBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptThreeBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptOneBtn threeBtn:self.mpptFourBtn
                                         SelectLabel:self.mpptThreeLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptOneLabel threeLabel:self.mpptFourLabel
                                         hiddenLabel:self.threeHiddenLabel oneLabel:self.oneHiddenLabel twoLabel:self.twoHiddenLabel threeLabel:self.fourHiddenLabel];
    if ([self.delegate respondsToSelector:@selector(segmentSelectWith:)]) {
        [self.delegate segmentSelectWith:2];
    }

}

- (IBAction)mpptFourBtnAction:(UIButton *)sender {
    [self changeBtnStatusAndLableStatusWithSelectBtn:self.mpptFourBtn oneBtn:self.mpptTwoBtn twoBtn:self.mpptThreeBtn threeBtn:self.mpptOneBtn
                                         SelectLabel:self.mpptFourLabel oneLabel:self.mpptTwoLabel twoLabel:self.mpptThreeLabel threeLabel:self.mpptOneLabel
                                         hiddenLabel:self.fourHiddenLabel oneLabel:self.oneHiddenLabel twoLabel:self.threeHiddenLabel threeLabel:self.twoHiddenLabel];
    if ([self.delegate respondsToSelector:@selector(segmentSelectWith:)]) {
        [self.delegate segmentSelectWith:3];
    }
}

-(void)changeBtnStatusAndLableStatusWithSelectBtn:(UIButton *)selectBtn oneBtn:(UIButton *)oneBtn twoBtn:(UIButton *)twoBtn threeBtn:(UIButton *)threeBtn
                                      SelectLabel:(UIView *)selectLabel oneLabel:(UIView *)oneLabel twoLabel:(UIView *)twoLabel threeLabel:(UIView *)threeLabel
                                      hiddenLabel:(UILabel *)hiddenLabel oneLabel:(UILabel *)oneHiddenLabel twoLabel:(UILabel *)twoHiddenLabel threeLabel:(UILabel *)threeHiddenLabel{
    selectBtn.selected = YES;
    [selectBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:14]];
    oneBtn.selected = NO;
    [oneBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    twoBtn.selected = NO;
    [twoBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    threeBtn.selected = NO;
    [threeBtn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:12]];
    selectLabel.hidden = NO;
    oneLabel.hidden = YES;
    twoLabel.hidden = YES;
    threeLabel.hidden = YES;
    hiddenLabel.hidden = NO;
    oneHiddenLabel.hidden = YES;
    twoHiddenLabel.hidden = YES;
    threeHiddenLabel.hidden = YES;
}


@end
