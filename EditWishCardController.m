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

@interface EditWishCardController ()
{
    NSMutableArray *dataArray;  //容量大数组
    NSMutableArray *contentDataArray;
    NSMutableArray *cssDataArray;
    NSMutableArray *propertiesDataArray;
    NSMutableArray *animDataArray;
    UIScrollView *wishScrollView;  //展示模板Page的scrollView
    UIPageControl *pagecontrol;   //小白点
}
@end

@implementation EditWishCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray =[[NSMutableArray alloc] init];
    contentDataArray =[[NSMutableArray alloc] init];
    cssDataArray =[[NSMutableArray alloc] init];
    propertiesDataArray =[[NSMutableArray alloc] init];
    animDataArray =[[NSMutableArray alloc] init];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self addTiTle:self.name];
    [self requestData];
    [self makeUI];
}
-(void)requestData{
    NSString *urlString =[Url queryModelPagesWishId:self.Id];
    [Netmanager GetRequestWithUrlString:urlString finished:^(NSDictionary *responseobj) {
        NSArray *arr =responseobj[@"pagelist"];
        for (NSDictionary *subdic  in arr) {
            EditWishCardModel *editModel = [[EditWishCardModel alloc] init];
            editModel.Id =[self judgeDicEmpty:subdic str:@"id"];
            editModel.page =[self judgeDicEmpty:subdic str:@"page"];
            for (NSDictionary *detSubdic in subdic[@"content"]) {
                EditWishCardModel *detEditModel = [[EditWishCardModel alloc] init];
                detEditModel.conntent =[self judgeDicEmpty:detSubdic str:@"content"];
                detEditModel.Id =[self judgeDicEmpty:detSubdic str:@"id"];
                detEditModel.NewAdd =[self judgeDicEmpty:detSubdic str:@"newAdd"];
                detEditModel.pageId =[self judgeDicEmpty:detSubdic str:@"pageId"];
                detEditModel.pageMove =[self judgeDicEmpty:detSubdic str:@"pageMove"];
                detEditModel.sceneId =[self judgeDicEmpty:detSubdic str:@"sceneId"];
                detEditModel.type =[self judgeDicEmpty:detSubdic str:@"type"];
                detEditModel.viewTag =[self judgeDicEmpty:detSubdic str:@"viewTag"];
                [contentDataArray addObject:detEditModel];
                
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
                [cssDataArray addObject:detEditModel];
//
                NSDictionary *propertiesDic=detSubdic[@"properties"];
                NSLog(@"propertiesDic::%@",propertiesDic);
                 detEditModel.imgSrc =[propertiesDic valueForKey:@"imgSrc"];
                 detEditModel.src =[propertiesDic valueForKey:@"src"];
                 detEditModel.bgColor =[propertiesDic valueForKey:@"bgColor"];
                 detEditModel.Pro_height =[propertiesDic valueForKey:@"height"];
                 detEditModel.Pro_width =[propertiesDic valueForKey:@"width"];
                [propertiesDataArray addObject:detEditModel];
                
                    NSDictionary *animDic = [propertiesDic valueForKey:@"anim"];
                    detEditModel.anim_countNum =[self judgeDicEmpty:animDic str:@"countNum"];
                    detEditModel.anim_delay =[self judgeDicEmpty:animDic str:@"delay"];
                    detEditModel.anim_direction =[self judgeDicEmpty:animDic str:@"direction"];
                    detEditModel.anim_duration =[self judgeDicEmpty:animDic str:@"duration"];
                    detEditModel.anim_type =[self judgeDicEmpty:animDic str:@"type"];
                    [animDataArray addObject:detEditModel];
                
                    NSDictionary *imgStyleDic = [propertiesDic valueForKey:@"anim"];
                    detEditModel.imgStyle_height =[self judgeDicEmpty:imgStyleDic str:@"height"];
                    detEditModel.imgStyle_marginLeft =[self judgeDicEmpty:imgStyleDic str:@"marginLeft"];
                    detEditModel.imgStyle_marginTop =[self judgeDicEmpty:imgStyleDic str:@"marginTop"];
                    detEditModel.imgStyle_width =[self judgeDicEmpty:imgStyleDic str:@"width"];
                    [animDataArray addObject:detEditModel];

            }
            [dataArray addObject:editModel];
        }
    } failed:^(NSString *errorMsg) {
        NSLog(@"erroe:%@",errorMsg);
    }];
}
-(void)makeUI{
    //      展示模板的scrollView
    wishScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64-49)];
    [self.view addSubview:wishScrollView];
    wishScrollView.pagingEnabled = YES;
//    wishScrollView.backgroundColor = [UIColor yellowColor];
    wishScrollView.showsHorizontalScrollIndicator = NO;
    wishScrollView.contentSize = CGSizeMake(dataArray.count*wid, 0);
    //imageView
    for (NSInteger i=0; i<dataArray.count; i++) {
        UIImageView *wishImageView= [[UIImageView alloc] initWithFrame:CGRectMake(i*wid+40, 40, wid-80, heigh-180)];
        wishImageView.backgroundColor = [UIColor redColor];
        NSLog(@"%@",[dataArray[i] valueForKey:@"image"]);
//        NSURL *url =[NSURL URLWithString:[dataArray[i] valueForKey:@"image"]];
//        [wishImageView setImageWithURL:url placeholderImage:nil];
        wishImageView.userInteractionEnabled = YES;
        wishImageView.tag = i;
        [wishScrollView addSubview:wishImageView];
    }
    pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(wid/2-30, heigh-65, 60, 10)];
    pagecontrol.numberOfPages = dataArray.count;
    pagecontrol.pageIndicatorTintColor =[UIColor lightGrayColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    pagecontrol.tag = 600;
    [self.view addSubview:pagecontrol];
//       底下的View
    UIView *botView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh-40, wid, 40)];
//    botView.backgroundColor = RGBCOLOR(10, 1, 2);
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
