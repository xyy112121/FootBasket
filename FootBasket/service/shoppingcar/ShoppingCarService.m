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
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:requrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            successBlock(dic);
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"获取商品分类别列表失败,请检查网络" toView:app.window];
    }];
}

@end
