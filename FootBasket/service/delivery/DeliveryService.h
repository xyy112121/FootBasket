//
//  DeliveryService.h
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^DeliverSuccessBlock)(NSDictionary *dicData);

@interface DeliveryService : RequestInterface


-(void)sendDeliveryListRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(GoodsDetaiolSuccessBlock)successBlock;

@end
