//
//  ImageCell.h
//  iPixTest
//
//  Created by Siavash on 2/8/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
