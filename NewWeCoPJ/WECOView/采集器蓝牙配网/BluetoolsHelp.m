//
//  CollectorTestTCP22.m
//  bluetest
//
//  Created by 风度 on 2020/12/31.
//  Copyright © 2020 qwl. All rights reserved.
//

#import "BluetoolsHelp.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#define GRT_KEY_LEN        7
const char GroKey[GRT_KEY_LEN] = {'G', 'r', 'o', 'w', 'a', 't', 't'};

// key跟后台协商一个即可，保持一致
#define PSW_AES_KEY  @"sxd_aiot_key_001"
// 这里的偏移量也需要跟后台一致，一般跟key一样就行
#define AES_IV_PARAMETER @"sxd_aiot_2022_01"


@implementation BluetoolsHelp


/**
 Payload数据做掩码加密
 
 @param Payload pyyload
 @param length 长度
 @param mask 掩码
 @return 加密后的数据
 */

//+ (NSData *)MaskEncryption:(Byte[])Payload length:(int)length
//{
//    NSLog(@"长度：%d",length);
//    for(int j=0; j < length ;j++)
//    {
//         Payload[j] = Payload[j] ^ bluetestKey[j%7];
//    }
//
//    NSData *PayloadData = [NSData dataWithBytes:Payload length:length];
//
//    return PayloadData;
//}

+ (NSData*)aci_encryptWithAESData:(NSData *)data{
    NSData *AESData = [self AES128operation:kCCEncrypt data:data key:PSW_AES_KEY iv:AES_IV_PARAMETER];
    
    return AESData;

    
}

+ (NSData*)aci_decryptWithAESData:(NSData *)data{
    
    NSData *AESData = [self AES128operation:kCCDecrypt
                                       data:data
                                        key:PSW_AES_KEY
                                         iv:AES_IV_PARAMETER];
    
    return AESData;
}


/**
 *  AES加解密算法
 *
 *  @param operation kCCEncrypt（加密）kCCDecrypt（解密）
 *  @param data      待操作Data数据
 *  @param key       key
 *  @param iv        向量
 *
 *
 */
+ (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
        这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说

    */
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}

/**
 Payload数据做掩码加密
 
 @param Payload pyyload
 @param length 长度
 @param mask 掩码
 @return 加密后的数据
 */

+ (NSData *)MaskEncryption:(Byte[])Payload length:(int)length
{
    NSLog(@"长度：%d",length);
    for(int j=0; j < length ;j++)
    {
         Payload[j] = Payload[j] ^ GroKey[j%7];
    }
    
    NSData *PayloadData = [NSData dataWithBytes:Payload length:length];
 
    return PayloadData;
}


/**
 和校验，取低8位 -- 取前面数据总和，再与0xff，取低8位
 
 @param bytes byte数组
 @param length 数组长度
 @return 返回校验值
 */
+ (long int)checkSumWithData:(Byte[])bytes length:(int)length
{
    int sum = 0;
    for (int i = 0; i < length; i++) sum += (int)bytes[i];
    return sum & 0xff;
}



#pragma mark -- 将NSData转换成十六进制的字符串
+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

 #pragma mark -- 获取当前时间字符串
+ (NSData *)getCurrentTime
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year =(int) [dateComponent year];
    int month = (int) [dateComponent month];
    int day = (int) [dateComponent day];
    int hour = (int) [dateComponent hour];
    int minute = (int) [dateComponent minute];
    int second = (int) [dateComponent second];
    
    //字符串的转化并且拼接
    NSString *yearstr=[self stringWithInteget:(long)year];
    NSString *monthstr=[self stringWithInteget:(long)month];
    NSString *daystr=[self stringWithInteget:(long)day];
    NSString *hourstr=[self stringWithInteget:(long)hour];
    NSString *minutestr=[self stringWithInteget:(long)minute];
    NSString *secondstr=[self stringWithInteget:(long)second];
    
    NSString *TimeString = [NSString stringWithFormat:@"%@%@%@_%@%@%@",yearstr,monthstr,daystr,hourstr,minutestr,secondstr];
    NSData *timeData = [self dataWithString:TimeString];
    NSLog(@"TimeString: %@, timeData: %@", TimeString, timeData);
    
    return timeData;
}
// 不足两位前面补零
+ (NSString *)stringWithInteget:(NSInteger)num
{
    NSString *str = [NSString stringWithFormat:@"%ld",num];
    while (str.length < 2) str = [NSString stringWithFormat:@"0%@",str];
    return str;
}


#pragma mark -- 将传入的NSString类型转换成ASCII码并返回
+ (NSData*)dataWithString:(NSString *)string
{
    unsigned char *bytes = (unsigned char *)[string UTF8String];
    NSInteger len = string.length;
    return [NSData dataWithBytes:bytes length:len];
}


#pragma mark --  10进制转16进制,返回为2字节,不带"0x"开头
+ (NSString *)ToHex:(int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        
        ttmpig=tmpid%16;

        tmpid=tmpid/16;
        
        switch (ttmpig)
        {
            case 10:   nLetterValue =@"A";break;
            case 11:   nLetterValue =@"B";break;
            case 12:   nLetterValue =@"C";break;
            case 13:   nLetterValue =@"D";break;
            case 14:   nLetterValue =@"E";break;
            case 15:   nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    str = str.length == 1 ? [NSString stringWithFormat:@"0%@",str] : str ;
    return str;
}

#pragma mark --  把数值比较大的10进制转16进制 ,不带"0x"开头， 例如 1000 转成 03e8
+ (NSString *)ToHex2:(int)tmpid
{
    NSString *str =@"";
    int tmpid2;
    do {
        tmpid2 = tmpid%256;
        tmpid = tmpid/256;
        str = [NSString stringWithFormat:@"%@%@", [self ToHex:tmpid2],str];
    } while (tmpid != 0);
    
    return str;
}


#pragma mark -- 高低位互换
- (NSString *)transform:(NSString *)string
{
    NSLog(@"高地位互换-%@",string);
    
    NSString *str = [NSString stringWithFormat:@"%@",string];
    
    for (int i = (int)string.length ; i< 4; i++)
    {
        str =  [NSString stringWithFormat:@"0%@",str];
    }
    return [[str substringWithRange:NSMakeRange(2, 2)] stringByAppendingString:[str substringWithRange:NSMakeRange(0, 2)]];
}

// 16进制转10进制
+ (NSNumber *) numberHexString:(NSString *)aHexString
{
    // 为空,直接返回.
    if (nil == aHexString)
    {
        return nil;
    }
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    //将整数转换为NSNumber,存储到数组中,并返回.
    
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    return hexNumber;
}

// 按规定位数返回，不足补00
+ (NSData*)dataWithString:(NSString *)string length:(NSInteger)length
{
    unsigned char *bytes = (unsigned char *)[string UTF8String];
    NSInteger len = string.length;
    NSMutableData *strData = [[NSMutableData alloc]initWithBytes:bytes length:len];
    if(strData.length > length){ // 判断是否超出位数
        return [NSData data];
    }
    
    // 不足补零
    NSMutableData *mutalData = [[NSMutableData alloc]init];
    while (mutalData.length < length-strData.length) {
        [mutalData appendData:[NSData dataWithBytes:[@"" UTF8String] length:1]];
    }
    [strData appendData:mutalData];
    
    return strData;
}

 #pragma mark -- 获取当前时间字符串
+ (NSData *)getCurrentTimeType:(NSString *)type
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitDay | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year =(int) [dateComponent year];
    int month = (int) [dateComponent month];
    int day = (int) [dateComponent day];
    int hour = (int) [dateComponent hour];
    int minute = (int) [dateComponent minute];
    int second = (int) [dateComponent second];
    
    //字符串的转化并且拼接
    NSString *yearstr=[self stringWithInteget:(long)year];
    NSString *monthstr=[self stringWithInteget:(long)month];
    NSString *daystr=[self stringWithInteget:(long)day];
    NSString *hourstr=[self stringWithInteget:(long)hour];
    NSString *minutestr=[self stringWithInteget:(long)minute];
    NSString *secondstr=[self stringWithInteget:(long)second];
    
    NSString *TimeString = [NSString stringWithFormat:@"%@%@%@_%@%@%@",yearstr,monthstr,daystr,hourstr,minutestr,secondstr];
    
    if([type isEqualToString:@"1"]){
        TimeString = [NSString stringWithFormat:@"%@%@%@%@%@%@",yearstr,monthstr,daystr,hourstr,minutestr,secondstr];
    }
    
    NSData *timeData = [self dataWithString:TimeString];
    NSLog(@"TimeString: %@, timeData: %@", TimeString, timeData);
    
    return timeData;
}

/**
 WiFi 发送指令
 
 @discussion
 帧头：1字节， 0x5a
 帧头：1字节， 0x5a
 协议类型：1字节， 0x01表示交流桩，0x02表示直流桩，0x03表示交直流桩
 加密类型：1字节，0x00表示不加密，0x01表示掩码加密，其他加密预留
 消息类型：1字节，对应业务流程命令类型
 数据长度：1字节，指示有效数据长度
 有效数据：低字节在前，高字节在后。最长(240字节)
 数据校验：1字节，和校验，取低字节
 结束符：1字节， 0x88
 
 @param protocol 协议类型
 @param cmd 消息类型
 @param dataLength 有效数据的长度
 @param payload 有效数据
 */
+ (NSData *)wifiSendDataProtocol:(NSString *)protocol Cmd:(NSString *)cmd DataLenght:(int)dataLength Payload:(Byte[])payload Mask:(Byte[])mask Useless:(Byte[])useless
{
    //先以16为参数告诉strtoul字符串参数表示16进制数字
//    Byte bytes[] = {};
//    bytes[0] = 0x00; // 帧头
//    bytes[1] = 0x01; // 帧头
//    bytes[2] = 0x00;
//    bytes[3] = 0x05;//
//
////    unsigned long datalengthInt = strtoul([[self ToHex:dataLength+2] UTF8String], 0, 16); // 有效数据的长度,转16进制
////    NSData *changLangdata = [self getHexHeigAndLow:datalengthInt];
//    Byte *datalengtharr=[self toByteIntNumb:dataLength+2];
//
//    bytes[4] = datalengtharr[0];
//    bytes[5] = datalengtharr[1];
//
//    NSLog(@"加密前的有效数据: %@",[NSData dataWithBytes:payload length:dataLength]);
//    // 有效数据进行掩码加密
////    NSData *paydata = [NSData dataWithBytes:payload length:dataLength];
//    NSData *PayloadData = [self MaskEncryption:payload length:dataLength];//
//    NSLog(@"加密后的有效数据: %@", PayloadData);
//    bytes[6] = 0x01;
//    bytes[7] = strtoul([cmd UTF8String], 0, 0); // 消息类型;
//
////     byte转Data数据再进行拼接
//    NSMutableData *bytesData = [[NSMutableData alloc]initWithBytes:bytes length:8];
//    [bytesData appendData:PayloadData];
//    Byte *bytes2 = (Byte *)[bytesData bytes];
//
//    // 转回byte类型
////    NSData *cmdData=[[NSData alloc]initWithBytes:bytes2 length:sizeof(bytes2)];
//    NSData *CRC = [self changCRC16:bytesData];
//    Byte *CRCArray=(Byte*)[CRC bytes];
//    NSInteger c1=CRCArray[0];
//    NSInteger c2=CRCArray[1];
//    bytes2[bytesData.length]= c1;//0xff;//
//    bytes2[bytesData.length+1]= c2;//0x72;//
//
//    NSData *sendByteData = [NSData dataWithBytes:bytes2 length:bytesData.length+2];
//    NSMutableData *allsenddata = [NSMutableData dataWithData:sendByteData];
//    while ((allsenddata.length%16) != 0) {
//
//        Byte *addbyte= [BluetoolsHelp toByteIntNumb:0];
//        NSData *adddata = [NSData dataWithBytes:addbyte length:1];
//        [allsenddata appendData:adddata];
//
//    }
//    NSLog(@"最后发送的完整 sendByteData: %@",allsenddata);
//    NSData *alldata = [self aci_encryptWithAESData:allsenddata];
//    return alldata;
    
    
    Byte *datalengtharr=[self toByteIntNumb:dataLength+2];

    NSLog(@"加密前的有效数据: %@",[NSData dataWithBytes:payload length:dataLength]);
    // 有效数据进行掩码加密
    NSData *subUseData = [NSData dataWithBytes:payload length:dataLength];
    
    NSData *AESData = [self aci_encryptWithAESData:subUseData];

    unsigned long aesdata00Len=  AESData.length;//allsenddata.length+2;
    unsigned long BallLength22= aesdata00Len+8;
    int first1=(BallLength22 & 0xff00)>>8;
    int first2=(BallLength22 & 0x00ff);
    Byte BlueheadData[] = {first1, first2, 0x00, 0x05, datalengtharr[0], datalengtharr[1],0x01,strtoul([cmd UTF8String], 0, 0)};
    NSMutableData *BlueSendData= [[NSMutableData alloc]initWithBytes:BlueheadData length:sizeof(BlueheadData)];
    //算CRC
    [BlueSendData appendData:AESData];
    NSData *CRCdata = [self changCRC16:BlueSendData];
    [BlueSendData appendData:CRCdata];
    NSLog(@"最后发送的完整 sendByteData: %@",BlueSendData);
    return BlueSendData;
}
//高低位分离
+ (NSData*)getHexHeigAndLow:(unsigned long)hexNumb{
    
    unsigned long high=hexNumb>>8;
    unsigned long low=hexNumb&0xff;
    Byte arraycrc[]={high,low};
    NSData *datacrc=[[NSData alloc]initWithBytes:arraycrc length:sizeof(arraycrc)];

    return datacrc;
}
//转换为两字节byte
+ (Byte*)toByteIntNumb:(int)numb{
    unsigned long datalengthInt = strtoul([[self ToHex:numb] UTF8String], 0, 16); // 有效数据的长度,转16进制
    NSData *changLangdata = [self getHexHeigAndLow:datalengthInt];
    Byte *datalengtharr=(Byte*)[changLangdata bytes];
    return datalengtharr;
}
//CRC16校验
+ (NSData*)changCRC16:(NSData*)data {
    int crcWord = 0x0000ffff;
    Byte *dataArray=(Byte*)[data bytes];
    for (int i=0; i <data.length; i++) {
        Byte byte=dataArray[i];
        crcWord ^=(int)byte & 0x000000ff;
        for (int j=0; j<8; j++) {
            if ((crcWord & 0x00000001)==1) {
                crcWord=crcWord>>1;
                crcWord=crcWord^0x0000A001;
            }else{
                crcWord=(crcWord>>1);
            }
        }
    }
    Byte crcH =(Byte)0xff&(crcWord>>8);
    Byte crcL=(Byte)0xff&crcWord;
    Byte arraycrc[]={crcH,crcL};
    NSData *datacrc=[[NSData alloc]initWithBytes:arraycrc length:sizeof(arraycrc)];
    NSLog(@"CRC go");
    return datacrc;
}

@end
