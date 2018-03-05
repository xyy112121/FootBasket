//
//  MangeAddressService.h
//  FootBasket
//
//  Created by xyy on 2018/2/24.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^MangeAddressSuccessBlock)(NSDictionary *dicData);

@interface MangeAddressService : RequestInterface

-(void)sendAddNewAddressRequest:(NSString * )provice City:(NSString *)city Area:(NSString *)area Address:(NSString *)address Tel:(NSString *)tel IsDefault:(NSString *)isdefault UserName:(NSString *)username UserId:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock;

-(void)sendAddrListRequest:(NSString * )userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock;


-(void)sendUpdateAddressRequest:(NSString * )provice City:(NSString *)city Area:(NSString *)area Address:(NSString *)address Tel:(NSString *)tel IsDefault:(NSString *)isdefault UserName:(NSString *)username ObjectId:(NSString *)objectID App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock;

-(void)sendDeleteAddressRequest:(NSString *)objectID App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(MangeAddressSuccessBlock)successBlock;
@end
