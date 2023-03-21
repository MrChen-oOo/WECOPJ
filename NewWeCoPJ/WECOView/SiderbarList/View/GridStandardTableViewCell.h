//
//  GridStandardTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GridStandardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *shorthandLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hiddenImage;

-(void)selectCellWith:(NSInteger)row select:(NSInteger)select;
@end

NS_ASSUME_NONNULL_END
