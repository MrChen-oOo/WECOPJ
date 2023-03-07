//
//  WeRightItemView.h
//  RedxPJ
//
//  Created by CBQ on 2023/1/3.
//  Copyright © 2023 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^seleBlock)(NSString *seleText,int numbSelect);

@interface WeRightItemView : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, strong)seleBlock selectBlock;
@property (nonatomic, assign)CGFloat tabvY;

- (void)showView;
@end

NS_ASSUME_NONNULL_END
