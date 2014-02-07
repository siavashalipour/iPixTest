//
//  ImageViewController.m
//  iPixTest
//
//  Created by Siavash on 2/7/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
{
    BOOL flag;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.mainImage.image = self.img;
    self.originalImage = self.img;
    self.title = @"Edit Image";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self unHideViewByName:@"all" answer:NO];
    flag = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)unHideViewByName:(NSString *)name answer:(BOOL)answer
{
    if ([name isEqualToString:@"all"]) {
        [self.colorView setHidden:!answer];
        [self.fxView setHidden:!answer];
        [self.rotateView setHidden:!answer];
        [self.fxPopUpArrow setHidden:!answer];
        [self.colorPopUpArrow setHidden:!answer];
        [self.rotatePopUpArrow setHidden:!answer];
    }
    else if ([name isEqualToString:@"colorView"]){
        [self.colorView setHidden:!answer];
        [self.colorPopUpArrow setHidden:!answer];
        
        [self.fxView setHidden:answer];
        [self.rotateView setHidden:answer];
        [self.fxPopUpArrow setHidden:answer];
        [self.rotatePopUpArrow setHidden:answer];
        
    }
    else if ([name isEqualToString:@"fxView"]){
        [self.fxView setHidden:!answer];
        [self.fxPopUpArrow setHidden:!answer];
        
        [self.colorView setHidden:answer];
        [self.rotateView setHidden:answer];
        [self.colorPopUpArrow setHidden:answer];
        [self.rotatePopUpArrow setHidden:answer];
    }
    else if ([name isEqualToString:@"rotateView"]){
        [self.rotateView setHidden:!answer];
        [self.rotatePopUpArrow setHidden:!answer];
        
        [self.fxView setHidden:answer];
        [self.fxPopUpArrow setHidden:answer];
        [self.colorView setHidden:answer];
        [self.colorPopUpArrow setHidden:answer];
        
    }
}
- (IBAction)saturation:(id)sender
{
    selectedFilter = [[GPUImageSaturationFilter alloc] init];
    [(GPUImageSaturationFilter *)selectedFilter setSaturation:[(UISlider *)sender value]];
    
    UIImage *filterImage =[selectedFilter imageByFilteringImage:self.img];
    
    
    self.mainImage.image = filterImage;
}

- (IBAction)brightness:(id)sender
{
    selectedFilter = [[GPUImageBrightnessFilter alloc] init];
    [(GPUImageBrightnessFilter *)selectedFilter setBrightness:[(UISlider *)sender value]];
    
    UIImage *filterImage =[selectedFilter imageByFilteringImage:self.img];
    
    
    self.mainImage.image = filterImage;
}

- (IBAction)contrast:(id)sender
{
    selectedFilter = [[GPUImageContrastFilter alloc] init];
    [(GPUImageContrastFilter *)selectedFilter setContrast:[(UISlider *)sender value]];
    
    UIImage *filterImage =[selectedFilter imageByFilteringImage:self.img];
    
    
    self.mainImage.image = filterImage;
}

- (IBAction)sepia:(id)sender
{
    static CGFloat counter = 1;
    counter -=0.25;
    if (counter<0) {
        counter = 1;
    }
    
    selectedFilter = [[GPUImageSepiaFilter alloc] init];
    [(GPUImageSepiaFilter *)selectedFilter setIntensity:counter];
    
    self.img = [selectedFilter imageByFilteringImage:self.img];
    
    self.mainImage.image = self.img;
}

- (IBAction)grayscale:(id)sender
{
    if (flag==NO) {
        selectedFilter = [[GPUImageGrayscaleFilter alloc] init];
        
        self.img = [selectedFilter imageByFilteringImage:self.img];
        
        self.mainImage.image = self.img;
        flag = YES;
    }
    else
    {
        self.mainImage.image = self.img;
        flag = NO;
    }
}

- (IBAction)exposure:(id)sender
{
    static CGFloat counter = 0.05;
    selectedFilter = [[GPUImageExposureFilter alloc] init];
    [(GPUImageExposureFilter *)selectedFilter setExposure:counter];
    
    self.img = [selectedFilter imageByFilteringImage:self.img];
    
    self.mainImage.image = self.img;
    if (counter>=1.5) {
        counter = -0.75;
        selectedFilter =  [[GPUImageExposureFilter alloc] init];
        self.originalImage = [selectedFilter imageByFilteringImage:self.originalImage];
        self.mainImage.image = self.originalImage;
        self.img = self.originalImage;
        
    }
    counter +=0.25;
}

- (IBAction)rotate90:(id)sender
{
    selectedFilter = [[GPUImageFilter alloc] init];
    [selectedFilter setInputRotation:GPUImageRotationSwapsWidthAndHeight(kGPUImageRotateLeft) atIndex:0];
    self.img = [selectedFilter imageByFilteringImage:self.img];
    
    self.mainImage.image = self.img;
    self.originalImage = self.img;
}

- (IBAction)rotate180:(id)sender
{
    selectedFilter = [[GPUImageTransformFilter alloc] init];
    
    [(GPUImageTransformFilter *)selectedFilter setAffineTransform:CGAffineTransformMakeRotation(-M_PI)];
    
    self.img = [selectedFilter imageByFilteringImage:self.img];
    
    self.mainImage.image = self.img;
    self.originalImage = self.img;
}

- (IBAction)rotate90CW:(id)sender
{
    selectedFilter = [[GPUImageFilter alloc] init];
    
    [selectedFilter setInputRotation:GPUImageRotationSwapsWidthAndHeight(kGPUImageRotateRight) atIndex:0];
    
    self.img = [selectedFilter imageByFilteringImage:self.img];
    self.mainImage.image = self.img;
    self.originalImage = self.img;
}

- (IBAction)rotate180CW:(id)sender
{
    selectedFilter = [[GPUImageTransformFilter alloc] init];
    
    [(GPUImageTransformFilter *)selectedFilter setAffineTransform:CGAffineTransformMakeRotation(M_PI)];
    
    
    self.img = [selectedFilter imageByFilteringImage:self.img];
    
    self.mainImage.image = self.img;
}

- (IBAction)fx:(id)sender
{
    [self unHideViewByName:@"all" answer:NO];
    [self unHideViewByName:@"fxView" answer:YES];
}

- (IBAction)color:(id)sender
{
    [self unHideViewByName:@"all" answer:NO];
    [self unHideViewByName:@"colorView" answer:YES];
}

- (IBAction)rotate:(id)sender
{
    [self unHideViewByName:@"all" answer:NO];
    [self unHideViewByName:@"rotateView" answer:YES];
}

@end
