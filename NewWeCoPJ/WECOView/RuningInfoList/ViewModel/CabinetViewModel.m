//
//  CabinetViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import "CabinetViewModel.h"
#import "MJExtension.h"

@implementation CabinetViewModel



- (void)getHmiRunInfoMessageCompleteBlock:(void (^)(NSString *, NSString *))completeBlock {
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/RunInfo/getHmiRunInfo",HEAD_URL];

    NSDictionary *dic = @{@"deviceSn":self.deviceStr};
    [CabinetViewModel requestGetForURL:urlStr withParam:dic withSuccess:^(id  _Nonnull resultData) {
        if ([self judgeSuccess:resultData] == YES) {
            self.infoModel.cabinetModel = [CabinetMsgInfoModel mj_objectWithKeyValues:[resultData objectForKey:@"data"]];
            [self.infoModel addICabinetSectionOneArrayWithIndex:0];
            [self.infoModel addICabinetSectionTwoArrayWithIndex:0];
            [self.infoModel addICabinetSectionThreeArray];

            completeBlock ? completeBlock(@"",@"") : nil;
        } else {
            completeBlock ? completeBlock([resultData objectForKey:@"errMessage"],[resultData objectForKey:@"errCode"]) : nil;
        }
    } orFail:^(NSString * _Nonnull errorMsg) {
        completeBlock ? completeBlock(errorMsg,@"") : nil;
    }];
}


-(CabinetInfoModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[CabinetInfoModel alloc]init];
    }
    return _infoModel;
}

@end
