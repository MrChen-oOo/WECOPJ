//
//  UIButton+type.m
//  瑞能云
//
//  Created by BQ123 on 2019/1/26.
//  Copyright © 2019 tuolve. All rights reserved.
//

#import "UIButton+type.h"


@implementation UIButton (type)

- (void)setButtonShowType:(RSButtonType)type space:(CGFloat)space
{
    [self layoutIfNeeded];
    
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    
    
    switch (type) {
        case RSButtonTypeRight:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0)];
            
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0)];
        }
            break;
        case RSButtonTypeLeft:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleFrame.size.width+space/2.0, 0, -titleFrame.size.width-space/2.0)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageFrame.size.width-space/2.0, 0, imageFrame.size.width+space/2.0)];
        }
            break;
        case RSButtonTypeBottom:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleFrame.size.width/2, titleFrame.size.height+space, -titleFrame.size.width/2)];
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imageFrame.size.height+space, -imageFrame.size.width, 0,0)];
        }
            break;
        case RSButtonTypeTop:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-(imageFrame.size.width), imageFrame.size.height+space, 0)];
            
            [self setImageEdgeInsets:UIEdgeInsetsMake(titleFrame.size.height+space,(titleFrame.size.width), 0, 0)];
        }
            break;
        default:
            break;
    }
    
}


@end


