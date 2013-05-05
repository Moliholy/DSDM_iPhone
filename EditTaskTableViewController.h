//
//  EditTaskTableViewController.h
//  DSDM
//
//  Created by Molina on 05/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@interface EditTaskTableViewController : UITableViewController<UITextFieldDelegate>


@property (strong, nonatomic) Task* editedTask;

@end
