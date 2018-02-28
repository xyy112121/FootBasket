//
//  SearchService.h
//  FootBasket
//
//  Created by xyy on 2018/2/28.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^SearchSuccessBlock)(NSDictionary *dicData);

@interface SearchService : RequestInterface
-(void)sendSearchProductRequest:(NSString *)searchtext Rows:(NSString *)rows App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SearchSuccessBlock)successBlock;
@end
