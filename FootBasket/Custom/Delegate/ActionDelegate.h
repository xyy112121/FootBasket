//
//  ActionDele/Users/xyy/Desktop/工作/Other/世平(在线卖菜系统app)/code/ios/FootBasket/FootBasket/service/hpgate.h
//  KuaiPaiYunNan
//
//  Created by 谢 毅 on 13-6-18.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum_set.h"
#import "MKPeopleCellModel.h"
@protocol ActionDelegate<NSObject>
@optional

-(void)DGClickPayWay:(id)sender TitleName:(UILabel *)label;
-(void)DGLoginSuccess:(id)sender; //登录成功
-(void)DGClickCategorySmall:(NSDictionary *)sender;//点击小分类获取
-(void)DGCickSearchTextfield:(id)sender;//点击搜索
-(void)DGClickRecommendDetail:(NSDictionary *)sender;//点击精品推荐
-(void)DGAddShoppingCar:(NSDictionary *)sender;//点击添加到购物车
@end
