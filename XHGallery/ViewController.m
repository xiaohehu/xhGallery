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
{
    CGRect                      viewFrame;
    NSArray                     *arr_rawData;
}
@property (nonatomic, strong)   XHGalleryViewController *gallery;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return  YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareGalleryData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    viewFrame = self.view.bounds;
}
//----------------------------------------------------
#pragma mark - Gallery View
//----------------------------------------------------
/*
 *To make sure the frame correct under iOS7,
 *Call thre createGallery method in ViewDidAppear:
 */
- (void)createGallery:(int)startIndex
{
    _gallery = [[XHGalleryViewController alloc] init];
    _gallery.delegate = self;
    _gallery.startIndex = startIndex;
    _gallery.view.frame = viewFrame;
    _gallery.arr_rawData = [arr_rawData objectAtIndex:0];
//    _gallery.view.frame = CGRectMake(0.0, 0.0, 400, 300);
//    _gallery.showNavBar = NO;
//    _gallery.showCaption = NO;
}
/*
 * Prepare data from plist
 */
- (void)prepareGalleryData
{
    NSString *url = [[NSBundle mainBundle] pathForResource:@"photoData" ofType:@"plist"];
    arr_rawData = [[NSArray alloc] initWithContentsOfFile:url];
}

// Button's action to load gallery
- (IBAction)tapButton:(id)sender {
    [self createGallery:4];
    [self addChildViewController:_gallery];
    [self.view addSubview: _gallery.view];
}
- (IBAction)tapStartButton:(id)sender {
    [self createGallery:0];
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
