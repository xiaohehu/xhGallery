//
//  XHGalleryViewController.m
//  XHGallery
//
//  Created by Xiaohe Hu on 12/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "XHGalleryViewController.h"
#import "embModelController.h"

@interface XHGalleryViewController ()<UIPageViewControllerDelegate>

// Page View
@property (nonatomic, readwrite)        NSInteger               currentPage;
@property (readonly, strong, nonatomic) embModelController		*modelController;
@property (readonly, strong, nonatomic) NSArray					*arr_pageData;
@property (strong, nonatomic)           UIPageViewController	*pageViewController;

@end

@implementation XHGalleryViewController

- (id)init
{
    if (self == [super init]) {
        self.view.backgroundColor = [UIColor redColor];
        [self performSelector:@selector(initPageView:) withObject:nil afterDelay:1.0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Set up page view

-(void)initPageView:(NSInteger)index {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self.modelController;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.autoresizesSubviews =YES;
    self.pageViewController.view.frame = self.view.bounds;
    [self.pageViewController didMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    [self.pageViewController.view setBackgroundColor:[UIColor whiteColor]];
    
//    [self loadPage:(int)index];
}

-(void)loadPage:(int)page {
    
    embDataViewController *startingViewController = [self.modelController viewControllerAtIndex:page storyboard:self.storyboard];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
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
