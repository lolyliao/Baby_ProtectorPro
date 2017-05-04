//
//  NSString+StringUtil.h
//  OC-Project
//
//  Created by 刘小辉 on 15/6/29.
//  Copyright (c) 2015年 刘小辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringUtil)

#pragma mark - 邮箱验证、手机号码验证、车牌号验证、身份证验证
-(BOOL)isEmail;
-(BOOL)isMobile;
-(BOOL)isCarNumber;
-(BOOL)isCardID;

#pragma mark - 返回汉字首字母  //大写
-(NSString*)ZHGetFirstLetter;


#pragma mark - MD5 16位加密 （大写  小写）
- (NSString *)MD5For16Bit_ABC:(NSString *)str;
- (NSString *)MD5For16Bit_abc:(NSString *)str;

#pragma mark - BASE 64位加密 （大写  小写)
//加密
- (NSString*)base64EncodedString:(NSData*)data;
//解密
- (NSData *)dataFromBase64String:(NSString *)aString;

@end
