//
//  ViewController.m
//  XHGallery
//
//  Created by Xiaohe Hu on 12/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "ViewController.h"
#import "XHGalleryViewController.h"

@interface ViewController () <XHGalleryDelegate>

@property (nonatomic, strong)   XHGalleryViewController *gallery;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return  YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tapButton:(id)sender {

    _gallery = [[XHGalleryViewController alloc] init];
    _gallery.delegate = self;
    _gallery.view.frame = CGRectMake(0.0, 0.0, 200, 200);
//    _gallery.showNavBar = NO;
//    _gallery.showCaption = NO;
    [self addChildViewController:_gallery];
    [self.view addSubview: _gallery.view];
}

- (void)didRemoveFromSuperView
{
    [UIView animateWithDuration:0.33
                     animations:^{
                         _gallery.view.alpha = 0.0;
                     } completion:^(BOOL finshed){
                         [_gallery.view removeFromSuperview];
                         [_gallery removeFromParentViewController];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
