//
//  GoodsDetailService.h
//  FootBasket
//
//  Created by xyy on 2018/2/9.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^GoodsDetaiolSuccessBlock)(NSDictionary *dicData);

@interface GoodsDetailService : RequestInterface

//获取产品详情
-(void)sendGoodsDetailRequest:(NSString * )goodsid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(GoodsDetaiolSuccessBlock)successBlock;

//加入购物车
-(void)sendaddShoppingCarRequest:(NSString * )goodsid UserId:(NSString *)userid ProductNumber:(NSString *)productnumber App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(GoodsDetaiolSuccessBlock)successBlock;
@end
