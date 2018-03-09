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
    
    textfieldinput = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5, XYViewTop(imagebg)+1, XYViewWidth(imagebg)-40, XYViewHeight(imagebg)-2)];
    textfieldinput.font = FONTN(15.0f);
    textfieldinput.delegate = self;
    textfieldinput.placeholder = @"搜索";
    textfieldinput.backgroundColor = [UIColor clearColor];
    [self addSubview:textfieldinput];
    
    _buttondiscovery = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttondiscovery.frame = CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
    [_buttondiscovery setImage:LOADIMAGE(@"活动", @"png") forState:UIControlStateNormal];
    [_buttondiscovery addTarget:self action:@selector(gotodiscovery:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttondiscovery];
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
    
    textfieldinput = [[UITextField alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5, XYViewTop(imagebg)+1, XYViewWidth(imagebg)-40, XYViewHeight(imagebg)-2)];
    textfieldinput.font = FONTN(15.0f);
    textfieldinput.delegate = self;
    textfieldinput.placeholder = @"输入产品名称";
    textfieldinput.backgroundColor = [UIColor clearColor];
    [self addSubview:textfieldinput];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == textfieldinput)
    {
        if(_delegate1 && [_delegate1 respondsToSelector:@selector(DGCickSearchTextfield:)])
        {
            [_delegate1 DGCickSearchTextfield:textField.text];
        }
        return NO;
    }
    return YES;
    
}

-(void)gotodiscovery:(id)sender
{
    if(_delegate1 && [_delegate1 respondsToSelector:@selector(DGClickHpDiscovery:)])
    {
        [_delegate1 DGClickHpDiscovery:sender];
    }
}

@end
