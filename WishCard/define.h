//
//  define.h
//  ChinaTransport
//
//  Created by 王攀登 on 15/8/31.
//  Copyright (c) 2015年 GuoguangGaoTong. All rights reserved.
//

#ifndef ChinaTransport_define_h
#define ChinaTransport_define_h

//获取设备基本参数
#define kCURRENT_SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define kCURRENT_MODEL [UIDevice currentDevice].model
#define kCURRENT_UUID [[UIDevice currentDevice].identifierForVendor UUIDString]
#define kCURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define kCURRENT_APP_VERSION [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
// 获取屏幕大小
#define wid [UIScreen mainScreen].bounds.size.width
#define heigh [UIScreen mainScreen].bounds.size.height

#define wishLeft 40
#define wishTop heigh*0.05
#define wishHeigh 500
#define wishWid 320
//颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 0代表公司-正式-外网，1代表公司-正式-内网 ，2代表阿里云-测试-外网
#define _APP_ENVIRMENT_ 1


#if ((_APP_ENVIRMENT_) == 0)
#define kHostAddr  @"http://103.43.184.235:8080/radio"
#elif ((_APP_ENVIRMENT_) == 1)
#define kHostAddr  @"http://192.168.3.1:8080/radio"
#endif

//#define kWishCardAddr @"http://www.cctbn.com:90"

#define kWishCardAddr @"http://192.168.3.3:90"

#define kCodeOK @"0000"



#endif
