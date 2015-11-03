//
//  ClipImage.h
//  WishCard
//
//  Created by 张鹤楠 on 15/11/3.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClipImage : UIView
{
    CGRect _clipRect;
}
- (instancetype)initWithFrame:(CGRect)frame andClipRect:(CGRect)clipRect;
@end
