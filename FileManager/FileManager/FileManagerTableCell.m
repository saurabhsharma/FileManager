//
//  FileManagerTableCell.m
//  FileManager
//
//  Created by Saurabh Sharma on 02/01/14.
//  Copyright (c) 2014 Saurabh Sharma. All rights reserved.
//

#import "FileManagerTableCell.h"

@implementation FileManagerTableCell

@synthesize nameLbl = _nameLbl;
@synthesize typeImg = _typeImg;
@synthesize typeLbl = _typeLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
