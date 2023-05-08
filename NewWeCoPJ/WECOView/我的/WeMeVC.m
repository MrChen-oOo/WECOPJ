//
//  WeMeVC.m
//  RedxPJ
//
//  Created by CBQ on 2022/11/28.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "WeMeVC.h"
#import "WeMeSetting.h"

@interface WeMeVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong)UIImageView *headimgv;

@end

@implementation WeMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Me_Me;
    [self createMeUI];
    // Do any additional setup after loading the view.
}

- (void)createMeUI{
    
    
    UIImageView *userHeaderIMG = [[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 10*HEIGHT_SIZE, 60*HEIGHT_SIZE, 60*HEIGHT_SIZE)];
    userHeaderIMG.image = IMAGE(@"WeHeaderIMG");
    userHeaderIMG.layer.cornerRadius = 30*HEIGHT_SIZE;
    userHeaderIMG.layer.masksToBounds = YES;
    userHeaderIMG.userInteractionEnabled = YES;
    [self.view addSubview:userHeaderIMG];
    _headimgv = userHeaderIMG;
    
    UITapGestureRecognizer *heaimgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickUpImage)];
    [userHeaderIMG addGestureRecognizer:heaimgTap];
    
    // 加载图片
    
    NSString *iconstr = [RedxUserInfo defaultUserInfo].userIcon;
    [userHeaderIMG sd_setImageWithURL:[NSURL URLWithString:iconstr] placeholderImage:IMAGE(@"WeHeaderIMG")];
    
    
    UILabel *namelb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userHeaderIMG.frame)+5*NOW_SIZE, 10*HEIGHT_SIZE+10*HEIGHT_SIZE, kScreenWidth-CGRectGetMaxX(userHeaderIMG.frame)-30*NOW_SIZE, 40*HEIGHT_SIZE)];
    namelb.font = FontSize(14*HEIGHT_SIZE);
    namelb.textColor = colorBlack;
    namelb.adjustsFontSizeToFitWidth = YES;
    namelb.textAlignment = NSTextAlignmentLeft;
    namelb.text = [RedxUserInfo defaultUserInfo].email;
    [self.view addSubview:namelb];
    
    UIView *linev = [self goToInitView:CGRectMake(10*NOW_SIZE, CGRectGetMaxY(userHeaderIMG.frame)+10*HEIGHT_SIZE, kScreenWidth-20*NOW_SIZE, 0.8*HEIGHT_SIZE) backgroundColor:backgroundNewColor];
    [self.view addSubview:linev];
    
    NSArray *funarr = @[Me_SetName1,
                        Me_SetName2,
                        Me_SetName3,
    ];
    NSArray *funImgArr = @[@"WeLocalDebugimg",@"WeSetting",@"weSuggest"];
    
    for (int i = 0; i < funarr.count; i++) {
        UIView *onev = [self goToInitView:CGRectMake(0, CGRectGetMaxY(linev.frame)+10*HEIGHT_SIZE+45*HEIGHT_SIZE*i, kScreenWidth, 45*HEIGHT_SIZE) backgroundColor:WhiteColor];
        onev.tag = 100+i;
        [self.view addSubview:onev];
        
        UIImageView *imgv = [self goToInitImageView:CGRectMake(10*NOW_SIZE, 5*HEIGHT_SIZE, 20*HEIGHT_SIZE, 20*HEIGHT_SIZE) imageString:funImgArr[i]];
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        [onev addSubview:imgv];
        
        UILabel *titLb = [self goToInitLable:CGRectMake(CGRectGetMaxX(imgv.frame)+5*NOW_SIZE, 0, kScreenWidth-CGRectGetMaxX(imgv.frame)-10*NOW_SIZE-10*HEIGHT_SIZE-5*NOW_SIZE-50*HEIGHT_SIZE, 30*HEIGHT_SIZE) textName:funarr[i] textColor:colorblack_102 fontFloat:14*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
        [onev addSubview:titLb];
        
        if(i == 2){
            
            UILabel *tipslb = [self goToInitLable:CGRectMake(CGRectGetMaxX(imgv.frame)+5*NOW_SIZE, CGRectGetMaxY(titLb.frame), kScreenWidth-CGRectGetMaxX(imgv.frame)-10*NOW_SIZE-10*HEIGHT_SIZE-5*NOW_SIZE-50*HEIGHT_SIZE, 15*HEIGHT_SIZE) textName:Me_SetnotificationTips textColor:colorblack_154 fontFloat:12*HEIGHT_SIZE AlignmentType:1 isAdjust:YES];
            [onev addSubview:tipslb];
            
            UIButton *onoffbtn = [self goToInitButton:CGRectMake(kScreenWidth-10*NOW_SIZE-40*HEIGHT_SIZE,0, 40*HEIGHT_SIZE, 30*HEIGHT_SIZE) TypeNum:2 fontSize:13 titleString:@"" selImgString:@"weon" norImgString:@"weoff"];
            [onoffbtn addTarget:self action:@selector(onoffClick:) forControlEvents:UIControlEventTouchUpInside];
            [onev addSubview:onoffbtn];
        }else{
            
            UITapGestureRecognizer *onetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewclick:)];
            [onev addGestureRecognizer:onetap];
            
            UIImageView *rigimg = [self goToInitImageView:CGRectMake(kScreenWidth-10*NOW_SIZE-8*HEIGHT_SIZE, (30*HEIGHT_SIZE-8*HEIGHT_SIZE)/2, 8*HEIGHT_SIZE, 8*HEIGHT_SIZE) imageString:@"rightBtn"];
            [onev addSubview:rigimg];
        }
    }
    
}

- (void)onoffClick:(UIButton *)clickBtn{
    
    clickBtn.selected = !clickBtn.selected;
}

- (void)viewclick:(UITapGestureRecognizer *)tapg{
    
    if(tapg.view.tag == 100){//local
        
        UIAlertController *alvc = [UIAlertController alertControllerWithTitle:@"Going to the Weco Blu download Page?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alvc addAction:[UIAlertAction actionWithTitle:root_cancel style:UIAlertActionStyleCancel handler:nil]];
        [alvc addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            

        }]];
        [self presentViewController:alvc animated:YES completion:nil];
    }
    if(tapg.view.tag == 101){//setting
        
        WeMeSetting *settingvc = [[WeMeSetting alloc]init];
        [self.navigationController pushViewController:settingvc animated:YES];
    }
}


- (void)pickUpImage{
    
    [self showProgressView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
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
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    [ud setObject:imageData forKey:@"userPic"];
    _headimgv.image = image;
    [self saveHeaderIMG:imageData];
    [self hideProgressView];

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
@end
