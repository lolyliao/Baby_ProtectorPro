//
//  Unit.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/11.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "Unit.h"

@implementation Unit
//磁盘总大小
+ (CGFloat)diskofAllSizeMBytes{
    CGFloat size = 0.0;
    NSError* error;
    NSDictionary* dic = [[NSFileManager defaultManager]attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error : %@",error.localizedDescription);
#endif
    }else{
        NSNumber* number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}
@end
