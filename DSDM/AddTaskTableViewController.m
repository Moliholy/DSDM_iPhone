//
//  AddTaskTableViewController.m
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "AddTaskTableViewController.h"
#import "Task.h"
#import "Category.h"

@interface AddTaskTableViewController ()

@end

@implementation AddTaskTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.addedTask = nil;
        self.taskName.text = @"";
        self.taskNote.text = @"";
        self.taskPriority.value = 0.0f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taskName.delegate = self;
    self.taskNote.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ReturnInput"]){
        if([self.taskName.text length]){
            float priority = self.taskPriority.value * MAX_PRIORITY;
            Task* taskToAdd = [[Task alloc] initWithName:self.taskName.text date:[NSDate date] note:self.taskNote.text priority:priority category:INBOX];
            self.addedTask = taskToAdd;
        }
    }
}


@end
