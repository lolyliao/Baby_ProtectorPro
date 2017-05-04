//
//  AppDelegate.h
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/11.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WXDelegate <NSObject>


-(void)loginSuccessByCode:(NSString *)code;

@end
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>


@property (strong, nonatomic) UIWindow *window;

@property ( nonatomic , weak ) id <WXDelegate>  wxDelegate;



@end
