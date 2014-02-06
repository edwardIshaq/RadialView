//
//  ViewController.h
//  RadialView
//
//  Created by Edward Ashak on 2/5/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadialView;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet RadialView *radialView;
- (IBAction)updateRadial:(id)sender;

@end
