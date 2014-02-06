//
//  ViewController.m
//  RadialView
//
//  Created by Edward Ashak on 2/5/14.
//  Copyright (c) 2014 Edward Ashak. All rights reserved.
//

#import "ViewController.h"
#import "RadialView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.radialView.percent = .0;
    self.radialView.centerLabel.text = @"0";
    self.radialView.animateOnce = YES;
    self.radialView.image = [UIImage imageNamed:@"RadialDemo"];
    self.radialView.centerFont = [UIFont fontWithName:@"Arial" size:45];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateRadial:(id)sender {
    UISlider *slider = (UISlider*)sender;

    self.radialView.percent = slider.value;
    self.radialView.centerLabel.text = [NSString stringWithFormat:@"%d",(int)(slider.value*100)];

    NSLog(@"%f %f",slider.value, self.radialView.percent);
}
@end
