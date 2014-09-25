RadialTransition_objC
=====================

Transition for navigation controller, with custom back swipe.


Demo
----
![alt tag](https://raw.githubusercontent.com/apadalko/RadialTransition_objC/master/radilaDemo_long.gif)


Example 
----
for push simple use
```  objc

 [self.navigationController radialPushViewController:[[UIViewController alloc]init] comlititionBlock:^{
        
    }];
 [self.navigationController radialPushViewController:[self secondVC] withDuration:1 comlititionBlock:^{
        
    }];
    
 [self.navigationController radialPushViewController:[self secondVC] withDuration:1 withStartFrame:CGRectMake(self.view.frame.size.width, 0, 0, 0) comlititionBlock:^{
        
    }];


```
for pop  use
```  objc

   [self.navigationController radialPopViewControllerWithComlititionBlock:^{
        
    }];
 [self.navigationController radialPopViewControllerWithDuration:0.9 comlititionBlock:^{
        
    }];
    [self.navigationController radialPopViewControllerWithDuration:0.9 withStartFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, 0, 0) comlititionBlock:^{
        
    }];


```
