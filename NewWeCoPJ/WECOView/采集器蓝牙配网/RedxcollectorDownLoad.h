typedef void(^collectBlock)(NSString * _Nullable showStr,NSInteger wifiType,BOOL isUpLoad,NSDictionary * _Nullable upDataDic);
typedef void(^uploadB)();
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <SystemConfiguration/CaptiveNetwork.h>
NS_ASSUME_NONNULL_BEGIN
@interface RedxcollectorDownLoad : NSObject
+ (void)collectDownLoad:(NSString *)SNStr whereIN:(NSString *)whereIN sucessBlock:(collectBlock)successBlock;
@property (nonatomic, strong)uploadB uploadBlock;
+ (void)wifiClick;
+ (NSString *)fetchSSIDInfo;
+ (void)downLoadUpPick:(NSString *)urlstr urlType:(NSString *)urltype Version:(NSString *)Version;

+ (NSDictionary *)getDatalastPath:(NSString *)lastPathStr;

@end
NS_ASSUME_NONNULL_END
