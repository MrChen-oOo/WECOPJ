#import <Foundation/Foundation.h>
@interface RedxUserInfo : NSObject
+ (RedxUserInfo *)defaultUserInfo;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *TelNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *agentCode;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, assign) BOOL isAutoLogin;
@property (nonatomic, assign) BOOL isRemeMe;
@property (nonatomic, strong) NSString *userIcon;



@property (nonatomic, strong) NSData *userPic;
@property(weak ,nonatomic)NSTimer *R_timer;
@property (nonatomic, strong) NSString *firstPic;
@property (nonatomic, strong) NSString *OSSserver;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *plantID;
@property (nonatomic, strong) NSString *plantNum;
@property (nonatomic, assign) NSString *coreDataEnable;



@end
