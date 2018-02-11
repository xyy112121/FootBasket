//
//  CategoryService.m
//  FootBasket
//
//  Created by xyy on 2018/2/7.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "CategoryService.h"

@implementation CategoryService

-(void)sendCategoryMainRequest:(NSString * )page PageSize:(NSString *)pagesize App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(CategorySuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"rows"];
    
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
        
        [MBProgressHUD showError:@"获取商品主要类别列表失败,请检查网络" toView:app.window];
    }];
}

-(void)sendCategorySmallRequest:(NSString * )page PageSize:(NSString *)pagesize CategoryId:(NSString *)categoryid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(CategorySuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"rows"];
    [params setObject:categoryid forKey:@"categoryId"];
    
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

-(void)sendCategoryGoodsRequest:(NSString * )page PageSize:(NSString *)pagesize SmallId:(NSString *)smallid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(CategorySuccessBlock)successBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:page forKey:@"page"];
    [params setObject:pagesize forKey:@"rows"];
    [params setObject:smallid forKey:@"categorySmallId"];
    
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
