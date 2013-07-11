//
//  DetailViewController.m
//  TB_ViewContainment
//
//  Created by Yari Dareglia on 7/6/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "DetailViewController.h"
#define ARC4RANDOM_MAX      0x100000000

@interface DetailViewController (){
    NSString *text;
    UIColor *color;
}
@end

@implementation DetailViewController

- (id)initWithString:(NSString*)string withColor:(UIColor*)theColor{
    self = [super init];
    
    if(self){
        text = string;
        color = theColor;//Setup some custom values
        
        UISwipeGestureRecognizer *sgr = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                            action:@selector(changeColor)];
        sgr.direction =(UISwipeGestureRecognizerDirectionLeft |
                        UISwipeGestureRecognizerDirectionRight);
        [self.view addGestureRecognizer:sgr];
    }
    
    return self;
}


//Setup the label color with a new one randomly generated
- (void)changeColor {
    double r = ((double)arc4random() / ARC4RANDOM_MAX);
    double g = ((double)arc4random() / ARC4RANDOM_MAX);
    double b = ((double)arc4random() / ARC4RANDOM_MAX);
    
    color = [UIColor colorWithRed:r green:g blue:b alpha:1];

    self.label.textColor = color;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup some custom values
    self.label.font = [UIFont italicFlatFontOfSize:40];
    self.label.textColor = color;
    self.label.text = text;

}


@end
