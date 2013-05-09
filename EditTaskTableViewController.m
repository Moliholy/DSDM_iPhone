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
@end

@implementation EditTaskTableViewController

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    switch (row) {
//        case 0:
//            return INBOX;
//        case 1:
//            return NEXT;
//        case 2:
//            return WAITTING;
//        case 3:
//            return SOME_DAY;
//        case 4:
//            return PROJECT;
//    }
//    return @"";
//}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    //let's edit the string picker...
//    self.taskCategorySelector.delegate = self;
//    self.taskCategorySelector.dataSource = self;
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
