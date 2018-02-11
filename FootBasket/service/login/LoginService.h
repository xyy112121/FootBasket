//
//  LoginService.h
//  FootBasket
//
//  Created by xyy on 2018/2/6.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^LoginSuccessBlock)(NSDictionary *dicData);

@interface LoginService : RequestInterface

-(void)sendVerifyCode:(NSString * )tel App:(AppDelegate *)app  ReqUrl:(NSString *)requrl;
-(void)sendloginrequest:(NSString * )tel Code:(NSString *)code App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(LoginSuccessBlock)successBlock;
@end
