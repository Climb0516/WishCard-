//
//  ClipImageViewController.m
//  WishCard
//
//  Created by 张鹤楠 on 15/11/2.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ClipImageViewController.h"
#define WIDTH 50

@interface ClipImageViewController ()
{
    UIImageView *clipImageView;
    UIButton *cancelButton;
    UIButton *clipButton;
    
}

@end

@implementation ClipImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self drawMyLayer];
    [self creatUI];
    [self creatRect];
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
}

- (void)creatUI{
    clipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(wid/12.8, heigh/19, wid-wid/12.8*2, heigh-heigh/19*2)];
    clipImageView.backgroundColor = [UIColor lightGrayColor];
    clipImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:clipImageView];
    clipImageView.image = _cilpImage;
}

- (void)creatRect{
    
}

-(void)drawRectWithContext:(CGContextRef)context{
    //添加矩形对象
    CGRect rect=CGRectMake(20, 50, 280.0, 50.0);
    CGContextAddRect(context,rect);
    //设置属性
    [[UIColor blueColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}



#pragma mark 绘制图层
-(void)drawMyLayer{
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    //获得根图层
    CALayer *layer=[[CALayer alloc]init];
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position=CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds=CGRectMake(0, 0, WIDTH,WIDTH);
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius=WIDTH/2;
    //设置阴影
    layer.shadowColor=[UIColor grayColor].CGColor;
    layer.shadowOffset=CGSizeMake(2, 2);
    layer.shadowOpacity=.9;
    //设置边框
    //    layer.borderColor=[UIColor whiteColor].CGColor;
    //    layer.borderWidth=1;
    
    //设置锚点
    //    layer.anchorPoint=CGPointZero;
    
    [self.view.layer addSublayer:layer];
    
}

#pragma mark 点击放大
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CALayer *layer=self.view.layer.sublayers[0];
    CGFloat width=layer.bounds.size.width;
    if (width==WIDTH) {
        width=WIDTH*6;
    }else{
        width=WIDTH;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
    layer.position=[touch locationInView:self.view];
    layer.cornerRadius=width/2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
