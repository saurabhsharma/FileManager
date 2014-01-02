//
//  FileManagerTableCell.h
//  FileManager
//
//  Created by Saurabh Sharma on 02/01/14.
//  Copyright (c) 2014 Saurabh Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManagerTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLbl;
@property (nonatomic, strong) IBOutlet UIImageView *typeImg;
@property (nonatomic, strong) IBOutlet UILabel *typeLbl;
@property (nonatomic, strong) IBOutlet UIImageView *checkmarkImg;
@property (nonatomic) BOOL checked;

@end
