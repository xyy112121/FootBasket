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
    EnMiddleMenuLeft,   //左边菜单
    EnMiddleMenuRight    //右边菜单
}EnMiddleMenuDirect;

typedef enum
{
    EnHpageView,   //首页菜单
    EnAssembly,    //部件菜单
    EnBookManual,  //手册
    EnSetting      //设置
}EnHpageItem;

typedef enum
{
    EnHpMiddleMenuNone,//无图纸
    EnHpUserDrawings,//用户图纸
    EnHpMaintainSys,//维护系统
    EnHpExamSys,//考试系统
    EnHpServicePlan,//维修计划
    EnHpServiceManual,//维修手册
    EnHpOverhaulManual //检修手册
}EnHpMiddleMenuItem;

typedef enum
{
    EnHpBottomMenuNone,//无模型
    EnHpBottomMenuVehicle,//整车
    EnHpBottomMenuBogie,//转向架
    EnHpBottomMenuVehicleBody,//车体
    EnHpBottomMenuBraking,//制动
    EnHpBottomMenuInDecoration,//内装
    EnHpBottomMenuDoor, //车门
    EnHpBottomMenuLink,//车端连接
    EnHpBottomMenuWarmSys,//暖通系统
    EnHpBottomMenuEleEquipment  //电器设备
}EnHpBottomMenuItem;

#define EnCategoryTopBtTag     5000 //分类buttontag
#define EnHpDiscountImageViewTag   5100//首页特优惠imagetag
#define EnHpDiscountShopCarBtTag   5300//首页特优惠购物车按钮
#define EnHpRecommendImageViewTag   5500//首页推荐image tag
#define EnHpRecommendShopCarBtTag   5600//首页推荐购物车按钮
#define EnHpNavigationBgTag   5700//首页导航栏背景
#endif /* Enum_set_h */




