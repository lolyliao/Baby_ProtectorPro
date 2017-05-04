//
//  Utility.h
//  ProjectDemo
//
//  Created by 刘小辉 on 15/6/26.
//  Copyright (c) 2015年 刘小辉. All rights reserved.
//

#ifndef ProjectDemo_Utility_h
#define ProjectDemo_Utility_h

#import <UIKit/UIKit.h>
#import "Unit.h"
#import "UIColor+ColorUtil.h"
#import "UIButton+Utility.h"
#import "UIView+Frame.h"
#import "Color.h"
//#import "UIImageView+WebCache.h"
#import "Color.h"
#import "Font.h"
//#import "HTTPHeader.h"
//#import "UINavigationBar+Awesome.h"
//#import "HttpRequest.h"
//#import "MJRefresh.h"
#import "Frame.h"
#import "HHLoadingView.h"
#ifdef __OBJC__

#pragma mark - Setting
//当前系统设置国家的country iso code
#define countryISO  [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]
//当前系统设置语言的iso code
#define languageISO [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode]
//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


//RGB颜色
#define RGBF16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGB_A(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)


#define iOS7            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

/**
 *  打印在Debug情况下才会打印
 */
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif
/**
    打印  去图片名字
 */
#define NSSTRING(a)             [NSString stringWithFormat:@"%@",a];
#define IMAGE_NAMED(_pointer)   [UIImage imageNamed:@"_pointer"]
/**
 *  或者只是标记那一行
 */
#define MARK    NSLog(@"\nMARK: %s -- 第%d行", __PRETTY_FUNCTION__, __LINE__);


#define IS7(a,b)        (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?a:b)
#define Color(_String)          [UIColor colorwithHexString:_String];

#pragma mark - 坐标
//屏幕宽度和高度
#define SCREENHEIGHT           [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH            [UIScreen mainScreen].bounds.size.width

#define LEFT_X(a)               CGRectGetMinX(a.frame)         //控件左边面的X坐标
#define NW(a)               CGRectGetMaxX(a.frame)         //控件右面的X坐标
#define TOP_Y(a)                CGRectGetMinY(a.frame)         //控件上面的Y坐标
#define NH(a)                   CGRectGetMaxY(a.frame)         //控件下面的Y坐标

#define HEIGHT(a)               CGRectGetHeight(a.frame)      //控件的高度
#define WIDTH(a)                CGRectGetWidth(a.frame)        //控件的宽度
#define CENTER_X(a)             CGRectGetMidX(a.frame)         //控件的中心X坐标
#define CENTER_Y(a)             CGRectGetMidY(a.frame)         //控件的中心Y坐标

//屏幕宽度和高度
#define DEVICEHEIGHT5           [UIScreen mainScreen].bounds.size.height==568

#define HEIGHT5BILI   0.85
/**
 *  字体大小
 */

#pragma mark -  UIFont 字体大小
#define Font_12                 [UIFont systemFontOfSize:12.0];
#define Font_13                 [UIFont systemFontOfSize:13.0];
#define Font_14                 [UIFont systemFontOfSize:14.0];
#define Font_15                 [UIFont systemFontOfSize:15.0];
#define Font_16                 [UIFont systemFontOfSize:16.0];
#define Font_17                 [UIFont systemFontOfSize:17.0];
#define Font_20                 [UIFont systemFontOfSize:20.0];
#define Font_21                 [UIFont systemFontOfSize:21.0];

#define TYPE_NewRoman           @"Times New Roman"              //新罗马字体
#define TYPE_NewCourier         @"Courier New"                  //幼圆
#define TYPE_Verdana            @"Verdana"                      //Verdana类型
#define TYPE_HeitiSC            @"STHeitiSC-Medium"             //黑体简
#define TYPE_HNBold             @"HelveticaNeue-Bold"           //加粗
#define TYPE_123                @"STHeitiSC"                    //黑体简




#pragma mark - 文件
//NSUserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//获取本地文件
#define LOAD_IMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]


#pragma mark - Info.Plist
//plist文件内容
#define InfoPlistDic              [[NSBundle mainBundle] infoDictionary]
#define ReadInfoPlistDic(_name)    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)_name] //获取infoPlist文件中的 属性

#define AppVersion                  ReadInfoPlistDic(kCFBundleVersionKey)      //APP 版本
#define AppBundleIdentifier         ReadInfoPlistDic(kCFBundleIdentifierKey)   //
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[[NSDate date] timeIntervalSinceNow])


#endif

#endif
