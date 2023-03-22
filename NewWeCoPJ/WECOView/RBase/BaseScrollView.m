//
//  BaseScrollView.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/22.
//

#import "BaseScrollView.h"

@implementation BaseScrollView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
   
    if ([self isPanBackAction:gestureRecognizer]) {
        return YES;
    }
    return NO;
    
}
/// 判断是否是全屏的返回手势
- (BOOL)isPanBackAction:(UIGestureRecognizer *)gestureRecognizer {
    
    // 在最左边时候 && 是pan手势 && 手势往右拖
    if (self.contentOffset.x == 0) {
        if (gestureRecognizer == self.panGestureRecognizer) {
            // 根据速度获取拖动方向
            CGPoint velocity = [self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
            if(velocity.x>0){
                //手势向右滑动
                return YES;
            }
        }
        
    }
    return NO;
}
 
// 如果是全屏的左滑返回,那么ScrollView的左滑就没用了,返回NO,让ScrollView的左滑失效
// 不写此方法的话,左滑时,那个ScrollView上的子视图也会跟着左滑的
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
 
    if ([self isPanBackAction:gestureRecognizer]) {
        return NO;
    }
    return YES;
 
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
