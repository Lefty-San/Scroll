//
//  ViewController.m
//  Scroll
//
//  Created by Eric Prewitt on 10/16/13.
//  Copyright (c) 2013 Eric Prewitt. All rights reserved.
//

#import "ViewController.h"
#import "PhotoAlbumLayout.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet PhotoAlbumLayout *photoalbumlayout;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
