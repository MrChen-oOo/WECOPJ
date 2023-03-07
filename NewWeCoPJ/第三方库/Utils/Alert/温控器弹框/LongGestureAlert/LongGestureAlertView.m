//
//  LongGestureAlertView.m
//  HyacinthBean
//
//  Created by liu on 2017/7/20.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "LongGestureAlertView.h"

@interface LongGestureAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray <NSArray*>*titleArray;

@property (nonatomic,assign)CGFloat height;
@end

@implementation LongGestureAlertView

-(instancetype)initWithFrame:(CGRect)frame withModelArray:(NSArray*)modelArray{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleArray = [NSMutableArray new];
        
        [self.titleArray addObject:modelArray];
        
        [self.titleArray addObject:@[root_cancel]];
        
        self.height = (self.titleArray.firstObject.count + 1) * 40 +10 ;
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.height)];
        self.tableView.delegate = self;
        
        self.tableView.dataSource = self;
        
        self.tableView.scrollEnabled = NO;
        
        [self addSubview:self.tableView];
        
        self.backgroundColor = COLOR(0, 0, 0, 0.2);
        
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.tableView.frame = CGRectMake(0, ScreenHeight-self.height, ScreenWidth, self.height);
            
        }];
        
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray[section].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UIButton *bnt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    
    
    [bnt setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    bnt.titleLabel.font = FontSize(14);
    
    bnt.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    bnt.tag = indexPath.row + indexPath.section * 10;
    
    [bnt addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:bnt];
    
    NSString *title;
    
    if (indexPath.section == 0) {
       
        LongGestureAlertModel *model = self.titleArray[indexPath.section][indexPath.row];
        
        title = model.title;
        [bnt setTitleColor:mainColor forState:UIControlStateHighlighted];
        
        [bnt setTitleColor:mainColor forState:UIControlStateSelected];
        
        [bnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else{
        
        title = self.titleArray[indexPath.section][indexPath.row];
        
        [bnt setTitleColor:textColorGray forState:UIControlStateHighlighted];

        [bnt setTitleColor:textColorGray forState:UIControlStateSelected];
        
        [bnt setTitleColor:COLOR(0, 0, 0, 0.2) forState:UIControlStateNormal];
    }
    
    [bnt setTitle:title forState:UIControlStateNormal];

    
    return cell;
    
}

-(void)didSelectButton:(UIButton*)bnt{
    
    
    bnt.selected = YES;
    
    if (bnt.tag == 10) {
        
        [self hidenAlertView];
        
    }else{
        
        LongGestureAlertModel *model = self.titleArray[0][bnt.tag];
  
        model.longGestureAlertBlock();
        
        [self hidenAlertView];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 10;
    }
    
    return 0;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        
        view.backgroundColor = COLOR(222, 240, 251, 1);
        
        return view;

    }
   
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   
    [self hidenAlertView];
}

-(void)hidenAlertView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.height);
        
        self.tableView.alpha = 0.4;
        
        self.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}



@end
