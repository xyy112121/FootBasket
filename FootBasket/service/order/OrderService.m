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
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

-(void)sendOrderDetailRequest:(NSString *)orderid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:orderid forKey:@"objectID"];
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
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

-(void)sendOrderDoneReceiveRequest:(NSString *)orderid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:orderid forKey:@"orderId"];
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
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

-(void)sendMyCouponOrderListRequest:(NSString *)userid Rows:(NSString *)rows App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:@"1" forKey:@"isCoupon"];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:rows forKey:@"rows"];
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
        [MBProgressHUD showError:@"获取优惠列表失败,请检查网络" toView:app.window];
    }];
}

-(void)sendMyOrderNumberRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
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
        [MBProgressHUD showError:@"获取优惠列表失败,请检查网络" toView:app.window];
    }];
}

@end
