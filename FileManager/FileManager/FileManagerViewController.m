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
    
    NSLog(@"Path = /n %@",self.path);
    
    NSError * error;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *directoryURL = [NSURL fileURLWithPath:self.path];
    directoryContents = [fm contentsOfDirectoryAtURL:directoryURL
                      includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey, NSURLIsDirectoryKey, NSURLContentModificationDateKey, nil]
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
    
    
//    NSLog(@"Directory Contents = /n %@",directoryContents);
    
    
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
        cell = (FileManagerTableCell*)[[NSBundle mainBundle] loadNibNamed:@"FileManagerTableCell_iPhone" owner:self options:nil];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSString *name;
    [[directoryContents objectAtIndex:indexPath.row] getResourceValue:&name forKey:NSURLNameKey error:nil];
    cell.nameLbl.text = name;
    
    
//    cell.nameLbl.text = [[self.diveSitesListArr objectAtIndex:indexPath.row] objectForKey:@"name"];
//    
//    NSString *descTxt = [NSString stringWithFormat:@"\"%@\"",[[self.diveSitesListArr objectAtIndex:indexPath.row] objectForKey:@"description"]];
//    
//    cell.description.text = descTxt;
//    
//    if(indexPath.row == 0)
//    {
//        cell.seperatorImg.hidden = YES;
//    }
//    
//    else
//    {
//        cell.seperatorImg.hidden = NO;
//    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DGDiveSitesListVC *dgDiveSiteListVc = [[DGDiveSitesListVC alloc]initWithNibName:[DGCommon getNibNameForName:@"DGDiveSitesListVC"] bundle:nil];
//    
//    dgDiveSiteListVc.divePointName = [[self.diveSitesListArr objectAtIndex:indexPath.row] objectForKey:@"name"];
//    
//    int siteId = indexPath.row+1;
//    
//    NSString *querystring = [NSString stringWithFormat:@"select * from dive_points_tbl where site_id = %d;", siteId];
//    NSLog(@"query string %@",querystring);
//    
//    dgDiveSiteListVc.diveSitesListArr = [DGDatabaseHandler fetchDataFromDatabase:querystring];
//    
//    [self.navigationController pushViewController:dgDiveSiteListVc animated:YES];
}







@end
