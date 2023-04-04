//
//  CabinetViewController.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "CabinetViewController.h"
#import "DeviceInfoView.h"
#import "GridInfoView.h"
#import "BatteryInfoView.h"
#import "RedxloginViewController.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;


@interface CabinetViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@property (nonatomic, strong)DeviceInfoView *deviceView;
@property (nonatomic, strong)GridInfoView *gridView;
@property (nonatomic, strong)BatteryInfoView *batteryView;


@property (nonatomic, strong)CabinetViewModel *cabinetViewModel;
@end

@implementation CabinetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cabinet Running Info";
    [self.scrollContentView addSubview:self.deviceView];
    [self.scrollContentView addSubview:self.gridView];
    [self.scrollContentView addSubview:self.batteryView];
    [self getHmiRunInfoHttp];
}


-(void)getHmiRunInfoHttp {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showProgressView];
    });
    @WeakObj(self)
    [self.cabinetViewModel getHmiRunInfoMessageCompleteBlock:^(NSString *resultStr, NSString *codeStr) {
        [selfWeak hideProgressView];
        if (resultStr.length == 0) {
            [selfWeak.deviceView reloadTableView];
            [selfWeak.gridView reloadTableView];
            [selfWeak.batteryView reloadTableView];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showToastViewWithTitle:resultStr];
            });
        }
        if ([codeStr isEqualToString:@""]) {
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

-(CabinetViewModel *)cabinetViewModel {
    if (!_cabinetViewModel) {
        _cabinetViewModel = [[CabinetViewModel alloc]initViewModel];
        _cabinetViewModel.deviceStr = self.deviceSnStr;
    }
    return _cabinetViewModel;
}

- (DeviceInfoView *)deviceView {
    if (!_deviceView) {
        _deviceView = [[DeviceInfoView alloc]initWithViewModel:self.cabinetViewModel];
        _deviceView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
        @WeakObj(self)
        _deviceView.headerRealoadBlock = ^{
            [selfWeak getHmiRunInfoHttp];
        };
    }
    return _deviceView;
}

- (GridInfoView *)gridView {
    if (!_gridView) {
        _gridView = [[GridInfoView alloc]initWithViewModel:self.cabinetViewModel];
        _gridView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
        @WeakObj(self)
        _gridView.headerRealoadBlock = ^{
            [selfWeak getHmiRunInfoHttp];
        };
    }
    return _gridView;
}

-(BatteryInfoView *)batteryView {
    if (!_batteryView) {
        _batteryView = [[BatteryInfoView alloc]initWithViewModel:self.cabinetViewModel];
        _batteryView.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - kNavBarHeight);
        @WeakObj(self)
        _batteryView.headerRealoadBlock = ^{
            [selfWeak getHmiRunInfoHttp];
        };
    }
    return _batteryView;
}

@end
