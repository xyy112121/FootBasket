//
//  PayButtonView.m
//  FootBasket
//
//  Created by xyy on 2018/2/22.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "PayButtonView.h"

@implementation PayButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(0,(frame.size.height-20)/2, 60, 20)];
        labeltitle.text = @"方式";
        labeltitle.font = FONTN(15.0f);
        labeltitle.backgroundColor = [UIColor clearColor];
        labeltitle.textColor = COLORNOW(52, 52, 52);
        [self addSubview:labeltitle];
        
        imageviewselect = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labeltitle)+5, XYViewTop(labeltitle), 20, 20)];
        imageviewselect.image = LOADIMAGE(@"选区", @"png");
        [self addSubview:imageviewselect];
        
        _buttonselect = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonselect.frame = CGRectMake(0, XYViewTop(labeltitle)-10,frame.size.width, 40);
        [_buttonselect addTarget:self action:@selector(clickselectpayway:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonselect];
    }
    return self;
}

-(void)initviewbutton:(NSString *)str Alignment:(EnButtonTextAlignment)alignment
{
    CommonHeader *header = [CommonHeader new];
    CGSize size = [header CMGetlablesize:str Fwidth:100 Fheight:20 Sfont:FONTN(15.0f) Spaceing:3.0f];
    labeltitle.text = str;
    if(alignment == EnButtonTextLeft)
    {
        labeltitle.frame = CGRectMake(0, (XYViewHeight(self)-20)/2, size.width, 20);
    }
    else if(alignment == EnButtonTextRight)
    {
        labeltitle.frame = CGRectMake(XYViewWidth(self)-30-size.width, (XYViewHeight(self)-20)/2, size.width, 20);
    }
    else
    {
        labeltitle.frame = CGRectMake((XYViewWidth(self)-(30+size.width))/2, (XYViewHeight(self)-20)/2, size.width, 20);
    }
    imageviewselect.frame = CGRectMake(XYViewR(labeltitle)+5, XYViewTop(labeltitle), 20, 20);
}

-(void)updateimageselect
{
    imageviewselect.image = LOADIMAGE(@"选区", @"png");
}

-(void)clickselectpayway:(id)sender
{
    imageviewselect.image = LOADIMAGE(@"选择框选中", @"png");
    if(_delegate1 &&[_delegate1 respondsToSelector:@selector(DGClickPayWay:TitleName:)])
    {
        [_delegate1 DGClickPayWay:imageviewselect TitleName:labeltitle];
    }
}

@end
