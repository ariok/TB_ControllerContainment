//
//  ContainerViewController.h
//  TB_ViewContainment
//
//  Created by Yari Dareglia on 7/6/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet FUIButton *button;

- (IBAction)addDetailController:(id)sender;

@end
