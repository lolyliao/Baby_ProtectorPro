 //
//  BPMyMusicViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/22.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPMyMusicViewController.h"
#import "MusicManager.h"

@interface BPMyMusicViewController (){
    
    BPNavView *navBarView;
}
@property(nonatomic,strong)MusicManager *musicManager;

@end

@implementation BPMyMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =COLOR_BACKGRUNDE;
    
    
    [self CreateNav];
    
    _musicManager = [[MusicManager shareInfo]init];
    _musicManager.musicArray = @[@"http://stream10.qqmusic.qq.com/34833285.mp3"];
 
    
}

#pragma mark - 自定义导航栏
-(void)CreateNav{
    
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    [navBarView.backBtn addTarget:self action:@selector(showBack) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text = @"我的音乐";
    navBarView.backBtn.hidden = NO;
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
    [navBarView.rightBtn setImage:[UIImage imageNamed:@"cutover"] forState:UIControlStateNormal];
    navBarView.backgroundColor= [UIColor colorwithHexString:@"#7ECEF4"];
    [self.view addSubview:navBarView];
}
-(void)showBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
