//
//  Enum_set.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/5.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#ifndef Enum_set_h
#define Enum_set_h

typedef enum
{
    EnButtonTextLeft,   //左对齐
    EnButtonTextCenter, //中间对齐
    EnButtonTextRight   //右对齐
}EnButtonTextAlignment;

typedef enum
{
    EnShoppingCarNotSelect,   //未选中
    EnShoppingCarSelected   //已选中
}EnShoppingCarSelectDelete;

typedef enum
{
    EnNotSelect,   //未选中
    EnSelected   //已选中
}EnSelect;

typedef enum
{
    EnNormalSelect,   //普通 用户
    EnDeliverySelected   //送货员
}EnUserTypeLogin;

#define EnCategoryTopBtTag     5000 //分类buttontag
#define EnHpDiscountImageViewTag   5100//首页特优惠imagetag
#define EnHpDiscountShopCarBtTag   5300//首页特优惠购物车按钮
#define EnHpRecommendImageViewTag   5500//首页推荐image tag
#define EnHpRecommendShopCarBtTag   5600//首页推荐购物车按钮
#define EnHpNavigationBgTag   5700//首页导航栏背景
#define EnShopCarDeleteBtTag 5800 //购物车删除按钮

#define EnShopCarReduceBtTag  5900 //购物车减少数量
#define EnShopCarAddBtTag  6000 //购物车增加数量
#define EnShopCarLabelNumTag  6100 //购物车显示数量

#define EnDoneOrderPayWayImageTag  6200 //确认订单付款方式按钮

#define EnMyAddrListDefaultBtTag 6300 //设置默认按钮
#define EnMyNewAddrTextfieldTag 6400 //填写地址信息

#define EnSearchNavigationBgViewTag 6500 //搜索背景

#define EnShoppingCarDeleteViewBgTag 6600 //搜索背景

#define EnMyOrderListStateBtTag 6700 //搜索背景

#define EnMyCategoryProductShopCarTag 6800 //分类里面点击购物车按钮

#define EnSearchProductListTag 6900

#define EnUserInfoAvatarTag 7000

#define EnMyAddrEditBtTag 7100 //编辑地址

#define EnMyAddrDeleteBtTag 7200 //删除地址

#define EnModifyTextfieldValue 7300 //编辑信息textfield

#endif /* Enum_set_h */




