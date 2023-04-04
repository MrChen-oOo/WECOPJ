//
//  InveterViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/27.
//

#import <Foundation/Foundation.h>
#import "RBaseViewModel.h"
#import "InveterInfoModel.h"

@interface InveterViewModel : RBaseViewModel

@property (nonatomic, strong)InveterInfoModel *infoModel;
@property (nonatomic, strong)NSString *deviceStr;

- (void)getMgrnRunInfoMessageCompleteBlock:(void(^)(NSString *resultStr))completeBlock;

@end


