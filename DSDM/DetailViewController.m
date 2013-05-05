//
//  DetailViewController.m
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "DetailViewController.h"
#import "Task.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

-(void)setTask:(Task *)task
{
    if(_task != task){
        _task = task;
        
        //updating the view
        [self configureView];
    }
}

- (void)setCategoryName:(NSString *)categoryName
{
    if(_categoryName != categoryName){
        _categoryName = categoryName;
        
        //updating the view
        [self configureView];
    }
}

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
        self.taskCategoryLabel.text = self.categoryName;
        self.taskDateLabel.text = dateFormatted;
        self.taskNameLabel.text = self.task.name;
        self.taskNoteLabel.text = self.task.note;
        self.taskPriorityLabel.text = [NSString stringWithFormat:@"%.1f /5.0", self.task.priority];
        self.taskAlreadyDoneLabel.text = self.task.alreadyDone ? @"Yes" : @"No";
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

@end
