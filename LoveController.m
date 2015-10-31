//
//  LoveController.m
//  WishCard
//
//  Created by WangPandeng on 15/10/29.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "LoveController.h"
#import "WishModel.h"
#import "UIImageView+AFNetworking.h"
#import "HTML5Controller.h"

@interface LoveController ()
{
    NSMutableArray *dataArray;  //容量数组
    UIScrollView *wishScrollView;  //展示的模板的scrollView
    UIPageControl *pagecontrol;   //小白点
}
@end

@implementation LoveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTiTle:@"Love贺卡"];
    dataArray =[[NSMutableArray alloc] init];
    
    
    [self requestData];
    

}
-(void)requestData{
    NSString *urlString =[Url queryWishModelsWishType:@"33"];
    NSLog(@"%@",urlString);
    [Netmanager GetRequestWithUrlString:urlString finished:^(id responseobj) {
        NSArray *array =responseobj[@"modellist"];
        for (NSDictionary *subdic in array) {
            WishModel *model =[[WishModel alloc] init];
            model.Id =[self judgeDicEmpty:subdic str:@"id"];
            model.image =[self judgeDicEmpty:subdic str:@"image"];
            model.name =[self judgeDicEmpty:subdic str:@"name"];
            model.type =[self judgeDicEmpty:subdic str:@"type"];
            model.url =[self judgeDicEmpty:subdic str:@"url"];
            [dataArray addObject:model];
        }
        
        [self createUI];
    } failed:^(NSString *errorMsg) {
        
    }];
}
-(void)createUI{
    //      展示模板的scrollView
    wishScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64-49)];
    [self.view addSubview:wishScrollView];
    wishScrollView.pagingEnabled = YES;
    wishScrollView.showsHorizontalScrollIndicator = NO;
    wishScrollView.contentSize = CGSizeMake(dataArray.count*wid, 0);
    //imageView
    for (NSInteger i=0; i<dataArray.count; i++) {
        UIImageView *wishImageView= [[UIImageView alloc] initWithFrame:CGRectMake(i*wid+40, 40, wid-80, heigh-180)];
        //        wishImageView.backgroundColor = [UIColor redColor];
        NSLog(@"%@",[dataArray[i] valueForKey:@"image"]);
        NSURL *url =[NSURL URLWithString:[dataArray[i] valueForKey:@"image"]];
        [wishImageView setImageWithURL:url placeholderImage:nil];
        wishImageView.userInteractionEnabled = YES;
        //        wishImageView.contentMode = UIViewContentModeScaleAspectFit;
        wishImageView.tag = i;
        UITapGestureRecognizer *tapImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseToPreWatch:)];
        [wishImageView addGestureRecognizer:tapImageGesture];
        [wishScrollView addSubview:wishImageView];
    }
    pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(wid/2-30, heigh-65, 60, 10)];
    pagecontrol.numberOfPages = dataArray.count;
    pagecontrol.pageIndicatorTintColor =[UIColor lightGrayColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    pagecontrol.tag = 600;
    [self.view addSubview:pagecontrol];
}
-(void)chooseToPreWatch:(UITapGestureRecognizer *)sender{
    NSLog(@"%ld",sender.view.tag);
    WishModel *model =dataArray[sender.view.tag];
    HTML5Controller *htmlVC =[[HTML5Controller alloc] init];
    htmlVC.model =model;
    htmlVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:htmlVC animated:YES];
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
