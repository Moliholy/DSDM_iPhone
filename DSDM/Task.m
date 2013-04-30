//
//  Task.m
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "Task.h"

@implementation Task


- (id)init
{
    self = [super init];
    if (self) {
        self->_alreadyDone = NO;
        self->_category = @"";
        self->_date = [NSDate date];
        self->_name = @"";
        self->_note = @"";
        self->_priority = 0;
    }
    return self;
}

-(id)initWithName:(NSString *)name date:(NSDate *)date note:(NSString *)note category:(NSString *)category priority:(NSInteger)priority
{
    self = [super init];
    if (self) {
        self->_alreadyDone = NO;
        self->_category = category;
        self->_date = date;
        self->_name = name;
        self->_note = note;
        self->_priority = priority;
    }
    return self;
}


@end
