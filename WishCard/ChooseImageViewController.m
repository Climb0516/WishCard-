//
//  ChooseImageViewController.m
//  WishCard
//
//  Created by 张鹤楠 on 15/11/9.
//  Copyright © 2015年 GuoguangGaoTong. All rights reserved.
//

#import "ChooseImageViewController.h"
#import "PECropViewController.h"
#define BUTTON_GAP 10
#define BUTTON_WIDTH (wid-10*4)/3

@interface ChooseImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,PECropViewControllerDelegate>
{
    UIImage *tempImage;//从picker中取出的TEMP IMAGE
}

@end

@implementation ChooseImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
     [self addimage:[UIImage imageNamed:@"back-icon"] title:nil selector:@selector(backClick) location:YES];
    [self layoutChooseImageStyle];
}

- (void)layoutChooseImageStyle{
    UIButton *chooseImageFromLiabreyButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_GAP, 64+BUTTON_GAP, BUTTON_WIDTH, BUTTON_WIDTH)];
    chooseImageFromLiabreyButton.backgroundColor = [UIColor redColor];
    [chooseImageFromLiabreyButton addTarget:self action:@selector(chooseImageFromLib:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:chooseImageFromLiabreyButton];
}

- (void)chooseImageFromLib:(UIButton *)btn{
    UIImagePickerController *pvc = [[UIImagePickerController alloc] init];
    pvc.delegate = self;
    pvc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pvc animated:YES completion:nil];
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    tempImage = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)openEditor{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = tempImage;
    controller.cropAspectRatio = self.cropAspectRatio;
    //    UIImage *image = self.imageView.image;
    //    CGFloat width = image.size.width;
    //    CGFloat height = image.size.height;
    //    CGFloat length = MIN(width, height);
    //    controller.imageCropRect = CGRectMake((width - length) / 2,
    //                                          (height - length) / 2,
    //                                          length,
    //                                          length);
    //    controller.imageCropRect = _imageRect;
    //    controller.cropAspectRatio = 1.0f/1.0f;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
                 transform:(CGAffineTransform)transform
                  cropRect:(CGRect)cropRect
{
    //     [self.navigationController popViewControllerAnimated:YES];
    //    [controller popoverPresentationController];
    [controller dismissViewControllerAnimated:YES completion:nil];
    tempImage = croppedImage;
    controller.keepingCropAspectRatio = YES;
    [self sendChooseImage];
    [self backClick];
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)sendChooseImage{
    if ([_delegate respondsToSelector:@selector(getImageFromChooseImageStyle:)]) {
        [_delegate getImageFromChooseImageStyle:tempImage];
    }
}



-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
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
