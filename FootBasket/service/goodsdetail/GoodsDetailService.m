//
//  GoodsDetailService.m
//  FootBasket
//
//  Created by xyy on 2018/2/9.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "GoodsDetailService.h"

@implementation GoodsDetailService

//获取商品详情
-(void)sendGoodsDetailRequest:(NSString * )goodsid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(GoodsDetaiolSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:goodsid forKey:@"objectID"];
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

-(void)sendaddShoppingCarRequest:(NSString * )goodsid UserId:(NSString *)userid ProductNumber:(NSString *)productnumber App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(GoodsDetaiolSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:goodsid forKey:@"productBasicId"];
    [params setObject:userid forKey:@"userId"];
    [params setObject:productnumber forKey:@"productNumber"];
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
