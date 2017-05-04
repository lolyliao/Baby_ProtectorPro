//
//  BPDeviceViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/21.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPDeviceViewController.h"
#import "BPPersonView.h"
#import "BPMyExperienceViewController.h"
#import "SLSlideMenu.h"
#import "BPHealthJViewController.h"
#import "BPAlertSmiewController.h"
#import "BPSleepJianViewController.h"
#import "BPAddBabyViewController.h"
#import "BPShareExViewController.h"
#import "BPMycollectViewController.h"
#import "BPMyMusicViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>


#define RIGHTVIEW 250
@interface BPDeviceViewController ()<SLSlideMenuProtocol>

@property (nonatomic ,strong)UIImageView *showImage;

@property (nonatomic ,strong)UIButton *alertBtn;

@property (nonatomic ,strong)UIButton *sleepBtn;

@property (nonatomic ,strong)UIButton *bodyBtn;

@property (nonatomic ,strong)UIView*notiView;

@property (nonatomic ,strong)UIView*midView;

@property (nonatomic ,strong)UILabel *notiLabel;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)UISwitch *switchNoti;


@end

@implementation BPDeviceViewController{
    BPNavView *navBarView;
    BPPersonView *_personView;
    UIView *_backView;
    SLSlideMenu *_slide;
    NSString *_grtoken;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
_grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    _dataSource = [NSMutableArray array];
    self.view.backgroundColor =COLOR_BACKGRUNDE;
    

    
    //策划个人页面
    [self creatPersonView];
    
    [self CreateNav];
    [self creatUI];

    
    [self getToday];
    
    //   [self showHeadView];
}

-(void)getToday{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    [self requestData:DateTime];
}
#pragma mark 调用数据
-(void)requestData:(NSString *)DateTime{
    NSDictionary *dicParam;
    dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",DateTime,@"time",_grtoken,@"gr_token",nil];
    [BPHttpRequest postWithURLString:APPMAINURL parameters:dicParam success:^(id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if([responseObject[@"errcode"]isEqual:@"1"]){
                [Unit saveUserDefaultsObj:responseObject forKey:@"guoer"];
            }else if([responseObject[ERRCODE]isEqual:@"0"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE0);
            }else if([responseObject[ERRCODE]isEqual:@"2"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE2);
            }else if([responseObject[ERRCODE]isEqual:@"3"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE3);
            }else if([responseObject[ERRCODE]isEqual:@"4"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE4);
            }else if([responseObject[ERRCODE]isEqual:@"5"]){
                NSLog(@"错误信息是==%@---%@",responseObject[ERRCODE],CODE5);
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
}
#pragma mark - 自定义导航栏
-(void)CreateNav{
    navBarView = [[BPNavView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    [navBarView.backBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [navBarView.backBtn addTarget:self action:@selector(showPersonView) forControlEvents:UIControlEventTouchUpInside];
    navBarView.titleLab.text = @"贝贝";
    navBarView.backBtn.hidden = NO;
    [navBarView.backBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    navBarView.titleLab.font = [UIFont fontWithName:@"Arial" size:15];
    navBarView.ToplineView.hidden = NO;
     [navBarView.rightBtn setImage:[UIImage imageNamed:@"cutover"] forState:UIControlStateNormal];
    navBarView.backgroundColor= [UIColor colorwithHexString:@"#7ECEF4"];
    [navBarView.rightBtn addTarget:self action:@selector(shareUI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBarView];
}
-(void)shareUI{
    //显示分享面板
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//    }];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType];
        
//        [self runShareWithType:platformType];
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"呱儿递安" descr:@"国内外首家智能硬件+软件育婴类平台,专业、全面育婴类知识查询，一站式了解学习科学育儿,远程视频、相片存储、远程通话,宝宝发烧、尿裤提醒、孕检提醒、体检提醒、云数据健康分析、远程定位、生病应急处理，附近医院推送等智能应用, 妈妈圈育儿交流" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://guaerdian.com/web/begzh/index.php";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}
-(void)creatUI{
    [self.view addSubview:self.showImage];
     [self.view addSubview:self.midView];
    [self.midView addSubview:self.alertBtn];
    [self.midView addSubview:self.sleepBtn];
    [self.midView addSubview:self.bodyBtn];
    [self.view addSubview:self.notiView];
    [self.notiView addSubview:self.notiLabel];
    [self.notiView addSubview:self.switchNoti];
    
}
-(UIView *)midView{
    if(!_midView){
        _midView = [[UIView alloc]initWithFrame:CGRectMake(10, NH(self.showImage)+10, SCREENWIDTH-20, 190*DevicesScale)];
        _midView.backgroundColor = COLOR_WHITE;

    }
    return _midView;
}

#pragma mark  布局页面
-(UIImageView *)showImage{
    if(!_showImage){
        _showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, NH(navBarView), SCREENWIDTH, 190*DevicesScale)];
        _showImage.image = [UIImage imageNamed:@"headerimage"];
    }
    return _showImage;
}
-(UIButton *)alertBtn{
    if(!_alertBtn){
        _alertBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _alertBtn.frame = CGRectMake(0, 0, _midView.width/2, _midView.height);
        _alertBtn.backgroundColor = [UIColor whiteColor];
        _alertBtn.tag = 600;
        [_alertBtn addTarget:self action:@selector(clickbodyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *linevies  = [[UIView alloc]initWithFrame:CGRectMake(_alertBtn.width-2, 0, 2, _alertBtn.height)];
        linevies.backgroundColor = COLOR_BACKGRUNDE;
        [_alertBtn addSubview:linevies];

        
        UIImageView *alertImage = [[UIImageView alloc]initWithFrame:CGRectMake(_alertBtn.width/2, 75, 45, 80/2)];
        alertImage.center = CGPointMake(_alertBtn.width/2, 75);
        alertImage.image = [UIImage imageNamed:@"baojing"];
        [_alertBtn addSubview:alertImage];
        
        UILabel *alertLa = [[UILabel alloc]initWithFrame:CGRectMake(0, NH(alertImage), _alertBtn.width, 13)];
        alertLa.font =[UIFont fontWithName:@"Arial" size:11];
        alertLa.text = @"报警系统";
        alertLa.textColor = COLOR_9999;
        alertLa.textAlignment = NSTextAlignmentCenter;
        alertLa.center = CGPointMake(_alertBtn.width/2, NH(alertImage)+10);
          [_alertBtn addSubview:alertLa];
    }
    return _alertBtn;
}
-(UIButton *)sleepBtn{
    if(!_sleepBtn){
        _sleepBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _sleepBtn.frame = CGRectMake(_midView.width/2-1, 0, _midView.width/2, _midView.height/2);
        _sleepBtn.backgroundColor = [UIColor whiteColor];
        _sleepBtn.tag = 601;
        [_sleepBtn addTarget:self action:@selector(clickbodyBtn:) forControlEvents:UIControlEventTouchUpInside];
        //    [_notkonwBtn setTitle:@"不知道预产期?" forState:UIControlStateNormal];
        //    [_alertBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        UIView *midsLine  = [[UIView alloc]initWithFrame:CGRectMake(0, _sleepBtn.height-2, _sleepBtn.width, 2)];
        midsLine.backgroundColor = COLOR_BACKGRUNDE;
        [_sleepBtn addSubview:midsLine];
        
        UIImageView *alertImage = [[UIImageView alloc]initWithFrame:CGRectMake(_sleepBtn.width/2, 65, 48, 12)];
        alertImage.center = CGPointMake(_sleepBtn.width/2, 50);
        alertImage.image = [UIImage imageNamed:@"sleep"];
        [_sleepBtn addSubview:alertImage];
        
        UILabel *alertLa = [[UILabel alloc]initWithFrame:CGRectMake(0, NH(alertImage), _sleepBtn.width, 13)];
        alertLa.font =[UIFont fontWithName:@"Arial" size:11];
        alertLa.text = @"睡眠监测";
        alertLa.textColor = COLOR_9999;
        alertLa.textAlignment = NSTextAlignmentCenter;
        alertLa.center = CGPointMake(_sleepBtn.width/2, NH(alertImage)+10);
        [_sleepBtn addSubview:alertLa];
    }
    return _sleepBtn;
}
-(UIButton *)bodyBtn{
    if(!_bodyBtn){
        _bodyBtn= [UIButton buttonWithType:UIButtonTypeCustom];
         _bodyBtn.frame = CGRectMake(_midView.width/2-1, _midView.height/2, _midView.width/2, _midView.height/2);
        _bodyBtn.backgroundColor = [UIColor whiteColor];
        _bodyBtn.tag = 602;
        //    [_notkonwBtn setTitle:@"不知道预产期?" forState:UIControlStateNormal];
        [_bodyBtn addTarget:self action:@selector(clickbodyBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *alertImage = [[UIImageView alloc]initWithFrame:CGRectMake(_bodyBtn.width/2, 65, 33, 33)];
        alertImage.center = CGPointMake(_bodyBtn.width/2, 30);
        alertImage.image = [UIImage imageNamed:@"health"];
        [_bodyBtn addSubview:alertImage];
        
        UILabel *alertLa = [[UILabel alloc]initWithFrame:CGRectMake(0, NH(alertImage), _bodyBtn.width, 13)];
        alertLa.font =[UIFont fontWithName:@"Arial" size:11];
        alertLa.text = @"身体状况";
        alertLa.textColor = COLOR_9999;
        alertLa.textAlignment = NSTextAlignmentCenter;
        alertLa.center = CGPointMake(_bodyBtn.width/2, NH(alertImage)+10);
        [_bodyBtn addSubview:alertLa];
    }
    return _bodyBtn;
}
-(UIView *)notiView{
    if(!_notiView){
        _notiView =[[UIView alloc]initWithFrame:CGRectMake(10, _midView.BottomY+2,SCREENWIDTH-20, 45)];
        _notiView.backgroundColor = COLOR_WHITE;
    }
    return _notiView;
}
-(UILabel *)notiLabel{
    if(!_notiLabel){
        _notiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _notiView.width/2, _notiView.height)];
        _notiLabel.font =Font_14;
        _notiLabel.text = @"通知开启";
        _notiLabel.textColor = COLOR_9999;
        _notiLabel.backgroundColor = COLOR_WHITE;
    }
    return _notiLabel;
}
-(UISwitch *)switchNoti{
    if(!_switchNoti){
        _switchNoti = [[UISwitch alloc]initWithFrame:CGRectMake(_notiView.width-13-40, 5, 34*DevicesScale,17*DevicesScale)];;
        _switchNoti.on = YES;
        }
    return _switchNoti;
}
-(void)creatPersonView{
#pragma mark- 侧滑
    _personView = [[BPPersonView alloc]initWithFrame:CGRectMake(-SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
//    _personView.delegate = self;
    _personView.backgroundColor = [UIColor clearColor];
 

}
-(void)showPersonView{

    [SLSlideMenu slideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuDirectionLeft slideOffset:230*DevicesScale allowSwipeCloseMenu:YES aboveNav:YES identifier:@"left"];
}
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    if (slideMenu.direction == SLSlideMenuDirectionLeft) {
        _personView = [[BPPersonView alloc]initWithFrame:CGRectMake(0, 0, 230*DevicesScale, SCREENHEIGHT)];
        _personView.backgroundColor = [UIColor redColor];
              [menuView addSubview:_personView];
        __weak  typeof(BPPersonView ) * perView = _personView;
        perView.block = ^(NSInteger tag) {
                    [slideMenu hide];
            if(tag == 0){
                BPMyMusicViewController *exvc = [[BPMyMusicViewController alloc]init];
                exvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:exvc animated:YES];
            }else if (tag == 1){
                BPMycollectViewController *exvc = [[BPMycollectViewController alloc]init];
                exvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:exvc animated:YES];
                
            }else if (tag == 2){
        
                BPMyExperienceViewController *exvc = [[BPMyExperienceViewController alloc]init];
                exvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:exvc animated:YES];
                
            }else if (tag == 3){

            }else if (tag == 4){
                BPAddBabyViewController *exvc = [[BPAddBabyViewController alloc]init];
                exvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:exvc animated:YES];
            }else if (tag == 5){
                
            }else if (tag == 6){
                BPShareExViewController *exvc = [[BPShareExViewController alloc]init];
                exvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:exvc animated:YES];
            }
            
        };
    }
}
-(void)clickbodyBtn:(UIButton *)btn{
    if(btn.tag == 600){
        BPAlertSmiewController *health = [[BPAlertSmiewController alloc]init];
        health.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:health animated:YES];
    }else if(btn.tag == 601){
        BPSleepJianViewController *health = [[BPSleepJianViewController alloc]init];
        health.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:health animated:YES];
    }else{
        BPHealthJViewController *health = [[BPHealthJViewController alloc]init];
        health.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:health animated:YES];
    }

}
@end
