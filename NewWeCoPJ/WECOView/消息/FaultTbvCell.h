//
//  FaultTbvCell.h
//  RedxPJ
//
//  Created by CBQ on 2022/12/7.
//  Copyright © 2022 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^seleBtnClickBlock)(BOOL isSelect);
NS_ASSUME_NONNULL_BEGIN

@interface FaultTbvCell : UITableViewCell

@property (nonatomic, strong)UIView *noReadVie;
@property (nonatomic, strong)UILabel *timeLB;
@property (nonatomic, strong)UILabel *contenLB;
@property (nonatomic, strong)seleBtnClickBlock BtnClickBlock;
@property (nonatomic, strong)UIButton *seleBtn;

- (void)createUnEditUI;
- (void)createEditUI;
@end

NS_ASSUME_NONNULL_END
