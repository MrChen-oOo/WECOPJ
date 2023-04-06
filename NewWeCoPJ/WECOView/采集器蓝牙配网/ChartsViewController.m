//
//  ChartsViewController.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/4/3.
//

#import "ChartsViewController.h"

@interface ChartsViewController ()
@property (weak, nonatomic) IBOutlet UIView *classificationView;     // 选项展示
@property (weak, nonatomic) IBOutlet UIView *chartsView;             // 曲线图展示

// 时间选择
@property (weak, nonatomic) IBOutlet UIButton *todaybtn;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UIButton *weekBtn;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;


// 时间选择器
@property (weak, nonatomic) IBOutlet UIButton *timeChooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextTimeBtn;

// 选项列表
@property (weak, nonatomic) IBOutlet UIButton *classificationBtn;

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - 点击事件


- (IBAction)chooseTimeAction:(UIButton *)sender {
    
    // 0日  1周  2月   3年
    switch(sender.tag){
        case 100:
            break;
        case 101:
            break;
        case 102:
            break;
        case 103:
            break;
        default:
            break;
    }
}











@end
