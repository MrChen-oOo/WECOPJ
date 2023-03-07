//
//  WePCSDJCell.h
//  RedxPJ
//
//  Created by CBQ on 2023/1/8.
//  Copyright © 2023 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^peekBlock)(UILabel *peekVLB);
typedef void(^timeBlock)(UILabel *timeVLB);

@interface WePCSDJCell : UITableViewCell

@property (nonatomic, strong)peekBlock peekSendBlock;
@property (nonatomic, strong)timeBlock timeSendBlock;
@property (nonatomic, strong)UILabel *peekLB;
@property (nonatomic, strong)UILabel *timeLB;

@property (nonatomic, strong)UILabel *leftNameLB;
@property (nonatomic, strong)UILabel *RighLB;
@property (nonatomic, strong)UIImageView *headimg;


@end

NS_ASSUME_NONNULL_END
