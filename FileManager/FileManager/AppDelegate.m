//
//  AppDelegate.m
//  FileManager
//
//  Created by Saurabh Sharma on 30/12/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self setupFolders];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.fileManagerVC = [[FileManagerViewController alloc] initWithNibName:@"FileManagerViewController_iPhone" bundle:nil];
    
    self.navCtrl = [[UINavigationController alloc] initWithRootViewController:self.fileManagerVC];
    
    [self.window setRootViewController:self.navCtrl];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   
    
    return YES;
}

-(void)setupFolders{
    
    
    
    NSString *file11InApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"11.png"];
    NSString *file12InApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"12.png"];
    NSString *file13InApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"13.png"];
    
    
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
	NSString *file11DocPath = [documentsDir stringByAppendingPathComponent:@"11.png"];
    NSString *file12DocPath = [documentsDir stringByAppendingPathComponent:@"12.png"];
    NSString *file13DocPath = [documentsDir stringByAppendingPathComponent:@"13.png"];
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    [fileManager copyItemAtPath:file11InApp toPath:file11DocPath error:nil];
    [fileManager copyItemAtPath:file12InApp toPath:file12DocPath error:nil];
    [fileManager copyItemAtPath:file13InApp toPath:file13DocPath error:nil];
     NSError * error;
    
    [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/one",documentsDir] withIntermediateDirectories:NO attributes:nil error:&error];
    
    [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/one/insideone",documentsDir] withIntermediateDirectories:NO attributes:nil error:&error];
    [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/two",documentsDir] withIntermediateDirectories:NO attributes:nil error:&error];
    
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
