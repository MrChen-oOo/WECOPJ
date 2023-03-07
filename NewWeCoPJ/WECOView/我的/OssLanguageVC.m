//
//  MyLanguageVC.m
//  ShinePhone
//
//  Created by CBQ on 2022/5/5.
//  Copyright © 2022 qwl. All rights reserved.
//

#import "OssLanguageVC.h"
#import "NTVLocalized.h"
#import "MyLanguageCell.h"
@interface OssLanguageVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int number;
@end

@implementation OssLanguageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Me_SetTing3;
    [self createTableView];
    // Do any additional setup after loading the view.
}
// tableView
- (void)createTableView {
    
    self.view.backgroundColor = backgroundNewColor;
    self.number = 0;
    self.number = [self nowLangIntNumber];
    float tableViewH = self.LangNameArr.count*50*HEIGHT_SIZE;
    if (tableViewH > kScreenHeight-kNavBarHeight) {
        tableViewH = kScreenHeight-kNavBarHeight;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, tableViewH+10*HEIGHT_SIZE) style:UITableViewStylePlain];
    _tableView.backgroundColor = backgroundNewColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(15*HEIGHT_SIZE, 0, 0, 0);
    _tableView.bounces=NO;
//    _tableView.layer.cornerRadius = 10*HEIGHT_SIZE;
//    _tableView.layer.masksToBounds = YES;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[MyLanguageCell class] forCellReuseIdentifier:@"langCellID"];
    

}
# pragma mark -- UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.LangNameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50*HEIGHT_SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid = @"langCellID";
    MyLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MyLanguageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.titlb1.text = self.LangNameArr[indexPath.row];
    if (indexPath.row == self.number) {
        cell.titlb1.textColor = mainColor;
        cell.seleimgv.hidden = NO;
    }else{
        cell.titlb1.textColor = colorblack_51;
        cell.seleimgv.hidden = YES;
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.number = (int)indexPath.row;
    [self.tableView reloadData];
    
    
    if (indexPath.row == 0) {

        [self resetSystemLanguage];
    }else{
        if (indexPath.row < self.LangKey2Arr.count) {
            [[NSUserDefaults standardUserDefaults] setValue:self.LangKey2Arr[indexPath.row] forKey:@"AppleLanguages"];
//            [[NSUserDefaults standardUserDefaults] setValue:_keyArr22[indexPath.row] forKey:@"LocalLanguageKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NTVLocalized sharedInstance] setLanguage:self.LangKeyArr[indexPath.row]];

        }

    }
    [self showProgressView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.title = Me_SetTing3;

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CHANGELANGUAGESET" object:nil];

        });
        [self hideProgressView];

    });
}
/**
 重置系统语言
 */
- (void)resetSystemLanguage {
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"AppleLanguages"];
    [[NTVLocalized sharedInstance] systemLanguage];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"appLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (int)nowLangIntNumber{
    
    NSString *langstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"];//自定义的保存语言设置
    int nowlangstr = 0;
    if (langstr.length > 0) {
    for (int i = 0; i < self.LangKeyArr.count; i++) {
            NSString *onekey = self.LangKeyArr[i];
            if ([onekey isEqualToString:langstr]) {
                nowlangstr = i;
                break;
            }
        }
    }
    return nowlangstr;
}


@end
