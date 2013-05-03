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

@interface SelectTaskCategoryViewController ()

@end

@implementation SelectTaskCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _taskCategoryArrays = [[TaskDataController alloc] init];
    //IGUAL SE DEBERIA HACER LA PERSISTENCIA DE DATOS AQUI
    /* if(hayDatosAlmacenadosEnDisco) _taskCategoryArrays = [[TaskDataController alloc] initWithList];
     else */
}

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
@end
