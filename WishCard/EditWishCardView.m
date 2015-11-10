//
//  EditWishCardView.m
//  WishCard
//
//  Created by WangPandeng on 15/11/2.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "EditWishCardView.h"
#import "UIImageView+AFNetworking.h"

@implementation EditWishCardView
{
    UIImageView *imgView;
     UIImageView *bgImgView;
    UILabel *label;
}
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        label = [[UILabel alloc] init];
        imgView = [[UIImageView alloc] init];
        bgImgView= [[UIImageView alloc] init];
//        [self addSubview:label];
//        [self addSubview:imgView];
//        [self insertSubview:bgImgView atIndex:0];
        [self createUI];
    }
    
    return self;
}
-(void)createUI{
//    [super layoutSubviews];
    
    if ([self.editWishCardModel.conntent_type integerValue] ==2) {
        NSLog(@"%@",self.editWishCardModel.css_left );
        NSLog(@"%@",self.editWishCardModel.css_top );
        NSLog(@"left:%ld,top:%ld",[self getIntgerFromNSstringWithString:self.editWishCardModel.css_left],[self getIntgerFromNSstringWithString:self.editWishCardModel.css_top]);
        label.frame = CGRectMake([self getIntgerFromNSstringWithString:self.editWishCardModel.css_left], [self getIntgerFromNSstringWithString:self.editWishCardModel.css_top], [self.editWishCardModel.css_width integerValue], [self.editWishCardModel.css_height integerValue]);
        label.text = self.editWishCardModel.conntent;
        label.textColor = [UIColor redColor];
//        [self addSubview:label];
        [self insertSubview:label atIndex:[self.editWishCardModel.css_zIndex integerValue]];
    }
    else if ([self.editWishCardModel.conntent_type integerValue] ==4) {
        NSLog(@"%ld,%ld",[self.editWishCardModel.Pro_width integerValue],[self.editWishCardModel.Pro_height integerValue]);
        imgView.frame =CGRectMake([self getIntgerFromNSstringWithString:self.editWishCardModel.css_left], [self getIntgerFromNSstringWithString:self.editWishCardModel.css_top], [self.editWishCardModel.css_width integerValue], [self.editWishCardModel.css_height integerValue]);
//        NSString *urlString =[NSString stringWithFormat:@"http://192.168.7.1/Uploads/%@",self.editWishCardModel.Pro_src];
         NSString *urlString =[kWishCardAddr stringByAppendingString:self.editWishCardModel.Pro_src];
        NSURL *url =[NSURL URLWithString:urlString];
        [imgView setImageWithURL:url placeholderImage:nil];
//        [self addSubview:imgView];
        [self insertSubview:imgView atIndex:[self.editWishCardModel.css_zIndex integerValue]];
    }
    else if ([self.editWishCardModel.conntent_type integerValue] ==3) {
                bgImgView.frame =CGRectMake(0, 0, wid-80, heigh-180);
//        NSString *urlString =[NSString stringWithFormat:@"http://192.168.7.1/Uploads/%@",self.editWishCardModel.Pro_imgSrc];
        NSString *urlString =[kWishCardAddr stringByAppendingString:self.editWishCardModel.Pro_imgSrc];
        NSURL *url =[NSURL URLWithString:urlString];
        [bgImgView setImageWithURL:url placeholderImage:nil];
        [self insertSubview:bgImgView atIndex:0];
    }

    
    
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//     Drawing code
//}
-( NSInteger)getIntgerFromNSstringWithString:(NSString *)string{
    NSString *sss =[NSString stringWithFormat:@"%@",string];
    NSString *str =[sss stringByAppendingString:@"px"];
    NSArray *array = [str componentsSeparatedByString:@"p"];
    NSString *lastString =array[0];
    
    return [lastString integerValue];
}





@end
