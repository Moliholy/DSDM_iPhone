//
//  Category.h
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Task;

@interface Category : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSHashTable* members;

- (id)initWithName:(NSString*)name;
- (Task*)obtainTask:(NSString*)task;
- (void)addTask:(Task*)task;
- (void)removeTask:(Task*)task;

@end
