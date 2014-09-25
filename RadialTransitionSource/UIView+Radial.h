//
//  UIView+Radial.h
//  RadialTransaction
//
//  Created by Alex Padalko on 9/22/14.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Animator: NSObject
-(void)startAnimation:(void(^)())complBlock;
-(instancetype)initWithLayer:(CALayer*)layer andAnimation:(CAAnimation*)anim;
@end;
@interface UIView(Radial)
-(void)radialAppireanceWithStartFrame:(CGRect)startFrame duration:(CGFloat)duration andComplitBLock:(void(^)())complBlock;
-(void)radialDissmisWithStartFrame:(CGRect)startFrame duration:(CGFloat)duration andComplitBLock:(void (^)())complBlock;
@end
