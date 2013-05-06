//
//  TaskDataController.h
//  DSDM
//
//  Created by Molina on 01/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Task;

@interface TaskDataController : NSObject

@property (nonatomic, copy) NSMutableArray* inboxTaskList;
@property (nonatomic, copy) NSMutableArray* nextTaskList;
@property (nonatomic, copy) NSMutableArray* waittingTaskList;
@property (nonatomic, copy) NSMutableArray* someDayTaskList;
@property (nonatomic, copy) NSMutableArray* projectTaskList;

- (id)init;
- (id)initWithListInbox:(NSMutableArray*)inbox next:(NSMutableArray*)next waitting:(NSMutableArray*)waitting someDay:(NSMutableArray*)someDay project:(NSMutableArray*)project;
- (NSMutableArray*) listByCategory:(NSString*)category;
- (void)addTaskWithTask:(Task*)task;
- (void)addTaskWithTask:(Task*)task withCategory:(NSString*)category;
- (Task*)objectInListWithCategory:(NSString*)category atIndex:(NSInteger)index;
- (NSInteger)countOfListWithCategory:(NSString*)category;
- (BOOL)changeTaskCategory:(Task*)task fromCategory:(NSString*)sourceCategory toCategory:(NSString*)destinyCategory;
- (void) removeTask:(Task*)task atCategory:(NSString*)category;

@end
