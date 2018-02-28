//
//  SearchService.m
//  FootBasket
//
//  Created by xyy on 2018/2/28.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "SearchService.h"

@implementation SearchService

-(void)sendSearchProductRequest:(NSString *)searchtext Rows:(NSString *)rows App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SearchSuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:searchtext forKey:@"productName"];
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
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        [PTLoadingHubView dismiss];
    } Failur:^(NSString *strmsg) {
        [PTLoadingHubView dismiss];
        [MBProgressHUD showError:@"获取商品详情失败,请检查网络" toView:app.window];
    }];
}

@end
