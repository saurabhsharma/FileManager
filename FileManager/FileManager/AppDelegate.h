//
//  AppDelegate.h
//  FileManager
//
//  Created by Saurabh Sharma on 30/12/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManagerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FileManagerViewController *fileManagerVC;
@property (strong, nonatomic) UINavigationController *navCtrl;
@end
