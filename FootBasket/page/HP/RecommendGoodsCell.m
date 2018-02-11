//
//  RecommendGoodsCell.m
//  FootBasket
//
//  Created by xyy on 2018/2/5.
//  Copyright © 2018年 谢毅. All rights reserved.
//

#import "RecommendGoodsCell.h"

@implementation RecommendGoodsCell

- (instancetype)initWithFrame:(CGRect)frame DicRecommend:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
        self.layer.borderWidth = 0.5f;
        [self initView:dic];
    }
    return self;
}

-(void)initView:(NSDictionary *)dic
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dic objectForKey:@"headPicture"]];
    [imageview setImageWithURL:[NSURL URLWithString:strpath] placeholderImage:LOADIMAGE(@"图层20", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [self addSubview:imageview];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview), XYViewWidth(self)-110, 20)];
    labelname.text = [dic objectForKey:@"name"];
    labelname.font = FONTB(17.0f);
    [self addSubview:labelname];
    
    UILabel *labelsummary = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelname)+5, 100, 20)];
    labelsummary.text = [dic objectForKey:@"summary"];
    labelsummary.font = FONTN(14.0f);
    labelsummary.textColor = COLORNOW(172, 172, 172);
    [self addSubview:labelsummary];
    
    UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelname), XYViewBottom(labelsummary)+5, 100, 20)];
    labelprice.text = [NSString stringWithFormat:@"￥%@元/%@",[dic objectForKey:@"salePrice"],[dic objectForKey:@"displayUnit"]];
    labelprice.font = FONTN(14.0f);
    labelprice.textColor = COLORNOW(248, 88, 37);
    [self addSubview:labelprice];
    
    UIButton *buttonshoppingcar = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonshoppingcar.frame = CGRectMake(XYViewWidth(self)-50,XYViewHeight(self)-50, 40, 40);
    [buttonshoppingcar setImage:LOADIMAGE(@"加入购物车small", @"png") forState:UIControlStateNormal];
    [self addSubview:buttonshoppingcar];
}

@end
