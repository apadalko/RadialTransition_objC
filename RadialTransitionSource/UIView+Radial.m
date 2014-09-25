//
//  UIView+Radial.m
//  RadialTransaction
//
//  Created by Alex Padalko on 9/22/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import "UIView+Radial.h"
#pragma mark - ANIMATOR
typedef void(^animatorCompletionBlock)();
@interface Animator()
{
    animatorCompletionBlock completitionBlock;
    
    CALayer * animLayer;
    CAAnimation * caAnimation;
}
@end
@implementation Animator
-(void)startAnimation:(void(^)())complBlock{
    completitionBlock=complBlock;
    [animLayer addAnimation:caAnimation forKey:@"animator"];
}

-(instancetype)initWithLayer:(CALayer*)layer andAnimation:(CAAnimation*)anim{
        if (self=[super init]) {
            animLayer=layer;
            caAnimation=anim;
            [anim setDelegate:self];
        }
        return self;
        
    }
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
        
        completitionBlock();
        
}
@end

#pragma mark - Radial
@implementation UIView(Radial)
-(void)radialDissmisWithStartFrame:(CGRect)startFrame duration:(CGFloat)duration andComplitBLock:(void (^)())complBlock{
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.backgroundColor=[UIColor greenColor].CGColor;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    CGRect maskRect = startFrame;
    
    CGPathRef path = CGPathCreateWithEllipseInRect(maskRect, NULL);
    float  d=sqrtf(powf(self.frame.size.width, 2)+powf(self.frame.size.height, 2));
    d*=2;
    
    CGRect newR=  CGRectMake(self.frame.size.width/2-d/2 ,maskRect.origin.y-d/2, d, d);
    
    
    
    CGMutablePathRef p1 = CGPathCreateMutable();
    CGPathAddPath(p1, nil, CGPathCreateWithEllipseInRect(maskRect, nil));
    CGPathAddPath(p1, nil, CGPathCreateWithEllipseInRect(newR, nil));
    
    CGMutablePathRef p2 = CGPathCreateMutable();
    CGPathAddPath(p2, nil, CGPathCreateWithEllipseInRect(newR, nil));
    CGPathAddPath(p2, nil, CGPathCreateWithEllipseInRect(newR, nil));
    
    
    
    
    self.layer.mask = maskLayer;
    
    CABasicAnimation* revealAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    revealAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    revealAnimation.fromValue = (__bridge id)(p1);
    revealAnimation.toValue = (__bridge id)(p2);
    revealAnimation.duration =duration;
    maskLayer.path = p2;
    CGPathRelease(path);
    
    Animator * a=[[Animator alloc]initWithLayer:maskLayer andAnimation:revealAnimation];
    
    [a startAnimation:^{
        
        complBlock();
        
        
    }];
    
}
-(void)radialAppireanceWithStartFrame:(CGRect)startFrame duration:(CGFloat)duration andComplitBLock:(void(^)())complBlock{
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = startFrame;
    
    CGPathRef path = CGPathCreateWithEllipseInRect(maskRect, NULL);
    maskLayer.path = path;
    
    float  d=sqrtf(powf(self.frame.size.width, 2)+powf(self.frame.size.height, 2));
    d*=2;
    
    CGRect newR=  CGRectMake(self.frame.size.width/2-d/2 ,maskRect.origin.y-d/2, d, d);
    CGPathRef newPath = CGPathCreateWithEllipseInRect(newR, NULL);
    
    self.layer.mask = maskLayer;
    
    CABasicAnimation* revealAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    revealAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    revealAnimation.fromValue = (__bridge id)(path);
    revealAnimation.toValue = (__bridge id)(newPath);
    revealAnimation.duration =duration;
    maskLayer.path = newPath;
    CGPathRelease(path);
    
    Animator * a=[[Animator alloc]initWithLayer:maskLayer andAnimation:revealAnimation];
    
    [a startAnimation:^{
        [maskLayer removeFromSuperlayer];
        complBlock();
        
        
    }];
    
    
}

@end
