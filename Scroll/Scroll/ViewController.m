//
//  ViewController.m
//  Scroll
//
//  Created by Eric Prewitt on 10/16/13.
//  Copyright (c) 2013 Eric Prewitt. All rights reserved.
//

/**
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
 *  /Users/ericprewitt/git/Touches
 *  touch animation referenced
 *
 */


#import "ViewController.h"
#import "PhotoAlbumLayout.h"
#import "AlbumPhotoCell.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";

@interface ViewController ()

@property (nonatomic, weak) IBOutlet PhotoAlbumLayout *photoalbumlayout;
@property (weak, nonatomic) IBOutlet UICollectionViewCell *bodyCollectionCell;

@end

@implementation ViewController

#define GROW_ANIMATION_DURATION_SECONDS 0.15    // Determines how fast a piece size grows when it is moved.
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15  // Determines how fast a piece size shrinks when a piece stops moving.

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

- (void)setupRecognizers {

    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    panRecognizer.minimumNumberOfTouches = 1;
    panRecognizer.delegate = self; // Very important
    [panRecognizer addTarget:self.collectionView action:@selector(panGestureRecognizer)];
    [self.collectionView addGestureRecognizer:panRecognizer];
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {

    return YES; // Also, very important.
}

/**
 Scales up a view slightly which makes the piece slightly larger, as if it is being picked up by the user.
 */
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UICollectionViewCell *)theView {
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
}

/**
 Checks to see which view, or views, the point is in and then sets the center of each moved view to the new postion.
 If views are directly on top of each other, they move together.
 */

-(void)dispatchTouchEvent:(UICollectionViewCell *)theView toPosition:(CGPoint)position
{
	// Check to see which view, or views,  the point is in and then move to that position.
	if (CGRectContainsPoint([self.bodyCollectionCell frame], position)) {
		self.bodyCollectionCell.center = position;
	}
}
/*
	if (CGRectContainsPoint([self.secondPieceView frame], position)) {
		self.secondPieceView.center = position;
	}
	if (CGRectContainsPoint([self.thirdPieceView frame], position)) {
		self.thirdPieceView.center = position;
	}
}
*/

/**
 Scales down the view and moves it to the new position.
 */
-(void)animateView:(UICollectionViewCell *)theView toPosition:(CGPoint)thePosition {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
	// Set the center to the final postion.
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}


@end
