//
//  BPRootViewController.m
//  Baby_ProtectorPro
//
//  Created by Macx on 2017/4/11.
//  Copyright © 2017年 Baby_Protector. All rights reserved.
//

#import "BPRootViewController.h"
#import "BPChoiceVCViewController.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import "BPTabbarViewController.h"

//微信开发者ID
#define URL_APPID @"wx845cdfd9ee53d65f"
#define URL_SECRET @"084f9b3365a960f1b2a5092a342664d3"

@interface BPRootViewController ()<WXDelegate> {

    //设置2个图片变量，显示图片
    UIImageView *_baidiImageV;
    
    UIImageView *_grayFimageV;
    /**
     *  背景图
     * param nil;
     */
      UIImageView *_bigImageView;
    //设置一个微信登录按钮
    UIButton *_weixinBtn;
    
    AppDelegate *appdelegate;
    NSString *_grtoken;
    
    NSString *_expiretime;

}
/** 通过block去执行AppDelegate中的wechatLoginByRequestForUserInfo方法 */
@property (copy, nonatomic) void (^requestForUserInfoBlock)();

@end

@implementation BPRootViewController
-(void)viewWillAppear:(BOOL)animated{
    BOOL isFirst = [IsFirst IsFirst];
    isFirst = YES;
#pragma mark  删除token
      [Unit removeUserDefaultsObjForKey:@"gr_token"];
     [Unit removeUserDefaultsObjForKey:@"countTime"];
         [Unit removeUserDefaultsObjForKey:@"pregrant"];
       [Unit saveUserDefaultsInt:1 forKey:@"countTime"];
             [Unit removeUserDefaultsObjForKey:@"pretime"];
    
    
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    NSLog(@"token是%@",_grtoken);
    
      _expiretime = [Unit getUserDefaultsObjForKey:@"expire_time"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //原有的导航栏隐藏
    self.navigationController.navigationBar.hidden = YES;
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
        //实例化uiimageview
    [self creatImageView];
    
    //实例化微信登录
    [self creatWeixinLoginBtn];
      
}

#pragma 实例化uiimageview
-(void)creatImageView{
    _bigImageView = [[UIImageView alloc]init];
    CGRect  rectImageB = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    _bigImageView.frame = rectImageB;
    _bigImageView.userInteractionEnabled = YES;
    UIImage *baidiImagB = [UIImage imageNamed:@"WechatIMG2"];
    _bigImageView.image = baidiImagB;
    [self.view addSubview:_bigImageView];

}

#pragma 实例化微信登录
-(void)creatWeixinLoginBtn{
    _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _weixinBtn.frame = CGRectMake(60, SCREENHEIGHT-80, SCREENWIDTH - 120, 50);
    _weixinBtn.backgroundColor = [UIColor colorWithRed:144/255.0 green:193/255.0 blue:50/255.0 alpha:0.6];
    [_weixinBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    _weixinBtn.layer.cornerRadius = 25;
    _weixinBtn.layer.masksToBounds = YES;
    [_weixinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bigImageView addSubview:_weixinBtn];
    [_weixinBtn addTarget:self action:@selector(HandleToWXlog) forControlEvents:UIControlEventTouchUpInside];

}
/**
 *  微信登录接口
 */

-(void)HandleToWXlog{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.openID = URL_APPID;
        req.state = @"1245";
      appdelegate = [UIApplication sharedApplication].delegate;
        appdelegate.wxDelegate = self;
        [WXApi sendReq:req];
    }else{
        //把微信登录的按钮隐藏掉。
            [_weixinBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    }
}
#pragma mark 微信登录回调。
-(void)loginSuccessByCode:(NSString *)code{
    NSLog(@"code %@",code);
    __weak typeof(*&self) weakSelf = self;
    NSString *guoqi= [Unit getUserDefaultsObjForKey:@"guoqi"];
    NSString * refresh_token = [Unit getUserDefaultsObjForKey:@"refresh_token"];
    NSString *url ;
    NSDictionary *dicParam;
    //如果过期
    if([guoqi isEqualToString:@"guoqi"]){
       url =@"https://api.weixin.qq.com/sns/oauth2/refresh_token";
        dicParam = [NSDictionary dictionaryWithObjectsAndKeys:
                    URL_APPID,@"appid",
                    URL_SECRET,@"secret",
                    @"refresh_token",@"grant_type",
                   refresh_token,@"refresh_token",nil];
    }else{
     url =@"https://api.weixin.qq.com/sns/oauth2/access_token";
        dicParam = [NSDictionary dictionaryWithObjectsAndKeys:
                    URL_APPID,@"appid",
                    URL_SECRET,@"secret",
                    code,@"code",
                    @"authorization_code",@"grant_type",nil];
    }
    [BPHttpRequest postWithURLString:url parameters:dicParam success:^(id responseObject) {
        
        NSLog(@"收到的数据 %@",responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]){
            /*
             access_token   接口调用凭证
             expires_in access_token接口调用凭证超时时间，单位（秒）
             refresh_token  用户刷新access_token
             openid 授权用户唯一标识
             scope  用户授权的作用域，使用逗号（,）分隔
             unionid     当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
             */
            NSDictionary *dic = responseObject;
            NSString* accessToken=[dic valueForKey:@"access_token"];
            NSString* openID=[dic valueForKey:@"openid"];
            [Unit saveUserDefaultsObj:responseObject[@"access_token"] forKey:@"access_token"];
            [Unit saveUserDefaultsObj:responseObject[@"openid"] forKey:@"openid"];
            [Unit saveUserDefaultsObj:responseObject[@"refresh_token"] forKey:@"refresh_token"];
            [weakSelf requestUserInfoByToken:accessToken andOpenid:openID];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"错误信息 %@",error);
        
    }];
}
-(void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID{
    NSString *url =@"https://api.weixin.qq.com/sns/userinfo";
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:
                              token,@"access_token",
                              openID,@"openid",nil];
    [BPHttpRequest postWithURLString:url parameters:dicParam success:^(id responseObject) {
        
        NSLog(@"收到的数据 %@",responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]){
                   NSLog(@"dic  ==== %@",responseObject);
            [self requestData:responseObject];
        }
        
    } failure:^(NSError *error) {
              NSLog(@"error %ld",(long)error.code);
        
    }];
}
#pragma mark - 设置弹出提示语
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 *  调用数据
 */
#pragma mark  调取数据
-(void)requestData:(NSDictionary *)dic{
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"1",@"type",
                              dic[@"openid"],@"openid",
                              dic[@"unionid"],@"unionid",
                              dic[@"nickname"],@"nickname",
                              dic[@"sex"],@"sex",
                              dic[@"province"],@"province",
                               dic[@"city"],@"city",
                               dic[@"country"],@"country",
                               dic[@"headimgurl"],@"headimgurl",  nil];
    if(_grtoken .length <= 0){
        [BPHttpRequest postWithURLString:APPUSEURL parameters:dicParam success:^(id responseObject) {
            
            NSLog(@"收到的数据 %@",responseObject);
            if([responseObject isKindOfClass:[NSDictionary class]]){
                [Unit saveUserDefaultsObj:responseObject[@"gr_token"] forKey:@"gr_token"];
                [Unit saveUserDefaultsObj:responseObject[@"expire_time"] forKey:@"expire_time"];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"错误信息 %@",error);
            
        }];
    }
    _grtoken = [Unit getUserDefaultsObjForKey:@"gr_token"];
    [self requesPer];

    
}
-(void)requesPer{
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *DateTime = [formatter stringFromDate:date];
        NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",DateTime,@"time",_grtoken,@"gr_token",nil];
        NSLog(@"提交的数据===%@",dicParam);
        [BPHttpRequest postWithURLString:APPMAINURL parameters:dicParam success:^(id responseObject) {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                NSLog(@"从微信登录获取的数据%@",responseObject);
                if([responseObject[@"errcode"]isEqual:@"1"]){
        
                          [Unit saveUserDefaultsObj:responseObject forKey:@"guoer"];
                    if([responseObject[@"active"]isEqual:@"0"]){
             
                        BPChoiceVCViewController *RPvc = [[BPChoiceVCViewController alloc]init];
                        __weak __typeof(BPRootViewController) *choice= self;
                        [choice.navigationController pushViewController:RPvc animated:YES];
                    }else{
                        BPTabbarViewController *tab = [[BPTabbarViewController alloc]init];
                        tab.active = responseObject[@"active"];
                        tab.hidesBottomBarWhenPushed = YES;
                        
                        [self.navigationController pushViewController:tab animated:YES];
                    }
              
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
@end
