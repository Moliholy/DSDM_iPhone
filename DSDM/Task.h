//
//  Task.h
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (weak, nonatomic) NSString* name;
@property (weak, nonatomic) NSDate* date;
@property (weak, nonatomic) NSString* note;
@property (weak, nonatomic) NSString* category;
@property (nonatomic) NSInteger priority;
@property (nonatomic) BOOL alreadyDone;

- (id)initWithName:(NSString*)name date:(NSDate*)date note:(NSString*)note category:(NSString*)category priority:(NSInteger)priority;


@end
