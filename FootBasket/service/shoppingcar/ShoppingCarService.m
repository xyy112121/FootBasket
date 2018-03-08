//
//  ShoppingCarService.m
//  FootBasket
//
//  Created by xyy on 2018/2/8.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "ShoppingCarService.h"

@implementation ShoppingCarService

-(void)sendShoppingCarRequest:(NSString * )userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock
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
        [MBProgressHUD showError:@"获取商品分类别列表失败,请检查网络" toView:app.window];
    }];
}

-(void)sendShoppingCarDeleteRequest:(NSString * )ids App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ids forKey:@"ids"];
    [XLBallLoading showInView:app.window];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"resultInfo"] toView:app.window];
            successBlock(dic);
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"resultInfo"] toView:app.window];
        }
        [XLBallLoading hideInView:app.window];
    } Failur:^(NSString *strmsg) {
        [XLBallLoading hideInView:app.window];
        [MBProgressHUD showError:@"获取商品分类别列表失败,请检查网络" toView:app.window];
    }];
}

-(void)sendShoppingCarSettlementRequest:(NSString * )products Userid:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:products forKey:@"products"];
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
        [MBProgressHUD showError:@"获取商品分类别列表失败,请检查网络" toView:app.window];
    }];
}

-(void)sendCommitOrderRequest:(NSString * )products Userid:(NSString *)userid AddrId:(NSString *)addrid PayWay:(NSString *)payway DeliveryTime:(NSString *)deliverytime App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userId"];
    [params setObject:products forKey:@"products"];
    [params setObject:addrid forKey:@"addressId"];
    [params setObject:payway forKey:@"payChannel"];
    [params setObject:deliverytime forKey:@"deliveryTime"];
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
        [MBProgressHUD showError:@"获取商品分类别列表失败,请检查网络" toView:app.window];
    }];
}

@end
