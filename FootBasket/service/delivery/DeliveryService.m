//
//  DeliveryService.m
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "DeliveryService.h"

@implementation DeliveryService

-(void)sendDeliveryListRequest:(NSString *)userid DeliveryState:(NSString *)deliverystate App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DeliverSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:deliverystate forKey:@"deliveryState"];
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

-(void)sendDeliveryDonePayRequest:(NSString *)orderid DeliveryUserId:(NSString *)deliveryuserid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DeliverSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:orderid forKey:@"orderId"];
    [params setObject:deliveryuserid forKey:@"deliveryUserId"];
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

@end
