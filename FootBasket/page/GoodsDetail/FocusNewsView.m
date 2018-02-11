//
//  FocusNewsView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "FocusNewsView.h"

@implementation FocusNewsView

-(id)initWithFrame:(CGRect)frame Focus:(NSArray *)focus
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self initviewloop:focus];
	}
	return self;
}

-(void)initviewloop:(NSArray *)focus
{
	float nowheight = 180;

	
	
	self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
	self.backgroundColor = [UIColor clearColor];

	NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
	for(int i=0;i<[focus count];i++)
	{
		NSDictionary *dictemp = [focus objectAtIndex:i];
        NSString *strpath = [NSString stringWithFormat:@"%@%@",URLPicHeader,[dictemp objectForKey:@"picture_pictureUrl"]];
		[arraypiclist addObject:strpath];
	}
	
	self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, nowheight)];
	[self addSubview:self.loop];
	self.loop.xlsn0wDelegate = self;
	self.loop.time = 5;
	[self.loop setPagePosition:PositionBottomRight];
	[self.loop setPageColor:[UIColor whiteColor] andCurrentPageColor:COLORNOW(32, 188, 167)];
	//支持gif动态图
	self.loop.imageArray = arraypiclist;
	
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
	NSLog(@"点击了第%ld张图片", index);
	
	
}

-(void)changepicdescript:(int)currentindex
{
    
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
//	int tagnow = (int)[[sender view] tag];
}


@end
