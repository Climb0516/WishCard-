//
//  ChooseImageViewController.h
//  WishCard
//
//  Created by 张鹤楠 on 15/11/9.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "RootViewController.h"

@protocol ChooseImageStyle <NSObject>

- (void)getImageFromChooseImageStyle:(UIImage *)image;

@end

@interface ChooseImageViewController : RootViewController

@property (weak,nonatomic)id<ChooseImageStyle> delegate;
@property (nonatomic) CGRect imageRect;
@property (nonatomic) UIImage *hahImage;

@end
