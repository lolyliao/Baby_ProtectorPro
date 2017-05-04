//
//  IsFirst.h
//  FitMent
//
//  Created by zhaoyunru on 15/11/4.
//  Copyright © 2015年 LXH. All rights reserved.
//

#import "IsFirst.h"

@implementation IsFirst

+(BOOL)IsFirst{
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirst"];
    if(first==nil){
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"IsFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)IsFirstG{
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstG"];
    if(first==nil){
        [[NSUserDefaults standardUserDefaults] setObject:@"yesG" forKey:@"IsFirstG"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)IsFirstD{
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstD"];
    if(first==nil){
        [[NSUserDefaults standardUserDefaults] setObject:@"yesD" forKey:@"IsFirstD"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)IsFirstS{
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstS"];
    if(first==nil){
        [[NSUserDefaults standardUserDefaults] setObject:@"yesS" forKey:@"IsFirstS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)IsFirstT{
    NSString *first = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstT"];
    if(first==nil){
        [[NSUserDefaults standardUserDefaults] setObject:@"yesT" forKey:@"IsFirstT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}
@end
