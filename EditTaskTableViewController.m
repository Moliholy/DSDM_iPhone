//
//  EditTaskTableViewController.m
//  DSDM
//
//  Created by Molina on 05/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "EditTaskTableViewController.h"
#import "Task.h"
#import "AddTaskTableViewController.h"
#import "Category.h"

@interface EditTaskTableViewController ()
- (void) configureElements;
- (NSInteger)obtainPath:(NSString*)category;
@end

@implementation EditTaskTableViewController

- (NSInteger)obtainPath:(NSString *)category
{
    if([category isEqualToString:NEXT])
        return 0;
    else if([category isEqualToString:WAITING])
        return 1;
    else if([category isEqualToString:PROJECT])
        return 2;
    else if([category isEqualToString:SOMEDAY])
        return 3;
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        NSString* futureCategory = nil;
        switch (indexPath.row) {
            case 0:
                futureCategory = NEXT;
                break;
            case 1:
                futureCategory = WAITING;
                break;
            case 2:
                futureCategory = PROJECT;
                break;
            case 3:
                futureCategory = SOMEDAY;
                break;
        }
    
        NSInteger oldRow = [self obtainPath:self.selectedCategory];
        NSIndexPath* oldIndexPath = [NSIndexPath indexPathForRow:oldRow inSection:1];
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        if (newCell.accessoryType == UITableViewCellAccessoryNone) {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.selectedCategory = futureCategory;
        }
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5; //the 5 categories
}


- (void)configureElements
{
    self.taskName.text = self.editedTask.name;
    self.taskNote.text = self.editedTask.note;
    self.taskPriority.value = self.editedTask.priority / MAX_PRIORITY;
    self.selectedCategory = self.editedTask.category;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taskNote.delegate = self;
    self.taskName.delegate = self;
    [self configureElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
