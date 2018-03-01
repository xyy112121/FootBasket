//
//  OrderService.m
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "OrderService.h"

@implementation OrderService

-(void)sendOrderListRequest:(NSString *)state UserId:(NSString *)userid Rows:(NSString *)rows App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:state forKey:@"deliveryState"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:rows forKey:@"rows"];
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

-(void)sendOrderDetailRequest:(NSString *)orderid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:orderid forKey:@"objectID"];
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

-(void)sendOrderDoneReceiveRequest:(NSString *)orderid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:orderid forKey:@"orderId"];
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
