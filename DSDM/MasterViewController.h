//
//  MasterViewController.h
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSMutableArray* activitiesArray;
@property (strong, nonatomic) NSString* categoryName;

- (IBAction)remove:(UIStoryboardSegue*)segue;
- (IBAction)organizeList:(id)sender;

@end
