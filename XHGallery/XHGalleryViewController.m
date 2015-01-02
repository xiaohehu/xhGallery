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

//Top View
@property (nonatomic, strong)           UIView                  *uiv_topView;
@property (nonatomic, strong)           UILabel                 *uil_numLabel;
@property (nonatomic, strong)           UIButton                *uib_back;

// Bottom View
@property (nonatomic, strong)           UIView                  *uiv_bottomView;
@property (nonatomic, strong)           UILabel                 *uil_caption;
// Page View
@property (nonatomic, readwrite)        NSInteger               currentPage;
@property (readonly, strong, nonatomic) embModelController		*modelController;
@property (readonly, strong, nonatomic) NSArray					*arr_pageData;
@property (strong, nonatomic)           UIPageViewController	*pageViewController;

@end

@implementation XHGalleryViewController
@synthesize modelController = _modelController;
@synthesize delegate;
- (id)init
{
    if (self == [super init]) {
        self.view.backgroundColor = [UIColor redColor];
        _modelController = [[embModelController alloc] init];
        
        _arr_pageData = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photoData" ofType:@"plist"]] copy];
        _modelController = [[embModelController alloc] initWithImage:_arr_pageData];
        [self initPageView:4];
        _currentPage = 4;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self createTopView];
    [self createBottomView];
    [self addGestureToView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Set Tap Gesture
- (void)addGestureToView
{
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView:)];
    tapOnView.numberOfTapsRequired = 1;
    tapOnView.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer: tapOnView];
    self.view.userInteractionEnabled = YES;
}

- (void)tapOnView:(UIGestureRecognizer *)gesture
{
    if (!_uiv_topView.hidden) {
        [UIView animateWithDuration:0.33
                         animations:^{
                             _uiv_topView.alpha = 0.0;
                             _uiv_bottomView.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                             _uiv_topView.hidden = YES;
                             _uiv_bottomView.hidden = YES;
                         }];
    }
    else {
        _uiv_topView.hidden = NO;
        _uiv_bottomView.hidden = NO;
        [UIView animateWithDuration:0.33
                         animations:^{
                             _uiv_topView.alpha = 1.0;
                             _uiv_bottomView.alpha = 1.0;
                         }];
    }
}

#pragma mark - Set Up top view
- (void)createTopView
{
    _uiv_topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 45.0)];
    _uiv_topView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self.view addSubview: _uiv_topView];
    
    _uil_numLabel = [[UILabel alloc] initWithFrame:CGRectMake((1024-100)/2, 0, 100, 45)];
    _uil_numLabel.text = [NSString stringWithFormat:@"%i of %i", (int)_currentPage+1, (int)_arr_pageData.count];
    _uil_numLabel.textColor = [UIColor blackColor];
    [_uiv_topView addSubview: _uil_numLabel];
    
    _uib_back = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_back.frame = CGRectMake(0.0, 0.0, 100.0, 45.0);
    _uib_back.backgroundColor = [UIColor clearColor];
    [_uib_back setTitle:@"BACK" forState:UIControlStateNormal];
    [_uib_back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_uib_back.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_uiv_topView addSubview: _uib_back];
    [_uib_back addTarget:self action:@selector(tapBackButton:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)tapBackButton:(id)sender
{
    [self.delegate didRemoveFromSuperView];
}

#pragma mark - Set up bottom View
-(void)createBottomView
{
    _uiv_bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 768-45, 1024, 45)];
    _uiv_bottomView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self.view addSubview: _uiv_bottomView];
    
    _uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, 200.0, 45.0)];
    _uil_caption.backgroundColor = [UIColor clearColor];
    [_uil_caption setText:@"Caption"];
    [_uil_caption setTextColor: [UIColor blackColor]];
    _uil_caption.font = [UIFont systemFontOfSize:13.0];
    [_uiv_bottomView addSubview: _uil_caption];
}

#pragma mark - Set up page view

- (embModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[embModelController alloc] initWithImage:_arr_pageData];
    }
    return _modelController;
}

-(void)initPageView:(NSInteger)index {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self.modelController;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.autoresizesSubviews =YES;
    self.pageViewController.view.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);//self.view.bounds;
    [self.pageViewController didMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    [self.pageViewController.view setBackgroundColor:[UIColor whiteColor]];
    [self loadPage:index];
}

-(void)loadPage:(int)page {
    embDataViewController *startingViewController = [self.modelController viewControllerAtIndex:page storyboard:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
}



#pragma mark - PageViewController
#pragma mark update page index

- (void)pageViewController:(UIPageViewController *)pvc didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // If the page did not turn
    if (!completed)
    {
        // You do nothing because whatever page you thought you were on
        // before the gesture started is still the correct page
        NSLog(@"same page");
        return;
    }
    // This is where you would know the page number changed and handle it appropriately
    //    NSLog(@"new page");
    [self setpageIndex];
}

//Up date panel's title text
- (void) setpageIndex
{
    embDataViewController *theCurrentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    int index = (int)[self.modelController indexOfViewController:theCurrentViewController];
    _currentPage = index;
    _uil_numLabel.text = [NSString stringWithFormat:@"%i of %i", (int)_currentPage+1, (int)_arr_pageData.count];
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
