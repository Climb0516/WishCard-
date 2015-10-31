//
//  EditWishCardController.m
//  WishCard
//
//  Created by WangPandeng on 15/10/30.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "EditWishCardController.h"

@interface EditWishCardController ()
{
    NSMutableArray *dataArray;  //容量大数组
    NSMutableArray *detDataArray; 
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
    [self makeUI];
}
-(void)requestData{
    NSString *urlString =[Url queryModelPagesWishId:self.Id];
    [Netmanager GetRequestWithUrlString:urlString finished:^(id responseobj) {
        
    } failed:^(NSString *errorMsg) {
        NSLog(@"erroe:%@",errorMsg);
    }];
}
-(void)makeUI{
    //      展示模板的scrollView
    wishScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64-49)];
    [self.view addSubview:wishScrollView];
    wishScrollView.pagingEnabled = YES;
    wishScrollView.backgroundColor = [UIColor yellowColor];
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
    UIView *botView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh-49, wid, 49)];
    botView.backgroundColor = RGBCOLOR(210, 201, 102);
    UIButton *backgroundbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    backgroundbutton.frame =CGRectMake(0, 0, wid/2, 49);
    [backgroundbutton setTitle:@"背景" forState:UIControlStateNormal];
    [backgroundbutton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:backgroundbutton];
    UIButton *musicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    musicButton.frame =CGRectMake(wid/2, 0, wid/2, 49);
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
    
}
-(void)musicButtonClick{
    
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
