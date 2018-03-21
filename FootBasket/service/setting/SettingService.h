//
//  SettingService.h
//  FootBasket
//
//  Created by xyy on 2018/3/1.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RequestInterface.h"

typedef void (^SettingSuccessBlock)(NSDictionary *dicData);
@interface SettingService : RequestInterface

-(void)sendGetUserInfoRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

-(void)sendUserInfoAvatarRequest:(NSString *)userid Avatar:(NSArray *)avatar App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

-(void)sendrestaurantpicRequest:(NSString *)userid Name:(NSString *)name Address:(NSString *)address RestaurantPic:(NSArray *)restaurantpic App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

-(void)sendGetRestaurangListRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

-(void)sendGetRestaurangDetailRequest:(NSString *)userid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

//修改用户信息
-(void)sendModifySettingRequest:(NSString *)userid Name:(NSString *)name NickName:(NSString *)nickname App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

//设置默认地址
-(void)sendSetDefaultAddressRequest:(NSString *)objectid App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;

//申请成为餐饮用户
-(void)sendStorebussiseRequest:(NSString *)userid Name:(NSString *)name StoreName:(NSString *)storename App:(AppDelegate *)app  ReqUrl:(NSString *)requrl successBlock:(SettingSuccessBlock)successBlock;
@end
