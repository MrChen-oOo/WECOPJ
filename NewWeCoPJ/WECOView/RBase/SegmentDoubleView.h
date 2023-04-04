//
//  SegmentDoubleView.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/4/1.
//

#import <UIKit/UIKit.h>

@protocol SegmentDoubleDelegate <NSObject>
@optional

-(void)segmentDoubleSelectWith:(NSInteger)index;

@end
@interface SegmentDoubleView : UIView

-(instancetype)initWithSegmentViewWithDoubleArray:(NSArray *)titleArray;

@property (nonatomic, weak)id<SegmentDoubleDelegate>delegate;

@end

