//
//  UINavigationController+RadialTransaction.h
//  RadialTransaction
//
//  Created by Alex Padalko on 9/22/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface UINavigationController(RadialTransaction)<UIGestureRecognizerDelegate>
/**
 * set default anim time. Default value 0.5
 *
 */
+(void)setDefaultRadialAnimationTime:(float)time;
+(float)defaultRadialAnimationTime;

#pragma mark - PUSH



/**
 * radial pushing view controller
 *
 * @param startFrame where circle start
 */
-(void)radialPushViewController:(UIViewController *)viewController  withDuration:(float)duration withStartFrame:(CGRect)rect  comlititionBlock:(void(^)())block;



-(void)radialPushViewController:(UIViewController *)viewController withDuration:(float)duration comlititionBlock:(void(^)())block;


-(void)radialPushViewController:(UIViewController *)viewController comlititionBlock:(void(^)())block;

-(void)radialPushViewController:(UIViewController *)viewController withStartFrame:(CGRect)rect comlititionBlock:(void(^)())block;




#pragma mark - POP


/**
 * radial pop view controller
 *
 * @param startFrame where circle start
 */
-(void)radialPopViewControllerWithDuration:(float)duration withStartFrame:(CGRect)rect  comlititionBlock:(void(^)())block;
-(void)radialPopViewControllerWithDuration:(float)duration comlititionBlock:(void(^)())block;


-(void)radialPopViewControllerWithComlititionBlock:(void(^)())block;

-(void)radialPopViewControllerWithStartFrame:(CGRect)rect comlititionBlock:(void(^)())block;



#pragma mark - swipe
/**
 * enabling swipe back gesture. NOTE interactivePopGestureRecognizer will be disabled
 *
 */
-(void)enableRadialSwipe;
-(void)disableRadialSwipe;

@end
