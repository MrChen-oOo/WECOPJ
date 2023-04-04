//
//  InveterViewController.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/28.
//

#import "InveterViewController.h"
#import "InveterViewModel.h"
#import "InveterDeviceView.h"
#import "InveterGridInfoView.h"
#import "InveterBatteryInfoView.h"
#import "RedxloginViewController.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface InveterViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) InveterViewModel *invViewModel;
@property (nonatomic, strong) InveterDeviceView *deviceView;
@property (nonatomic, strong) InveterGridInfoView *gridInfoView;
@property (nonatomic, strong) InveterBatteryInfoView *batteryInfoView;

@end

@implementation InveterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Inverter Running Info";
    [self.scrollContentView addSubview:self.deviceView];
    [self.scrollContentView addSubview:self.gridInfoView];
    [self.scrollContentView addSubview:self.batteryInfoView];
    [self getMgrnRunInfoHttp];
}


-(void)getMgrnRunInfoHttp {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressView];
    });
    @WeakObj(self)
    [self.invViewModel getMgrnRunInfoMessageCompleteBlock:^(NSString *resultStr, NSString *codeStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            [selfWeak.deviceView reloadDeviceTableView];
            [selfWeak.gridInfoView reloadTableView];
            [selfWeak.batteryInfoView reloadTableView];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showToastViewWithTitle:resultStr];
            });
        }
        if ([codeStr isEqualToString:@"-1"]) {
            [selfWeak pushLogin];
        }
        
    }];
}

-(void)pushLogin {
    RedxloginViewController *login =[[RedxloginViewController alloc]init];
    [RedxUserInfo defaultUserInfo].userPassword = @"";
    [RedxUserInfo defaultUserInfo].isAutoLogin = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    nav.modalPresentationStyle=UIModalPresentationFullScreen;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:nav animated:YES completion:nil];
    });
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    scrollView.contentOffset = point;
    if (point.x > kScreenWidth / 2) {
        self.pageControl.currentPage =  point.x > 3 * kScreenWidth / 2 ? 2 : 1;
    } else {
        self.pageControl.currentPage = 0;
    }

}

#pragma mark -懒加载

-(InveterViewModel *)invViewModel {
    if (!_invViewModel) {
        _invViewModel = [[InveterViewModel alloc]initViewModel];
        _invViewModel.deviceStr = self.deviceSnStr;
    }
    return _invViewModel;
}

- (InveterDeviceView *)deviceView {
    if (!_deviceView) {
        _deviceView = [[InveterDeviceView alloc]initWithViewModel:self.invViewModel];
        _deviceView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
        @WeakObj(self)
        _deviceView.headerRealoadBlock = ^{
            [selfWeak getMgrnRunInfoHttp];
        };
    }
    return _deviceView;
}

-(InveterGridInfoView *)gridInfoView {
    if (!_gridInfoView) {
        _gridInfoView = [[InveterGridInfoView alloc]initWithViewModel:self.invViewModel];
        _gridInfoView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
        @WeakObj(self)
        _gridInfoView.headerRealoadBlock = ^{
            [selfWeak getMgrnRunInfoHttp];
        };
    }
    return _gridInfoView;
}

-(InveterBatteryInfoView *)batteryInfoView {
    if (!_batteryInfoView) {
        _batteryInfoView = [[InveterBatteryInfoView alloc]initWithViewModel:self.invViewModel];
        _batteryInfoView.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
        @WeakObj(self)
        _batteryInfoView.headerRealoadBlock = ^{
            [selfWeak getMgrnRunInfoHttp];
        };
    }
    return _batteryInfoView;
}

@end
