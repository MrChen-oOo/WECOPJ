//
//  ScanViewController.h
//  LocalDebug
//
//  Created by 管理员 on 2023/3/3.
//

#import "RedxRootNewViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ScanResultBlock)(NSString *scanResult);

@interface ScanViewController : RedxRootNewViewController
@property (nonatomic, copy)       ScanResultBlock resultBlock;
@property (nonatomic, strong)NSString* PlantID;

@end
 
NS_ASSUME_NONNULL_END
