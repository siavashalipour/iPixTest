//
//  ImageViewController.h
//  iPixTest
//
//  Created by Siavash on 2/7/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface ImageViewController : UIViewController
{
    GPUImageFilter *selectedFilter;
    GPUImageFilter *rotateFilter;
}
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *cropOriginalImage;

@property (strong, nonatomic) IBOutlet UIImageView *mainImage;


@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIView *fxView;
@property (strong, nonatomic) IBOutlet UIView *rotateView;
@property (strong, nonatomic) IBOutlet UIImageView *fxPopUpArrow;
@property (strong, nonatomic) IBOutlet UIImageView *colorPopUpArrow;
@property (strong, nonatomic) IBOutlet UIImageView *rotatePopUpArrow;

- (IBAction)saturation:(id)sender;
- (IBAction)brightness:(id)sender;
- (IBAction)contrast:(id)sender;


- (IBAction)sepia:(id)sender;
- (IBAction)grayscale:(id)sender;
- (IBAction)exposure:(id)sender;


- (IBAction)rotate90:(id)sender;
- (IBAction)rotate180:(id)sender;
- (IBAction)rotate90CW:(id)sender;
- (IBAction)rotate180CW:(id)sender;

- (IBAction)fx:(id)sender;
- (IBAction)color:(id)sender;
- (IBAction)rotate:(id)sender;

@end
