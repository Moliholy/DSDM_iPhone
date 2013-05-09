//
//  SelectTaskCategoryViewController.h
//  DSDM
//
//  Created by Molina on 01/05/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskDataController;

@interface SelectTaskCategoryViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) TaskDataController* taskCategoryArrays;

- (IBAction)cancel:(UIStoryboardSegue*)segue;
- (IBAction)done:(UIStoryboardSegue*)segue;
- (IBAction)showExtraOptions:(id)sender;

@end
