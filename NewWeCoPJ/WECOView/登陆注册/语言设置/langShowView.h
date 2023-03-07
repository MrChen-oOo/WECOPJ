//
//  langShowView.h
//  ShinePhone
//
//  Created by CBQ on 2022/4/26.
//  Copyright © 2022 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^seleBlock)(NSString *seleText);
@interface langShowView : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, strong)NSArray *keyArr;
@property (nonatomic, strong)NSArray *keyArr22;

@property (nonatomic, strong)seleBlock selectBlock;
@property (nonatomic, assign)CGFloat tabvY;

- (void)showView;
@end

NS_ASSUME_NONNULL_END
