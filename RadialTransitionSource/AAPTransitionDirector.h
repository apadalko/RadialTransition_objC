//
//  AnimationDirector.h
//  RadialTransaction
//
//  Created by Alex Padalko on 9/22/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef void(^UpdateBlock)(id<UIViewControllerContextTransitioning> transitionContext,float precent);
typedef void(^AnimationBlock)(id<UIViewControllerContextTransitioning> transitionContext,float time,void (^complitBlock)());


@interface AAPTransitionDirector : NSObject<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate,UIViewControllerInteractiveTransitioning>



/**
 * animation block.Use transactionContext to get all needed views. toViewController will be above. NOTE: if you use it for animation without interactive YOU MUST RUN complitBlock at end.
 *
 */
@property (copy)AnimationBlock animBlock;

/**
 * interactive update block.Use transactionContext to get all needed views.updating after percent changing
 *
 */
@property (copy)UpdateBlock interactiveUpdateBlock;

@property (copy)void (^interactiveComplitionBlock)();



@property (nonatomic)float duration;





@property (nonatomic, assign, getter = isInteractive) BOOL interactive;


/**
 * run to end interactive transaction
 *
 */
-(void)endInteractiveTranscation:(BOOL)cancelled complition:(void (^)())complitBlock ;

@property (nonatomic)CFTimeInterval timeOffset;


@property (nonatomic)float percent;
@end
