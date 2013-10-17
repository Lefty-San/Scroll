//
//  ViewController.h
//  Scroll
//
//  Created by Eric Prewitt on 10/16/13.
//  Copyright (c) 2013 Eric Prewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoAlbumLayout.h"

@interface ViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionConnection;
@property (nonatomic, weak) IBOutlet PhotoAlbumLayout *photoalbumlayout;

@end

@implementation UICollectionViewController