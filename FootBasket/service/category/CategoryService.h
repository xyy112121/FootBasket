//
//  CategoryService.h
//  FootBasket
//
//  Created by xyy on 2018/2/7.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^CategorySuccessBlock)(NSDictionary *dicData);;

@interface CategoryService : RequestInterface

-(void)sendCategoryMainRequest:(NSString * )page PageSize:(NSString *)pagesize App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock;

-(void)sendCategorySmallRequest:(NSString * )page PageSize:(NSString *)pagesize CategoryId:(NSString *)categoryid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock;

-(void)sendCategoryGoodsRequest:(NSString * )page PageSize:(NSString *)pagesize SmallId:(NSString *)smallid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock;
@end
