//
//  JPDataUtility.m
//  TaskRabbit
//
//  Created by ShiXiong on 14-6-30.
//  Copyright (c) 2014年 junepartner. All rights reserved.
//

#import "DataUtility.h"

#define ALPHA           @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMBERS         @"0123456789"
#define ALPHANUM        @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define CARDID          @"0123456789Xx"
#define ALLCHAR         @""

@implementation DataUtility

/**
 验证手机号是否合法
 @params phoneNumber 手机号
 @returns 手机号有效返回YES
 **/
+ (BOOL)isPhoneNumberValid:(NSString *)phoneNumber
{
    NSString *regex = @"(13[0-9]|14[0-9]|15[0-9]|16[0-9]|18[0-9])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([phoneNumber length] >= 11) {
        id object = [phoneNumber substringFromIndex:[phoneNumber length] - 11];
        return [mobileTest evaluateWithObject:object];
    } else {
        return [mobileTest evaluateWithObject:phoneNumber];
    }
}
+ (BOOL)validatePhone:(NSString *)phone
{
    NSString *M1 = @"^1(3[0-9]|4[57]|8[0-9]|7[08]|5[0-35-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", M1];
    
    if ([regextestmobile evaluateWithObject:phone] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 验证字符是否符合规则
 @params text 手机号
 @params
 @returns 手机号有效返回YES
 **/
+ (BOOL)verifyText:(NSString *)text satisfyRule:(JPTextRuleType)ruleType
{
    NSString *ruleString = @"";
    switch (ruleType) {
        case 1:
            ruleString = ALPHA;
            break;
        case 2:
            ruleString = NUMBERS;
            break;
        case 3:
            ruleString = CARDID;
            break;
        default:
            ruleString = ALPHANUM;
            break;
    }
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:ruleString] invertedSet];
    NSArray *stringList = [text componentsSeparatedByCharactersInSet:cs];
    NSString *filtered = [stringList componentsJoinedByString:@""];
    BOOL basicTest = [text isEqualToString:filtered];
    return basicTest;
}

/**
 获取中英文混合字符串长度
 @params strtemp 中英文混合字符串
 @returns 中英文混合字符串长度
 **/
+ (NSInteger)convertToCountWithString:(NSString*)string
{
    float length = 0;
    NSString * tempString = string;
    for (int i = 0; i < [tempString length]; i++) {
        NSString * stt = [tempString substringWithRange:NSMakeRange(i, 1)];
        if ([stt lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            length ++;
        } else {
            length += 1;
        }
    }
    return length;
}

/**
 清除数组中的NSNull对象
 @params array 包含有null对象的数组
 @returns 不包含null对象的数组
 **/
+ (NSArray *)returnArray:(NSArray *)array {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger index,BOOL *stop){
        if (obj == [NSNull null]) {
            [mutableArray addObject:@""];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            [mutableArray addObject:[DataUtility
                                     returnArray:array]];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            [mutableArray addObject:[DataUtility returnDictionary:obj]];
        } else {
            [mutableArray addObject:obj];
        }
    }];
    return mutableArray;
}

/**
 清除字典中的NSNull对象
 @params dictionary 包含有null对象的字典
 @returns 不包含null对象的字典
 **/
+ (NSDictionary *)returnDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        if (obj == [NSNull null]) {
            [mutableDictionary setObject:@"" forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            [mutableDictionary setObject:[DataUtility returnArray:obj]
                                  forKey:key];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            [mutableDictionary setObject:[DataUtility returnDictionary:obj]
                                  forKey:key];
        } else {
            [mutableDictionary setObject:obj forKey:key];
        }
    }];
    return mutableDictionary;
}

/**
 判断对象是不是空对象
 @params object 判断对象
 @returns bool值
 **/
+ (BOOL)isBlankObject:(id)object {
    if (object == nil) {
        return YES;
    }
    if (object == NULL) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        if ([[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        } else {
            const char *str = [object UTF8String];
            if (strlen(str) == 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end