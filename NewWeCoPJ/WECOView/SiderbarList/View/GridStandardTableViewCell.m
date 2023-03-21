//
//  GridStandardTableViewCell.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import "GridStandardTableViewCell.h"

@implementation GridStandardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)selectCellWith:(NSInteger)row select:(NSInteger)select {
    if (row == select) {
        self.contentView.backgroundColor = HexRGB(0xEFF3FF);
        self.hiddenImage.hidden = NO;
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.hiddenImage.hidden = YES;
    }
}


@end
