//
//  WallImageViewController.h
//  iPixTest
//
//  Created by Siavash on 2/8/14.
//  Copyright (c) 2014 SiavashAlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@end
