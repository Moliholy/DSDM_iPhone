//
//  SelectTaskCategoryViewController.h
//  DSDM
//
//  Created by Molina on 01/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskDataController;

@interface SelectTaskCategoryViewController : UIViewController

@property (nonatomic, strong) TaskDataController* taskCategoryArrays;

- (IBAction)cancel:(UIStoryboardSegue*)segue;
- (IBAction)done:(UIStoryboardSegue*)segue;

@end
