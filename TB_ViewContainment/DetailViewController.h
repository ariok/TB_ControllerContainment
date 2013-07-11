//
//  DetailViewController.h
//  TB_ViewContainment
//
//  Created by Yari Dareglia on 7/6/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContainerViewController;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet FUIButton *button;

- (id)initWithString:(NSString*)string withColor:(UIColor*)color;

@end
