//
//  SelectTaskCategoryViewController.m
//  DSDM
//
//  Created by Molina on 01/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "SelectTaskCategoryViewController.h"
#import "TaskDataController.h"
#import "MasterViewController.h"
#import "AddTaskTableViewController.h"
#import "Category.h"
#import "Task.h"
#import "EditTaskTableViewController.h"

@interface SelectTaskCategoryViewController ()

-(void)refreshNotificationText;

@end

@implementation SelectTaskCategoryViewController

-(void)refreshNotificationText
{
    // Actualizar el texto sobre las tareas sin asignar
    int unassignedTasks = [self.taskCategoryArrays countOfListWithCategory:INBOX];
    if ( unassignedTasks == 0) {
        self.notificationText.text = @"You have assigned all your tasks";
    } else {
        //self.notificationText.text = [[NSString alloc]initWithFormat:@"You have %d unassigned tasks", unassignedTasks;
        self.notificationText.text = @"You have unassigned tasks";
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _taskCategoryArrays = [[TaskDataController alloc] init];
    
    //using data core HERE
    [self.taskCategoryArrays loadDataFromCoreData];
    
    [self refreshNotificationText];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self refreshNotificationText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancel:(UIStoryboardSegue *)segue
{
    if([[segue identifier] isEqualToString:@"CancelInput"]){
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)showExtraOptions:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Visualize..." message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"All", @"Completed", @"Trash", nil];
    [alert show];
}

- (void)done:(UIStoryboardSegue *)segue
{
    [self refreshNotificationText];
    
    if([[segue identifier] isEqualToString:@"ReturnInput"]){
        AddTaskTableViewController* addController = [segue sourceViewController];
        if(addController.addedTask){
            [self.taskCategoryArrays addTaskWithTask:addController.addedTask];
            //task added to its corresponding array. There's nothing more to do here
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else if([[segue identifier] isEqualToString:@"EditFinished"]){
        EditTaskTableViewController* editView = [segue sourceViewController];
        NSString* originalCategory = editView.editedTask.category;
        NSString* finalCategory = editView.selectedCategory;
        NSInteger index = [editView.tableView indexPathForSelectedRow].row;
        
        float priority = editView.taskPriority.value * MAX_PRIORITY;
        Task* newTask = [[Task alloc] initWithName:editView.taskName.text date:editView.editedTask.date note:editView.taskNote.text priority:priority category:finalCategory];
        
        //we have to remove the original task to add a new (modified) one
        [self.taskCategoryArrays removeTask:editView.editedTask atCategory:originalCategory];
        
        //now adding a new one
        [self.taskCategoryArrays addTaskWithTask:newTask withCategory:finalCategory];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* identifier = [segue identifier];
    if(! [identifier isEqualToString:@"AddTask"]){
        MasterViewController* masterViewController = [segue destinationViewController];
        if([identifier isEqualToString:INBOX]){
            masterViewController.activitiesArray = self.taskCategoryArrays.inboxTaskList;
        } else if([identifier isEqualToString:NEXT]){
            masterViewController.activitiesArray = self.taskCategoryArrays.nextTaskList;
        }else if([identifier isEqualToString:WAITTING]){
            masterViewController.activitiesArray = self.taskCategoryArrays.waittingTaskList;
        }else if([identifier isEqualToString:SOME_DAY]){
            masterViewController.activitiesArray = self.taskCategoryArrays.someDayTaskList;
        }else if([identifier isEqualToString:PROJECT]){
            masterViewController.activitiesArray = self.taskCategoryArrays.projectTaskList;
        }else if([identifier isEqualToString:DONE]){
            masterViewController.activitiesArray = self.taskCategoryArrays.doneTaskList;
        }else if([identifier isEqualToString:TRASH]){
            masterViewController.activitiesArray = self.taskCategoryArrays.trashTaskList;
        }else if([identifier isEqualToString:@"ALL"]){
            masterViewController.activitiesArray = [self.taskCategoryArrays completedArray];
        }
        
        masterViewController.categoryName = identifier;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [self performSegueWithIdentifier: @"ALL" sender: self];
            break;
        case 2:
            [self performSegueWithIdentifier: DONE sender: self];
            break;
        case 3:
            [self performSegueWithIdentifier: TRASH sender: self];
            break;
        default:
            break;
    }
}
@end
