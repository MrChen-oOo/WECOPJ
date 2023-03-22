//
//  BasicWarningView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/17.
//

#import "BasicWarningView.h"

@interface BasicWarningView()

@property (nonatomic, strong)INVSettingViewModel *invVM;
@property (weak, nonatomic) IBOutlet UIView *AttentionView;
@property (weak, nonatomic) IBOutlet UIImageView *attentionImage;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionTextLabel;

@property (nonatomic, assign) BOOL isShutDown;
@end

@implementation BasicWarningView

-(instancetype)initWithViewModel:(INVSettingViewModel *)viewModel {
    self = [[NSBundle mainBundle] loadNibNamed:@"BasicWarningView" owner:nil options:nil].lastObject;
    if (self) {
        self.invVM = viewModel;
        self.AttentionView.hidden = YES;
    }
    return self;
}

-(void)showAttentionWith:(BOOL)isAttention {
    self.AttentionView.hidden = isAttention;
    self.isShutDown = !isAttention;
    self.attentionTextLabel.text = isAttention == YES ? @"Restoring factory settings vill cause data falure. Are you sure to perform this operation?" : @"Remote shutdown requires restaring the on-sitesystem, press to proceed.";
}


- (IBAction)cancelAction:(UIButton *)sender {
    self.hidden = YES;
}

- (IBAction)confirmAction:(UIButton *)sender {
    self.hidden = YES;
    self.ShutDownBlock ? self.ShutDownBlock(self.isShutDown): nil;
}
- (IBAction)hiddenAction:(UIButton *)sender {
    self.hidden = YES;
}


@end
