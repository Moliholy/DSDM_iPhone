//
//  TaskDataController.m
//  DSDM
//
//  Created by Molina on 01/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "TaskDataController.h"
#import "Category.h"
#import "Task.h"
#import "AppDelegate.h"
#import "SelectTaskCategoryViewController.h"
#import "TaskModel.h"

@implementation TaskDataController
- (BOOL)saveTaskModelUsingCoreData:(Task*)task withCategory:(NSString*) category{
    //storing data using Core Data
    AppDelegate *appDelegate = [[UIApplication sharedApplication]
                                delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    TaskModel* taskModel = [NSEntityDescription insertNewObjectForEntityForName:@"TaskModel" inManagedObjectContext:context];
    [taskModel setValue:task.name forKey:@"name"];
    [taskModel setValue:task.note forKey:@"note"];
    [taskModel setValue:task.date forKey:@"date"];
    [taskModel setValue:category forKey:@"category"];
    [taskModel setValue:[NSNumber numberWithFloat:task.priority] forKey:@"priority"];
    
    //saving modifications
    NSError* error = nil;
    [context save:&error];
    
    return error ? NO : YES;
}

- (void)addTaskWithTaskModel:(TaskModel *)taskModel
{
    Task* taskToBeAdded = [[Task alloc] initWithName:taskModel.name date:taskModel.date note:taskModel.note priority:[taskModel.priority floatValue] category:taskModel.category];
    NSMutableArray* array = [self listByCategory:taskToBeAdded.category];
    [array addObject:taskToBeAdded];
}

- (BOOL)loadDataFromCoreData
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription* taskModelDescription = [NSEntityDescription entityForName:@"TaskModel" inManagedObjectContext:context];
    [request setEntity:taskModelDescription];
    if(taskModelDescription){
        NSError *error;
        NSArray *taskModelArray = [context executeFetchRequest:request error:&error];
        if(!error){
            for (TaskModel* taskModel in taskModelArray)
                [self addTaskWithTaskModel:taskModel];
            return YES;
        }
    }
    return NO;
}


- (id)init
{
    self = [super init];
    if (self) {
        self->_inboxTaskList = [[NSMutableArray alloc] init];
        self->_nextTaskList = [[NSMutableArray alloc] init];
        self->_waittingTaskList = [[NSMutableArray alloc] init];
        self->_someDayTaskList = [[NSMutableArray alloc] init];
        self->_projectTaskList = [[NSMutableArray alloc] init];
        self->_trashTaskList = [[NSMutableArray alloc] init];
        self->_doneTaskList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithListInbox:(NSMutableArray *)inbox next:(NSMutableArray *)next waitting:(NSMutableArray *)waitting someDay:(NSMutableArray *)someDay project:(NSMutableArray *)project
{
    self = [super init];
    if (self) {
        self->_inboxTaskList = inbox;
        self->_nextTaskList = next;
        self->_waittingTaskList = waitting;
        self->_someDayTaskList = someDay;
        self->_projectTaskList = project;
        self->_trashTaskList = [[NSMutableArray alloc] init];
        self->_doneTaskList = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)addTaskWithTask:(Task *)task
{
    BOOL dataStored = [self saveTaskModelUsingCoreData:task withCategory:INBOX];
    if(dataStored)
        [_inboxTaskList addObject:task];
}

- (void)addTaskWithTask:(Task *)task withCategory:(NSString *)category
{
    BOOL correctlyStored = [self saveTaskModelUsingCoreData:task withCategory:category];
    if(correctlyStored){
        NSMutableArray* array = [self listByCategory:category];
        [array addObject:task];
    }
}

- (NSMutableArray *)listByCategory:(NSString *)category
{
    if([category isEqualToString:INBOX])
        return _inboxTaskList;
    else if ([category isEqualToString: NEXT])
        return _nextTaskList;
    else if([category isEqualToString: WAITING])
        return _waittingTaskList;
    else if([category isEqualToString: SOMEDAY])
        return _someDayTaskList;
    else if([category isEqualToString: PROJECT])
        return _projectTaskList;
    else if([category isEqualToString: TRASH])
        return _trashTaskList;
    else if([category isEqualToString: DONE])
        return _doneTaskList;
    
    return nil;
}

-(Task *)objectInListWithCategory:(NSString *)category atIndex:(NSInteger)index
{
    NSMutableArray* array = [self listByCategory:category];
    if(array != nil)
        return [array objectAtIndex:index];
    return nil;
}

-(NSInteger)countOfListWithCategory:(NSString *)category
{
    NSMutableArray* array = [self listByCategory:category];
    if(array)
        return [array count];
    return 0;
}

-(BOOL)changeTaskCategory:(Task *)task fromCategory:(NSString *)sourceCategory toCategory:(NSString *)destinyCategory
{
    NSMutableArray* sourceArray = [self listByCategory:sourceCategory];
    int index = [sourceArray indexOfObject:task];
    if(index >=0){
        [self removeTask:task atCategory:task.category];
        task.category = destinyCategory;
        [self addTaskWithTask:task withCategory:task.category];
        
        return TRUE;
    }
    return FALSE;
}

- (void)removeTask:(Task *)task atCategory:(NSString*)category
{
    //first core data
    AppDelegate *appDelegate = [[UIApplication sharedApplication]
                                delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"TaskModel" inManagedObjectContext:context];
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    request.entity = entityDescription;
    NSError* error;
    NSArray* array = [context executeFetchRequest:request error:&error];
    if([array count]){
        bool finish = false;
        for (int i=0; i<[array count] && !finish; i++) {
            TaskModel* taskModel = [array objectAtIndex:i];
            NSString* name = taskModel.name;
            if([name isEqualToString:task.name]){
                [context deleteObject:taskModel];
                NSError* error;
                [context save:&error];
                finish = true;
            }
        }
    }
    
    //and later the array
    NSMutableArray* myArray = [self listByCategory:category];
    [myArray removeObject:task];
}

- (NSMutableArray *)completedArray
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:self.inboxTaskList];
    [array addObjectsFromArray:self.nextTaskList];
    [array addObjectsFromArray:self.someDayTaskList];
    [array addObjectsFromArray:self.projectTaskList];
    [array addObjectsFromArray:self.waittingTaskList];
    [array addObjectsFromArray:self.doneTaskList];
    [array addObjectsFromArray:self.trashTaskList];
    
     return array;
}

@end
