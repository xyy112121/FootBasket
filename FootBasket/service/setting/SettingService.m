//
//  SettingService.m
//  FootBasket
//
//  Created by xyy on 2018/3/1.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "SettingService.h"

@implementation SettingService

-(void)sendGetUserInfoRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"objectID"];

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

-(void)sendUserInfoAvatarRequest:(NSString *)userid Avatar:(NSArray *)avatar App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"objectID"];
    
    [PTLoadingHubView show];
    [RequestInterface doGetJsonWithArraypic:avatar Parameter:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
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
        [MBProgressHUD showError:@"上传图片失败,请检查网络" toView:app.window];
    }];
}

-(void)sendrestaurantpicRequest:(NSString *)userid Name:(NSString *)name Address:(NSString *)address RestaurantPic:(NSArray *)restaurantpic App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:name forKey:@"name"];
    [params setObject:address forKey:@"address"];

    [PTLoadingHubView show];
    [RequestInterface doGetJsonWithArraypic:restaurantpic Parameter:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
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
        [MBProgressHUD showError:@"餐馆上传图片失败,请检查网络" toView:app.window];
    }];
}

-(void)sendGetRestaurangListRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    
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

-(void)sendGetRestaurangDetailRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"objectID"];
    
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

-(void)sendModifySettingRequest:(NSString *)userid Name:(NSString *)name NickName:(NSString *)nickname App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"objectID"];
    [params setObject:name forKey:@"realName"];
    [params setObject:nickname forKey:@"nickName"];
    
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

-(void)sendSetDefaultAddressRequest:(NSString *)objectid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:objectid forKey:@"objectID"];
    
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
