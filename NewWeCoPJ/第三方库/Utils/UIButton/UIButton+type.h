//
//  UIButton+type.h
//  瑞能云
//
//  Created by BQ123 on 2019/1/26.
//  Copyright © 2019 tuolve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RSButtonType) {
    RSButtonTypeRight = 0, //文字在图片右测
    RSButtonTypeLeft, //文字在图片左测
    RSButtonTypeBottom, //文字在图片下测
    RSButtonTypeTop //文字在图片上测
};

@interface UIButton (type)

/**
 *  设置button中title的位置
 *
 *  @param type type位置类型
 *  @param space 间距
 
 */
- (void)setButtonShowType:(RSButtonType)type space:(CGFloat)space;


@end

NS_ASSUME_NONNULL_END
