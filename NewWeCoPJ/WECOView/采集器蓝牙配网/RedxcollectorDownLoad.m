#import "RedxcollectorDownLoad.h"
@implementation RedxcollectorDownLoad
+ (void)collectDownLoad:(NSString *)SNStr whereIN:(NSString *)whereIN sucessBlock:(collectBlock)successBlock{
    NSString *urlstr = HEAD_URL;
    if ([whereIN isEqualToString:@"3"]) {
        urlstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"ADDNEEDSERVERURL"];
        if ([urlstr containsString:@"-cn"]) {
            urlstr = HEAD_URL_Demo_CN;
        }else{
            urlstr = HEAD_URL_Demo;
        }
    }
    [RedxBaseRequest myHttpPost:@"/dxRegister.do?op=getDatalogData" parameters:@{@"datalogSn":SNStr} Method:urlstr success:^(id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (json) {
                NSDictionary *objdic = json[@"obj"];
                NSLog(@"升级数据:%@",objdic);
                if (objdic) {
                    NSString *isNewDatalog = [NSString stringWithFormat:@"%@",objdic[@"isNewDatalog"]];
                    NSString *datalogType = [NSString stringWithFormat:@"%@",objdic[@"datalogType"]];
                    NSString *isWifiDatalog = [NSString stringWithFormat:@"%@",objdic[@"isWifiDatalog"]];
                    NSString *isHaveDatalog = [NSString stringWithFormat:@"%@",objdic[@"isHaveDatalog"]];
                    if ([whereIN isEqualToString:@"2"] || [whereIN isEqualToString:@"6"] || [whereIN isEqualToString:@"5"]) {
                    }else{
                        if ([isHaveDatalog isEqualToString:@"1"]) {
                            successBlock(@"HaveDatalog",0,NO,@{});
                            return;
                        }
                    }
                    NSInteger type=[[NSString stringWithFormat:@"%@", datalogType] integerValue];
                    BOOL isUpLoad = NO;
                    NSDictionary *datalogWifiFile = objdic[@"datalogWifiFile"];
                    if (type == 11 || type == 16){
                    if (datalogWifiFile) {
                                NSString *wifiXVersion = [NSString stringWithFormat:@"%@",datalogWifiFile[@"wifi-x_version"]];
                                NSString *wifiSVersion = [NSString stringWithFormat:@"%@",datalogWifiFile[@"wifi-s_version"]];
                        NSString *oldwifiXVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"wifiXVersion"];
                           if (kStringIsEmpty(oldwifiXVersion) || ![oldwifiXVersion isEqualToString:wifiXVersion]) {
                               isUpLoad = YES;
                           }
                        NSString *oldwifiSVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"wifiSVersion"];
                        if (kStringIsEmpty(oldwifiSVersion) || ![wifiSVersion isEqualToString:oldwifiSVersion]) {
                            isUpLoad = YES;
                        }
                    }
               }
                    if (kStringIsEmpty(isNewDatalog)) {
                        isNewDatalog = @"0";
                    }
                successBlock(isNewDatalog, type,isUpLoad,datalogWifiFile);
        }
     }
    } failure:^(NSError *error) {
        successBlock(@"NetEorror", 0,NO,@{});
    }];
}
+ (void)downLoadUpPick:(NSString *)urlstr urlType:(NSString *)urltype Version:(NSString *)Version{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [manager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
        return nil;
    }];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *pathURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        NSLog(@"保存的路径:%@",[NSString stringWithFormat:@"%@-%@",urltype,[response suggestedFilename]]);
        return [pathURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@",urltype,[response suggestedFilename]]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error)
        {
            if ([urltype isEqualToString:@"wifiX"]) {
                [[NSUserDefaults standardUserDefaults]setObject:Version forKey:@"wifiXVersion"];
            }else{
                [[NSUserDefaults standardUserDefaults]setObject:Version forKey:@"wifiSVersion"];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UPLOADCOLLECTSUCCESS" object:nil];
        NSLog(@"下载的连接:%@,保存的连接:%@",urlstr,filePath);
        }
    }];
    [task resume];
}

//获取文件数据
+ (NSDictionary *)getDatalastPath:(NSString *)lastPathStr{

     NSString *lastDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:lastPathStr];
    NSLog(@"path:%@",lastDir);
//    NSData *readdata22 = [[NSFileManager defaultManager] contentsAtPath:lastDir];
//    NSLog(@"dataLen:%ld",readdata22.length);
     NSFileManager *fileManager = [NSFileManager defaultManager];
     if (![fileManager fileExistsAtPath:lastDir]) {
         //cadLocalDir文件不存在

         return @{@"name":@"",@"path":@""};
     }
     //lastDir 为文件夹的路径
     NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:lastDir];
     //用来存文件信息的数组
     NSMutableArray *fileInfosArr = [[NSMutableArray alloc] init];
     NSString *file;
     //遍历当前目录
     while ((file = [myDirectoryEnumerator nextObject])) {
//         if ([[file pathExtension] isEqualToString:ExtensionStr]) {
             //取得文件扩展名为.dwg的文件名
             NSString *filePath = [lastDir stringByAppendingPathComponent:file];
             NSDictionary *dataDic = @{@"name":file,@"path":filePath};
             [fileInfosArr addObject:dataDic];
//         }
     }
     if (fileInfosArr.count > 0) {
         NSDictionary *datadic = fileInfosArr[0];
//         NSData *readdata22 = [[NSFileManager defaultManager] contentsAtPath:datadic[@"path"]];
//         NSLog(@"%ld",datadic);
         return datadic;;
     }else{
         return @{@"name":@"",@"path":@""};

     }
     

     
 }


+ (void)createpressUI{
}
+ (void)deleteFile:(NSString *)urlstr urlType:(NSString *)urltype updataName:(NSString *)userNum{
        NSFileManager* fileManager=[NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@",urltype,userNum]];
        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
        if (!blHave) {
        NSLog(@"no  have");
        return ;
        }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
        NSLog(@"dele success");
        }else {
        NSLog(@"dele fail");
        }
    }
}
+ (NSString *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    return info[@"SSID"];
}
+ (void)wifiClick{
    NSURL *url = [self wifiSettingUrl];
       if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
           [[UIApplication sharedApplication] openURL:url];
       } else {
           if (@available(iOS 10.0, *)) {
               [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
               }];
           } else {
           }
       }
}
+ (NSURL *)prefsUrlWithQuery:(NSDictionary *)query {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"QXBwLVByZWZz" options:0];
    NSString *scheme = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableString *url = [NSMutableString stringWithString:scheme];
    for (int i = 0; i < query.allKeys.count; i ++) {
        NSString *key = [query.allKeys objectAtIndex:i];
        NSString *value = [query valueForKey:key];
        [url appendFormat:@"%@%@=%@", (i == 0 ? @":" : @"?"), key, value];
    }
    return [NSURL URLWithString:url];
}
+ (NSURL *)wifiSettingUrl {
    return [self prefsUrlWithQuery:@{@"root": @"WIFI"}];
}
@end
