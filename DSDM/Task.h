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
@property (copy, nonatomic) NSString* category;
@property (nonatomic) float priority;


- (id)initWithName:(NSString*)name date:(NSDate*)date note:(NSString*)note priority:(float)priority category:(NSString*)category;


@end
