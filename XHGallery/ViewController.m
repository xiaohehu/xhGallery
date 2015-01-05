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
//----------------------------------------------------
#pragma mark - Gallery View
//----------------------------------------------------
- (IBAction)tapButton:(id)sender {

    _gallery = [[XHGalleryViewController alloc] init];
    _gallery.delegate = self;
    NSString *url = [[NSBundle mainBundle] pathForResource:@"photoData" ofType:@"plist"];
    _gallery.arr_images = [[NSArray alloc] initWithContentsOfFile:url];
    _gallery.arr_captions = [[NSArray alloc] initWithObjects:
                             @"caption 1",
                             @"caption 2",
                             @"caption 3",
                             @"caption 4",
                             @"caption 5",
                             @"caption 6",
                             @"caption 7",
                             @"caption 8",
                             @"caption 9",
                             nil];
    _gallery.startIndex = 4;
//    _gallery.view.frame = CGRectMake(0.0, 0.0, 400, 300);
//    _gallery.showNavBar = NO;
//    _gallery.showCaption = NO;
    [self addChildViewController:_gallery];
    [self.view addSubview: _gallery.view];
}
//----------------------------------------------------
#pragma mark Remove gallery delegate
//----------------------------------------------------
- (void)didRemoveFromSuperView
{
    [UIView animateWithDuration:0.33
                     animations:^{
                         _gallery.view.alpha = 0.0;
                     } completion:^(BOOL finshed){
                         [_gallery.view removeFromSuperview];
                         _gallery.view = nil;
                         [_gallery removeFromParentViewController];
                         _gallery = nil;
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
