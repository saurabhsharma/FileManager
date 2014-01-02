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
   
    
//    for (NSURL *filePath in directoryContents){
//        
//        NSLog(@"file path url - %@", filePath);
//        NSString *modificationDate;
//        
//        [filePath getResourceValue:&modificationDate forKey:NSURLContentModificationDateKey error:nil];
//        
//        NSLog(@"modificationDate = %@",modificationDate);
//    }
    
    
     NSLog(@"Directory Contents = /n %@",directoryContents);
   
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if the tapped row is of folder..
    NSString *isDirectory;
    [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    
    if ([isDirectory boolValue]){
        
        NSString *path;
        [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&path forKey:NSURLPathKey error:nil];
        
        FileManagerViewController *fmvc = [[FileManagerViewController alloc] initWithNibName:@"FileManagerViewController_iPhone" bundle:nil];
        fmvc.path = path;
        [self.navigationController pushViewController:fmvc animated:YES];

    }
    
}


@end
