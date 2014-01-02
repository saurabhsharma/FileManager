//
//  FileManagerViewController.m
//  FileManager
//
//  Created by Saurabh Sharma on 30/12/13.
//  Copyright (c) 2013 Saurabh Sharma. All rights reserved.
//

#import "FileManagerViewController.h"
#import "FileManagerTableCell.h"

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


- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!self.path){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.path = [paths objectAtIndex:0];
    }
    
    NSError * error;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *directoryURL = [NSURL fileURLWithPath:self.path];
    directoryContents = [fm contentsOfDirectoryAtURL:directoryURL
                      includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLPathKey,NSURLNameKey, NSURLIsDirectoryKey, NSURLContentModificationDateKey, nil]
                                         options:NSDirectoryEnumerationSkipsHiddenFiles
                                           error:&error];
    
    NSLog(@"Directory Contents = /n %@",directoryContents);
    
    UIBarButtonItem *optionsBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(optBtnAction:)];
    [optionsBtn setTag:1];
    [self.navigationItem setRightBarButtonItem:optionsBtn];
   
    
    self.selectedRows = [[NSMutableArray alloc] init];
    
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
    return [directoryContents count];
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
    [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&name forKey:NSURLNameKey error:nil];
    cell.nameLbl.text = name;
    
    
    NSString *path;
    [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&path forKey:NSURLPathKey error:nil];
    
    cell.typeLbl.text = [path pathExtension];
    
    NSString *isDirectory;
    [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    
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
    [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    
    if ([isDirectory boolValue] && self.toolBar.hidden){
        
        NSString *path;
        [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&path forKey:NSURLPathKey error:nil];
        
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


@end
