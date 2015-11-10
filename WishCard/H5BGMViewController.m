//
//  H5BGMViewController.m
//  WishCard
//
//  Created by 张鹤楠 on 15/11/6.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "H5BGMViewController.h"
#import "BGMModel.h"
#import <AVFoundation/AVFoundation.h>

@interface H5BGMViewController ()
{
    UITableView *musicTableView;
    NSMutableArray *musicDataArray;
    NSMutableArray *caonimaArray;
    AVPlayer *newPlayer;
    NSInteger selectedCell;
    NSString *BGMId;
}
@end

@implementation H5BGMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    newPlayer = [[AVPlayer alloc] init];
    [self requestData];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];

}

- (void)creatUI{
    musicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64)];
    musicTableView.delegate = self;
    musicTableView.dataSource = self;
    [self.view addSubview:musicTableView];
}

- (void)requestData{
    selectedCell = 0;
    musicDataArray = [[NSMutableArray alloc] init];
    BGMModel *bmodel = [[BGMModel alloc] init];
    bmodel.name = @"默认音乐";
    bmodel.Id = @"defaultMusic";
    [musicDataArray addObject:bmodel];
//    [musicDataArray addObject:@"s"];
//    NSString *url = [Url queryBGMData];
    NSString *url =  @"http://192.168.3.1:8080/radio/queryWishResource/ios/deviceid/1.0?type=2";

    [Netmanager GetRequestWithUrlString:url finished:^(NSDictionary *responseObj){
         NSArray *arr =responseObj[@"filelist"];
        for (NSDictionary *subArr in arr) {
            BGMModel *bmodel = [[BGMModel alloc] init];
            bmodel.name = [self judgeDicEmpty:subArr str:@"name"];
            NSLog(@"%@",bmodel.name);
            bmodel.Id =[self judgeDicEmpty:subArr str:@"id"];
            bmodel.name=[self judgeDicEmpty:subArr str:@"name"];
            bmodel.url =[self judgeDicEmpty:subArr str:@"url"];
            bmodel.thumburl =[self judgeDicEmpty:subArr str:@"thumburl"];
            [musicDataArray addObject:bmodel];
        }
        [self creatUI];

    }failed:^(NSString *errorMsg){
        NSLog(@"BGMerror:%@",errorMsg);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算魅族行数%lu",(unsigned long)[musicDataArray count]);

    return [musicDataArray count];
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    BGMModel *model = musicDataArray[indexPath.row];
    cell.textLabel.text = model.name;
    if (indexPath.row==selectedCell) {
        cell.imageView.image = [UIImage imageNamed:@"拖动按钮"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BGMModel *model = musicDataArray[indexPath.row];
    NSString *url = [Url queryBGMUrl:model.url];
    newPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:url]];
    selectedCell = indexPath.row;
    BGMId = model.Id;
    [newPlayer play];
    [tableView reloadData];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
    if ([_delegate respondsToSelector:@selector(sendBMGId:)]) {
        [_delegate sendBMGId:BGMId];
    }
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
