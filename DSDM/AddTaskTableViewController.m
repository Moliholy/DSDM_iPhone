//
//  AddTaskTableViewController.m
//  DSDM
//
//  Created by Molina on 30/04/13.
//  Copyright (c) 2013 Ladis-Molina. All rights reserved.
//

#import "AddTaskTableViewController.h"

@interface AddTaskTableViewController ()

@end

@implementation AddTaskTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //IMPLEMENTAR
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //IMPLEMENTAR
}


@end
