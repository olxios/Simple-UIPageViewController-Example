//
//  ViewController.m
//  Paging_ObjC
//
//  Created by olxios on 23/10/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import "ViewController.h"
#import "PageItemController.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *contentImages;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation ViewController

#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createPageViewController];
    [self setupPageControl];
}

- (void)createPageViewController
{
    _contentImages = @[@"nature_pic_1",
                      @"nature_pic_2",
                      @"nature_pic_3",
                      @"nature_pic_4"];
    
    UIPageViewController *pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageController"];
    
    pageController.dataSource = self;
    
    if([_contentImages count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex:0]];
        [pageController setViewControllers:startingViewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
    
    self.pageViewController = pageController;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)setupPageControl
{
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor grayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [[UIPageControl appearance] setBackgroundColor:[UIColor darkGrayColor]];
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PageItemController *itemController = (PageItemController *)viewController;
    
    if (itemController.itemIndex > 0)
    {
        return [self itemControllerForIndex:itemController.itemIndex-1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PageItemController *itemController = (PageItemController *)viewController;
    
    if (itemController.itemIndex+1 < [_contentImages count])
    {
        return [self itemControllerForIndex:itemController.itemIndex+1];
    }
    
    return nil;
}

- (PageItemController *)itemControllerForIndex:(NSUInteger)itemIndex
{
    if (itemIndex < [_contentImages count])
    {
        PageItemController *pageItemController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemController"];
        pageItemController.itemIndex = itemIndex;
        pageItemController.imageName = _contentImages[itemIndex];
        return pageItemController;
    }
    
    return nil;
}

#pragma mark Page Indicator

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_contentImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
