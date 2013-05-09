//
//  DetailViewController.h
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) Task* task;
@property (weak, nonatomic) IBOutlet UILabel *taskNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskPriorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;

@end
