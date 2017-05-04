//
//  JPDataUtility.h
//  TaskRabbit
//
//  Created by ShiXiong on 14-6-30.
//  Copyright (c) 2014年 junepartner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum JPTextRuleType {
    JPTextAlphaNumbersRuleType = 0,
    JPTextAlphaRuleType = 1,
    JPTextNumbersRuleType = 2,
    JPTextCardIdRuleType = 3
} JPTextRuleType;

@interface DataUtility : NSObject

//验证手机号是否合法
+ (BOOL)isPhoneNumberValid:(NSString *)phoneNumber;
+ (BOOL)validatePhone:(NSString *)phone;
//验证字符是否符合规则
+ (BOOL)verifyText:(NSString *)text satisfyRule:(JPTextRuleType)ruleType;

//获取中英文混合字符串长度
+ (NSInteger)convertToCountWithString:(NSString*)string;

//清除数组中的NSNull对象
+ (NSArray *)returnArray:(NSArray *)array;

//清除字典中的NSNull对象
+ (NSDictionary *)returnDictionary:(NSDictionary *)dictionary;

//判断对象是不是空对象
+ (BOOL)isBlankObject:(id)object;

@end
