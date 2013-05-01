//
//  AddTaskTableViewController.h
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@interface AddTaskTableViewController : UITableViewController

@property (weak, nonatomic) Task* addedTask;

@end
