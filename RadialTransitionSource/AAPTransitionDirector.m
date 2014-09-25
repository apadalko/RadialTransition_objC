//
//  AnimationDirector.m
//  RadialTransaction
//
//  Created by Alex Padalko on 9/22/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import "AAPTransitionDirector.h"
#import "UIView+Radial.h"
@interface AAPTransitionDirector(){
    
     id<UIViewControllerContextTransitioning> _context;
     CADisplayLink *_displayLink;
}
@end
@implementation AAPTransitionDirector



-(instancetype)init{
    if (self=[super init]) {
        _duration=0.5;
    }
    return self;
}

#pragma mark - time offset
- (CFTimeInterval)timeOffset {
    return [_context containerView].layer.timeOffset;
}

- (void)setTimeOffset:(NSTimeInterval)timeOffset {
    
    [self setPercent:timeOffset/self.duration];
   
}
#pragma mark - update percent
-(void)setPercent:(float)percent{
    _percent=percent;
    
    [_context updateInteractiveTransition:_percent];
    
    [_context containerView].layer.timeOffset = _percent*self.duration;
    if (self.interactiveUpdateBlock) {
        self.interactiveUpdateBlock(_context,_percent);
    }
}


#pragma mark - interactiveTransaction ending
-(void)endInteractiveTranscation:(BOOL)cancelled complition:(void (^)())complitBlock {
    
    if (complitBlock) {
        self.interactiveComplitionBlock=complitBlock;
    }
    
    
    
    if (cancelled) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateCancelAnimation)];
        
       
        
        
    } else {
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFinishAnimation)];
     
        
    }
       [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    
}
-(void)_transactionFinishFinishing{
    [_displayLink invalidate];
    [_context finishInteractiveTransition];
    [_context completeTransition:YES];
    if (self.interactiveComplitionBlock) {
        self.interactiveComplitionBlock();
    }
}
- (void)_transitionFinishedCanceling {
    [_displayLink invalidate];
    [_context cancelInteractiveTransition];
    [_context completeTransition:NO];
    
    if (self.interactiveComplitionBlock) {
        self.interactiveComplitionBlock();
    }
    
    
}
- (void)updateCancelAnimation {
    NSTimeInterval timeOffset = [self timeOffset]-[_displayLink duration];
    if (timeOffset < 0) {
        [self _transitionFinishedCanceling];
    } else {
        
        [self setTimeOffset:timeOffset];
    }
}

- (void)updateFinishAnimation {
    NSTimeInterval timeOffset = [self timeOffset]+[_displayLink duration];
    if (timeOffset > self.duration) {
        [self _transactionFinishFinishing];
    } else {
        [self setTimeOffset:timeOffset];
    }
}


#pragma mark - transaction delegate
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _context=transitionContext;
    UIViewController* toViewController = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *  containerView=  [_context containerView];
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    if (self.animBlock) {
        self.animBlock(transitionContext,[self transitionDuration:transitionContext],^{
            [transitionContext finishInteractiveTransition];
            [transitionContext completeTransition:YES];
        });
    }else{
        [transitionContext finishInteractiveTransition];
        [transitionContext completeTransition:YES];
    }
  
    

}
-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _context=transitionContext;
    UIViewController* toViewController = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *  containerView=  [_context containerView];
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    if (self.animBlock) {
        self.animBlock(transitionContext,[self transitionDuration:transitionContext],^{});
    }else{
        [transitionContext finishInteractiveTransition];
        [transitionContext completeTransition:YES];
    }
    
        
    
    
    
    
    
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

#pragma mark - navigation controller delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    return self;
    
}


-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {

    return self.isInteractive?self:nil;
}
 

@end
