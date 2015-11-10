//
//  EditWishCardBean.h
//  WishCard
//
//  Created by WangPandeng on 15/11/2.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditWishCardBean : NSObject

//  id
@property (nonatomic,copy)NSString *Id;
//  page
@property (nonatomic,copy)NSString *page;

@property (nonatomic,strong)NSArray *modelDataArray;
@end
