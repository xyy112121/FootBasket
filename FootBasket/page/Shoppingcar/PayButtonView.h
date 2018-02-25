//
//  PayButtonView.h
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayButtonView : UIView
{
    AppDelegate *app;
    UILabel *labeltitle;
    UIImageView *imageviewselect;

}
@property(nonatomic,strong)UIButton *buttonselect;
@property(nonatomic,weak)id<ActionDelegate>delegate1;
-(void)updateimageselect;
-(void)updateimageselected;
-(void)initviewbutton:(NSString *)str Alignment:(EnButtonTextAlignment)alignment;
@end
