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

- (void)refreshNotificationText;
- (void)scheduleNotification;
@end

@implementation SelectTaskCategoryViewController



-(void)scheduleNotification
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    // notification is going to fire after 20 seconds
    notification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:20];
    
    // message to show
    notification.alertBody = @"Remeber to take a look at your uncategorized task!";
    
    // default sound
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // button tittle
    notification.alertAction = @"Go";
    notification.hasAction = YES;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

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
    [self scheduleNotification];
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
    [self refreshNotificationText];
}

- (void)showExtraOptions:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Visualize..." message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"All", @"Completed", @"Trash", nil];
    [alert show];
}

- (void)done:(UIStoryboardSegue *)segue
{    
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
        
        float priority = editView.taskPriority.value * MAX_PRIORITY;
        Task* newTask = [[Task alloc] initWithName:editView.taskName.text date:editView.editedTask.date note:editView.taskNote.text priority:priority category:finalCategory];
        
        //we have to remove the original task to add a new (modified) one
        [self.taskCategoryArrays removeTask:editView.editedTask atCategory:originalCategory];
        
        //now adding a new one
        [self.taskCategoryArrays addTaskWithTask:newTask withCategory:finalCategory];
    }
    [self refreshNotificationText];
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
        }else if([identifier isEqualToString:WAITING]){
            masterViewController.activitiesArray = self.taskCategoryArrays.waitingTaskList;
        }else if([identifier isEqualToString:SOMEDAY]){
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
