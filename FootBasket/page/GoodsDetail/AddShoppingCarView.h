//
//  AddShoppingCarView.h
//  FootBasket
//
//  Created by xyy on 2018/2/28.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddShoppingCarView : UIView
{
    AppDelegate *app;
    NSDictionary *dicfrom;
}
@property(nonatomic,weak)id<ActionDelegate>delegate1;
- (instancetype)initWithFrame:(CGRect)frame DicRecommend:(NSDictionary *)dic;
@end
