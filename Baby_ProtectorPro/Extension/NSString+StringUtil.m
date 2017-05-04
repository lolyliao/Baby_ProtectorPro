//
//  NSString+StringUtil.m
//  OC-Project
//
//  Created by 刘小辉 on 15/6/29.
//  Copyright (c) 2015年 刘小辉. All rights reserved.
//

#import "NSString+StringUtil.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (StringUtil)
#pragma mark - 邮箱验证、手机号码验证、车牌号验证、身份证验证
-(BOOL)isEmail;
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


-(BOOL)isMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}



-(BOOL)isCarNumber
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}



-(BOOL)isCardID
{
    NSString *cardCheck = @"^[0-9]{17}[0-9|xX]{1}$";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",cardCheck];
    return [cardTest evaluateWithObject:self];
}


#pragma mark - 返回汉字首字母  //大写
-(NSString*)ZHGetFirstLetter
{
    NSMutableString *source=[self mutableCopy];
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *firstLetter=[source substringWithRange:NSMakeRange(0, 1)];
    return [firstLetter capitalizedString];     //首字母大写
}



#pragma mark - MD5 16位加密 （大写  小写）
- (NSString *)MD5For16Bit_ABC:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSString *)MD5For16Bit_abc:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//base64 加密
- (NSString*)base64EncodedString:(NSData *)data
{
    //
    /**
     1、首先把字符串转成data
     2、然后在转base64加密成字符串
     
     NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
     NSString* encodeResult = [originData base64EncodedStringWithOptions:
     //                              NSDataBase64EncodingEndLineWithLineFeed];
     */
    return  [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
//base64 解密
- (NSData*)dataFromBase64String:(NSString *)aString
{
    /**
        1、首先把base64加密后的字符串转成data
        2、然后在转成字符串
     
     NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:aString options:0];
     NSString* encodeResult1 = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
     */
    
     return  [[NSData alloc] initWithBase64EncodedString:aString options:0];;
}
@end
