//
//  HSDropDownMenu.m
//  瑞能云
//
//  Created by BQ123 on 2019/1/27.
//  Copyright © 2019 tuolve. All rights reserved.
//

#import "HSDropDownMenu.h"

@interface HSDropDownMenu ()
{
    float viewHeight;
    
    NSArray *titleArray;
    NSArray *imageArray;
    
    UIView *currentView;
    UIView *MenuView;
    UIButton *directionButton;
}

@end

@implementation HSDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame arrayOfTitle:(NSArray *)titleArr arrayOfImage:(NSArray *)imageArr{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        titleArray = titleArr;
        imageArray = imageArr;
        viewHeight = self.frame.size.height;
        
        float viewH = 30*XLscaleH, viewW = self.frame.size.width*3/4, viewY = (viewHeight-viewH)/2;
        CGRect viewRect = CGRectMake(0, viewY, viewW, viewH);
        currentView = [self createUIViewWithFrame:viewRect Title:titleArr[0] imageName:imageArr[0]];
        [self addSubview:currentView];
        
        float btnW = self.frame.size.width/4;
        directionButton = [[UIButton alloc]initWithFrame:CGRectMake(viewW, viewY, btnW, viewH)];
        [directionButton setImage:[UIImage imageNamed:@"dev_down"] forState:UIControlStateNormal];
        [directionButton setImage:[UIImage imageNamed:@"dev_up"] forState:UIControlStateSelected];
        [directionButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:directionButton];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDropDownMenu)];
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}

- (void)touchButton:(UIButton *)button{
    if (button.isSelected) {
        [self hideDropDownMenu];
    } else{
        [self showDropDownMenu];
    }
}

- (void)showDropDownMenu{
    
    if (MenuView) {
        [MenuView removeFromSuperview];
        MenuView = nil;
    }
    
    float viewH = 30*XLscaleH, viewW = self.frame.size.width*3/4;
    MenuView = [[UIView alloc]initWithFrame:CGRectMake(0, 5*XLscaleH, viewW, self->titleArray.count*viewH + 20*XLscaleH)];
    [self addSubview:MenuView];
    MenuView.hidden = YES;
    
    for (int i = 0; i < self->titleArray.count; i++) {
        CGRect viewRect = CGRectMake(0, 10*XLscaleH+i*viewH, viewW, viewH);
        UIView *view = [self createUIViewWithFrame:viewRect Title:self->titleArray[i] imageName:self->imageArray[i]];
        view.tag = 900 + i;
        [MenuView addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectItem:)];
        [view addGestureRecognizer:tap];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self->MenuView.hidden = NO;
        self->currentView.hidden = YES;
        self->directionButton.selected = YES;
        CGRect rect = self.frame;
        rect.size.height = self->titleArray.count*viewH + 30*XLscaleH;
        self.frame = rect;
        self.backgroundColor = COLOR(255, 255, 255, 1);
    }];
}


- (void)hideDropDownMenu{
    
    [UIView animateWithDuration:0.2 animations:^{
        self->MenuView.hidden = YES;
        self->currentView.hidden = NO;
        self->directionButton.selected = NO;
        CGRect rect = self.frame;
        rect.size.height = self->viewHeight;
        self.frame = rect;
        self.backgroundColor = COLOR(255, 255, 255, 1);
    } completion:^(BOOL finished) {
        if (self->MenuView) {
            [self->MenuView removeFromSuperview];
            self->MenuView = nil;
        }
    }];
}


- (UIView *)createUIViewWithFrame:(CGRect)rect Title:(NSString *)title imageName:(NSString *)imageName{
    
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    
    float imgW = 20*XLscaleH, viewH = rect.size.height;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15*XLscaleW, (viewH-imgW)/2, imgW, imgW)];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    
    float labelW = rect.size.width - (20*XLscaleW+20*XLscaleH);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20*XLscaleW+20*XLscaleH, (viewH-imgW)/2, labelW, imgW)];
    titleLabel.text = title;
    titleLabel.textColor = colorblack_154;
    titleLabel.font = FontSize([NSString getFontWithText:titleLabel.text size:titleLabel.xmg_size currentFont:16*XLscaleH]);
    [view addSubview:titleLabel];
    
    return view;
}


// 选择一项
- (void)selectItem:(UITapGestureRecognizer *)gesture{
    
    UIView *view = gesture.view;
    NSInteger tag = view.tag - 900;
    
    CGRect viewRect = currentView.frame;
    if (currentView) {
        [currentView removeFromSuperview];
        currentView = nil;
    }
    currentView = [self createUIViewWithFrame:viewRect Title:titleArray[tag] imageName:imageArray[tag]];
    [self addSubview:currentView];
    
    if (self.returnDropDownSelectNumber) {
        self.returnDropDownSelectNumber(tag);
    }
    [self hideDropDownMenu];
}

- (void)setCurrentSelect:(NSInteger)currentSelect{
    
    _currentSelect = currentSelect;

    CGRect viewRect = currentView.frame;
    if (currentView) {
        [currentView removeFromSuperview];
        currentView = nil;
    }
    currentView = [self createUIViewWithFrame:viewRect Title:titleArray[currentSelect] imageName:imageArray[currentSelect]];
    [self addSubview:currentView];
}

@end
