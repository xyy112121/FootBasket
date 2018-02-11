//
//  HpService.h
//  FootBasket
//
//  Created by xyy on 2018/2/7.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^DiscountSuccessBlock)(NSDictionary *dicData);;

@interface HpService : RequestInterface

-(void)sendRecommendRequest:(NSString * )page PageSize:(NSString *)pagesize App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock;

-(void)sendDiscountRequest:(NSString * )page PageSize:(NSString *)pagesize App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(DiscountSuccessBlock)successBlock;
@end
