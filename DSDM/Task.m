//
//  Task.m
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "Task.h"
#import "Category.h"

@implementation Task


-(id)initWithName:(NSString *)name date:(NSDate *)date note:(NSString *)note priority:(float)priority category:(NSString *)category
{
    self = [super init];
    if (self) {
        self->_date = date;
        self->_name = name;
        self->_note = note;
        self->_priority = priority;
        self->_category = category;
        return self;
    }
    return nil;
}


@end
