//
//  FileManagerViewController.h
//  FileManager
//
//  Created by Saurabh Sharma on 30/12/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManagerViewController : UIViewController{
    
    NSArray * directoryContents;
    
}

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) NSMutableArray *selectedRows;

-(IBAction)optBtnAction:(id) sender;

@end
