//
//  InveterViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "InveterViewModel.h"
#import "MJExtension.h"

@implementation InveterViewModel


- (void)getMgrnRunInfoMessageCompleteBlock:(void (^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/RunInfo/getMgrnRunInfo",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":self.deviceStr};
    [InveterViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.infoModel.dataModel = [InveterMsgInfoModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            [self.infoModel addInveterSectionOneArray];
            [self.infoModel addInveterSectionTwoArray];
            [self.infoModel addInveterSectionThreeArray];

            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}


-(InveterInfoModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[InveterInfoModel alloc]init];
    }
    return _infoModel;
}

@end
