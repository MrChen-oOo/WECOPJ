//
//  InfoTableViewCell.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier index:(NSIndexPath *)indexpath;

-(void)setCellUIWithKey:(NSString *)key value:(NSString *)value isLast:(BOOL)isLast isFirst:(BOOL)isFirst isSegment:(BOOL)isSegment unit:(NSInteger)unit typeNum:(NSInteger)typeNum;

@end

NS_ASSUME_NONNULL_END
