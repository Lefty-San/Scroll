//
//  ViewController.m
//  Scroll
//
//  Created by Eric Prewitt on 10/16/13.
//  Copyright (c) 2013 Eric Prewitt. All rights reserved.
//

/*
 *
 *  http://skeuo.com/uicollectionview-custom-layout-tutorial
 *  leaving off on step 32
 *
 *  http://www.raywenderlich.com/22324/beginning-uicollectionview-in-ios-6-part-12
 *  another tutorial with collectionview
 *
 *  http://www.mindtreatstudios.com/how-its-made/ios-gesture-recognizer-tips-tricks/
 *  pangesturerecognizer tip
 *
 */


#import "ViewController.h"
#import "PhotoAlbumLayout.h"
#import "AlbumPhotoCell.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";

@interface ViewController ()

@property (nonatomic, weak) IBOutlet PhotoAlbumLayout *photoalbumlayout;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.50f alpha:1.0f];

    [self.collectionView registerClass:[AlbumPhotoCell class]
            forCellWithReuseIdentifier:PhotoCellIdentifier];
    [self setupRecognizers];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRecognizers {

    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.delegate = self; // Very important
    [panRecognizer addTarget:self.collectionView action:@selector(panGestureRecognizer)];
    [self.collectionView addGestureRecognizer:panRecognizer];

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {

    NSLog(@"dey be hollerin at me like ay Lil Swipey");
    return YES; // Also, very important.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {

    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AlbumPhotoCell *photoCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier
                                              forIndexPath:indexPath];
    
    return photoCell;
}

@end
