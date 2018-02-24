//
//  ShoppingCarService.h
//  FootBasket
//
//  Created by xyy on 2018/2/8.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^ShoppingCarSuccessBlock)(NSDictionary *dicData);

@interface ShoppingCarService : RequestInterface


-(void)sendShoppingCarRequest:(NSString * )userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock;


-(void)sendShoppingCarDeleteRequest:(NSString * )ids App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock;

-(void)sendShoppingCarSettlementRequest:(NSString * )products Userid:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock;

-(void)sendCommitOrderRequest:(NSString * )products Userid:(NSString *)userid AddrId:(NSString *)addrid PayWay:(NSString *)payway DeliveryTime:(NSString *)deliverytime App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(ShoppingCarSuccessBlock)successBlock;


@end
