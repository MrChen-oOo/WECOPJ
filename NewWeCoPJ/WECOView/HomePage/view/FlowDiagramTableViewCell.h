//
//  FlowDiagramTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import <UIKit/UIKit.h>
#import "HomePageViewModel.h"

typedef void(^HomePushBlock)(void);

@interface FlowDiagramTableViewCell : UITableViewCell


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier homeVM:(HomePageViewModel *)homeVM;

- (void)reloadCellMessage;

@property (nonatomic,copy) HomePushBlock cellPushBlock;

@end


