//
//  Unit.h
//  FMDB-demo
//
//  Created by apple on 14-11-12.
//  Copyright (c) 2014年 LXH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Unit : NSObject

+ (void)showAlert:(NSString *)message;
+ (void)removeAlert:(NSTimer *)timer;
+ (void)showNetFail;
// ***  存本地数据  *** //
+ (BOOL)saveUserDefaultsObj:(id)obj forKey:(NSString *)key;
// ***  取本地数据  *** //
+ (id)getUserDefaultsObjForKey:(NSString *)key;
// ***  移除本地数据  *** //
+ (BOOL)removeUserDefaultsObjForKey:(NSString *)key;

+ (BOOL)saveUserDefaultsInt:(NSInteger)obj forKey:(NSString *)key;
+ (NSInteger)getUserDefaultsIntForKey:(NSString *)key;


+(NSString *)RefrshTheData:(id)string;

//创建UILabel
+ (UILabel*)createLable:(CGRect)frame withName:(NSString *)name withFont:(CGFloat)font textAlignt:(NSString *)alignt;
//创建UIButton
+(UIButton*)creatButton:(CGRect)frame withName:(NSString*)name normalImg:(UIImage*)normalImg highlightImg:(UIImage*)highlightImg selectImg:(UIImage*)selectImg;
//创建UITextField
+ (UITextField *)createTextField:(CGRect)frame withPlaceholder:(NSString *)placeholder;
//创建UITableView
+ (UITableView *)createTableView:(CGRect)frame withDelegate:(id)delegate;
//创建UIImageView
+ (UIImageView *)createImageView:(CGRect)frame isRound:(BOOL)isRound;
//创建UIScrollView
+ (UIScrollView *)createScrollView:(CGRect)frame withDelegate:(id)delegate withContentSize:(CGSize)contentSize;
//+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;
#pragma mark -- image的翻转
+ (UIImage *)rotateImage:(UIImage *)aImage;
//判断手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (void)showHint:(NSString *)hint;

+ (BOOL)checkEmail:(NSString *)email;

+ (void)showHud:(UIView *)view title:(NSString *)title animated:(BOOL)isAnimated;


+ (void)hideHud:(UIView *)view animated:(BOOL)animated;

+ (void)showAlertViewWithTitle:(NSString*)title  messsage:(NSString*)message;
/**
 *  利用SDWebImage去根据url获取本地缓存图片
 */
+ (UIImage *)getImageWithUrl:(NSString *)strUrl;

//显示提示框
+ (void)showAlert:(NSString*)message;

+(NSMutableDictionary *)setPictureAdd:(NSDictionary *)sendDictionary;

/**
 *  @author guilin, 15-03-15 22:03:35
 *
 *  显示网络不给力，然后自动移除
 *
 *  @param views 传入要显示的views
 */
+ (void)showMessage:(UIView *)views;

/**
 *  @author guilin, 15-03-14 10:03:36
 *
 *  没网络，动画
 *
 *  @param views
 */
+(void)showNote:(UIView *)views;


/**
 *  @author guilin, 15-03-15 22:03:51
 *
 *  自定义显示，然后自动移除
 *
 *  @param views
 *  @param message 传入显示字符
 */
+(void)showMessage:(UIView *)views withMessage:(NSString *)message;


+ (NSString *)convertToTime:(NSString *)addTime;
+ (NSString *)convertToTimeWithSecond:(NSString *)addTime;
+ (NSString *)convertToUTCTime:(NSString *)addTime;
#pragma mark --计算Lable高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

+(void)CreatView:(UIView *)_ViewName Color:(UIColor *)color;

#pragma mark --  Lable单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text;
#pragma mark - layer封装
+(void)CreatView:(UIView *)_ViewName Color:(UIColor *)color cornerRadius:(NSInteger)cornerRadius;
//多少分前
+ (NSString *)compareCurrentTime:(NSString *)str;
//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;


@end
