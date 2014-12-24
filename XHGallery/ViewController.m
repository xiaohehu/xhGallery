//
//  ViewController.m
//  XHGallery
//
//  Created by Xiaohe Hu on 12/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "ViewController.h"
#import "XHGalleryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tapButton:(id)sender {
    NSLog(@"Should load gallery");
    XHGalleryViewController *gallery = [[XHGalleryViewController alloc] init];
    [self.view addSubview: gallery.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
