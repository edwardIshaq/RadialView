//
//  RadialView.h
//  NGTS
//
//  Created by Edward Ashak on 3/27/12.
//  Copyright (c) 2012 Three Pillar Global. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CAShapeLayer;

/**
 \class RadialView
 \brief This class will draw a visualized representation of a percent
 \ingroup Views
 
 This class can draw a circular representation of a percent and animate it.
 In addition you can set the text display an image and choose a color for this view.
 The view should work in any frame it will adjust its inner componnets to meat the new frame.
 
 */
@interface RadialView : UIView {
    
@private
    CAShapeLayer *pathLayer;
    
@public
	CGFloat percent;        
	UIColor *strokeColor;   
	UIImageView *imageView; //!< an image to display under the label
	UIView *innerSquare;
}

@property (nonatomic, assign) CGFloat percent;      //!< 0 <= percent <= 1
@property (nonatomic, retain) UIColor *strokeColor; //!< Color of the circular band
@property (nonatomic, retain) UILabel *centerLabel; //!< Label property to add text/numbers inside the RadialView
@property (nonatomic, retain) UIFont *centerFont;   //!< Font of the label
@property (nonatomic, retain) UIImage *image;       //!< image for the RadialView
@property (assign) BOOL shouldAnimate;              //!< default YES, assign NO if you dont want animation
@property (nonatomic, assign) BOOL animateOnce;                //!< default NO, assign YES if you want a to see animation on first run only
@end
