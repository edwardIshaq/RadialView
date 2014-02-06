//
//  RadialView.m
//  NGTS
//
//  Created by Edward Ashak on 3/27/12.
//  Copyright (c) 2012 Three Pillar Global. All rights reserved.
//

#import "RadialView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RadialView

@synthesize percent;
@synthesize strokeColor;
@synthesize centerLabel;
@synthesize image;
@synthesize centerFont;
@synthesize shouldAnimate;
@synthesize animateOnce;

- (id)commonInit {
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		innerSquare = [[UIView alloc] init];
		[self addSubview:innerSquare];
		
		self.centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		self.centerLabel.backgroundColor = [UIColor clearColor];
		self.centerLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:49];
		self.centerLabel.adjustsFontSizeToFitWidth = YES;
		self.centerLabel.textAlignment = NSTextAlignmentCenter;
        self.centerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		self.centerLabel.text = @"999";
		self.centerLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.31 alpha:1];
		[innerSquare addSubview:self.centerLabel];
		
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stats.jpg"]];
		[imageView setFrame:CGRectMake(0, 0, 23, 26)];
		[innerSquare addSubview:imageView];
        
        self.shouldAnimate = YES;
        self.animateOnce = NO;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self commonInit];
		
    }
    return self;
}

- (void)setPercent:(CGFloat)percent_ {
	percent = percent_;
	[self setNeedsDisplay];
}

- (CGFloat)angle {
	if (percent < 0) {
		return 0;
	}
	if (percent > 1) {
		return (M_PI * 2);
	}
	CGFloat result = percent * M_PI * 2;
	return result;
}

- (UIColor*)fillColor {
    if (self.strokeColor) {
		return self.strokeColor;
	}
    return [UIColor purpleColor];
}

- (void)setAnimateOnce:(BOOL)_animateOnce {
    if (_animateOnce) {
        self.shouldAnimate = YES;
        animateOnce = _animateOnce;
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGFloat startAngle = (3*M_PI_2);
	CGFloat endAngle = (startAngle + [self angle]);
	CGFloat radius = (rect.size.width > rect.size.height ? rect.size.height : rect.size.width)/2.0;
	radius -= 14;	//chop of for insets
	CGFloat lineWidth = 13;
    
    // Background filling
    UIBezierPath *backgroundRing = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
	backgroundRing.lineWidth = lineWidth;
	[[UIColor whiteColor] setStroke];
	[backgroundRing stroke];
    
    //Percent filling
    NSLog(@"%f - %f", startAngle , endAngle);
	UIBezierPath *percentRing = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    if (self.shouldAnimate) {
        //Animate the filling
        if (pathLayer.superlayer) {
            //remove existing path first
            [pathLayer removeAllAnimations];
            [pathLayer removeFromSuperlayer];
        }
        pathLayer = [CAShapeLayer layer];
        pathLayer.frame = self.bounds;
        pathLayer.bounds = self.bounds;
        pathLayer.path = percentRing.CGPath;
        pathLayer.strokeColor = [[self fillColor] CGColor];
        pathLayer.fillColor = [[UIColor clearColor] CGColor];
        pathLayer.lineWidth = lineWidth;
        [self.layer addSublayer:pathLayer];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.7;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        
        if (self.animateOnce) {
            self.shouldAnimate = NO;
        }
    }
    else {
        [[self fillColor] setStroke];
        percentRing.lineWidth = lineWidth;
        [percentRing stroke];
        
    }
    
    
	//outer Border
	CGFloat innerRadius = radius-(lineWidth/2.0);
	UIBezierPath *innerBorder = [UIBezierPath bezierPathWithArcCenter:center radius:innerRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
	innerBorder.lineWidth = 1;
	[[UIColor grayColor] setStroke];
	[innerBorder stroke];
	
	//inner Border
	UIBezierPath *outerBorder = [UIBezierPath bezierPathWithArcCenter:center radius:radius+(lineWidth/2.0) startAngle:0 endAngle:2*M_PI clockwise:YES];
	outerBorder.lineWidth = 1;
	[[UIColor grayColor] setStroke];
	[outerBorder stroke];
	
	if (self.image) {
		imageView.image = self.image;
	}
	
	CGFloat ir = (innerRadius-2);
	CGFloat squareDim = sqrtf(ir*ir*2);
    
	innerSquare.frame = CGRectMake(0, 0, squareDim, squareDim*1.1);
	innerSquare.center = center;
	innerSquare.backgroundColor = [UIColor clearColor];
    
	CGRect innerFrame = innerSquare.frame;
	CGFloat innerWidth = innerFrame.size.width;
	
	//Adjust the center label and the image
	CGFloat labelWidth = 4*innerWidth/5;
	CGRect labelRect = CGRectMake((innerWidth - labelWidth)/2, 0, labelWidth, labelWidth);
	
	centerLabel.frame = labelRect;
	if (!self.centerFont) {
		centerLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:labelRect.size.width/1];
	}
	else {
		self.centerLabel.font = self.centerFont;
	}
	centerLabel.backgroundColor = [UIColor clearColor];
	
    CGFloat imageDim = MIN(labelRect.size.width, (innerWidth-labelRect.size.height)*2);
    CGRect imageRect = CGRectMake((innerWidth - imageDim)/2, labelRect.origin.y + labelRect.size.height, imageDim, imageDim);
    
	imageView.frame = imageRect;
    imageView.backgroundColor = [UIColor clearColor];
	
}

- (void)dealloc {

}
@end