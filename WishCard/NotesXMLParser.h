//
//  NotesXMLParser.h
//  WishCard
//
//  Created by WangPandeng on 15/11/10.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotesXMLParser : NSObject<NSXMLParserDelegate>


///解析出的数据内部是字典类型
@property (strong,nonatomic) NSMutableArray *notes;
//当前标签的名字
@property (strong,nonatomic) NSString *currentTagName;

//开始解析
-(void)startString:(NSString *)string;
@end
