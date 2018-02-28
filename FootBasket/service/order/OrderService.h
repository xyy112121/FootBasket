//
//  OrderService.h
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^OrderSuccessBlock)(NSDictionary *dicData);

@interface OrderService : RequestInterface

-(void)sendOrderListRequest:(NSString *)state UserId:(NSString *)userid  Rows:(NSString *)rows App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock;

-(void)sendOrderDetailRequest:(NSString *)orderid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock;


-(void)sendOrderDoneReceiveRequest:(NSString *)orderid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(OrderSuccessBlock)successBlock;
@end
