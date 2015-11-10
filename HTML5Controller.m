//
//  HTML5Controller.m
//  WishCard
//
//  Created by WangPandeng on 15/10/30.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "HTML5Controller.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "EditWishCardController.h"

@interface HTML5Controller ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    UIWebView *webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@end

@implementation HTML5Controller
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTiTle:self.model.name];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self addimage:nil title:@"使用" selector:@selector(goEdit) location:NO];
    [self WebView];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goEdit{
    EditWishCardController *editVC =[[EditWishCardController alloc] init];
    editVC.Id = self.model.Id;
    editVC.name =self.model.name;
    [self.navigationController pushViewController:editVC animated:YES];
}
-(void)editButtonClick{
    [self goEdit];
}
#pragma mark - UIload
-(void)WebView{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-64)];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    NSURL *url =[NSURL URLWithString:self.model.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    //    webView.delegate =self;
    //     加着句话是为了让webView能播放声音
    webView.mediaPlaybackRequiresUserAction=NO;
    [self.view addSubview:webView];
    
    UIButton *editButton =[UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(wid/2-37.5, heigh-100, 75, 75);
    [editButton setImage:[UIImage imageNamed:@"使用"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    
    
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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
