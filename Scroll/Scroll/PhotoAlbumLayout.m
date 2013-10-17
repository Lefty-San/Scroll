//
//  PhotoAlbumLayout.m
//  Scroll
//
//  Created by Eric Prewitt on 10/17/13.
//  Copyright (c) 2013 Eric Prewitt. All rights reserved.
//

#import "PhotoAlbumLayout.h"

static NSString * const PhotoAlbumLayoutPhotoCellKind = @"PhotoCell";

@interface PhotoAlbumLayout ()

/***** Private declarations *****/
@property (nonatomic, strong) NSDictionary *layoutInfo;

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath;
//- (CGRect)frameForAlbumTitleAtIndexPath:(NSIndexPath *)indexPath;
//- (CGRect)frameForEmblem;

- (CATransform3D)transformForAlbumPhotoAtIndex:(NSIndexPath *)indexPath;

@end

@implementation PhotoAlbumLayout

-(id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}


/******* Setup *******/
-(void)setup {
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(125.0f, 125.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

-(void) prepareLayout {
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
        newLayoutInfo[PhotoAlbumLayoutPhotoCellKind] = cellLayoutInfo;
        
        self.layoutInfo = newLayoutInfo;
    }
}

-(CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
        
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
        
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
        
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
        
    CGFloat originY = floor(self.itemInsets.top +
                            (self.itemSize.height + self.titleHeight + self.interItemSpacingY) * row);
        
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}
    
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
        
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                            NSDictionary *elementsInfo,
                                                            BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                            UICollectionViewLayoutAttributes *attributes,
                                                            BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
        
    return allAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.layoutInfo[PhotoAlbumLayoutPhotoCellKind][indexPath];

}

@end