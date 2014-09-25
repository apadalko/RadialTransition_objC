//
//  SecondViewController.m
//  RadialTransitionExample
//
//  Created by Alex Padalko on 9/24/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationController+RadialTransaction.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second ViewController";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(simplePop:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)simplePop:(id)sender {
    
    [self.navigationController radialPopViewControllerWithComlititionBlock:^{
        
    }];
}

- (IBAction)customFrame1:(id)sender {
    
    [self.navigationController radialPopViewControllerWithDuration:0.9 withStartFrame:CGRectZero comlititionBlock:^{
        
    }];
    
}

- (IBAction)customFrame2:(id)sender {
    
    [self.navigationController radialPopViewControllerWithDuration:0.9 withStartFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, 0, 0) comlititionBlock:^{
        
    }];
    
    
}
@end
