//
//  H5BGMViewController.h
//  WishCard
//
//  Created by 张鹤楠 on 15/11/6.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@protocol H5BGMDelegate <NSObject>

- (void)sendBMGId:(NSString *)Id;

@end

@interface H5BGMViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic)id<H5BGMDelegate> delegate;

@end
