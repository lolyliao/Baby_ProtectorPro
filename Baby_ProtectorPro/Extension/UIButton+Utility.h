//
//  UIButton+Utility.h
//  OC-Project
//
//  Created by liuxhui on 15/7/3.
//  Copyright (c) 2015年 刘小辉. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>
@interface UIButton (Utility)
/**
 *  扩展UIButton的方法
 *
 *  @param title
 */
- (void)normalTitle:(NSString *)title;  //正常状态
- (void)highltTitle:(NSString *)title;  //高亮
- (void)selectTitle:(NSString *)title;  //选中

- (void)normalTitleColor:(UIColor *)color;  //正常状态
- (void)highltTitleColor:(UIColor *)color;  //高亮
- (void)selectTitleColor:(UIColor *)color;  //选中

- (void)normalImage:(NSString *)imgName;// 正常
- (void)highltImage:(NSString *)imgName;//高亮
- (void)selectImage:(NSString *)imgName;//选中

- (void)left;   //button文字靠左
- (void)right;  //button文字靠右

@end
