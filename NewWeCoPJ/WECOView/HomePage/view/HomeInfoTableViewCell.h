//
//  HomeInfoTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/30.
//

#import <UIKit/UIKit.h>
#import "HomePageViewModel.h"


typedef void(^HomeInfoCellBlock)(void);

@interface HomeInfoTableViewCell : UITableViewCell

@property (nonatomic,copy) HomeInfoCellBlock cellPushBlock;

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier homeVM:(HomePageViewModel *)homeVM;

- (void)reloadCellMessage;


@end


