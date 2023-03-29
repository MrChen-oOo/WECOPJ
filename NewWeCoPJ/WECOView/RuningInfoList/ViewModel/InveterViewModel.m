//
//  InveterViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "InveterViewModel.h"
#import "MJExtension.h"

@implementation InveterViewModel


- (void)getMgrnRunInfoMessageCompleteBlock:(void(^)(NSString *resultStr))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/RunInfo/getMgrnRunInfo",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":self.deviceStr};
    [InveterViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.infoModel.dataModel = [InveterMsgInfoModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            [self.infoModel addInveterSectionOneArray];
            [self.infoModel addInveterSectionTwoArray];
            [self.infoModel addInveterSectionThreeArray];

            completeBlock ? completeBlock(@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"]) : nil;
        }
    } orFail:^(NSError * _Nonnull errorMsg) {
        completeBlock ? completeBlock(@"Network request failure") : nil;
    }];
}


-(InveterInfoModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[InveterInfoModel alloc]init];
    }
    return _infoModel;
}

@end
