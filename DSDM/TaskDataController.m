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

@implementation TaskDataController

- (id)init
{
    self = [super init];
    if (self) {
        self->_inboxTaskList = [[NSMutableArray alloc] init];
        self->_nextTaskList = [[NSMutableArray alloc] init];
        self->_waittingTaskList = [[NSMutableArray alloc] init];
        self->_someDayTaskList = [[NSMutableArray alloc] init];
        self->_projectTaskList = [[NSMutableArray alloc] init];
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
    }
    return self;
}


-(void)addTaskWithTask:(Task *)task
{
    [_inboxTaskList addObject:task];
}

- (void)addTaskWithTask:(Task *)task withCategory:(NSString *)category
{
    NSMutableArray* array = [self listByCategory:category];
    [array addObject:task];
}

- (NSMutableArray *)listByCategory:(NSString *)category
{
    if([category isEqualToString:INBOX])
        return _inboxTaskList;
    else if ([category isEqualToString: NEXT])
        return _nextTaskList;
    else if([category isEqualToString: WAITTING])
        return _waittingTaskList;
    else if([category isEqualToString: SOME_DAY])
        return _someDayTaskList;
    else if([category isEqualToString: PROJECT])
        return _projectTaskList;
    
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
        NSMutableArray* destinyArray = [self listByCategory:destinyCategory];
        [sourceArray removeObjectAtIndex:index];
        [destinyArray addObject:task];
        return TRUE;
    }
    return FALSE;
}

- (void)removeTask:(Task *)task atCategory:(NSString*)category
{
    NSMutableArray* array = [self listByCategory:category];
    [array removeObject:task];
}

@end
