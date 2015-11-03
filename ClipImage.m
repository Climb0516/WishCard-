//
//  ClipImage.m
//  WishCard
//
//  Created by 张鹤楠 on 15/11/3.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ClipImage.h"
#define dragButton 40

@implementation ClipImage
{
    UIView *clipView;
//    UIView *clipImageButton;
}

- (instancetype)initWithFrame:(CGRect)frame andClipRect:(CGRect)clipRect{
    self = [super initWithFrame:frame];
    _clipRect = clipRect;
    clipView = [[UIView alloc] initWithFrame:clipRect];
//    clipView.backgroundColor = [UIColor redColor];
    [self addSubview:clipView];
    [self addButtonAndGesture];
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawRectWithContext:context];
}

- (void)addButtonAndGesture{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changeClipView:)];
    NSValue *zeroGround = [NSValue valueWithCGRect:CGRectMake(clipView.bounds.origin.x-dragButton/2, clipView.bounds.origin.y-dragButton/2, dragButton, dragButton)];
    NSValue *upRight = [NSValue valueWithCGRect:CGRectMake(clipView.bounds.origin.x-dragButton/2 +clipView.bounds.size.width, clipView.bounds.origin.y-dragButton/2, dragButton, dragButton)];
    NSValue *downLeft =[NSValue valueWithCGRect:CGRectMake(clipView.bounds.origin.x-dragButton/2, clipView.bounds.origin.y-dragButton/2 + clipView.bounds.size.height , dragButton, dragButton)];
    NSValue *downRight = [NSValue valueWithCGRect:CGRectMake(clipView.bounds.origin.x-dragButton/2 +clipView.bounds.size.width, clipView.bounds.origin.y-dragButton/2 + clipView.bounds.size.height   , dragButton, dragButton)];
    NSArray *clipButtonArray = @[zeroGround,upRight,downLeft,downRight];

    for (int i = 0; i<4;i++) {
        UIView *clipImageButton = [[UIView alloc] initWithFrame:[clipButtonArray[i] CGRectValue]];
        [clipImageButton addGestureRecognizer:panGesture];
        clipImageButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"拖动按钮"]];
//        clipImageButton.userInteractionEnabled = YES;
        [clipView addSubview:clipImageButton];
        
    }
}

- (void)drawRectWithContext:(CGContextRef)context{
    //添加矩形对象
    CGRect rect = _clipRect;
    //设置属性
    [[UIColor clearColor]set];
    [[UIColor whiteColor]setStroke];
    UIRectFill(rect);
    UIRectFrame(rect);
}

- (void)changeClipView:(UIGestureRecognizer *)pan{
    NSLog(@"ddd");
}

@end
