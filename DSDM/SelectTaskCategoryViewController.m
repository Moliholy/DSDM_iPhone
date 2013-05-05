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

@interface SelectTaskCategoryViewController ()

@end

@implementation SelectTaskCategoryViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    _taskCategoryArrays = [[TaskDataController alloc] init];
    NSDate* today = [NSDate date];
    Task* toAdd = [[Task alloc]initWithName:@"Task 1 Molina prueba" date:today note:@"Task 1 note done by molina aaaaaaabbbbbbbbbbccccccccccddddddd" priority:2.5];
    [_taskCategoryArrays addTaskWithTask:toAdd];
    //IGUAL SE DEBERIA HACER LA PERSISTENCIA DE DATOS AQUI
    /* if(hayDatosAlmacenadosEnDisco) _taskCategoryArrays = [[TaskDataController alloc] initWithList];
     else */
}

/*
- (void)setTaskCategoryArrays:(TaskDataController *)taskCategoryArrays
{
    if(_taskCategoryArrays != taskCategoryArrays)
        _taskCategoryArrays = [taskCategoryArrays mutableCopy];
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

- (void)done:(UIStoryboardSegue *)segue
{
    if([[segue identifier] isEqualToString:@"ReturnInput"]){
        AddTaskTableViewController* addController = [segue sourceViewController];
        if(addController.addedTask){
            [self.taskCategoryArrays addTaskWithTask:addController.addedTask];
            //task added to its corresponding array. There's nothing more to do here
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
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
        }
        masterViewController.categoryName = identifier;
    }
}
@end
