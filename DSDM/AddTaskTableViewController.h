//
//  AddTaskTableViewController.h
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_PRIORITY 5;
@class Task;

@interface AddTaskTableViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskNote;
@property (weak, nonatomic) IBOutlet UISlider *taskPriority;
@property (strong, nonatomic) Task* addedTask;

@end
