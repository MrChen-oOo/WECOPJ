//
//  RBaseViewModel.h
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface RBaseViewModel : NSObject



-(instancetype)initViewModel;

@property (nonatomic,assign) NSInteger pageIndex;

-(BOOL)judgeSuccess:(id)resultData;

- (NSString *)gs_jsonStringCompactFormatForDictionary:(NSDictionary *)dicJson;

+(void)requestGetForURL:(NSString *)url withParam:(id)param withSuccess:(void(^)(id resultData))successBlock orFail:(void(^)(NSError *errorMsg))failBlock;

+(void)requestPostForURL:(NSString *)url withParam:(id)param withSuccess:(void(^)(id resultData))successBlock orFail:(void(^)(NSError *errorMsg))failBlock;



@end

NS_ASSUME_NONNULL_END
