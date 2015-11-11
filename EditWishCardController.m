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
#import "Masonry.h"
#import "SettingController.h"
#import "AFNetworking.h"
#import "H5BGMViewController.h"
#import "NotesXMLParser.h"
#import "ChooseImageViewController.h"

#define krgb(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f]
@interface EditWishCardController ()<UIScrollViewDelegate,UITextViewDelegate,H5BGMDelegate,PECropViewControllerDelegate,ChooseImageStyle>
{
    NSMutableArray *dataArray;  //容量大数组
    UIImageView *bgImageView;   //背景图片
    UIScrollView *wishScrollView;  //展示模板Page的scrollView
    UIPageControl *pagecontrol;   //小白点
    UILabel *label;               //更改文字的临时label
    UIImageView *imageView; //更改图片的临时imageView
    NSMutableDictionary *lableAttrDictionary;
    UIView *editView;
    UITextView *textView;
    NSMutableAttributedString *attr; //字体属性
    NSInteger lenth ;//所选文字字体长度
    NSInteger labelTag; //临时存贮tag值
    UIView *maskView;
    UIButton *resignFirstResponderButton;
    UIView *buttomView;
    UIView *topView;
    NSInteger currentScrollViewPage;
    NSMutableDictionary *tagDic;  // 找出第几页  确定dataArray【tagDic】 从而确定model  再设置model里的一个bool来区分是否改过此控件
    
    
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
     [self addimage:nil title:@"合成" selector:@selector(makeClick) location:NO];
    [self addTiTle:self.name];
    [self requestData];
    currentScrollViewPage = 0;
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
//                NSLog(@"propertiesDic::%@",propertiesDic);
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
        imageView = [[UIImageView alloc] init];
        [self createToolBar];
    } failed:^(NSString *errorMsg) {
        NSLog(@"erroe:%@",errorMsg);
    }];
}
-(void)makeUI{
    //      展示模板的scrollView
     lableAttrDictionary = [NSMutableDictionary dictionaryWithCapacity:1000];
    tagDic = [[NSMutableDictionary alloc] init];
    wishScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, wid, heigh-113-wishTop)];
    [self.view addSubview:wishScrollView];
     wishScrollView.pagingEnabled = YES;
    wishScrollView.delegate =self;
    wishScrollView.showsHorizontalScrollIndicator = NO;
    wishScrollView.contentSize = CGSizeMake(dataArray.count*wid, 0);
    if (dataArray.count>0) {
        for (NSInteger i=0; i<dataArray.count; i++) {
            EditWishCardBean *model = dataArray[i];
            bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(wid*i+wishLeft/2, 0, wid-wishLeft,  heigh-113-wishTop)];
            for (EditWishCardModel *tagModel in model.modelDataArray) {
                if ([tagModel.conntent_type integerValue] ==3) {
                    //做个字典  存背景图的tag
                    [tagDic setValue:[NSString stringWithFormat:@"%@",tagModel.conntent_id] forKey:[NSString stringWithFormat:@"%ld",i+20151110]];
                    bgImageView.tag = [tagModel.conntent_id integerValue];
                }
            }
           
            bgImageView.userInteractionEnabled = YES;
            [wishScrollView addSubview:bgImageView];
            for (NSInteger j=0; j<model.modelDataArray.count; j++) {
                EditWishCardModel *editModel =model.modelDataArray[j];
                /**
                 *  label
                 *  @param type =2
                 *  @return label
                 */
                if ([editModel.conntent_type integerValue] ==2) {
                    label =[[UILabel alloc] init];
                    label.tag = [editModel.conntent_id integerValue];

                    label.frame = CGRectMake([self getIntgerFromNSstringWithString:editModel.css_left]*(wid-wishLeft)/wishWid, [self getIntgerFromNSstringWithString:editModel.css_top]* (heigh-113-wishTop)/wishHeigh, [editModel.css_width integerValue]*(wid-wishLeft)/wishWid, [editModel.css_height integerValue]*(heigh-113-wishTop)/wishHeigh);
                    if (editModel.css_backgroundColor.length>=10) {
                        NSArray *arr =[self colorFormString:editModel.css_backgroundColor];
                        label.backgroundColor = RGBACOLOR([arr[0] integerValue], [arr[1] integerValue], [arr[2] integerValue],[arr[3] floatValue]);
                    }
                    if (editModel.css_borderColor.length>=10) {
                        NSArray *arr =[self colorFormString:editModel.css_borderColor];
                        label.layer.borderColor = RGBACOLOR([arr[0] integerValue], [arr[1] integerValue], [arr[2] integerValue],[arr[3] floatValue]).CGColor;
                    }
                    label.layer.borderWidth = [self getIntgerFromNSstringWithString:editModel.css_borderWidth];
                    NSLog(@"css_borderRadius:::%ld",[self getIntgerFromNSstringWithString:editModel.css_borderRadius]);
                    label.layer.cornerRadius = [self getIntgerFromNSstringWithString:editModel.css_borderRadius]*(heigh-113-wishTop)/320;
                    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[editModel.conntent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                    label.attributedText = attrStr;
//                    [label drawTextInRect:UIEdgeInsetsInsetRect(label.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
                    label.numberOfLines=0;
                    label.userInteractionEnabled = YES;
                    [lableAttrDictionary setObject:attrStr forKey:[NSString stringWithFormat:@"%@",editModel.conntent_id]];
                    UITapGestureRecognizer *tapLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelEditting:)];
                    [label addGestureRecognizer:tapLabelGesture];

                    [bgImageView insertSubview:label atIndex:[editModel.css_zIndex integerValue]];
//                    [bgImageView addSubview:label];
                }
                /**
                 *  imageView
                 *
                 *  @param type = 4
                 *
                 *  @return imageView
                 */
                else if ([editModel.conntent_type integerValue] ==4) {
                    UIImageView *imgView=[[UIImageView alloc] init];
                    imgView.frame =CGRectMake([self getIntgerFromNSstringWithString:editModel.css_left]*(wid-wishLeft)/wishWid, [self getIntgerFromNSstringWithString:editModel.css_top]*(heigh-113-wishTop)/wishHeigh, [editModel.css_width integerValue]*(wid-wishLeft)/wishWid, [editModel.css_height integerValue]*(heigh-113-wishTop)/wishHeigh);
                    NSString *urlString =[NSString stringWithFormat:@"%@/Uploads/%@",kWishCardAddr,editModel.Pro_src];
                    NSURL *url =[NSURL URLWithString:urlString];
                    [imgView setImageWithURL:url placeholderImage:nil];
                    imgView.userInteractionEnabled = YES;
                    imgView.tag = [editModel.conntent_id integerValue];
                    imgView.layer.masksToBounds = YES;
                    imgView.layer.borderWidth = [self getIntgerFromNSstringWithString:editModel.css_borderWidth];
                    if (editModel.css_borderColor.length>=10) {
                        NSArray *arr =[self colorFormString:editModel.css_borderColor];
                        imgView.layer.borderColor = RGBACOLOR([arr[0] integerValue], [arr[1] integerValue], [arr[2] integerValue],[arr[3] floatValue]).CGColor;
                    }
                    if (editModel.css_borderRadius.length>0) {
                        imgView.layer.cornerRadius =
                        [self getIntgerFromNSstringWithString:editModel.css_borderRadius]*wishWid/wishHeigh;

                    }
                    UITapGestureRecognizer *imageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageEditting:)];
                    [imgView addGestureRecognizer:imageGesture];
                    [bgImageView insertSubview:imgView atIndex:[editModel.css_zIndex integerValue]];
//                     [bgImageView addSubview:imgView];
                }
                /**
                 *  背景imageView
                 *  @param type = 3
                 *  @return 背景imageView
                 */
                else if ([editModel.conntent_type integerValue] ==3) {
//                    //做个字典  存背景图的tag
//                    [tagDic setValue:[NSString stringWithFormat:@"%@",editModel.conntent_id ] forKey:[NSString stringWithFormat:@"%ld",currentScrollViewPage]];
//                    bgImageView.tag = [editModel.conntent_id integerValue];;
                    NSString *urlString =[NSString stringWithFormat:@"%@/Uploads/%@",kWishCardAddr,editModel.Pro_imgSrc];
                    NSURL *url =[NSURL URLWithString:urlString];
                    [bgImageView setImageWithURL:url placeholderImage:nil];
                }
            }
        }
        pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(wid/2-50, CGRectGetMaxY(wishScrollView.frame)+10, 100, 10)];
        pagecontrol.numberOfPages = dataArray.count;
        pagecontrol.pageIndicatorTintColor =RGBCOLOR(144, 144, 144);
        pagecontrol.currentPageIndicatorTintColor = RGBCOLOR(0, 165, 223);
        pagecontrol.tag = 600;
        [self.view addSubview:pagecontrol];
    }
   //       底下的View
    UIView *botView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh-49, wid, 49)];
    botView.backgroundColor=[UIColor whiteColor];
    UIButton *backgroundbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    backgroundbutton.frame =CGRectMake(0, 0, wid/3, 49);
    backgroundbutton.backgroundColor=[UIColor whiteColor];
    [backgroundbutton setTitleColor:[UIColor grayColor]   forState:UIControlStateNormal];
    [backgroundbutton setTitle:@"背景" forState:UIControlStateNormal];
    [backgroundbutton setImage:[UIImage imageNamed:@"背景"] forState:UIControlStateNormal];
    [backgroundbutton setImageEdgeInsets:UIEdgeInsetsMake(-15, 25, 0, 0)];
    [backgroundbutton setTitleEdgeInsets:UIEdgeInsetsMake(28, -25, 0, 0)];
    backgroundbutton.titleLabel.font =[UIFont systemFontOfSize:14];
    [backgroundbutton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:backgroundbutton];
    UIButton *musicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    musicButton.frame =CGRectMake(wid/3, 0, wid/3, 49);
    [musicButton setTitle:@"音乐" forState:UIControlStateNormal];
    [musicButton setTitleColor:[UIColor grayColor]   forState:UIControlStateNormal];
    [musicButton setImage:[UIImage imageNamed:@"音乐‘"] forState:UIControlStateNormal];
    [musicButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 25, 0, 0)];
    [musicButton setTitleEdgeInsets:UIEdgeInsetsMake(28, -25, 0, 0)];
    musicButton.titleLabel.font =[UIFont systemFontOfSize:14];
    [musicButton addTarget:self action:@selector(musicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:musicButton];
    UIButton *settingButton =[UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame =CGRectMake(2*wid/3, 0, wid/3, 49);
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingButton setTitleColor:[UIColor grayColor]   forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [settingButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 25, 0, 0)];
    [settingButton setTitleEdgeInsets:UIEdgeInsetsMake(28, -25, 0, 0)];
    settingButton.titleLabel.font =[UIFont systemFontOfSize:14];
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:settingButton];

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
    NSString *sss =[NSString stringWithFormat:@"%@",string];
    if ([sss rangeOfString:@"p"].location==NSNotFound){
        return [sss integerValue];
    }
    NSArray *array = [sss componentsSeparatedByString:@"p"];
    NSString *lastString =array[0];
    NSLog(@"lastString:%@",lastString);
    return [lastString integerValue];
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
//   合成 按钮
-(void)makeClick{
    NSMutableArray *pagelistArray =[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<dataArray.count; i++) {
        NSDictionary *dic1 =[[NSDictionary alloc] init];
        NSMutableArray *jsonArray =[[NSMutableArray alloc] init];
        EditWishCardBean *model = dataArray[i];
        for (NSInteger j=0; j<model.modelDataArray.count; j++) {
            EditWishCardModel *editModel =model.modelDataArray[j];
            if (editModel.judgeBool) {
                if ([[NSString stringWithFormat:@"%@",editModel.conntent_type] isEqualToString:@"2"]) {
                    NSLog(@"%@",editModel.conntent_id);
                    NSDictionary *jsonDic1 =@{@"type":editModel.conntent_type,@"content":editModel.conntent,@"id":editModel.conntent_id};
                    [jsonArray addObject:jsonDic1];

                }
                else if ([[NSString stringWithFormat:@"%@",editModel.conntent_type] isEqualToString:@"4"]){
                    NSDictionary *jsonDic2 =@{@"type":editModel.conntent_type,@"content":editModel.Pro_src,@"id":editModel.conntent_id};
                    [jsonArray addObject:jsonDic2];
                }
                else if ([[NSString stringWithFormat:@"%@",editModel.conntent_type] isEqualToString:@"3"]){
                    NSDictionary *jsonDic2 =@{@"type":editModel.conntent_type,@"content":editModel.Pro_imgSrc,@"id":editModel.conntent_id};
                    [jsonArray addObject:jsonDic2];
                }
            }
        }
        if (jsonArray.count>0) {
            dic1 =@{@"pageid":model.Id,@"jsonarray":jsonArray};
            [pagelistArray addObject:dic1];
        }
    }
    NSLog(@"pagelistArray::%@",pagelistArray);
    
    NSString *urlString =[Url postWishCard];
    NSLog(@"urlString:%@",urlString);
    NSString *jsonString = [pagelistArray JSONString];
     NSDictionary *dic =@{@"id":self.Id,@"scenename":@"遗失的美好",@"pagelist":jsonString,@"uid":@"1",@"anchorid":@"1"};
    NSLog(@"dic:%@",dic);
    [Netmanager PostRequestWithUrlString:urlString parms:dic finished:^(id responseobj) {
        NSLog(@"responseObj:%@",responseobj);
//        if ([responseobj[@"resCode"] isEqualToString:@"00000"]) {
            NSString *succeedString =responseobj[@"url"];
            NSLog(@"succeedString:%@",succeedString);
//        }else{
//            NSLog(@"合成失败");
//        }
    } failed:^(NSString *errorMsg) {
        NSLog(@"error:%@",errorMsg);
    }];
}
//  post图片实例
-(void)backgroundButtonClick{
    ChooseImageViewController *cvc = [[ChooseImageViewController alloc] init];
    cvc.delegate = self;
    //    UIImageView *bImageView = [[UIImageView alloc] init];
//    imageView = (UIImageView *)[self.view viewWithTag:120151110+currentScrollViewPage];
//    EditWishCardBean *model =dataArray[currentScrollViewPage];
    NSString *tagStr =[tagDic objectForKey:[NSString stringWithFormat:@"%ld",currentScrollViewPage+20151110]];
    
    NSLog(@"tagStr::%@,,,%@",tagDic,tagStr);
     imageView = (UIImageView *)[self.view viewWithTag:[tagStr integerValue]];
    CGRect rect =  [self getFrameSizeForImage:imageView.image inImageView:imageView];
    cvc.imageRect = rect;
    CGFloat width = imageView.image.size.width;
    CGFloat height = imageView.image.size.height;
    CGFloat aspectRatio = width/height;
    cvc.cropAspectRatio = aspectRatio;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cvc];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}
-(void)musicButtonClick{
    NSLog(@"music");
    H5BGMViewController *hvc = [[H5BGMViewController alloc] init];
    hvc.delegate = self;
    [self.navigationController pushViewController:hvc animated:YES];
}
-(void)settingButtonClick{
    NSLog(@"setting  ");
    SettingController *setVC =[[SettingController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = floor((scrollView.contentOffset.x - wid / 2)/wid)+1;
    pagecontrol.currentPage = page;
    currentScrollViewPage = page;

}
#pragma mark - tapGesture
//  点击label
- (void)tapLabelEditting:(UITapGestureRecognizer *)ges{
//    [self creatEditModeUI];
    [UIView animateWithDuration:0.3 animations:^{
        [self creatEditModeUI];
    } completion:nil];
    label = (UILabel *)[self.view viewWithTag:ges.view.tag];
    labelTag = ges.view.tag;
    label.numberOfLines = 0;
    NSString *key = [NSString stringWithFormat:@"%ld", ges.view.tag];
    attr = [lableAttrDictionary objectForKey:key];
    lenth = [attr.string length];
    textView.editable  = YES;
    NSRange textRange = NSMakeRange (0, lenth);
    
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
//  点击图片
- (void)tapImageEditting:(UITapGestureRecognizer *)ges{
    [self tapImageClick];
    
    imageView = (UIImageView *)[self.view viewWithTag:ges.view.tag];
    
}

#pragma mark - textView Delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView commitAnimations];
    return YES;
}
//     点击编辑文字的确定  触发
- (void) resignFirstResponder:(UIButton *) sender{
    [resignFirstResponderButton removeFromSuperview];
    label = (UILabel *)[self.view viewWithTag:labelTag];
    [attr replaceCharactersInRange:NSMakeRange(0, lenth) withString:textView.text];
    label.attributedText = attr;
    [textView resignFirstResponder];
    editView.frame = CGRectMake(0, -1, wid, 64);
    [maskView removeFromSuperview];
    
#pragma mark - xml
    NSString * html111String = @"<font color=\"#ffffff\"><span style=\"line-height: 13px;\"><font size=\"5\">为了</font><font size=\"2\">寻你，我错过了许多的良辰美景，错过了闲看花开花落的心情，可我不后悔。因为你是我今生最美的遇见；寻得你，我就拥有了全世界的花开颜色。你的到来，为我拂去了浪迹天涯的孤独，我漂泊的灵魂再也不用辗转流连于亭台楼榭之间，湄湄云水之上。</font>\n</span>\n</font>";

    NotesXMLParser *parser = [NotesXMLParser new];
    //    NotesTBXMLParser *parser = [NotesTBXMLParser new];
    //开始解析
    [parser startString:html111String];

//    NSString *ssss =[NSData ]
    
    
    NSData *htmlData = [attr dataFromRange:NSMakeRange(0, [attr length]) documentAttributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} error:nil];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];

//    for (EditWishCardBean *model in dataArray) {
        EditWishCardBean *model =dataArray[currentScrollViewPage];
        for (EditWishCardModel *editModel in model.modelDataArray) {
            if ([[NSString stringWithFormat:@"%@",editModel.conntent_id] isEqualToString:[NSString stringWithFormat:@"%ld",label.tag]]) {
                NSLog(@"editmodel:%@,,,%ld",editModel.conntent_id,label.tag);
                NSLog(@"%@",editModel.conntent);
                editModel.judgeBool =YES;
                if ([[NSString stringWithFormat:@"%@",editModel.conntent_type] isEqualToString:@"2"]) {
                    editModel.conntent =htmlString;
                }
            }
        }
//    }
}
#pragma mark -  H5BGMDelegate 回传背景音乐ID
- (void)sendBMGId:(NSString *)Id{
    NSLog(@"!!!!!!!!%@",Id);
}
-(void)createToolBar{
    topView =[[UIView alloc] initWithFrame:CGRectMake(0, heigh, wid, heigh-64-100)];
    topView.backgroundColor = [UIColor blackColor];
    topView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [topView addGestureRecognizer:tap];
    topView.alpha = 0.7;
    [self.view addSubview:topView];
    buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, heigh, wid, 100)];
    buttomView.backgroundColor = RGBACOLOR(0, 20, 41, 1);
//    UIImage *chageImage = [UIImage imageNamed];
//    UIImage *clipImage = [UIImage imageNamed:];

    NSArray *titleArray =@[@"EdittingWishCard_Image_changeImage",@"EdittingWishCard_Image_clipImage"];
    
    for (NSInteger i=0; i<2; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.frame =CGRectMake(i*wid/2+10, 25, wid/2-20, 50);
        itemButton.tag = i+20151109;
        [itemButton setBackgroundImage:[UIImage imageNamed:titleArray[i]] forState:UIControlStateNormal];
//        [itemButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(handelImage:) forControlEvents:UIControlEventTouchUpInside];
        [buttomView addSubview:itemButton];
    }
    [self.view addSubview:buttomView];
}
#pragma mark - 更换图片
- (void)handelImage:(UIButton *)btn{
    if (btn.tag==20151109) {
         //选择图片
        ChooseImageViewController *cvc = [[ChooseImageViewController alloc] init];
        cvc.delegate = self;
        CGRect rect =  [self getFrameSizeForImage:imageView.image inImageView:imageView];
        cvc.imageRect = rect;
        CGFloat width = imageView.image.size.width;
        CGFloat height = imageView.image.size.height;
        CGFloat aspectRatio = width/height;
        cvc.cropAspectRatio = aspectRatio;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cvc];
        
        [self presentViewController:navigationController animated:YES completion:NULL];
        
    }else if (btn.tag==20151110){
        //裁剪图片
        
        PECropViewController *controller = [[PECropViewController alloc] init];
        controller.delegate = self;
        controller.image = imageView.image;
        CGFloat width = imageView.image.size.width;
        CGFloat height = imageView.image.size.height;
        CGFloat aspectRatio = width/height;
        controller.cropAspectRatio = aspectRatio;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navigationController animated:YES completion:NULL];
    }
}
//   出现buttomView
-(void)tapImageClick{
    topView.frame = CGRectMake(0, 64, wid, heigh-64-100);
    [UIView animateWithDuration:0.5 animations:^{
      buttomView.frame = CGRectMake(0, heigh-100, wid, 100);
    } completion:nil];
}
//   topView botView  点击消失
-(void)tapClick{
    topView.frame = CGRectMake(0, heigh, wid,  heigh-64-100);
    [UIView animateWithDuration:0.3 animations:^{
        buttomView.frame =CGRectMake(0, heigh, wid, 100);
    } completion:^(BOOL finished) {
    }];
}
//   换图片 裁剪图片 点击事件
-(void)bottomBarDisAppear{
    NSLog(@"现在第几页:%ld",(long)currentScrollViewPage);
     NSLog(@"imageView.tag:%ld",(long)imageView.tag);
    NSString *urlString =[Url postImage];
    NSLog(@"postImage:%@",urlString);
    UIImage *image =imageView.image;
    NSData *imageData = UIImageJPEGRepresentation(image,0.1);
//    NSData *imageData = UIImagePNGRepresentation(image);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"1.png" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        NSLog(@"responseObject::%@",responseObject);
//        for (EditWishCardBean *model in dataArray) {
         EditWishCardBean *model =dataArray[currentScrollViewPage];
            for (EditWishCardModel *editModel in model.modelDataArray) {
                if ([[NSString stringWithFormat:@"%@",editModel.conntent_id] isEqualToString:[NSString stringWithFormat:@"%ld",(long)imageView.tag]]) {
                    NSLog(@"editmodel:%@,,,%ld",editModel.conntent_id,(long)imageView.tag);
                    NSLog(@"%@",editModel.conntent);
                    editModel.judgeBool =YES;
                    if ([[NSString stringWithFormat:@"%@",editModel.conntent_type] isEqualToString:@"4"]) {
                        editModel.Pro_src =responseObject[@"path"];
                    }
                    if ([[NSString stringWithFormat:@"%@",editModel.conntent_type] isEqualToString:@"3"]) {
                        editModel.Pro_imgSrc =responseObject[@"path"];
                    }
                }
            }
//        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        NSLog(@"%@",error);
    }];
    
    

    
    topView.frame = CGRectMake(0, heigh, wid,  heigh-64-100);
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, wid, heigh);
        buttomView.frame =  CGRectMake(0, heigh, wid, 100);
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
                 transform:(CGAffineTransform)transform
                  cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    imageView.image = croppedImage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    controller.keepingCropAspectRatio = YES;
    [self bottomBarDisAppear];
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    [self bottomBarDisAppear];
    
}

#pragma mark - ChooseImageDelegate

- (void)getImageFromChooseImageStyle:(UIImage *)image{
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self bottomBarDisAppear];
    
}

- (CGRect)getFrameSizeForImage:(UIImage *)image inImageView:(UIImageView *)ImageView {
    
    float hfactor = image.size.width / ImageView.frame.size.width;
    float vfactor = image.size.height / ImageView.frame.size.height;
    
    float factor = fmax(hfactor, vfactor);
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    float newWidth = image.size.width / factor;
    float newHeight = image.size.height / factor;
    
    // Then figure out if you need to offset it to center vertically or horizontally
    float leftOffset = (imageView.frame.size.width - newWidth) / 2;
    float topOffset = (imageView.frame.size.height - newHeight) / 2;
    leftOffset += wid/12.8;
    topOffset += heigh/19;
    return CGRectMake(leftOffset, topOffset, newWidth, newHeight);
    
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
