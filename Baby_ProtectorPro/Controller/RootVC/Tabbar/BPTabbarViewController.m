//
//  BPTabbarViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/12.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPTabbarViewController.h"
#import "BPMainViewController.h"
#import "BPGuaerViewController.h"
#import "BPNewestViewController.h"
#import "BPPersonCenterViewController.h"
#import "BPDeviceViewController.h"

@interface BPTabbarViewController ()

@end

@implementation BPTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL isFirst = [IsFirst IsFirst];
    isFirst = NO;
           [Unit removeUserDefaultsObjForKey:@"countTime"];
        BPDeviceViewController*vc1 = [BPDeviceViewController new];
    
        BPMainViewController*vc2 = [BPMainViewController new];
//    BPGuaerViewController*vc2 = [BPGuaerViewController new];

    BPNewestViewController *vc3 = [BPNewestViewController new];
//    MryScrollPageVC*vc3 = [MryScrollPageVC new];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav1.tabBarItem.title = @"首页";
    nav1.tabBarItem.image = [[UIImage imageNamed:@"sy"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"sy-h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [nav1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    [nav1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:240/255.0 green:55/255 blue:88/255 alpha:0.8],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.tabBarItem.title = @"呱儿百科";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"bk"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    nav2.tabBarItem.selectedImage =[ [UIImage imageNamed:@"bk-h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [nav2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    [nav2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:240/255.0 green:55/255 blue:88/255 alpha:0.8],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav3.tabBarItem.title = @"新鲜事";
    nav3.tabBarItem.image = [[UIImage imageNamed:@"xxs"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
;

    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"xxs-h"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
;
    [nav3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
            [nav3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:240/255.0 green:55/255 blue:88/255 alpha:0.8],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];

    self.viewControllers = @[nav1,nav2,nav3];
}



@end
