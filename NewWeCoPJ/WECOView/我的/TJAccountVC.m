//
//  WeMeVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/28.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "TJAccountVC.h"
#import "WeMeSetting.h"
#import "RedxloginViewController.h"
#import "AppDelegate.h"
#import "TJChangePswordVC.h"
#import "RedxAnotherSearchViewController.h"
#import "USSetValueAlterView.h"

@interface TJAccountVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong)UIImageView *headimgv;
@property (nonatomic, strong)NSMutableArray *provinceArray;
@property (nonatomic, strong)NSMutableArray *cityArr;
@property (nonatomic, strong)USSetValueAlterView *viewAlert;

@end

@implementation TJAccountVC


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_headimgv) {
        NSString *iconstr = [RedxUserInfo defaultUserInfo].userIcon;
        [_headimgv sd_setImageWithURL:[NSURL URLWithString:iconstr] placeholderImage:IMAGE(@"WeHeaderIMG")];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Manu";
    self.view.backgroundColor = backgroundNewColor;
    [self createMeUI];
    
//    [self getPickerData];
    // Do any additional setup after loading the view.
}

- (void)createMeUI{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100*HEIGHT_SIZE)];
    headView.backgroundColor = WhiteColor;
    [self.view addSubview:headView];
    
    UILabel *namelb = [[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 30*HEIGHT_SIZE, kScreenWidth-50*HEIGHT_SIZE-10*NOW_SIZE-20*HEIGHT_SIZE-40*NOW_SIZE, 40*HEIGHT_SIZE)];
    namelb.font = FontSize(14*HEIGHT_SIZE);
    namelb.textColor = colorBlack;
    namelb.adjustsFontSizeToFitWidth = YES;
    namelb.textAlignment = NSTextAlignmentLeft;
    namelb.text = @"Photo";
    [headView addSubview:namelb];
    
    UIImageView *userHeaderIMG = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-10*NOW_SIZE-16*HEIGHT_SIZE-50*HEIGHT_SIZE-5*NOW_SIZE, 25*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
    userHeaderIMG.image = IMAGE(@"WeHeaderIMG");
    userHeaderIMG.layer.cornerRadius = 25*HEIGHT_SIZE;
    userHeaderIMG.layer.masksToBounds = YES;
    userHeaderIMG.userInteractionEnabled = YES;
    [headView addSubview:userHeaderIMG];
    _headimgv = userHeaderIMG;
    
    UITapGestureRecognizer *heaimgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickUpImage)];
    [headView addGestureRecognizer:heaimgTap];
    
    // 加载图片
    
    NSString *iconstr = [RedxUserInfo defaultUserInfo].userIcon;
    [userHeaderIMG sd_setImageWithURL:[NSURL URLWithString:iconstr] placeholderImage:IMAGE(@"WeHeaderIMG")];
    
    
    
    
    UIImageView *rigIMG = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 10*NOW_SIZE - 16*HEIGHT_SIZE, (100*HEIGHT_SIZE - 16*HEIGHT_SIZE)/2, 16*HEIGHT_SIZE, 16*HEIGHT_SIZE)];
    rigIMG.image = IMAGE(@"prepare_more");
    rigIMG.userInteractionEnabled = YES;
    [headView addSubview:rigIMG];
    
    
//    UIView *linev = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(userHeaderIMG.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 0.8*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
//    [self.view addSubview:linev];
    
    NSArray *funarr = @[@"Avatar",
                        @"Modify password",
                        @"Email",
//                        @"Installation Code"
                        
                        
    ];
    
    NSString *useEmail = [RedxUserInfo defaultUserInfo].email;
    NSString *userName = [RedxUserInfo defaultUserInfo].userName;
//    NSString *stall = [RedxUserInfo defaultUserInfo].;

    NSArray *ValuArr = @[userName,@"",useEmail];
    
    for (int i = 0; i < funarr.count; i++) {
        UIView *onev = [self goToInitView:CGRectMake(0, CGRectGetMaxY(headView.frame)+10*HEIGHT_SIZE+40*HEIGHT_SIZE*i, kScreenWidth, 40*HEIGHT_SIZE) backgroundColor:WhiteColor];
        onev.tag = 100+i;
        [self.view addSubview:onev];
        
//        UIImageView *imgv = [self goToInitImageView:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) imageString:funImgArr[i]];
//        imgv.contentMode = UIViewContentModeScaleAspectFit;
//        [onev addSubview:imgv];
        CGSize textSize = [self getStringSize:14*HEIGHT_SIZE Wsize:kScreenWidth/2 Hsize:40*errSecInvalidKeyHierarchy stringName:funarr[i]];
        
        UILabel *titLb = [self goToInitLable:CGRectMake(10*NOW_SIZE, 0, textSize.width+20*NOW_SIZE, 40*HEIGHT_SIZE) textName:funarr[i] textColor:colorblack_51 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        [onev addSubview:titLb];
        
        UILabel *valueLb = [self goToInitLable:CGRectMake(CGRectGetMaxX(titLb.frame)+5*NOW_SIZE, 0, kScreenWidth-CGRectGetMaxX(titLb.frame)-10*NOW_SIZE-5*NOW_SIZE-16*HEIGHT_SIZE-10*NOW_SIZE, 40*HEIGHT_SIZE) textName:ValuArr[i] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:2 isAdjust:YES];
        valueLb.tag = 1000+i;
        [onev addSubview:valueLb];

            
            UITapGestureRecognizer *onetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewclick:)];
            [onev addGestureRecognizer:onetap];
            
            UIImageView *rigimg = [self goToInitImageView:CGRectMake(kScreenWidth-10*NOW_SIZE-16*HEIGHT_SIZE, (40*HEIGHT_SIZE-16*HEIGHT_SIZE)/2, 16*HEIGHT_SIZE, 16*HEIGHT_SIZE) imageString:@"prepare_more"];
            [onev addSubview:rigimg];
        
        if (i == 2) {
            rigimg.hidden = YES;
        }
    }
    _viewAlert = [[USSetValueAlterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarHeight)];
    [self.view addSubview:_viewAlert];
    _viewAlert.hidden = YES;
//    UIButton *logOutBtn = [self goToInitButton:CGRectMake(30*NOW_SIZE, kScreenHeight-kNavBarHeight-TabbarHeight-80*HEIGHT_SIZE-45*HEIGHT_SIZE, kScreenWidth-60*NOW_SIZE, 45*HEIGHT_SIZE) TypeNum:1 fontSize:14*HEIGHT_SIZE titleString:@"Log Out" selImgString:@"" norImgString:@""];
//    [logOutBtn addTarget:self action:@selector(logOutClick) forControlEvents:UIControlEventTouchUpInside];
//    logOutBtn.backgroundColor = mainColor;
//    logOutBtn.layer.cornerRadius = 8*HEIGHT_SIZE;
//    logOutBtn.layer.masksToBounds = YES;
//    [self.view addSubview:logOutBtn];
}

//- (void)onoffClick:(UIButton *)clickBtn{
//
//    clickBtn.selected = !clickBtn.selected;
//}

- (void)viewclick:(UITapGestureRecognizer *)tapg{
    
    if(tapg.view.tag == 100){//local
        
        UILabel *namlb = [self.view viewWithTag:1000];
        
        if (_viewAlert) {
    //        NSString *fanweiStr = @"";
    //        NSString *danweiStr = @"";

            NSString *danweistr = namlb.text;


            _viewAlert.hidden = NO;
            __weak typeof(self) weakself = self;
            [_viewAlert valueSet:danweistr fanwei:@"" danwei:@"" titleStr:@"Avatar"];
            
            _viewAlert.valueBlock = ^(NSString * _Nonnull valuestr) {
               
                [weakself changeName:valuestr];

            };
        }
    }
    if(tapg.view.tag == 101){//setting
        
        TJChangePswordVC *settingvc = [[TJChangePswordVC alloc]init];
        [self.navigationController pushViewController:settingvc animated:YES];
    }
    if(tapg.view.tag == 102){//setting
        
        

    }
}

- (void)changeName:(NSString *)namestr{
    
  
    
    [self showProgressView];
    
    [RedxBaseRequest myHttpPost:@"/v1/user/modifyUserName" parameters:@{@"email":[RedxUserInfo defaultUserInfo].email,@"userName":namestr} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (datadic) {
            NSString *result = [NSString stringWithFormat:@"%@",datadic[@"result"]];
            NSString *msg = [NSString stringWithFormat:@"%@",datadic[@"msg"]];
            [self showToastViewWithTitle:msg];
            
            if ([result isEqualToString:@"0"]) {
                UILabel *valulb = [self.view viewWithTag:1000];
                valulb.text = namestr;
                
                [RedxUserInfo defaultUserInfo].userName = namestr;
            }
            //
        }
        
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
        
    }];
    
}

- (void)pickUpImage{
    
    [self showProgressView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hideProgressView];
        
        
    });
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self hideProgressView];

    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    [ud setObject:imageData forKey:@"userPic"];
    _headimgv.image = image;
    [self saveHeaderIMG:imageData];
}

- (void)saveHeaderIMG:(NSData *)imgdata{
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    [dataImageDict setObject:imgdata forKey:@"file"];

    [self showProgressView];
    [RedxBaseRequest uplodImageWithMethod:HEAD_URL paramars:@{} paramarsSite:@"/v1/user/uploadAvatar" dataImageDict:dataImageDict sucessBlock:^(id content) {
        [self hideProgressView];
        
        NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *codestr = [NSString stringWithFormat:@"%@",jsondic[@"result"]];
        NSString *msg = [NSString stringWithFormat:@"%@",jsondic[@"msg"]];
        NSString *objstr = [NSString stringWithFormat:@"%@",jsondic[@"obj"]];
        [self showToastViewWithTitle:[NSString stringWithFormat:@"%@",msg]];

        if ([codestr isEqualToString:@"0"]) {
            if (!kStringIsEmpty(objstr)) {
                
                [RedxUserInfo defaultUserInfo].userIcon = objstr;
                
//                [[NSUserDefaults standardUserDefaults]setObject:objstr forKey:@"headeIMGUrl"];
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
}


//获取的国家
- (void)getPickerData{
    
    _provinceArray=[NSMutableArray array];
    [self showProgressView];//@"admin":@"admin"
    [RedxBaseRequest myHttpPost:@"/v1/user/getCountryList" parameters:@{} Method:HEAD_URL success:^(id responseObject) {
        [self hideProgressView];
        NSDictionary *datadic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (datadic) {
            
            id objdic = datadic[@"obj"];
            if([objdic isKindOfClass:[NSArray class]]){
                
                NSArray *dataArr= (NSArray *)datadic[@"obj"];//[NSArray arrayWithArray:content];
                if (dataArr.count>0) {
                    
                    NSArray *countrysArr = dataArr;
                    for (int i=0; i<countrysArr.count; i++) {
                        NSString *DY=[NSString stringWithFormat:@"%@",countrysArr[i]];
                        [ _provinceArray addObject:DY];
                    }
                    [_provinceArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                        NSString *str1=(NSString *)obj1;
                        NSString *str2=(NSString *)obj2;
                        return [str1 compare:str2];
                    }];
    //                [self.provinceArray insertObject:@"*Australia*" atIndex:0];
    //                [self.provinceArray insertObject:@"*中国*" atIndex:0];
                    
                }
            }
            
            
        }


    } failure:^(NSError *error) {
        [self hideProgressView];
    
    }];
}
@end
