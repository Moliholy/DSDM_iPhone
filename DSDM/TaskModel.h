//
//  TaskModel.h
//  DSDM
//
//  Created by Molina on 07/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TaskModel : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * priority;

@end
