//
//  WePlantListCell.h
//  RedxPJ
//
//  Created by CBQ on 2022/12/2.
//  Copyright © 2022 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^editBlock)(void);
@interface WePlantListCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headIMGV;
@property (nonatomic, strong)UILabel *StaNameLB;
//@property (nonatomic, strong)UILabel *DateLB;
//@property (nonatomic, strong)UILabel *PVcapaLB;
//@property (nonatomic, strong)UILabel *TodayTPLB;
@property (nonatomic, strong)editBlock EditClickBlock;

@property (nonatomic, strong)UILabel *localLB;

@property (nonatomic, strong)UILabel *currPowerValuLB;
@property (nonatomic, strong)UILabel *DateValueLB;
@property (nonatomic, strong)UILabel *TodayTPValueLB;
@property (nonatomic, strong)UILabel *PVcapaValueLB;


@end

NS_ASSUME_NONNULL_END
