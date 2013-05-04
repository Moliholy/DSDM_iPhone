//
//  MasterViewController.h
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) NSMutableArray* activitiesArray;
@property (weak, nonatomic) NSString* categoryName;

- (IBAction)remove:(UIStoryboardSegue*)segue;

@end
