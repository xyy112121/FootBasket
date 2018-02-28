//
//  AddShoppingCarView.m
//  FootBasket
//
//  Created by xyy on 2018/2/28.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "AddShoppingCarView.h"

@implementation AddShoppingCarView

- (instancetype)initWithFrame:(CGRect)frame DicRecommend:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
        self.layer.borderWidth = 0.5f;
        DLog(@"dic====%@",dic);
        [self setinitView:dic];
        dicfrom = dic;
    }
    return self;
}


-(void)setinitView:(NSDictionary *)dictemp
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(self));
    button.backgroundColor = [UIColor blackColor];
    button.alpha = 0.2;
    [button addTarget:self action:@selector(removepopbuyview:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIImageView *viewbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewHeight(self)-200, XYViewWidth(button), 200)];
    viewbg.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewbg];
    
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dictemp objectForKey:@"headPicture"]];
    UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(10, XYViewTop(viewbg)+10, 80, 80)];
    [imagepic setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    imagepic.layer.cornerRadius = 3.0f;
    imagepic.clipsToBounds = YES;
    [self addSubview:imagepic];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imagepic)+10,XYViewBottom(imagepic)-40, 200, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dictemp objectForKey:@"salePrice"],[dictemp objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(15.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [self addSubview:labelprice];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelprice), XYViewBottom(labelprice), 200, 20)];
    labelName.text = [dictemp objectForKey:@"name"];
    labelName.font = FONTN(15.0f);
    labelName.textColor = COLORNOW(52, 52, 52);
    [self addSubview:labelName];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imagepic), XYViewBottom(imagepic)+30, 50, 20)];
    labeltitle.text = @"数量";
    labeltitle.font = FONTN(15.0f);
    labeltitle.textColor = COLORNOW(52, 52, 52);
    [self addSubview:labeltitle];
    
    //减少
    UIButton *buttonreduce = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonreduce.frame = CGRectMake(XYViewR(imagepic)+10, XYViewTop(labeltitle)-10, 40, 40);
    [buttonreduce setImage:LOADIMAGE(@"reduceicon", @"png") forState:UIControlStateNormal];
    [buttonreduce addTarget:self action:@selector(clickreduceproduct:) forControlEvents:UIControlEventTouchUpInside];
    buttonreduce.tag = EnShopCarReduceBtTag;
    [self addSubview:buttonreduce];
    
    UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(buttonreduce), XYViewTop(buttonreduce), 25, 40)];
    labelnum.text = @"1";
    labelnum.textAlignment = NSTextAlignmentCenter;
    labelnum.font = FONTN(15.0f);
    labelnum.textColor = COLORNOW(52, 52, 52);
    labelnum.tag = EnShopCarLabelNumTag;
    [self addSubview:labelnum];
    
    //增加
    UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonadd.frame = CGRectMake(XYViewR(labelnum), XYViewTop(buttonreduce), 40, 40);
    [buttonadd setImage:LOADIMAGE(@"addicon", @"png") forState:UIControlStateNormal];
    [buttonadd addTarget:self action:@selector(clickaddproduct:) forControlEvents:UIControlEventTouchUpInside];
    buttonadd.tag = EnShopCarAddBtTag;
    [self addSubview:buttonadd];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, XYViewHeight(self)-40, SCREEN_WIDTH, 0.7)];
    imageviewline.backgroundColor = COLORNOW(210, 210, 210);
    [self addSubview:imageviewline];
    
    UIImageView *imageviewshopcar = [[UIImageView alloc] initWithFrame:CGRectMake(10, XYViewBottom(imageviewline)+9, 24, 21)];
    imageviewshopcar.image = LOADIMAGE(@"购物车选择后", @"png");
    [self addSubview:imageviewshopcar];
    
    UIButton *buttonaddshopcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonaddshopcar.frame = CGRectMake(SCREEN_WIDTH-130, XYViewBottom(imageviewline), 130, 40);
    [buttonaddshopcar setTitle:@"立即加入购物车" forState:UIControlStateNormal];
    buttonaddshopcar.titleLabel.font = FONTN(15.0f);
    buttonaddshopcar.backgroundColor = COLORNOW(32, 188, 167);
    [buttonaddshopcar addTarget:self action:@selector(clickaddshoppingcar:) forControlEvents:UIControlEventTouchUpInside];
    [buttonaddshopcar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:buttonaddshopcar];
}

-(void)removepopbuyview:(id)sender
{
    [self removeFromSuperview];
}

-(void)clickaddshoppingcar:(id)sender
{
    UILabel *labelnum = [self viewWithTag:EnShopCarLabelNumTag];
    [self addshoppingcar:[dicfrom objectForKey:@"id"] UserId:app.userinfo.userid ProductNumber:labelnum.text];
    
    
}

-(void)clickaddproduct:(id)sender
{
    UILabel *labelnum = [self viewWithTag:EnShopCarLabelNumTag];
    
    int numnow = [labelnum.text intValue];
    if(numnow+1>99)
    {
        [MBProgressHUD showError:@"单一商品最大数量订购99件" toView:app.window];
    }
    else
    {
        labelnum.text = [NSString stringWithFormat:@"%d",numnow+1];
    }
}

-(void)clickreduceproduct:(id)sender
{
    UILabel *labelnum = [self viewWithTag:EnShopCarLabelNumTag];
    
    int numnow = [labelnum.text intValue];
    if(numnow-1<1)
    {
        [MBProgressHUD showError:@"单一商品最小数量订购1件" toView:app.window];
    }
    else
    {
        labelnum.text = [NSString stringWithFormat:@"%d",numnow-1];
    }
}

-(void)addshoppingcar:(NSString *)goodsid UserId:(NSString *)userid ProductNumber:(NSString *)productnumber
{
    GoodsDetailService *goodsdetail = [GoodsDetailService new];
    [goodsdetail sendaddShoppingCarRequest:goodsid UserId:userid ProductNumber:productnumber App:app ReqUrl:RQAddShoppingCar successBlock:^(NSDictionary *dicData) {
        
        [MBProgressHUD showSuccess:[dicData objectForKey:@"resultInfo"] toView:app.window];
        [self removepopbuyview:nil];
    }];
}

@end
