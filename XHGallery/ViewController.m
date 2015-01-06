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
    NSMutableArray              *arr_galleryFiles;
    NSMutableArray              *arr_galleryCaptions;
    NSMutableArray              *arr_contentType;
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
- (void)createGallery
{
    [self prepareGalleryData];
    
    _gallery = [[XHGalleryViewController alloc] init];
    _gallery.delegate = self;
    _gallery.arr_images = [[NSArray alloc] initWithArray:arr_galleryFiles];
    _gallery.arr_captions = [[NSArray alloc] initWithArray: arr_galleryCaptions];
    _gallery.arr_fileType = [[NSArray alloc] initWithArray:arr_contentType];
    _gallery.startIndex = 4;
    _gallery.view.frame = viewFrame;
//    _gallery.view.frame = CGRectMake(0.0, 0.0, 400, 300);
//    _gallery.showNavBar = NO;
//    _gallery.showCaption = NO;
}

- (void)prepareGalleryData
{
    NSString *url = [[NSBundle mainBundle] pathForResource:@"photoData" ofType:@"plist"];
    NSArray *arr_rawData = [[NSArray alloc] initWithContentsOfFile:url];
    [arr_contentType removeAllObjects];
    arr_contentType = nil;
    arr_contentType = [[NSMutableArray alloc] init];
    [arr_galleryFiles removeAllObjects];
    arr_galleryFiles = nil;
    arr_galleryFiles = [[NSMutableArray alloc] init];
    [arr_galleryCaptions removeAllObjects];
    arr_galleryCaptions = nil;
    arr_galleryCaptions = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict_tmp in arr_rawData[0]) {
        [arr_galleryFiles addObject: [dict_tmp objectForKey:@"file"]];
        [arr_galleryCaptions addObject: [dict_tmp objectForKey:@"caption"]];
        [arr_contentType addObject: [dict_tmp objectForKey:@"type"]];
    }
}

- (IBAction)tapButton:(id)sender {
    [self createGallery];
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
