//
//  Category.m
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "Category.h"
#import "Task.h"

@implementation Category

-(id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self->_name = name;
        self->_members = [[NSHashTable alloc] init];
    }
    return self;
}

-(id)obtainTask:(Task*)task;
{
    return [self->_members member:task];
}

- (void)addTask:(Task *)task
{
    [self->_members addObject:task];
}

-(void)removeTask:(Task *)task
{
    [self->_members removeObject:task];
}


@end
