//
//  EditTaskTableViewController.h
//  DSDM
//
//  Created by Molina on 05/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Task;

@interface EditTaskTableViewController : UITableViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>


@property (strong, nonatomic) Task* editedTask;
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskNote;
@property (weak, nonatomic) IBOutlet UISlider *taskPriority;
@property (weak, nonatomic) IBOutlet UIPickerView *taskCategorySelector;


@end
