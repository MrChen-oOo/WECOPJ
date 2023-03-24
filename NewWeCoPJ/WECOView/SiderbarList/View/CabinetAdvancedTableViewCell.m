//
//  CabinetAdvancedTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/22.
//

#import "CabinetAdvancedTableViewCell.h"


@interface CabinetAdvancedTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *shutBtn;

@property (weak, nonatomic) IBOutlet UIButton *onGridStartBtn;

@end

@implementation CabinetAdvancedTableViewCell


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath {
    self = [[NSBundle mainBundle] loadNibNamed:@"CabinetAdvancedTableViewCell" owner:self options:nil].lastObject;;
    if (self) {
        self.shutBtn.layer.borderWidth = 1;
        self.shutBtn.layer.borderColor = HexRGB(0x4776ff).CGColor;
        self.onGridStartBtn.layer.borderWidth = 1;
        self.onGridStartBtn.layer.borderColor = HexRGB(0x4776ff).CGColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)shutDownAction:(UIButton *)sender {    
    if ([self.delegate respondsToSelector:@selector(didClickStartUpWithStatus:)]) {
        [self.delegate didClickStartUpWithStatus:1];
    }
}
- (IBAction)onGridStartAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickStartUpWithStatus:)]) {
        [self.delegate didClickStartUpWithStatus:3];
    }
}
- (IBAction)offGridStartAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickStartUpWithStatus:)]) {
        [self.delegate didClickStartUpWithStatus:4];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
