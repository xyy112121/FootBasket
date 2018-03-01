//
//  HpService.m
//  FootBasket
//
//  Created by xyy on 2018/2/7.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "HpService.h"

@implementation HpService

-(void)sendRecommendRequest:(NSString * )page PageSize:(NSString *)pagesize App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"rows"];
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
        [MBProgressHUD showError:@"获取推荐商品列表失败,请检查网络" toView:app.window];
    }];
}

-(void)sendDiscountRequest:(NSString * )page PageSize:(NSString *)pagesize App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"rows"];
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
    } Failur:^(NSString *strmsg) {
        
        [MBProgressHUD showError:@"获取特惠商品列表失败,请检查网络" toView:app.window];
    }];
}

@end
