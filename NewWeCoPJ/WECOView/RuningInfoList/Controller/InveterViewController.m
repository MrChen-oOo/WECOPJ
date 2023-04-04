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
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface InveterViewController ()
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

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
    [self.invViewModel getMgrnRunInfoMessageCompleteBlock:^(NSString *resultStr) {
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
    }];
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
