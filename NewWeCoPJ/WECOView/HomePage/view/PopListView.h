//
//  PopListView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/31.
//

#import <UIKit/UIKit.h>
#import "HomePageViewModel.h"

typedef void(^PopListBlock)(NSInteger index);

@interface PopListView : UIView


-(instancetype)initWithViewModel:(HomePageViewModel *)viewModel;

@property (nonatomic,copy) PopListBlock selectCellBlock;

- (void)reloadCellMessage;

@end


