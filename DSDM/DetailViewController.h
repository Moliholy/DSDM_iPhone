//
//  DetailViewController.h
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
