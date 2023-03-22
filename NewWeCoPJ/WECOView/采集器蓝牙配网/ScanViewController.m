//
//  ScanViewController.m
//  LocalDebug
//
//  Created by 管理员 on 2023/3/3.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import<AudioToolbox/AudioToolbox.h>
#import "RedxNewAddCollector22VC.h"
//#import "ProductListVC.h"
#import <Vision/Vision.h>
//#import "GTCheckDeviceSNController.h"
//#import "GTSNGuidePageView.h"
 
@interface ScanViewController ()
<AVCaptureMetadataOutputObjectsDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
AVCapturePhotoCaptureDelegate,
UIGestureRecognizerDelegate>
{
    AVCaptureMetadataOutput *_metadataOutput;
    BOOL _up;
    BOOL hasEntered;//首次进入，addTimer那不执行startsession操作，不然容易和初始化的start重复导致多次start
}
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVCapturePhotoOutput *capturePhotoOutput;
@property (nonatomic, strong) UIImageView *scanningline;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *takePhotoTimer;
@property (nonatomic, strong) UIView *xuliehaoTipsView;
@property (nonatomic, assign) NSTimeInterval animationTimeInterval;
@property (nonatomic, strong) UIView *toolsView;  //底部显示的功能项 -box
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic) BOOL isScreenshot;  //是否截图 
@end

@implementation ScanViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addTimer];
    [self addNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initData];
    [self initUI];
    [self startScanQRCodeViewControllerWithResult:^(NSString * _Nonnull result) {
        [self scanSession];
    }];
}

- (void)initData{
    self.animationTimeInterval = 0.02;
}

- (void)addNotification {
    //后台进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundEnter) name:@"ENTERFOREGROUND1" object:nil];
}
 
- (void)backgroundEnter {
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself addTimer];
    });
}

- (void)initUI {
 
    CGFloat ratio = [[UIScreen mainScreen] bounds].size.width/320.0;
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:maskView];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(45*ratio, (64+60)*ratio-50, 230*ratio, 230*ratio) cornerRadius:1] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = rectPath.CGPath;
    maskView.layer.mask = shapeLayer;
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(45*ratio, (64+60)*ratio-50, 230*ratio, 230*ratio)];
    bgImg.image = [UIImage imageNamed:@"scanBackground"];
    [self.view addSubview:bgImg];
    
//    self.toolsView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-90-NaviHeight,kScreenWidth, 90)];
//    _toolsView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_toolsView];
//
//    float buttonW=37*HEIGHT_SIZE;
    
    self.toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-170*HEIGHT_SIZE,kScreenWidth,190*HEIGHT_SIZE)];
    _toolsView.layer.cornerRadius = 20*HEIGHT_SIZE;
    _toolsView.layer.masksToBounds = YES;
    _toolsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_toolsView];
    
    float buttonW=50;
    
    //手电筒
    UIButton *btnFlash = [[UIButton alloc]init];
    btnFlash.frame = CGRectMake(0, 0, 30*HEIGHT_SIZE,40*HEIGHT_SIZE);
    btnFlash.center = CGPointMake(kScreenWidth/2, CGRectGetMinY(_toolsView.frame)-80);
    [btnFlash setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [btnFlash setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFlash setImage:IMAGE(@"DianTongOff") forState:UIControlStateNormal];
    [btnFlash setImage:IMAGE(@"DianTongOn") forState:UIControlStateSelected];
    [btnFlash setSelected:NO];
//    btnFlash.layer.cornerRadius = 15*HEIGHT_SIZE;
//    btnFlash.layer.masksToBounds = YES;
    [btnFlash addTarget:self action:@selector(openOrCloseFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFlash];
    
    
    
    
    //选择相册
//    CGSize size = CGSizeMake(buttonW, buttonW);
//    UIButton *photoBtn = [[UIButton alloc]init];
//    photoBtn.frame = CGRectMake(0,0, size.width, size.height);
//    photoBtn.center = CGPointMake(self.toolsView.xmg_width/4, self.toolsView.xmg_height/2-5);
//    [photoBtn setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
//    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [photoBtn setImage:[UIImage imageNamed:@"selectPhoto"] forState:UIControlStateNormal];
//    [photoBtn setSelected:NO];
//    [photoBtn addTarget:self action:@selector(photosAction) forControlEvents:UIControlEventTouchUpInside];
//    [_toolsView addSubview:photoBtn];
//    UILabel *tipslb = [[UILabel alloc]init];
//    tipslb.text = root_xiangkuang_xuanQu;
//    tipslb.font = FontSize(12);
//    tipslb.adjustsFontSizeToFitWidth = YES;
//    tipslb.numberOfLines = 0;
//    tipslb.textAlignment = NSTextAlignmentCenter;
//    tipslb.textColor = colorblack_102;
//    [tipslb sizeToFit];
//    tipslb.xmg_centerX = _toolsView.xmg_width/4;
//    tipslb.xmg_y = CGRectGetMaxY(photoBtn.frame)+2;
//    [_toolsView addSubview:tipslb];
//
//    //手动输入
//    UIButton *shoudongBtn = [[UIButton alloc]init];
//    shoudongBtn.frame = CGRectMake(0,0, size.width, size.height);
//    shoudongBtn.center = CGPointMake(self.toolsView.xmg_width/4*3, self.toolsView.xmg_height/2-5);
//    [shoudongBtn setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
//    [shoudongBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [shoudongBtn setImage:[UIImage imageNamed:@"sdsr"] forState:UIControlStateNormal];
//    [shoudongBtn setSelected:NO];
//    [shoudongBtn addTarget:self action:@selector(shoudongBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_toolsView addSubview:shoudongBtn];
//    UILabel *tipslb1 = [[UILabel alloc]init];
//    tipslb1.text = root_MAX_499;
//    tipslb1.font = FontSize(12);
//    tipslb1.adjustsFontSizeToFitWidth = YES;
//    tipslb1.numberOfLines = 0;
//    tipslb1.textAlignment = NSTextAlignmentCenter;
//    tipslb1.textColor = colorblack_102;
//    [tipslb1 sizeToFit];
//    tipslb1.xmg_centerX = _toolsView.xmg_width/4*3;
//    tipslb1.xmg_y = CGRectGetMaxY(shoudongBtn.frame)+2;
//    [_toolsView addSubview:tipslb1];
//
//    //找不到序列号
//    UIButton *tipsBtn = [[UIButton alloc]init];
//    tipsBtn.frame = CGRectMake(0,0,220*HEIGHT_SIZE, 30*HEIGHT_SIZE);
//    tipsBtn.xmg_y = CGRectGetMaxY(btnFlash.frame)+10;
//    tipsBtn.xmg_centerX = kScreenWidth/2;
//    tipsBtn.alpha = 0.5;
//    [tipsBtn setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
//    [tipsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [tipsBtn setTitle:NewLocat_FindXLH forState:UIControlStateNormal];
//    tipsBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.9];
//    tipsBtn.titleLabel.font = FontSize(13*HEIGHT_SIZE);
//    tipsBtn.layer.cornerRadius = 8*HEIGHT_SIZE;
//    tipsBtn.layer.masksToBounds = YES;
//    [tipsBtn addTarget:self action:@selector(tipsBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:tipsBtn];
    
    
   
    
    
    UIImageView *tipsIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-25*HEIGHT_SIZE, 10*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
    tipsIMGV.image = IMAGE(@"erweima");
    [_toolsView addSubview:tipsIMGV];
    
    UILabel *scanLB = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(tipsIMGV.frame), kScreenWidth-20*NOW_SIZE, 20*HEIGHT_SIZE)];
    scanLB.text = @"Scan Picture";
    scanLB.textAlignment = NSTextAlignmentCenter;
    scanLB.font = FontSize(13*HEIGHT_SIZE);
    scanLB.textColor = colorblack_154;
    [_toolsView addSubview:scanLB];
    
    //    WEPhotoScan
    
    UIButton *changeButton = [[UIButton alloc]init];
    changeButton.frame = CGRectMake(10*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 30*HEIGHT_SIZE);
    //    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [changeButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
    [changeButton setImage:[UIImage imageNamed:@"WEeditIM"] forState:UIControlStateNormal];
    [changeButton setTitle:@"Manual Input" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(shoudongBtnClick) forControlEvents:UIControlEventTouchUpInside];
    changeButton.backgroundColor = backgroundNewColor;
    changeButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    changeButton.layer.masksToBounds = YES;
    [_toolsView addSubview:changeButton];
    
    UIButton *photoButton = [[UIButton alloc]init];
    photoButton.frame = CGRectMake(CGRectGetMaxX(changeButton.frame)+5*NOW_SIZE,CGRectGetMaxY(scanLB.frame)+20*HEIGHT_SIZE,kScreenWidth/2-10*NOW_SIZE-5*NOW_SIZE, 30*HEIGHT_SIZE);
    //    [changeButton setTitleColor:[UIColor colorWithRed:0.165 green:0.663 blue:0.886 alpha:1.00] forState:UIControlStateSelected];
    [photoButton setTitleColor:colorblack_102 forState:UIControlStateNormal];
    [photoButton setImage:[UIImage imageNamed:@"WEPhotoScan"] forState:UIControlStateNormal];
    [photoButton setTitle:@"Photo Album" forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photosAction) forControlEvents:UIControlEventTouchUpInside];
    photoButton.backgroundColor = backgroundNewColor;
    photoButton.layer.cornerRadius = 8*HEIGHT_SIZE;
    photoButton.layer.masksToBounds = YES;
    [_toolsView addSubview:photoButton];
}

//找不到序列号
- (void)tipsBtnClick{
//    GTSNGuidePageView *tipView = [[GTSNGuidePageView alloc] initWithFrame:self.view.frame];
//    [tipView showPickViewTo:self.view];
}
- (void)tipsViewClick{
    _xuliehaoTipsView.hidden = YES;
}

#pragma mark -> 闪光灯 点击

- (void)openOrCloseFlash:(UIButton *)flshBtn
{
    AVCaptureTorchMode torch = self.deviceInput.device.torchMode;
    
    switch (self.deviceInput.device.torchMode) {
        case AVCaptureTorchModeAuto:
            break;
        case AVCaptureTorchModeOff:
            torch = AVCaptureTorchModeOn;
            break;
        case AVCaptureTorchModeOn:
            torch = AVCaptureTorchModeOff;
            break;
        default:
            break;
    }
    [self.deviceInput.device lockForConfiguration:nil];
    self.deviceInput.device.torchMode = torch;
    [self.deviceInput.device unlockForConfiguration];
}
#pragma mark - action
//跳过
- (void)jumpGoTo{
//    if ([_whereIN isEqualToString:@"2"]) {
//        BluetoolsSeachDevVC *add = [[BluetoolsSeachDevVC alloc]init];
//        add.whereIN = self.whereIN;
//        [self.navigationController pushViewController:add animated:YES];
//    }else{
//        ProductListVC *typevc = [[ProductListVC alloc]init];
//        [self.navigationController pushViewController:typevc animated:YES];
//    }
}

- (void)shoudongBtnClick{
    RedxNewAddCollector22VC *addvc = [[RedxNewAddCollector22VC alloc]init];
    addvc.stationId = _PlantID;
    [self.navigationController pushViewController:addvc animated:YES];
}

//去相册
- (void)photosAction{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户第一次同意了访问相册权限
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self enterPhotos];
                    });
                } else { 
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            [self enterPhotos];
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            [self deviceSettingShowText:root_server_1271];
        } else if (status == PHAuthorizationStatusRestricted) {
        }
    }
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [self removeTimer];
        
        if (@available(iOS 10.0, *)) {
            UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
            [impactLight impactOccurred];
        }else{
        }
        NSMutableArray *results = [[NSMutableArray alloc] init];
        [metadataObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AVMetadataMachineReadableCodeObject *code = (AVMetadataMachineReadableCodeObject*)[_videoPreviewLayer transformedMetadataObjectForMetadataObject:obj];
            [results addObject:code.stringValue]; 
        }];
        [self showResult:results];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (self.isScreenshot) {
        self.isScreenshot = NO;
        [self takePhoneDetect:[self imageFromSampleBuffer:sampleBuffer]];
    }
}

#pragma mark - - UIImagePickerControllerDelegate 的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self detect:image];
}

#pragma mark - private
- (void)scanSession{
    self.session = [AVCaptureSession new];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    self.deviceInput = deviceInput;
    if ([self.session canAddInput:deviceInput]) {
        [self.session addInput:deviceInput];
    }
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];

    NSString     *key           = (NSString *)kCVPixelBufferPixelFormatTypeKey;
    NSNumber     *value         = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    [self.session addOutput:captureOutput];
      
    _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //扫描区域
    CGFloat ratio = [[UIScreen mainScreen] bounds].size.width/320.0;
    CGRect rect = CGRectMake(45*ratio, (64+60)*ratio-50, 230*ratio, 230*ratio);
    _metadataOutput.rectOfInterest = CGRectMake(rect.origin.y/self.view.xmg_height,
                                                rect.origin.x/self.view.xmg_width,
                                                rect.size.height/self.view.xmg_height,
                                                rect.size.width/self.view.xmg_width);

    // 5、添加元数据输出流到会话对象
    [_session addOutput:_metadataOutput];
    _metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _videoPreviewLayer.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight-90-NaviHeight);
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [weakself.session startRunning];
    });
}
- (void)startScanQRCodeViewControllerWithResult:(void (^)(NSString * _Nonnull result))block {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted) {
            
        } else if (authStatus == AVAuthorizationStatusDenied) {
            [self deviceSettingShowText:root_server_1269];
        } else if (authStatus == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            //允许访问相机
            block(@"");
        } else if (authStatus == AVAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            __weak typeof(self) weakself = self;

            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    //这里是在block里面操作UI，因此需要回到主线程里面去才能操作UI
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself addTimer];
                        block(@"");
                    });
                }else {
                    //                    拒绝
                }
            }];
        }
    } else {
    }
}

- (void)deviceSettingShowText:(NSString *)text {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDict objectForKey:@"CFBundleDisplayName"];
    if (app_Name == nil) {
        app_Name = [infoDict objectForKey:@"CFBundleName"];
    }
    UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_Alet_user message:[NSString stringWithFormat:text,app_Name] preferredStyle:UIAlertControllerStyleAlert];
    [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
    [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:appSettings options:0 completionHandler:nil];
    }]];
    [self presentViewController:alvc animated:YES completion:nil];
}

- (void)enterPhotos{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)processWithResult:(NSString *)resultStr {
    NSArray *textArray = [resultStr componentsSeparatedByString:@" "];
    
    RedxNewAddCollector22VC *addvc = [[RedxNewAddCollector22VC alloc]init];
    addvc.SNStr = textArray.lastObject;
    addvc.stationId = _PlantID;
    [self.navigationController pushViewController:addvc animated:YES];
    if (self.resultBlock) {
        self.resultBlock(textArray.lastObject);
    }
}

#pragma mark - - - 添加定时器
- (void)addTimer {
    if (_session&&!_session.isRunning&&hasEntered) {
        [_session startRunning];
    }
    CGFloat ratio = [[UIScreen mainScreen] bounds].size.width/320.0;
    hasEntered = YES;
    CGFloat scanninglineX = 0;
    CGFloat scanninglineY = 0;
    CGFloat scanninglineW = 0;
    CGFloat scanninglineH = 0;
    [self.view addSubview:self.scanningline];
    scanninglineW = 230*ratio;
    scanninglineH = 20*ratio;
    scanninglineX = 45*ratio;
    scanninglineY = (64+60)*ratio-50;
    _scanningline.frame = CGRectMake(scanninglineX, scanninglineY, scanninglineW, scanninglineH);
    _scanningline.hidden = YES;
 
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self addTakePhotoTimer];
}

- (void)addTakePhotoTimer {
    [[NSRunLoop mainRunLoop] addTimer:self.takePhotoTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - - - 移除定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
    [self.takePhotoTimer invalidate];
    self.takePhotoTimer = nil;
    [self.scanningline removeFromSuperview];
    self.scanningline = nil;
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}

#pragma mark - - - 执行定时器方法
- (void)beginRefreshUI { 
    if (!_session.isRunning) {
        [self removeTimer];
    }
    CGFloat ratio = [[UIScreen mainScreen] bounds].size.width/320.0;
    _scanningline.hidden = NO;
    if (_up == YES) {
        CGFloat y = self.scanningline.frame.origin.y;
        y += 2;
        self.scanningline.xmg_y = y;
        if (y >= ((64+60)*ratio+230*ratio-20*ratio-50)) {
            _up = NO;
        }
    }else{
        CGFloat y = self.scanningline.frame.origin.y;
        y -= 2;
        self.scanningline.xmg_y = y;
        if (y <= (64+60)*ratio-50) {
            _up = YES;
        }
    }
}
#pragma mark - set/get
- (UIImageView *)scanningline {
    if (!_scanningline) {
        _scanningline = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"scanLine"];
        _scanningline.image = image;
    }
    return _scanningline;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.animationTimeInterval target:self selector:@selector(beginRefreshUI) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (NSTimer *)takePhotoTimer {
    if (!_takePhotoTimer) {
        _takePhotoTimer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(takePhoto) userInfo:nil repeats:YES];
    }
    return _takePhotoTimer;
}

//相册识别二维码/条形码
- (void)detect:(UIImage*)image {
    __weak typeof(self) weakSelf = self;

    VNDetectBarcodesRequest *detectRequest = [[VNDetectBarcodesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        NSArray *observations = request.results;
        if ([observations count] > 0) {
            NSMutableArray *tmpResult = [NSMutableArray new];
            for(VNBarcodeObservation *barocde in observations) {
                NSString *codeStr = barocde.payloadStringValue;
                if (![tmpResult containsObject:codeStr] && codeStr.length>=10) {
                    [tmpResult addObject:barocde.payloadStringValue];
                }
            }
            if (tmpResult.count == 1) {
                [weakSelf processWithResult:tmpResult.firstObject];
            }
            if (tmpResult.count > 1) {
                UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_MIX_225 message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                for (NSString *str in tmpResult) {
                    [alvc addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf processWithResult:action.title];
                    }]];
                }
                [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
                [weakSelf presentViewController:alvc animated:YES completion:nil];
            }
        } else {
            [self showToastViewWithTitle:NSLocalizedString(@"未找到相关信息", nil)];
        }
    }];
    CIImage *convertImage = [[CIImage alloc] initWithImage:image];
    VNImageRequestHandler *detectRequestHandler = [[VNImageRequestHandler alloc] initWithCIImage:convertImage options:@{}];
    NSError *err;
    [detectRequestHandler performRequests:@[detectRequest] error:&err];
}

//拍照识别二维码/条形码
- (void)takePhoneDetect:(UIImage*)image {
    __weak typeof(self) weakSelf = self;

    VNDetectBarcodesRequest *detectRequest = [[VNDetectBarcodesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        NSArray *observations = request.results;
        if ([observations count] > 0) {
            //停止拍照
            [self removeTimer];
            NSMutableArray *tmpResult = [NSMutableArray new];
            for(VNBarcodeObservation *barocde in observations) {
                NSString *codeStr = barocde.payloadStringValue;
                if (![tmpResult containsObject:codeStr] && codeStr.length>=10) {
                    [tmpResult addObject:barocde.payloadStringValue];
                }
            }
            [weakSelf showResult:tmpResult];
        }
    }];
    CIImage *convertImage = [[CIImage alloc] initWithImage:image];
    VNImageRequestHandler *detectRequestHandler = [[VNImageRequestHandler alloc] initWithCIImage:convertImage options:@{}];
    NSError *err;
    [detectRequestHandler performRequests:@[detectRequest] error:&err];
}

- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    CGImageRelease(quartzImage);
    return (image);
}

#pragma mark 拍照
- (void)takePhoto {
    self.isScreenshot = YES;
}

//显示选择
- (void)showResult:(NSArray *)tmpResult {
    __weak typeof(self) weakSelf = self;

    if (tmpResult.count == 0) {
        [weakSelf showToastViewWithTitle:NSLocalizedString(@"未找到相关信息", nil)];
        //继续拍照
        [weakSelf addTimer];
    }
    if (tmpResult.count == 1) {
        [weakSelf processWithResult:tmpResult.firstObject];
    }
    if (tmpResult.count > 1) {
        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:root_MIX_225 message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *str in tmpResult) {
            [alvc addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf processWithResult:action.title];
            }]];
        }
        [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf addTimer];
        }]];
        [weakSelf presentViewController:alvc animated:YES completion:nil];
    }
}

@end

