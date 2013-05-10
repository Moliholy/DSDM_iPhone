//
//  MasterViewController.m
//  DSDM
//
//  Created by Molina on 26/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Task.h"
#import "SelectTaskCategoryViewController.h"
#import "TaskDataController.h"
#import "Category.h"



@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

-(void)remove:(UIStoryboardSegue *)segue
{
    if([[segue identifier] isEqualToString:@"RemoveInput"]){
        DetailViewController* detaillViewController = [segue sourceViewController];
        Task* taskToRemove = detaillViewController.task;
        SelectTaskCategoryViewController* selectView = [self.navigationController.viewControllers objectAtIndex:0];
        
        if (![taskToRemove.category isEqualToString:TRASH]) {
            // we have to push it inside TRASH category
            [selectView.taskCategoryArrays changeTaskCategory:taskToRemove fromCategory:taskToRemove.category toCategory:TRASH];
        } else
            //as always, core data first
            [selectView.taskCategoryArrays removeTask:taskToRemove atCategory:taskToRemove.category];
        
        //later the rest
        [self.tableView reloadData];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = [self.categoryName capitalizedString];
}

- (void)organizeList:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Sort by..." message:@"" delegate:self cancelButtonTitle:@"Cancel"
        otherButtonTitles:@"Name",@"Date", @"Completed", @"Priority", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //let's sort the array
    switch (buttonIndex) {
        case 1:
            //by name
            [self.activitiesArray sortUsingComparator:^NSComparisonResult(Task* task1, Task* task2) {
                return [task1.name compare:task2.name options:NSCaseInsensitiveSearch];
            }];
            break;
        case 2:
            //by date
            [self.activitiesArray sortUsingComparator:^NSComparisonResult(Task* task1, Task* task2) {
                return [task1.date compare:task2.date];
            }];
            break;
        case 3:
            //already done
            [self.activitiesArray sortUsingComparator:^NSComparisonResult(Task* task1, Task* task2) {
                bool task1Done = [task1.category isEqualToString:DONE];
                bool task2Done = [task2.category isEqualToString:DONE];
                if(task1Done == task2Done)
                    //if they're both done or undone it will be sorted by name
                    return [task1.name compare:task2.name options:NSCaseInsensitiveSearch];
                return task1Done ? NSOrderedAscending : NSOrderedDescending;
            }];
            break;
        case 4:
            // by priority
            [self.activitiesArray sortUsingComparator:^NSComparisonResult(Task* task1, Task* task2) {
                if (task1.priority == task2.priority)
                    return NSOrderedSame;
                return task1.priority < task2.priority ? NSOrderedDescending : NSOrderedAscending;
            }];
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //there's only one section: tasks in this category
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return the number of elements in the array or 0 if there's no array (it should not happen)
    if(self.activitiesArray){
        return [self.activitiesArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"TaskCell";
    
    static NSDateFormatter* formatter = nil;
    if(formatter == nil){
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Task* task = [self.activitiesArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:task.name];
    [[cell detailTextLabel] setText:[formatter stringFromDate:(NSDate*)task.date]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowTaskDetails"]) {
        DetailViewController* detailViewController = [segue destinationViewController];
        NSUInteger index = [self.tableView indexPathForSelectedRow].row;
        detailViewController.task = [self.activitiesArray objectAtIndex:index];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

@end
