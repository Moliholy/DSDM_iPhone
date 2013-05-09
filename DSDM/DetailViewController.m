//
//  DetailViewController.m
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "DetailViewController.h"
#import "AddTaskTableViewController.h"
#import "Task.h"
#import "EditTaskTableViewController.h"
#import "Category.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)configureView
{
    // Update the user interface for the detail item.
    static NSDateFormatter* formatter = nil;
    if(formatter == nil){
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    if(self.task){
        NSString* dateFormatted = [formatter stringFromDate:(NSDate*)self.task.date];
        self.taskCategoryLabel.text = self.task.category;
        self.taskDateLabel.text = dateFormatted;
        self.taskNameLabel.text = self.task.name;
        self.taskNoteLabel.text = self.task.note;
        float maxPriority = MAX_PRIORITY;
        self.taskPriorityLabel.text = [NSString stringWithFormat:@"%.1f / %.1f", self.task.priority, maxPriority];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"EditInput"]){
        EditTaskTableViewController* editView = [segue destinationViewController];
        editView.editedTask = self.task;
    }
}

@end
