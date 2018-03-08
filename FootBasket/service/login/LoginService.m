//
//  LoginService.m
//  FootBasket
//
//  Created by xyy on 2018/2/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService

-(void)sendloginverifycoderequest:(NSString * )tel App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(LoginSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:tel forKey:@"mobile"];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"code"] isEqualToString:@"ok"])
        {
            successBlock(dic);
        }
        else
        {
           [MBProgressHUD showError:[dic objectForKey:@"resultInfo"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {

           [MBProgressHUD showError:@"请求验证码失败,请检查网络" toView:app.window];
    }];
}

-(void)sendloginrequest:(NSString * )tel Code:(NSString *)code App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(LoginSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:tel forKey:@"mobile"];
    [params setObject:code forKey:@"code"];
   // [PTLoadingHubView show];
    [XLBallLoading showInView:app.window];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            successBlock(dic);
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"resultInfo"] toView:app.window];
        }
        [XLBallLoading hideInView:app.window];
    } Failur:^(NSString *strmsg) {
        [XLBallLoading hideInView:app.window];
        [MBProgressHUD showError:@"登录失败,请检查网络" toView:app.window];
    }];
}

-(void)sendGetVersionrequest:(NSString * )type App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(LoginSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:type forKey:@"phoneType"];
    // [PTLoadingHubView show];
    [XLBallLoading showInView:app.window];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            successBlock(dic);
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"resultInfo"] toView:app.window];
        }
        [XLBallLoading hideInView:app.window];
    } Failur:^(NSString *strmsg) {
        [XLBallLoading hideInView:app.window];
        [MBProgressHUD showError:@"登录失败,请检查网络" toView:app.window];
    }];
}


@end
