//
//  EditWishCardController.m
//  WishCard
//
//  Created by WangPandeng on 15/10/30.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "EditWishCardController.h"
#import "EditWishCardModel.h"
#import "MJExtension.h"
#import "EditWishCardBean.h"
#import "UIImageView+AFNetworking.h"
#import "EditWishCardView.h"
//#import "TFHpple.h"
//#import "TFHppleElement.h"


@interface EditWishCardController ()<UIScrollViewDelegate>
{
    NSMutableArray *dataArray;  //容量大数组
    UIScrollView *wishScrollView;  //展示模板Page的scrollView
    UIPageControl *pagecontrol;   //小白点
}
@end

@implementation EditWishCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray =[[NSMutableArray alloc] init];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self addTiTle:self.name];
    [self requestData];
    
}
-(void)requestData{
    NSString *urlString =[Url queryModelPagesWishId:self.Id];
    [Netmanager GetRequestWithUrlString:urlString finished:^(NSDictionary *responseobj) {
        NSArray *arr =responseobj[@"pagelist"];
        for (NSDictionary *subdic  in arr) {
            NSMutableArray *testArray =[[NSMutableArray alloc] init];  //存model数组
            EditWishCardBean *editModel = [[EditWishCardBean alloc] init];
            editModel.Id =[self judgeDicEmpty:subdic str:@"id"];
            editModel.page =[self judgeDicEmpty:subdic str:@"page"];
            for (NSDictionary *detSubdic in subdic[@"content"]) {
                EditWishCardModel *detEditModel = [[EditWishCardModel alloc] init];
                detEditModel.conntent =[self judgeDicEmpty:detSubdic str:@"content"];
                detEditModel.conntent_id =[self judgeDicEmpty:detSubdic str:@"id"];
                detEditModel.conntent_newAdd =[self judgeDicEmpty:detSubdic str:@"newAdd"];
                detEditModel.conntent_pageId =[self judgeDicEmpty:detSubdic str:@"pageId"];
                detEditModel.conntent_pageMove =[self judgeDicEmpty:detSubdic str:@"pageMove"];
                detEditModel.conntent_sceneId =[self judgeDicEmpty:detSubdic str:@"sceneId"];
                detEditModel.conntent_type =[self judgeDicEmpty:detSubdic str:@"type"];
                detEditModel.conntent_viewTag =[self judgeDicEmpty:detSubdic str:@"viewTag"];
                
                NSDictionary *sccDic =detSubdic[@"css"];
                detEditModel.css_backgroundColor =[self judgeDicEmpty:sccDic str:@"backgroundColor"];
                detEditModel.css_borderColor =[self judgeDicEmpty:sccDic str:@"borderColor"];
                detEditModel.css_borderRadius =[self judgeDicEmpty:sccDic str:@"borderRadius"];
                detEditModel.css_borderStyle =[self judgeDicEmpty:sccDic str:@"borderStyle"];
                detEditModel.css_borderWidth =[self judgeDicEmpty:sccDic str:@"borderWidth"];
                detEditModel.css_boxShadow =[self judgeDicEmpty:sccDic str:@"boxShadow"];
                detEditModel.css_color =[self judgeDicEmpty:sccDic str:@"color"];
                detEditModel.css_height =[self judgeDicEmpty:sccDic str:@"height"];
                detEditModel.css_left =[self judgeDicEmpty:sccDic str:@"left"];
                detEditModel.css_paddingBottom =[self judgeDicEmpty:sccDic str:@"paddingBottom"];
                detEditModel.css_paddingTop =[self judgeDicEmpty:sccDic str:@"paddingTop"];
                detEditModel.css_top =[self judgeDicEmpty:sccDic str:@"top"];
                detEditModel.css_width =[self judgeDicEmpty:sccDic str:@"width"];
                detEditModel.css_zIndex =[self judgeDicEmpty:sccDic str:@"zIndex"];

                NSDictionary *propertiesDic=detSubdic[@"properties"];
                NSLog(@"propertiesDic::%@",propertiesDic);
                 detEditModel.Pro_imgSrc =[propertiesDic valueForKey:@"imgSrc"];
                 detEditModel.Pro_src =[propertiesDic valueForKey:@"src"];
                 detEditModel.Pro_bgColor =[propertiesDic valueForKey:@"bgColor"];
                 detEditModel.Pro_height =[propertiesDic valueForKey:@"height"];
                 detEditModel.Pro_width =[propertiesDic valueForKey:@"width"];
                
                    NSDictionary *animDic = [propertiesDic valueForKey:@"anim"];
                    detEditModel.anim_countNum =[self judgeDicEmpty:animDic str:@"countNum"];
                    detEditModel.anim_delay =[self judgeDicEmpty:animDic str:@"delay"];
                    detEditModel.anim_direction =[self judgeDicEmpty:animDic str:@"direction"];
                    detEditModel.anim_duration =[self judgeDicEmpty:animDic str:@"duration"];
                    detEditModel.anim_type =[self judgeDicEmpty:animDic str:@"type"];
                
                    NSDictionary *imgStyleDic = [propertiesDic valueForKey:@"anim"];
                    detEditModel.imgStyle_height =[self judgeDicEmpty:imgStyleDic str:@"height"];
                    detEditModel.imgStyle_marginLeft =[self judgeDicEmpty:imgStyleDic str:@"marginLeft"];
                    detEditModel.imgStyle_marginTop =[self judgeDicEmpty:imgStyleDic str:@"marginTop"];
                    detEditModel.imgStyle_width =[self judgeDicEmpty:imgStyleDic str:@"width"];
                
                [testArray addObject:detEditModel];
            }
            editModel.modelDataArray =testArray;
            [dataArray addObject:editModel];
        }
        [self makeUI];
    } failed:^(NSString *errorMsg) {
        NSLog(@"erroe:%@",errorMsg);
        
    }];
}
-(void)jiexiHtml{
//[UIColor colorWithCGColor:<#(nonnull CGColorRef)#>:<#(nonnull CIColor *)#>]
    NSString *str =@"<font color=\"#ffffff\"><span style=\"line-height: 13px;\"><font size=\"5\">为了</font><font size=\"2\">寻你，我错过了许多的良辰美景，错过了闲看花开花落的心情，可我不后悔。因为你是我今生最美的遇见；寻得你，我就拥有了全世界的花开颜色。你的到来，为我拂去了浪迹天涯的孤独，我漂泊的灵魂再也不用辗转流连于亭台楼榭之间，湄湄云水之上。</font>\n</span>\n</font>";
//    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    UIWebView *webView =[[UIWebView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [webView loadHTMLString:str baseURL:nil];
    [self.view addSubview:webView];
    
}
-(void)makeUI{
    //      展示模板的scrollView
    wishScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64-49)];
    [self.view addSubview:wishScrollView];
    wishScrollView.pagingEnabled = YES;
    wishScrollView.delegate =self;
    wishScrollView.showsHorizontalScrollIndicator = NO;
    wishScrollView.contentSize = CGSizeMake(dataArray.count*wid, 0);

//     解析html
    [self jiexiHtml];
    if (dataArray.count>0) {
        for (NSInteger i=0; i<dataArray.count; i++) {
            EditWishCardBean *model = dataArray[i];
//            EditWishCardView *view = [[EditWishCardView alloc]initWithFrame:CGRectMake(40+i*wid, 40, wid-80, heigh-180)];
//            [wishScrollView addSubview:view];
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(wid*i, 0, wid, heigh-64-59)];
            [wishScrollView addSubview:bgImageView];
            for (NSInteger i=0; i<model.modelDataArray.count; i++) {
                EditWishCardModel *editModel =model.modelDataArray[i];
//                view.editWishCardModel =editModel;
                if ([editModel.conntent_type integerValue] ==2) {
                    NSLog(@"%@",editModel.css_left );
                    NSLog(@"%@",editModel.css_top );
                    NSLog(@"left:%ld,top:%ld",[self getIntgerFromNSstringWithString:editModel.css_left],[self getIntgerFromNSstringWithString:editModel.css_top]);
                    UILabel *label =[[UILabel alloc] init];
                    label.frame = CGRectMake([self getIntgerFromNSstringWithString:editModel.css_left], [self getIntgerFromNSstringWithString:editModel.css_top], [editModel.css_width integerValue], [editModel.css_height integerValue]);
                    label.textColor = [UIColor redColor];
                    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[editModel.conntent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                    label.attributedText = attrStr;
                    label.numberOfLines=0;
//                    [bgImageView insertSubview:label atIndex:7-[editModel.css_zIndex integerValue]];
                    [bgImageView addSubview:label];
                }
                else if ([editModel.conntent_type integerValue] ==4) {
                    NSLog(@"%ld,%ld",[editModel.Pro_width integerValue],[editModel.Pro_height integerValue]);
                    UIImageView *imgView=[[UIImageView alloc] init];
                    imgView.frame =CGRectMake([self getIntgerFromNSstringWithString:editModel.css_left], [self getIntgerFromNSstringWithString:editModel.css_top], [editModel.css_width integerValue], [editModel.css_height integerValue]);
                    NSString *urlString =[NSString stringWithFormat:@"http://192.168.7.1/Uploads/%@",editModel.Pro_src];
                    NSURL *url =[NSURL URLWithString:urlString];
                    [imgView setImageWithURL:url placeholderImage:nil];
//                    [bgImageView insertSubview:imgView atIndex:7-[editModel.css_zIndex integerValue]];
                     [bgImageView addSubview:imgView];
                }
                else if ([editModel.conntent_type integerValue] ==3) {
                    NSString *urlString =[NSString stringWithFormat:@"http://192.168.7.1/Uploads/%@",editModel.Pro_imgSrc];
                    NSURL *url =[NSURL URLWithString:urlString];
                    [bgImageView setImageWithURL:url placeholderImage:nil];

                }

            }

        }

        pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(wid/2-50, heigh-50, 100, 10)];
        pagecontrol.numberOfPages = dataArray.count;
        pagecontrol.pageIndicatorTintColor =[UIColor lightGrayColor];
        pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
        pagecontrol.tag = 600;
        [self.view addSubview:pagecontrol];

    }
   //       底下的View
    UIView *botView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh-40, wid, 40)];
    UIButton *backgroundbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    backgroundbutton.frame =CGRectMake(0, 0, wid/2-0.5, 40);
    backgroundbutton.backgroundColor=[UIColor grayColor];
    [backgroundbutton setTitle:@"背景" forState:UIControlStateNormal];
    [backgroundbutton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:backgroundbutton];
    UIButton *musicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    musicButton.frame =CGRectMake(wid/2, 0, wid/2, 40);
    musicButton.backgroundColor=[UIColor grayColor];
    [musicButton setTitle:@"音乐" forState:UIControlStateNormal];
    [musicButton addTarget:self action:@selector(musicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:musicButton];

    [self.view addSubview:botView];
}
-( NSInteger)getIntgerFromNSstringWithString:(NSString *)string{
    if ([self isPureInt:string]) {
        return [string integerValue];
    }
//    NSString *sss =[NSString stringWithFormat:@"%@",string];
//    NSString *str =[sss stringByAppendingString:@"px"];
    NSArray *array = [string componentsSeparatedByString:@"p"];
    NSString *lastString =array[0];
    
    return [lastString integerValue];
}
//   判断数字
- (BOOL)isPureInt:(id )string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
#pragma mark - Click事件
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backgroundButtonClick{
    NSLog(@"backGround");
}
-(void)musicButtonClick{
    NSLog(@"music");
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = floor((scrollView.contentOffset.x - wid / 2)/wid)+1;
    pagecontrol.currentPage = page;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
