//
//  EditWishCardModel.h
//  WishCard
//
//  Created by WangPandeng on 15/10/31.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditWishCardModel : NSObject


//  content
@property (nonatomic,copy)NSString *conntent;

//  newAdd
@property (nonatomic,copy)NSString *conntent_newAdd;
//  id
@property (nonatomic,copy)NSString *conntent_id;
//  pageId
@property (nonatomic,copy)NSString *conntent_pageId;
//  pageMove
@property (nonatomic,copy)NSString *conntent_pageMove;
//  sceneId
@property (nonatomic,copy)NSString *conntent_sceneId;
//  type                控件种类（2是Label  3是背景  4是Image）
@property (nonatomic,copy)NSString *conntent_type;
//  viewTag
@property (nonatomic,copy)NSString *conntent_viewTag;
//  css
@property (nonatomic,copy)NSString *css_backgroundColor;
@property (nonatomic,copy)NSString *css_borderColor;
@property (nonatomic,copy)NSString *css_borderRadius;
@property (nonatomic,copy)NSString *css_borderStyle;
@property (nonatomic,copy)NSString *css_borderWidth;
@property (nonatomic,copy)NSString *css_boxShadow;
@property (nonatomic,copy)NSString *css_color;
@property (nonatomic,copy)NSString *css_height;
@property (nonatomic,copy)NSString *css_left;
@property (nonatomic,copy)NSString *css_paddingBottom;
@property (nonatomic,copy)NSString *css_paddingTop;
@property (nonatomic,copy)NSString *css_top;
@property (nonatomic,copy)NSString *css_width;
@property (nonatomic,copy)NSString *css_zIndex;   //层

//  properties   / anim        动画的参数
@property (nonatomic,copy)NSString *anim_countNum;
@property (nonatomic,copy)NSString *anim_delay;
@property (nonatomic,copy)NSString *anim_direction;
@property (nonatomic,copy)NSString *anim_duration;
@property (nonatomic,copy)NSString *anim_type;
//  properties   / imgStyle        动画的参数
@property (nonatomic,copy)NSString *imgStyle_height;
@property (nonatomic,copy)NSString *imgStyle_marginLeft;
@property (nonatomic,copy)NSString *imgStyle_marginTop;
@property (nonatomic,copy)NSString *imgStyle_width;
// properties    /imgSrc       最底层背景图片
@property (nonatomic,copy)NSString *Pro_imgSrc;
// properties    /src
@property (nonatomic,copy)NSString *Pro_src;
// properties    /bgColor
@property (nonatomic,copy)NSString *Pro_bgColor;
// properties    /width
@property (nonatomic,copy)NSString *Pro_width;
@property (nonatomic,copy)NSString *Pro_height;




@end
