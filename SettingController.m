//
//  SettingController.m
//  WishCard
//
//  Created by WangPandeng on 15/11/6.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()<UITextViewDelegate>

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTiTle:@"设置"];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self addimage:nil title:@"确定" selector:@selector(saveClick) location:NO];
    [self createUI];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveClick{
    
}
-(void)createUI{
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
//     名字
    UIImageView *nameImageView = [[UIImageView alloc] init];
    nameImageView.image = [UIImage imageNamed:@"名字"];
    [self.view addSubview:nameImageView];
    
    
    UITextView *nameTextView = [[UITextView alloc] init];
    nameTextView.backgroundColor = RGBCOLOR(255, 255, 255);
    nameTextView.textColor = RGBCOLOR(68, 68, 68);
    nameTextView.font = [UIFont systemFontOfSize:15];
    nameTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:nameTextView];
//     描述
    UIImageView *desImageView = [[UIImageView alloc] init];
    desImageView.image = [UIImage imageNamed:@"描述"];
    [self.view addSubview:desImageView];
    UITextView *desTextView = [[UITextView alloc] init];
    desTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    desTextView.textColor = RGBCOLOR(102, 102, 102);
    desTextView.font = [UIFont systemFontOfSize:14];

    [self.view addSubview:desTextView];
    [nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(64+18);
        make.size.mas_equalTo(CGSizeMake(192, 16));
    }];

    [nameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(nameImageView.mas_bottom).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(wid-20, 45));
    }];

    [desImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(nameTextView.mas_bottom).with.offset(22);
        make.size.mas_equalTo(CGSizeMake(192, 16));
    }];

    [desTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(desImageView.mas_bottom).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(wid-20, 150));
    }];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
