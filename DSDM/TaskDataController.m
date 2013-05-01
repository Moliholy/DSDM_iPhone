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
        //if there're data persistece it is the moment to load the information
    }
    return self;
}

-(void)addTaskWithTask:(Task *)task
{
    [_inboxTaskList addObject:task];
}

- (NSMutableArray *)listByCategory:(NSString *)category
{
    if(category == INBOX)
        return _inboxTaskList;
    else if (category == NEXT)
        return _nextTaskList;
    else if(category == WAITTING)
        return _waittingTaskList;
    else if(category == SOME_DAY)
        return _someDayTaskList;
    else if(category == PROJECT)
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
    if(array != nil)
        return [array count];
    return 0;
}


@end
