//
//  HpNavigationView.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "HpNavigationView.h"

@implementation HpNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void)initViewHP
{
    UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonleft.frame = CGRectMake(10, 2, 40, 40);
    [buttonleft setImage:LOADIMAGE(@"hpicon", @"png") forState:UIControlStateNormal];
    [self addSubview:buttonleft];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(buttonleft)+10,(XYViewHeight(self)-28)/2, XYViewWidth(self)-120, 28)];
    imagebg.layer.cornerRadius = 14.0f;
    imagebg.clipsToBounds = YES;
    imagebg.layer.borderColor = COLORNOW(32, 188, 167).CGColor;
    imagebg.layer.borderWidth = 1.0f;
    [self addSubview:imagebg];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(imagebg)+10,XYViewTop(imagebg)+6, 16, 16)];
    imageicon.image = LOADIMAGE(@"searchicon", @"png");
    [self addSubview:imageicon];
    
    UITextField *textfieldcode = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5, XYViewTop(imagebg)+1, XYViewWidth(imagebg)-40, XYViewHeight(imagebg)-2)];
    textfieldcode.font = FONTN(15.0f);
    textfieldcode.delegate = self;
    textfieldcode.placeholder = @"搜索";
    textfieldcode.backgroundColor = [UIColor clearColor];
    
    [self addSubview:textfieldcode];
    
    UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.frame = CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
    [buttonright setImage:LOADIMAGE(@"消息", @"png") forState:UIControlStateNormal];
    [self addSubview:buttonright];
}

-(void)initViewCategory
{
    UIButton *buttonleft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonleft.frame = CGRectMake(10, 2, 40, 40);
    [buttonleft setImage:LOADIMAGE(@"hpicon", @"png") forState:UIControlStateNormal];
    [self addSubview:buttonleft];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(buttonleft)+10,(XYViewHeight(self)-28)/2, XYViewWidth(self)-70, 28)];
    imagebg.layer.cornerRadius = 14.0f;
    imagebg.clipsToBounds = YES;
    imagebg.layer.borderColor = COLORNOW(32, 188, 167).CGColor;
    imagebg.layer.borderWidth = 1.0f;
    [self addSubview:imagebg];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(imagebg)+10,XYViewTop(imagebg)+6, 16, 16)];
    imageicon.image = LOADIMAGE(@"searchicon", @"png");
    [self addSubview:imageicon];
    
    UITextField *textfieldcode = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5, XYViewTop(imagebg)+1, XYViewWidth(imagebg)-40, XYViewHeight(imagebg)-2)];
    textfieldcode.font = FONTN(15.0f);
    textfieldcode.delegate = self;
    textfieldcode.placeholder = @"输入产品名称";
    textfieldcode.backgroundColor = [UIColor clearColor];
    [self addSubview:textfieldcode];
}

@end
