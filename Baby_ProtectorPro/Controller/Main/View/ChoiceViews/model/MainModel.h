//
//  MainModel.h
//  tableViewDemo
//
//  Created by 贺兵 on 17/4/17.
//  Copyright © 2017年 贺兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *condition;

@property (nonatomic, assign) BOOL open;
//详情
@property ( nonatomic , strong ) NSString *introLabel;
//详情
@property ( nonatomic , strong ) NSString *detailsLabel;
//头像
@property ( nonatomic , strong ) UIImageView *allowImage;

@property (nonatomic, assign) int cellHeigh; //cell的高度

//详情
@property ( nonatomic , strong ) NSArray *tArr;;

@property ( nonatomic , strong ) NSString * sort;
//详情
@property ( nonatomic , strong ) NSArray *bkClass;;

@end
