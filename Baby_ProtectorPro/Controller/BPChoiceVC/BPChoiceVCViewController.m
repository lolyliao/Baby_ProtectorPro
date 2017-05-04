//
//  BPChoiceVCViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/11.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPChoiceVCViewController.h"
#import "BPChoiceView.h"
#import "BPReadPreViewController.h"
#import "BPPregrantViewController.h"
#import "BPMomViewController.h"
#import "BPMainViewController.h"
#import "BPGuaerViewController.h"
#import "BPNewestViewController.h"
#import "BPPersonCenterViewController.h"
#import "BPTabbarViewController.h"


@interface BPChoiceVCViewController ()<ClickMainDelegte>{
     //  背景图
    UIImageView *_bigImageView;
    
    //白色背景
//    BPChoiceView *_bigWhiteView;
}
@property (nonatomic,strong) BPChoiceView *bigWhiteView;
@end

@implementation BPChoiceVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //实例化uiimageview
    [self creatImageView];
    
    //实例化白色背景
    [self creatWhiteView];
    


}

#pragma 实例化uiimageview
-(void)creatImageView{
    _bigImageView = [[UIImageView alloc]init];
    _bigImageView.userInteractionEnabled = YES;
    CGRect  rectImageB = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    _bigImageView.frame = rectImageB;
    UIImage *baidiImagB = [UIImage imageNamed:@"choice1.jpg"];
    _bigImageView.image = baidiImagB;
    [self.view addSubview:_bigImageView];
    
}
//-(BPChoiceView *)bigWhiteView{
//        if (_bigWhiteView == nil) {
//            _bigWhiteView = [[BPChoiceView alloc] init];
//        }
//        return _bigWhiteView;
//    
//}
-(void)creatWhiteView{
    _bigWhiteView = [[BPChoiceView alloc]init];
    _bigWhiteView = [[BPChoiceView alloc]initWithFrame:CGRectMake(20, 100, SCREENWIDTH-40, (934/2)*0.85)];
    if(DEVICEHEIGHT5){
        _bigWhiteView.height=  (934/2)*HEIGHT5BILI;
    }else{
         _bigWhiteView.height=  (934/2);
    }
    _bigWhiteView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    _bigWhiteView.layer.cornerRadius = 10;
    _bigWhiteView.layer.masksToBounds = YES;
    _bigWhiteView.delegate = self;
//    _bigWhiteView.alpha = 0.8;
    [_bigImageView addSubview:_bigWhiteView];
        __weak __typeof(BPChoiceView) *add= _bigWhiteView;
    add.block = ^(int tag) {
        if(tag == 0){
            /**
             *  备孕
             * param ;
             */

            BPReadPreViewController *RPvc = [[BPReadPreViewController alloc]init];
            __weak __typeof(BPChoiceVCViewController) *choice= self;
            [choice.navigationController pushViewController:RPvc animated:YES];
            
        }else if (tag == 1){
            /**
             *  准妈妈
             * param nil;
             */
            BPPregrantViewController *RPvc = [[BPPregrantViewController alloc]init];
            __weak BPChoiceVCViewController *choice = self;
            [choice.navigationController pushViewController:RPvc animated:YES];
        }else if (tag == 2){
            /**
             *  宝妈
             * param nil;
             */
            BPMomViewController *RPvc = [[BPMomViewController alloc]init];
            __weak BPChoiceVCViewController *choice = self;
            [choice.navigationController pushViewController:RPvc animated:YES];
        }
    };

}

-(void)ClickMain{
    BPTabbarViewController *tab = [[BPTabbarViewController alloc]init];
    [self.navigationController pushViewController:tab animated:YES];
    
}
@end
