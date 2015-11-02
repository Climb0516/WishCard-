//
//  testClipViewController.m
//  WishCard
//
//  Created by 张鹤楠 on 15/11/2.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "testClipViewController.h"
#import "ClipImageViewController.h"

@interface testClipViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView *imageView;
    UIButton *btnChooseImage;
}

@end

@implementation testClipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    btnChooseImage = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    btnChooseImage.backgroundColor = [UIColor redColor];
    [btnChooseImage setTitle:@"ddd" forState:UIControlStateNormal];
    [btnChooseImage addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:imageView];
    [self.view addSubview:btnChooseImage];
    // Do any additional setup after loading the view.
}

- (void)chooseImage{
    UIImagePickerController *pvc = [[UIImagePickerController alloc] init];
    pvc.delegate = self;
    pvc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pvc animated:YES completion:nil];
    
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self performSelector:@selector(goEditingImage:)  withObject:img afterDelay:0.5];
    }
    
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)goEditingImage:(UIImage *)img{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    [UIImageJPEGRepresentation(img, 0.4f) writeToFile:imageFilePath atomically:YES];//写入文件
    
    UIImage *selfPhoto1 = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    imageView.image = img;
    ClipImageViewController *cvc = [[ClipImageViewController alloc] init];
    cvc.navigationController.navigationBarHidden = YES;
    cvc.hidesBottomBarWhenPushed = YES;
    cvc.cilpImage = img;
    [self.navigationController pushViewController:cvc animated:YES];
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
