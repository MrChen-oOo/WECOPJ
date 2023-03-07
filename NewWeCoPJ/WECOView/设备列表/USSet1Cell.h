//
//  USSet1Cell.h
//  LocalDebug
//
//  Created by CBQ on 2021/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USSet1Cell : UITableViewCell
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UILabel *detailLB;

@property (nonatomic, strong)UILabel *valueLB;
@property (nonatomic, strong)UIButton *onoffBtn;
@property (nonatomic, strong)UIImageView *rightIMG;

@end

NS_ASSUME_NONNULL_END
