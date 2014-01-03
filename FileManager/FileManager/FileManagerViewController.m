//
//  FileManagerViewController.m
//  FileManager
//
//  Created by Saurabh Sharma on 30/12/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import "FileManagerViewController.h"
#import "FileManagerTableCell.h"
#import "FileManagerGlobals.h"
@interface FileManagerViewController ()

@end

@implementation FileManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithPath:(NSString *) path{
    
    if (self = [super init]){
        self.path = path;
    
    }
    return self;
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    self.selectedRows       = [[NSMutableArray alloc] init];
    [self reloadFolderData];
   

    
}

-(void) reloadFolderData{
    
    NSError * error;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *directoryURL = [NSURL fileURLWithPath:self.path];
    self.directoryContents = [fm contentsOfDirectoryAtURL:directoryURL
                               includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLPathKey,NSURLNameKey, NSURLIsDirectoryKey, NSURLContentModificationDateKey, nil]
                                                  options:NSDirectoryEnumerationSkipsHiddenFiles
                                                    error:&error];
    
    NSLog(@"Directory Contents = /n %@",self.directoryContents);

    [self.tblView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.path){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.path = [paths objectAtIndex:0];
    }
    
    NSLog(@"self.path = %@",self.path);
    
    
    UIBarButtonItem *optionsBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(optBtnAction:)];
    [optionsBtn setTag:1];
    [self.navigationItem setRightBarButtonItem:optionsBtn];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)optBtnAction:(id) sender{
    
    // if the right bar button item is "options button"
    if ([(UIBarButtonItem *)sender tag] == 1){
        
        UIBarButtonItem *optionsBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(optBtnAction:)];
        [optionsBtn setTag:2];
        [self.navigationItem setRightBarButtonItem:optionsBtn];
        
        
        [self.toolBar setHidden:NO];
        
        
    }
    else if ([(UIBarButtonItem *)sender tag] == 2){

        UIBarButtonItem *optionsBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(optBtnAction:)];
        [optionsBtn setTag:1];
        [self.navigationItem setRightBarButtonItem:optionsBtn];

        [self.toolBar setHidden:YES];
        
    }
    else {
        
        
    }
    
    [self.tblView reloadData];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.directoryContents count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tblCellIdentifier   = @"FileManagerTableCell";
    
    FileManagerTableCell *cell = (FileManagerTableCell *)[self.tblView dequeueReusableCellWithIdentifier:tblCellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FileManagerTableCell_iPhone" owner:self options:nil];
        cell = (FileManagerTableCell*)[nib objectAtIndex:0];
    }
    
    NSString *name;
    [[self.directoryContents objectAtIndex:indexPath.row] getResourceValue:&name forKey:NSURLNameKey error:nil];
    cell.nameLbl.text = name;
    
    
    NSString *path;
    [[self.directoryContents objectAtIndex:indexPath.row] getResourceValue:&path forKey:NSURLPathKey error:nil];
    
    cell.typeLbl.text = [path pathExtension];
    
    NSString *isDirectory;
    [[self.directoryContents objectAtIndex:indexPath.row] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    
    if ([isDirectory boolValue]){
        cell.typeLbl.text = @"folder";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (!self.toolBar.hidden){
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.checkmarkImg setImage:[UIImage imageNamed:@"grey_checkmark"]];
    }
    else{
        
        [cell.checkmarkImg setImage:nil];
        
        if ([isDirectory boolValue]){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if the tapped row is of folder..
    NSString *isDirectory;
    [[self.directoryContents objectAtIndex:indexPath.row] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    
    if ([isDirectory boolValue] && self.toolBar.hidden){
        
        NSString *path;
        [[self.directoryContents objectAtIndex:indexPath.row] getResourceValue:&path forKey:NSURLPathKey error:nil];
        
        FileManagerViewController *fmvc = [[FileManagerViewController alloc] initWithNibName:@"FileManagerViewController_iPhone" bundle:nil];
        fmvc.path = path;
        [self.navigationController pushViewController:fmvc animated:YES];

    }
    
    if (!self.toolBar.hidden){

        FileManagerTableCell *cell = (FileManagerTableCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (![self.selectedRows containsObject:indexPath]){
            [self.selectedRows addObject:indexPath];
            [cell.checkmarkImg setImage:[UIImage imageNamed:@"blue_checkmark"]];
        }
        else {
            [self.selectedRows removeObject:indexPath];
            [cell.checkmarkImg setImage:[UIImage imageNamed:@"grey_checkmark"]];
        }
        
    }
    
}

-(IBAction)cutBtnAction:(id)sender{
    
    [self moveSelectedFilesPathInClipboard];
    cutCopyAction = @"cut";
    
}


-(IBAction)copyBtnAction:(id)sender{

    [self moveSelectedFilesPathInClipboard];
    cutCopyAction = @"copy";
    
}


-(IBAction)pasteBtnAction:(id)sender{

    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    for (NSURL *pathURL in cutCopyClipboard) {
            
        NSString *sourcePath;
        [pathURL getResourceValue:&sourcePath forKey:NSURLPathKey error:nil];
        
        NSString *fileName;
        [pathURL getResourceValue:&fileName forKey:NSURLNameKey error:nil];
        
        
        NSString *targetPath = [self.path stringByAppendingPathComponent:fileName];
        NSLog(@"target file path = %@",targetPath);
        
        if ([cutCopyAction isEqualToString:@"cut"]){
            
            NSError *err;
            if ([filemgr moveItemAtPath:sourcePath toPath:targetPath error: &err]  == YES)
                NSLog (@"Move successful");
            else
                NSLog (@"Move failed, error - %@",err.description);
            
        } else if ([cutCopyAction isEqualToString:@"copy"]){
            
            if ([filemgr copyItemAtPath:sourcePath toPath:targetPath error: NULL]  == YES)
                NSLog (@"Copy successful");
            else
                NSLog (@"Copy failed");

        }
     
        
        [cutCopyClipboard removeAllObjects];
        cutCopyAction = @"";
        [self reloadFolderData];
        
    }
    
}


-(IBAction)newFolderBtnAction:(id)sender{
    
}


-(IBAction)deleteBtnAction:(id)sender{
    
    
    NSMutableArray *selectedRowsForDelete = [[NSMutableArray alloc] init]
    
    if ([self.selectedRows count]){
        
        [cutCopyClipboard removeAllObjects];
        
        for (NSIndexPath *indexPath in self.selectedRows) {
            [cutCopyClipboard addObject:[self.directoryContents objectAtIndex:indexPath.row]];
        }
        
    }
    
    
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    NSString * allFilesToDelete = @"";
    for (NSURL *pathURL in cutCopyClipboard) {
        
        NSString *sourcePath;
        [pathURL getResourceValue:&sourcePath forKey:NSURLPathKey error:nil];
        
        NSString *fileName;
        [pathURL getResourceValue:&fileName forKey:NSURLNameKey error:nil];
        
        allFilesToDelete = [NSString stringWithFormat:@"%@, %@", allFilesToDelete, fileName];
        
//        if ([filemgr removeItemAtPath:@"/tmp/myfile.txt" error: NULL]  == YES)
//            NSLog (@"Remove successful");
//        else
//            NSLog (@"Remove failed");
//        
//        
//        [self reloadFolderData];
        
    }
    
    NSString *deleteConfirmMsg = [NSString stringWithFormat:@"Are you sure you want to delete %@",allFilesToDelete];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:deleteConfirmMsg delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
    [alertView show];

    
}


-(void) moveSelectedFilesPathInClipboard{
    
    if ([self.selectedRows count]){
        
        [cutCopyClipboard removeAllObjects];

        for (NSIndexPath *indexPath in self.selectedRows) {
            [cutCopyClipboard addObject:[self.directoryContents objectAtIndex:indexPath.row]];
        }
        
    }
    
}



@end
