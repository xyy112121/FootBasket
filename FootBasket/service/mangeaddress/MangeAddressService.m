//
//  MangeAddressService.m
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "MangeAddressService.h"

@implementation MangeAddressService

-(void)sendAddNewAddressRequest:(NSString * )provice City:(NSString *)city Area:(NSString *)area Address:(NSString *)address Tel:(NSString *)tel IsDefault:(NSString *)isdefault UserName:(NSString *)username UserId:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:provice forKey:@"province"];
    [params setObject:city forKey:@"city"];
    [params setObject:area forKey:@"county"];
    [params setObject:address forKey:@"address"];
    [params setObject:tel forKey:@"mobile"];
    [params setObject:username forKey:@"userName"];
    [params setObject:isdefault forKey:@"defaultAdr"];
    [params setObject:app.userinfo.userid forKey:@"userId"];
    [PTLoadingHubView show];
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
        [PTLoadingHubView dismiss];
    } Failur:^(NSString *strmsg) {
        [PTLoadingHubView dismiss];
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

-(void)sendAddrListRequest:(NSString * )userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:app.userinfo.userid forKey:@"userId"];
    [PTLoadingHubView show];
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
        [PTLoadingHubView dismiss];
    } Failur:^(NSString *strmsg) {
        [PTLoadingHubView dismiss];
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

-(void)sendUpdateAddressRequest:(NSString * )provice City:(NSString *)city Area:(NSString *)area Address:(NSString *)address Tel:(NSString *)tel IsDefault:(NSString *)isdefault UserName:(NSString *)username ObjectId:(NSString *)objectID App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:provice forKey:@"province"];
    [params setObject:city forKey:@"city"];
    [params setObject:area forKey:@"county"];
    [params setObject:address forKey:@"address"];
    [params setObject:tel forKey:@"mobile"];
    [params setObject:username forKey:@"userName"];
    [params setObject:isdefault forKey:@"defaultAdr"];
    [params setObject:objectID forKey:@"objectID"];
    [PTLoadingHubView show];
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
        [PTLoadingHubView dismiss];
    } Failur:^(NSString *strmsg) {
        [PTLoadingHubView dismiss];
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

-(void)sendDeleteAddressRequest:(NSString *)objectID App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:objectID forKey:@"objectID"];
    [PTLoadingHubView show];
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
        [PTLoadingHubView dismiss];
    } Failur:^(NSString *strmsg) {
        [PTLoadingHubView dismiss];
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}


@end
