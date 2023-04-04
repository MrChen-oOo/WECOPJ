//
//  SegmentThreeView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/4/1.
//

#import <UIKit/UIKit.h>


@protocol SegmentThreeDelegate <NSObject>
@optional

-(void)segmentThreeSelectWith:(NSInteger)index;

@end
@interface SegmentThreeView : UIView

-(instancetype)initWithSegmentViewWithTitleArray:(NSArray *)titleArray;

@property (nonatomic, weak)id<SegmentThreeDelegate>delegate;

@end


