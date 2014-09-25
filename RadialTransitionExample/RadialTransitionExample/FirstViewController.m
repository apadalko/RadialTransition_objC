//
//  FirstViewController.m
//  RadialTransitionExample
//
//  Created by Alex Padalko on 9/24/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UINavigationController+RadialTransaction.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController enableRadialSwipe];

    self.title = @"First ViewController";
    
 
    
 
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
-(UIViewController*)secondVC{
    
    return [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    
}
- (IBAction)simplePush:(id)sender {
    
    [self.navigationController radialPushViewController:[self secondVC] comlititionBlock:^{
        
    }];
    
}

- (IBAction)pushWIthCustomFrame1:(UIButton*)sender {
    
    
    
    [self.navigationController radialPushViewController:[self secondVC] withDuration:1 withStartFrame:sender.frame comlititionBlock:^{
        
    }];
    
}

- (IBAction)pushWithCustomFrame2:(id)sender {
    
    [self.navigationController radialPushViewController:[self secondVC] withDuration:1 withStartFrame:CGRectMake(self.view.frame.size.width, 0, 0, 0) comlititionBlock:^{
        
    }];
    
}
@end
