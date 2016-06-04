//
//  PageItemController.h
//  Paging_ObjC
//
//  Created by olxios on 23/10/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageItemController : UIViewController

// Item controller information
@property (nonatomic) NSUInteger itemIndex;
@property (nonatomic, strong) NSString *imageName;

// IBOutlets
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;

@end
