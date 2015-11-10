//
//  NotesXMLParser.m
//  WishCard
//
//  Created by WangPandeng on 15/11/10.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "NotesXMLParser.h"

@implementation NotesXMLParser


-(void)startString:(NSString *)string
{
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"xml"];
    
//    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data =[string dataUsingEncoding:NSUTF8StringEncoding];
    //开始解析XML
//    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
     NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    NSLog(@"解析完成...");
}

//文档开始的时候触发
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _notes = [NSMutableArray new];
}

//文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@",parseError);
}

//遇到一个开始标签时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    _currentTagName = elementName;
    
    NSLog(@"_currentTagName = %@",_currentTagName);
    
    if ([_currentTagName isEqualToString:@"Note"]) {
        NSString *_id = [attributeDict objectForKey:@"id"];
        NSLog(@"note对应的属性id ＝ %@",_id);
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:_id forKey:@"id"];
        [_notes addObject:dict];
    }
    
}

//遇到字符串时候触发
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //替换回车符和空格
    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([string compare:@""] == NSOrderedDescending) {
        NSLog(@"字符串 = %@",string);
    }
    if ([string isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary *dict = [_notes lastObject];
    
    if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
    }
    
    if ([_currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
    }
    
    if ([_currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
    }
}

//遇到结束标签时候出发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName;
{
    self.currentTagName = nil;
}

//遇到文档结束时候触发
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    self.notes = nil;
}

@end
