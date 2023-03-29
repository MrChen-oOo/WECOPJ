//
//  CabinetViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <Foundation/Foundation.h>
#import "CabinetInfoModel.h"
#import "RBaseViewModel.h"

@interface CabinetViewModel : RBaseViewModel

@property (nonatomic, strong)CabinetInfoModel *infoModel;
@property (nonatomic, strong)NSString *deviceStr;

- (void)getHmiRunInfoMessageCompleteBlock:(void(^)(NSString *resultStr))completeBlock;


@end


