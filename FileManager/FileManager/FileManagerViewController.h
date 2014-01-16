//
//  FileManagerViewController.h
//  FileManager
//
//  Created by Saurabh Sharma on 30/12/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManagerViewController : UIViewController{
    
    
    
}

@property (strong, nonatomic) NSArray * directoryContents;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) NSMutableArray *selectedRows;



-(IBAction)optBtnAction:(id) sender;
-(IBAction)cutBtnAction:(id)sender;
-(IBAction)copyBtnAction:(id)sender;
-(IBAction)pasteBtnAction:(id)sender;
-(IBAction)newFolderBtnAction:(id)sender;
-(IBAction)deleteBtnAction:(id)sender;

-(void) moveSelectedFilesPathInClipboard;
-(void) reloadFolderData;
-(void) askForNewFolder;

@end
