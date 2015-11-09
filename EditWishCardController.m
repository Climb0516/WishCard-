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
#import "H5BGMViewController.h"
//#import "TFHpple.h"
//#import "TFHppleElement.h"

#define krgb(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f]
@interface EditWishCardController ()<UIScrollViewDelegate,UITextViewDelegate,H5BGMDelegate>
{
    NSMutableArray *dataArray;  //容量大数组
    UIScrollView *wishScrollView;  //展示模板Page的scrollView
    UIPageControl *pagecontrol;   //小白点
    UILabel *label;
    NSMutableDictionary *lableAttrDictionary;
    UIView *editView;
    UITextView *textView;
    NSMutableAttributedString *attr; //字体属性
    NSInteger lenth ;//所选文字字体长度
    NSInteger labelTag; //临时存贮tag值
    UIView *maskView;
    UIButton *resignFirstResponderButton;
    UIView *buttomView;
}
@end

@implementation EditWishCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =RGBCOLOR(232, 232, 232);
    [self colorFormString:nil];
    dataArray =[[NSMutableArray alloc] init];
    [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self addTiTle:self.name];
    [self requestData];
    
}
-(void)requestData{
    NSString *urlString =[Url queryModelPagesWishId:self.Id];
    NSLog(@"urlString:%@",urlString);
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
        [self createToolBar];

    } failed:^(NSString *errorMsg) {
        NSLog(@"erroe:%@",errorMsg);
        
    }];
}
-(void)makeUI{
    //      展示模板的scrollView
    lableAttrDictionary = [NSMutableDictionary dictionaryWithCapacity:1000];
    wishScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid, 416*heigh/568)];
    [self.view addSubview:wishScrollView];
    wishScrollView.pagingEnabled = YES;
    wishScrollView.delegate =self;
    wishScrollView.showsHorizontalScrollIndicator = NO;
    wishScrollView.contentSize = CGSizeMake(dataArray.count*wid, 0);
    if (dataArray.count>0) {
        for (NSInteger i=0; i<dataArray.count; i++) {
            EditWishCardBean *model = dataArray[i];
            //            EditWishCardView *view = [[EditWishCardView alloc]initWithFrame:CGRectMake(40+i*wid, 40, wid-80, heigh-180)];
            //            [wishScrollView addSubview:view];
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(wid*i+22*wid/320, 0, wid-2*22*wid/320,  416*heigh/568)];
            bgImageView.userInteractionEnabled = YES;
            [wishScrollView addSubview:bgImageView];
            for (NSInteger i=0; i<model.modelDataArray.count; i++) {
                EditWishCardModel *editModel =model.modelDataArray[i];
                //                  label
                if ([editModel.conntent_type integerValue] ==2) {
                    NSLog(@"%@",editModel.css_left );
                    NSLog(@"%@",editModel.css_top );
                    NSLog(@"left:%ld,top:%ld",[self getIntgerFromNSstringWithString:editModel.css_left],[self getIntgerFromNSstringWithString:editModel.css_top]);
                    
                    label =[[UILabel alloc] init];
                    NSInteger tagNumber = [editModel.conntent_id integerValue];
                    label.tag = [editModel.conntent_id integerValue];
                    label.frame = CGRectMake([self getIntgerFromNSstringWithString:editModel.css_left], [self getIntgerFromNSstringWithString:editModel.css_top], [editModel.css_width integerValue]*276/320*wid/320, [editModel.css_height integerValue]*416/568*heigh/568);
                    if (editModel.css_backgroundColor.length>=10) {
                        NSArray *arr =[self colorFormString:editModel.css_backgroundColor];
                        label.backgroundColor = RGBACOLOR([arr[0] integerValue], [arr[1] integerValue], [arr[2] integerValue],[arr[3] floatValue]);
                    }
                    if (editModel.css_borderColor.length>=10) {
                        NSArray *arr =[self colorFormString:editModel.css_backgroundColor];
                        label.layer.borderColor = RGBACOLOR([arr[0] integerValue], [arr[1] integerValue], [arr[2] integerValue],[arr[3] floatValue]).CGColor;
                    }
                    label.layer.borderWidth = [self getIntgerFromNSstringWithString:editModel.css_borderWidth];
                    label.layer.cornerRadius = [self getIntgerFromNSstringWithString:editModel.css_borderRadius]*276/320*wid/320;
                    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[editModel.conntent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                    label.attributedText = attrStr;
                    label.numberOfLines=0;
                    label.userInteractionEnabled = YES;
                    //                    lableAttrDictionary[tagNumber] = [attrStr];
                    [lableAttrDictionary setObject:attrStr forKey:[NSString stringWithFormat:@"%@",editModel.conntent_id]];
                    UITapGestureRecognizer *tapLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelEditting:)];
                    [label addGestureRecognizer:tapLabelGesture];
                    
                    [bgImageView insertSubview:label atIndex:[editModel.css_zIndex integerValue]];
                    
                    //                    [bgImageView addSubview:label];
                }
                //                  图片
                else if ([editModel.conntent_type integerValue] ==4) {
                    NSLog(@"%ld,%ld",[editModel.Pro_width integerValue],[editModel.Pro_height integerValue]);
                    UIImageView *imgView=[[UIImageView alloc] init];
                    imgView.userInteractionEnabled = YES;
                    imgView.frame =CGRectMake([self getIntgerFromNSstringWithString:editModel.css_left], [self getIntgerFromNSstringWithString:editModel.css_top], [editModel.css_width integerValue]*276/320*wid/320, [editModel.css_height integerValue]*416/568*heigh/568);
                    NSString *urlString =[NSString stringWithFormat:@"http://192.168.7.1/Uploads/%@",editModel.Pro_src];
                    NSURL *url =[NSURL URLWithString:urlString];
                    [imgView setImageWithURL:url placeholderImage:nil];
                    imgView.layer.masksToBounds = YES;
                    imgView.layer.borderWidth = [self getIntgerFromNSstringWithString:editModel.css_borderWidth];
                    imgView.layer.cornerRadius = [self getIntgerFromNSstringWithString:editModel.css_borderRadius];
                    UITapGestureRecognizer *imageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageEditting:)];
                    [imgView addGestureRecognizer:imageGesture];
                    [bgImageView insertSubview:imgView atIndex:[editModel.css_zIndex integerValue]];
                    //                     [bgImageView addSubview:imgView];
                }
                //                  背景图片
                else if ([editModel.conntent_type integerValue] ==3) {
                    NSString *urlString =[NSString stringWithFormat:@"http://192.168.7.1/Uploads/%@",editModel.Pro_imgSrc];
                    NSURL *url =[NSURL URLWithString:urlString];
                    [bgImageView setImageWithURL:url placeholderImage:nil];
                    
                }
                
            }
            
        }
        
        pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(wid/2-50, CGRectGetMaxY(wishScrollView.frame)+20, 100, 10)];
        pagecontrol.numberOfPages = dataArray.count;
        pagecontrol.pageIndicatorTintColor =[UIColor lightGrayColor];
        pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
        pagecontrol.tag = 600;
        [self.view addSubview:pagecontrol];
        
    }
    //       底下的View
    UIView *botView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh-49, wid, 49)];
    UIButton *backgroundbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    backgroundbutton.frame =CGRectMake(0, 0, wid/2-0.5, 49);
    backgroundbutton.backgroundColor=[UIColor grayColor];
    [backgroundbutton setTitle:@"背景" forState:UIControlStateNormal];
    [backgroundbutton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:backgroundbutton];
    UIButton *musicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    musicButton.frame =CGRectMake(wid/2, 0, wid/2, 49);
    musicButton.backgroundColor=[UIColor grayColor];
    [musicButton setTitle:@"音乐" forState:UIControlStateNormal];
    [musicButton addTarget:self action:@selector(musicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:musicButton];
    [self.view addSubview:botView];
    [self creatEditModeUI];
    
}

- (void)creatEditModeUI{
    // 键盘上的view
    editView = [[UIView alloc] initWithFrame:CGRectMake(0, heigh, wid, 64)];
    textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, wid-10, 60)];
    textView.delegate = self;
    resignFirstResponderButton =[UIButton buttonWithType:UIButtonTypeCustom];
    resignFirstResponderButton.frame =CGRectMake(wid-45, 60, 40, 25);
    //    [resignFirstResponderButton setTitleColor:[UIColor colorWithRed:55 green:170 blue:252 alpha:1] forState:UIControlStateNormal];
    [resignFirstResponderButton setTitleColor:RGBCOLOR(55, 170, 252) forState:UIControlStateNormal];
    [resignFirstResponderButton setTitle:@"确定" forState:UIControlStateNormal];
    [resignFirstResponderButton addTarget:self action:@selector(resignFirstResponder:) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:textView];
    [editView addSubview:resignFirstResponderButton];
    [self.view addSubview:editView];
}
-( NSInteger)getIntgerFromNSstringWithString:(NSString *)string{
    //    if ([self isPureInt:string]) {
    //        return [string integerValue];
    //    }
    NSString *sss =[NSString stringWithFormat:@"%@",string];
    if ([sss rangeOfString:@"p"].location==NSNotFound){
        return [sss integerValue];
    }
    NSArray *array = [sss componentsSeparatedByString:@"p"];
    NSString *lastString =array[0];
    NSLog(@"lastString:%@",lastString);
    return [lastString integerValue];
    //    NSString *str =[sss stringByAppendingString:@"px"];
    //    NSArray *array = [string componentsSeparatedByString:@"p"];
    //    NSString *lastString =array[0];
    //
    //    return [lastString integerValue];
}
////   判断RGB
-(NSArray *)colorFormString:(NSString *)string{
    if (string.length>=8) {
        NSRange range1 = [string rangeOfString:@"("];
        NSRange range2 = [string rangeOfString:@")"];
        NSString * strings = [string substringWithRange:NSMakeRange(range1.location+1,range2.location-range1.location-1)];
        NSArray *array = [strings componentsSeparatedByString:@","];
        
        return array;
    }
    return nil;
}
#pragma mark - Click事件
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backgroundButtonClick{
    NSLog(@"backGround");
}
-(void)musicButtonClick{
    H5BGMViewController *hvc = [[H5BGMViewController alloc] init];
    hvc.delegate = self;
    [self.navigationController pushViewController:hvc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = floor((scrollView.contentOffset.x - wid / 2)/wid)+1;
    pagecontrol.currentPage = page;
}

#pragma mark - tapGesture
- (void)tapLabelEditting:(UITapGestureRecognizer *)ges{
    [self creatEditModeUI];
    label = (UILabel *)[self.view viewWithTag:ges.view.tag];
    labelTag = ges.view.tag;
//    label.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
//    label.layer.borderWidth = 10;
    label.numberOfLines = 0;
    NSString *key = [NSString stringWithFormat:@"%ld", ges.view.tag];
    attr = [lableAttrDictionary objectForKey:key];
    lenth = [attr.string length];
    textView.editable  = YES;
    NSRange textRange = NSMakeRange (0, lenth);
//    textView.attributedText = attr;
    textView.text = attr.string;
    textView.selectedRange = textRange;
    editView.frame = CGRectMake(0, heigh-(216+120), wid, 120);
    editView.backgroundColor = [UIColor whiteColor];
    maskView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, wid, heigh-(216+120))];
    maskView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self.view addSubview:maskView];
    [textView becomeFirstResponder];
    
    [self textViewShouldBeginEditing:textView];
}

#pragma mark - textView Delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView commitAnimations];
    [self addimage:nil title:@"确定" selector:@selector(resignFirstResponder:) location:NO ];
    
    
    return YES;
}

- (void) resignFirstResponder:(UIButton *) sender{
    [resignFirstResponderButton removeFromSuperview];
    label = (UILabel *)[self.view viewWithTag:labelTag];
    [attr replaceCharactersInRange:NSMakeRange(0, lenth) withString:textView.text];
    label.attributedText = attr;
    [textView resignFirstResponder];
//    wishScrollView.dragEnable = YES;
    editView.frame = CGRectMake(0, -1, wid, 64);
    [maskView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;

}
- (void)tapImageEditting:(UITapGestureRecognizer *)ges{
    [self tapImageClick];
}

#pragma mark - H5BGMDelegate
- (void)sendBMGId:(NSString *)Id{
    NSLog(@"!!!!!!!!%@",Id);
}

-(void)createToolBar{
    buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, heigh, wid, 100)];
    buttomView.backgroundColor = [UIColor lightGrayColor];
    NSArray *titleArray =@[@"更换图片",@"裁剪图片"];
    for (NSInteger i=0; i<2; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.frame =CGRectMake(i*wid/2, 0, wid/2, 40);
        itemButton.backgroundColor = [UIColor blackColor];
        [itemButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(bottomBarDisAppear) forControlEvents:UIControlEventTouchUpInside];
        [buttomView addSubview:itemButton];
    }
    [self.view addSubview:buttomView];

}

-(void)tapImageClick{
    self.navigationController.toolbar.hidden = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//    bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh, wid, 100)];
    [UIView animateWithDuration:0.5 animations:^{
        buttomView.frame = CGRectMake(0, heigh-100, wid, 100);
    } completion:nil];

    
    
}

-(void)bottomBarDisAppear{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, wid, heigh);
        buttomView.frame =  CGRectMake(0, heigh, wid, 100);
    } completion:^(BOOL finished) {
        
//        [topView removeFromSuperview];
    }];
    
    
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
