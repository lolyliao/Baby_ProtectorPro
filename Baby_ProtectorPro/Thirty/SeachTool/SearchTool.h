//
//  SearchTool.h
//  yunwoke
//
//  Created by 史金亮 on 15/11/4.
//  Copyright © 2015年 Michael Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTool : NSObject
@property (nonatomic, strong) NSMutableArray *SearchDataArray;

/**
 *    添加搜索历史
 *    @param searchStr 新加的输入条目
 */
+ (void)addSearchRecord:(NSString *)searchStr;

/**
 *    获取所有的搜索历史
 *    @return 搜索历史 字符数组
 */
+ (NSArray *)getAllSearchHistory;

/**
 *    清空搜索历史
 */
+ (void)clearAllSearchHistory;
@end
