//
//  XHGalleryViewController.h
//  XHGallery
//
//  Created by Xiaohe Hu on 12/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGalleryViewController;
@protocol XHGalleryDelegate

- (void)didRemoveFromSuperView;

@end


@interface XHGalleryViewController : UIViewController

@property (nonatomic, strong)       id              delegate;
@property (nonatomic, readwrite)    int             startIndex;
@property (nonatomic, readwrite)    BOOL            showNavBar;
@property (nonatomic, readwrite)    BOOL            showCaption;
@property (nonatomic, strong)       NSArray         *arr_images;
@property (nonatomic, strong)       NSArray         *arr_captions;
@property (nonatomic, strong)       NSArray         *arr_fileType;
@end
