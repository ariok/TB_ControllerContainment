//
//  ContainerViewController.m
//  TB_ViewContainment
//
//  Created by Yari Dareglia on 7/6/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "ContainerViewController.h"
#import "DetailViewController.h"


@interface ContainerViewController ()
@property UIViewController  *currentDetailViewController;
@end

@implementation ContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithViewController:(UIViewController*)viewController{
    
    self = [super init];
    
    if(self){
        [self presentDetailController:viewController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //UI ***************************
    
    self.title = @"CONTAINER";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    
    
    //Load the first detail controller 
    DetailViewController *detailOne = [[DetailViewController alloc]initWithString:@"I'm the first Detail Controller!"
                                                                        withColor:[UIColor carrotColor]];
    
    
    
    [self presentDetailController:detailOne];
    

    [self.button configureButtonWithColor:[UIColor colorFromHexCode:@"#e75659"]
                                andShadow:[UIColor colorFromHexCode:@"#bb2c38"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)presentDetailController:(UIViewController*)detailVC{
    
    //0. Remove the current Detail View Controller showed 
    if(self.currentDetailViewController){
        [self removeCurrentDetailViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:detailVC];
    
    //2. Define the detail controller's view size
    detailVC.view.frame = [self frameForDetailController];
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    [self.detailView addSubview:detailVC.view];
    self.currentDetailViewController = detailVC;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [detailVC didMoveToParentViewController:self];

}



- (void)removeCurrentDetailViewController{
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.currentDetailViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
    [self.currentDetailViewController removeFromParentViewController];
}



- (void)swapCurrentControllerWith:(UIViewController*)viewController{
    
    //1. The current controller is going to be removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. The new controller is a new child of the container
    [self addChildViewController:viewController];
    
    //3. Setup the new controller's frame depending on the animation you want to obtain
    viewController.view.frame = CGRectMake(0, 2000, viewController.view.frame.size.width, viewController.view.frame.size.height);

    //3b. Attach the new view to the views hierarchy
    [self.detailView addSubview:viewController.view];
    
    
    //Save the button position...we'll use it later
    CGPoint buttonCenter = self.button.center;
    
    
    [UIView animateWithDuration:1.3

        //4. Animate the views to create a transition effect
        animations:^{
        
            //The new controller's view is going to take the position of the current controller's view
            viewController.view.frame = self.currentDetailViewController.view.frame;
            
            //The current controller's view will be moved outside the window
            self.currentDetailViewController.view.frame = CGRectMake(0,
                                                                     -2000,
                                                                     self.currentDetailViewController.view.frame.size.width,
                                                                     self.currentDetailViewController.view.frame.size.width);
            //...and the same is for the button
            self.button.center = CGPointMake(buttonCenter.x, 1000);

        }
     
     
        //5. At the end of the animations we remove the previous view and update the hierarchy.
        completion:^(BOOL finished) {
            
            //Remove the old Detail Controller view from superview
            [self.currentDetailViewController.view removeFromSuperview];
            
            //Remove the old Detail controller from the hierarchy
            [self.currentDetailViewController removeFromParentViewController];
            
            //Set the new view controller as current
            self.currentDetailViewController = viewController;
            [self.currentDetailViewController didMoveToParentViewController:self];
            
            //reset the button position
            [UIView animateWithDuration:0.5 animations:^{
                self.button.center = buttonCenter;
            }];
    }];
    
}


- (CGRect)frameForDetailController{
    CGRect detailFrame = self.detailView.bounds;
    
    return detailFrame;
}

- (IBAction)addDetailController:(id)sender {
    DetailViewController *detailVC = [[DetailViewController alloc]initWithString:@"This is a new viewController!" withColor:[UIColor asbestosColor]];
    
    /* Mode 1 */
    //[self presentDetailController:detailVC];
    
    /* Mode 2 */
    [self swapCurrentControllerWith:detailVC];
}
@end
