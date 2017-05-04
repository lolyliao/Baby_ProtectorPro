//
//  SearchTool.m
//  yunwoke
//
//  Created by 史金亮 on 15/11/4.
//  Copyright © 2015年 Michael Hu. All rights reserved.
//

#import "SearchTool.h"
#define RecordCount 1000      //最多存储5条，自定义
#define SEARCH_HISTORY [[NSUserDefaults standardUserDefaults] arrayForKey:@"SearchHistory"]
@implementation SearchTool

+ (void)addSearchRecord:(NSString *)searchStr
{
    NSMutableArray *searchArray = [[NSMutableArray alloc]initWithArray:SEARCH_HISTORY];
    if (searchArray == nil) {
        searchArray = [[NSMutableArray alloc]init];
    } else if ([searchArray containsObject:searchStr]) {
        [searchArray removeObject:searchStr];
    } else if ([searchArray count] >= RecordCount) {
        [searchArray removeObjectsInRange:NSMakeRange(RecordCount - 1, [searchArray count] - RecordCount + 1)];
    }
    [searchArray insertObject:searchStr atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:searchArray forKey:@"SearchHistory"];
}

+ (NSArray *)getAllSearchHistory
{
    return SEARCH_HISTORY;
}

+ (void)clearAllSearchHistory
{
    [[NSUserDefaults standardUserDefaults] setObject:[[NSMutableArray alloc]init] forKey:@"SearchHistory"];
}

@end
