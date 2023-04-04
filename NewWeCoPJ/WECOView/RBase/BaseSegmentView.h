//
//  BaseSegmentView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <UIKit/UIKit.h>


@protocol SegmentSettingDelegate <NSObject>
@optional

-(void)segmentSelectWith:(NSInteger)index;

@end

@interface BaseSegmentView : UIView


-(instancetype)initWithSegmentViewWithTitleArray:(NSArray *)titleArray;

@property (nonatomic, weak)id<SegmentSettingDelegate>delegate;


@end


