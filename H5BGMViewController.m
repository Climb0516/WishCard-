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
}
@end

@implementation H5BGMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *str =  @"http://192.168.3.3:90/Uploads/syspic/mp3/yq0KA1R9XYCAVcSWAA8tADeZN1g520.mp3";
//    AVPlayer *newPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:str]];
    [self requestData];
    [self creatUI];
}

- (void)creatUI{
    musicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64)];
    musicTableView.delegate = self;
    musicTableView.dataSource = self;

    [self.view addSubview:musicTableView];
}

- (void)requestData{
    musicDataArray = [[NSMutableArray alloc] init];
    [musicDataArray addObject:@"s"];
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
            [musicDataArray addObject:bmodel];
            NSLog(@"ff");
        }
    }failed:^(NSString *errorMsg){
        NSLog(@"BGMerror:%@",errorMsg);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [musicDataArray count];
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    BGMModel *model = musicDataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
