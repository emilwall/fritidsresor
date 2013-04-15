//
//  VTCell.m
//  fritidsresor
//
//  Created by Emil Wall on 4/15/13.
//  Copyright (c) 2013 William Lundin Forssén. All rights reserved.
//

#import "VTCell.h"

@implementation VTCell

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
