//
//  UINavigationController+RadialTransaction.m
//  RadialTransaction
//
//  Created by Alex Padalko on 9/22/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import "UINavigationController+RadialTransaction.h"
#import "UIView+Radial.h"
#import "AAPTransitionDirector.h"


@implementation  UINavigationController(RadialTransaction)


static float defaultAnimationTime = 0.33;
+(void)setDefaultRadialAnimationTime:(float)time{
    defaultAnimationTime=time;
    
}
+(float)defaultRadialAnimationTime{
    return defaultAnimationTime;
}

#pragma  mark - PUSH
-(void)radialPushViewController:(UIViewController *)viewController withDuration:(float)duration comlititionBlock:(void(^)())block{

    
    [self radialPushViewController:viewController withDuration:duration withStartFrame:CGRectMake(self.visibleViewController.view.frame.size.width, self.visibleViewController.view.frame.size.height/2,0, 0) comlititionBlock:block];
    
    
}

-(void)radialPushViewController:(UIViewController *)viewController comlititionBlock:(void(^)())block{
    
     [self radialPushViewController:viewController withDuration:defaultAnimationTime withStartFrame:CGRectMake(self.visibleViewController.view.frame.size.width, self.visibleViewController.view.frame.size.height/2,0, 0) comlititionBlock:block];
    
}

-(void)radialPushViewController:(UIViewController *)viewController withStartFrame:(CGRect)rect comlititionBlock:(void(^)())block{
    
    
     [self radialPushViewController:viewController withDuration:defaultAnimationTime withStartFrame:rect comlititionBlock:block];
    
    
}

-(void)radialPushViewController:(UIViewController *)viewController  withDuration:(float)duration withStartFrame:(CGRect)rect  comlititionBlock:(void(^)())block{
    
    AAPTransitionDirector * a=[[AAPTransitionDirector alloc]init];
    a.duration=duration;
 
    a.animBlock=^(id<UIViewControllerContextTransitioning> transitionContext,float time,void(^comlitBlock)() ){
        
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
        [toViewController.view radialAppireanceWithStartFrame:rect duration:time andComplitBLock:comlitBlock];
        
    };
    [self setDelegate:a];
    
    
    
    [self pushViewController:viewController animated:YES];

     self.delegate = nil;
    
    
    
}

#pragma mark - POP


-(void)radialPopViewControllerWithComlititionBlock:(void (^)())block{
    
    [self radialPopViewControllerWithDuration:defaultAnimationTime withStartFrame:CGRectMake(0, self.visibleViewController.view.frame.size.height/2, 0, 0) comlititionBlock:block];
    
    
}

-(void)radialPopViewControllerWithDuration:(float)duration comlititionBlock:(void (^)())block{
    
    [self radialPopViewControllerWithDuration:duration withStartFrame:CGRectMake(0, self.visibleViewController.view.frame.size.height/2, 0, 0) comlititionBlock:block];
    
}

-(void)radialPopViewControllerWithStartFrame:(CGRect)rect comlititionBlock:(void (^)())block{
    
    [self radialPopViewControllerWithDuration:defaultAnimationTime withStartFrame:rect comlititionBlock:block];
    
}
-(void)radialPopViewControllerWithDuration:(float)duration withStartFrame:(CGRect)rect comlititionBlock:(void (^)())block{
    
    AAPTransitionDirector * a=[[AAPTransitionDirector alloc]init];
    
     a.duration=duration;
     a.animBlock=^(id<UIViewControllerContextTransitioning> transitionContext,float time,void(^comlitBlock)() ){
        
         UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [toViewController.view radialAppireanceWithStartFrame:rect duration:time andComplitBLock:comlitBlock];
        
    };
    [self setDelegate:a];
    [self popViewControllerAnimated:YES];
       self.delegate = nil;
    return;
    
    
 
    
 
    
    
}

#pragma mark - swipe 

-(void)enableRadialSwipe{
    
  
    [self enableGesture:YES];

}
-(void)disableRadialSwipe{
    
    [self enableGesture:NO];
    
}
-(void)enableGesture:(BOOL)enable{
    
    
    
    static NSMutableDictionary * recDictionary=nil;
    if (!recDictionary) {
        recDictionary=[[NSMutableDictionary alloc]init];
    }
    
    if (enable) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
         UIScreenEdgePanGestureRecognizer * panGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenPan:)];
            panGesture.edges=UIRectEdgeLeft;

        
        [recDictionary setValue:panGesture forKey:self.description];
        
       
        
        [self.view addGestureRecognizer:panGesture];
    }else {
     
        [self.view removeGestureRecognizer:[recDictionary valueForKey:self.description]];
        [recDictionary removeObjectForKey:self.description];
       // panGesture = nil;
        
    }
    
}


- (void)screenPan:(id)sender {
    
 
    
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    
    UIGestureRecognizerState state = pan.state;
    
    CGPoint location = [pan locationInView:self.view];
   
    static CGPoint firstTouch;
    static float d=0;
    static AAPTransitionDirector * animDirector=nil;

    

    switch (state) {
        case UIGestureRecognizerStateBegan: {
          
            
            animDirector=[[AAPTransitionDirector alloc]init];
            animDirector.interactive=YES;
            animDirector.duration=defaultAnimationTime;
            [self setDelegate:animDirector];
            [self popViewControllerAnimated:YES];
            
                 self.delegate = nil;
            d=sqrtf(powf(self.visibleViewController.view.frame.size.width*2, 2)+powf(self.visibleViewController.view.frame.size.height*2, 2));
            firstTouch=location;
            
            animDirector.animBlock=^(id<UIViewControllerContextTransitioning> transitionContext,float time,void(^comlitBlock)() ){
                
                
                UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                CGRect maskRect = CGRectMake(location.x-location.x/2, location.y-location.x/2, 0, 0);
                CGPathRef path = CGPathCreateWithEllipseInRect(maskRect, NULL);
                maskLayer.path = path;
        
                maskLayer.path=path;
                toViewController.view.layer.mask = maskLayer;
                CGPathRelease(path);
            };
            
       
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            
            animDirector.interactiveUpdateBlock=^(id<UIViewControllerContextTransitioning> transitionContext,float percent){
                
                CAShapeLayer *maskLayer =(CAShapeLayer*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask;
                float mainD= percent*d;
              
                
                CGRect maskRect = CGRectMake(-mainD/2, location.y-mainD/2, mainD, mainD);
                CGMutablePathRef p1 = CGPathCreateMutable();
                CGPathAddPath(p1, nil, CGPathCreateWithEllipseInRect(maskRect, nil));
                maskLayer.path=p1;
                
            };
          

                float mainD= location.x*d/self.view.frame.size.width;
                
                [animDirector setPercent:mainD/d];
 


            break;
        }
        default: {
            
            float mainD= location.x*d/self.view.frame.size.width;
            
            BOOL canceled=   mainD>d*0.5?NO:YES;
            
            [animDirector endInteractiveTranscation:canceled complition:^{
                animDirector = nil;
                self.delegate = nil;
            }];

            break;

        }
    }
}




@end
