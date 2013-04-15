//
//  VTCell.h
//  fritidsresor
//
//  Created by Emil Wall on 4/15/13.
//  Copyright (c) 2013 William Lundin Forssén. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *countryLabel;

@property (nonatomic, strong) IBOutlet UILabel *monthLabel;

@property (nonatomic, strong) IBOutlet UILabel *dayLabel;

@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) IBOutlet UILabel *travelTypeLabel;

@property (nonatomic, strong) IBOutlet UILabel *detailsLabel;

@property (nonatomic, strong) IBOutlet UILabel *alertLabel;

@end
