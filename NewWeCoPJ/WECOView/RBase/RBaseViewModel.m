//
//  RBaseViewModel.m
//  NewWeCoPJ
//
//  Created by 欧利普 on 2023/3/16.
//

#import "RBaseViewModel.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"
@implementation RBaseViewModel


-(instancetype)initViewModel{
    self = [super init];
    if (self) {
        self.pageIndex = 1;
    }
    return self;
}

+(void)requestGetForURL:(NSString *)url withParam:(id)param withSuccess:(void (^)(id _Nonnull))successBlock orFail:(void (^)(NSString * _Nonnull))failBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    manager.requestSerializer.timeoutInterval = 20;

    [manager GET:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (successBlock) {
            NSLog(@"%@", [NSString stringWithFormat:@"URL:%@  ---  Result:%@",url,responseObject]);
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // -1009  //网络无连接
        // -1001  //超时
        // -1011  //404
        // 3840   //500
        if (failBlock) {
            NSString *errorMsg = @"";
            switch(error.code){
                case 3840:
                    errorMsg = @"Server internal error.";
                    break;
                case -1011:
                    errorMsg = @"The right resources were not found.";
                    break;
                case -1001:
                    errorMsg = @"Timeout fetching data, please try again later.";
                    break;
                case -1009:
                    errorMsg = @"Network connection failed. Please check the network.";
                    break;
            default:
                break;
            };
            NSLog(@"%@", [NSString stringWithFormat:@"URL:%@  ---  Result:%@",url,error]);
            failBlock(errorMsg);
        }
    }];

    
}

+(void)requestPostForURL:(NSString *)url withParam:(id)param withSuccess:(void (^)(id _Nonnull))successBlock orFail:(void (^)( NSString* _Nonnull))failBlock{
   
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
       cachePolicy:NSURLRequestUseProtocolCachePolicy
       timeoutInterval:20.0];
    NSDictionary *headers = @{
       @"User-Agent": @"Apifox/1.0.0 (https://www.apifox.cn)",
       @"Content-Type": @"application/json"
    };
    [request setAllHTTPHeaderFields:headers];
    NSData *postData = [[NSData alloc] initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error) {
          NSLog(@"%@", error);
           if (failBlock) {
               NSString *errorMsg = @"";

               switch(error.code){
                   case 3840:
                       errorMsg = @"Server internal error.";
                       break;
                   case -1011:
                       errorMsg = @"The right resources were not found.";
                       break;
                   case -1001:
                       errorMsg = @"Timeout fetching data, please try again later.";
                       break;
                   case -1009:
                       errorMsg = @"Network connection failed. Please check the network.";
                       break;
               default:
                   break;
               };
               NSLog(@"%@", [NSString stringWithFormat:@"URL:%@  ---  Result:%@",url,error]);
               failBlock(errorMsg);
           }
//          dispatch_semaphore_signal(sema);
       } else {
          NSError *parseError = nil;
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
           NSLog(@"%@",responseDictionary);
           if (successBlock) {
               NSLog(@"%@", [NSString stringWithFormat:@"URL:%@  ---  Result:%@",url,responseDictionary]);
               if ([responseDictionary[@"success"] integerValue] == 1) {
                   // 提示MBProgress
               }
               successBlock(responseDictionary);
           }
//          dispatch_semaphore_signal(sema);
       }
    }];
    [dataTask resume];
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

+ (void)requestOldPostForURL:(NSString *)url withParam:(id)param withSuccess:(void (^)(id _Nonnull))successBlock orFail:(void (^)(NSError * _Nonnull))failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSLog(@"%@", [NSString stringWithFormat:@"URL:%@  ---  Result:%@",url,responseObject]);
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            NSLog(@"%@", [NSString stringWithFormat:@"URL:%@  ---  Result:%@",url,error]);
            failBlock(error);
        }
    }];
}





- (NSString *)gs_jsonStringCompactFormatForDictionary:(NSDictionary *)dicJson {
    if (![dicJson isKindOfClass:[NSDictionary class]] || ![NSJSONSerialization isValidJSONObject:dicJson]) {
        return nil;

    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}

-(BOOL)judgeSuccess:(id)resultData{
    if (resultData && ![resultData isKindOfClass:[NSString class]] && [[resultData objectForKey:@"success"] integerValue] == 1) {
        return YES;
    }
    return NO;
}

@end
