//
//  Task.h
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (copy, nonatomic) NSString* name;
@property (strong, nonatomic) NSDate* date;
@property (copy, nonatomic) NSString* note;
@property (nonatomic) float priority;
@property (nonatomic) BOOL alreadyDone;

- (id)init;
- (id)initWithName:(NSString*)name date:(NSDate*)date note:(NSString*)note priority:(float)priority;


@end
