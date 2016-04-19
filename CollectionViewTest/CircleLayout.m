//
//  CircleLayout.m
//  CollectionViewTest
//
//  Created by tunsuy on 16/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "CircleLayout.h"
#import "DecorationReusableView.h"

#define kCellItemWidth 20

@interface CircleLayout(){
    CGSize cvSize;
    CGPoint cvCenter;
    CGFloat radius;
    NSInteger cellCount;
}

@end

@implementation CircleLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    [self registerClass:[DecorationReusableView class] forDecorationViewOfKind:@"decoration"];
    
    cvSize = self.collectionView.frame.size;
    cvCenter = CGPointMake(cvSize.width/2.0, cvSize.height/2.0);
    radius = MIN(cvSize.width, cvSize.height)/2;
    cellCount = [self.collectionView numberOfItemsInSection:0];
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributesArr = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributesArr addObject:attributes];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:@"firstSupplementary" atIndexPath:indexPath];
    [layoutAttributesArr addObject:attributes];

    attributes = [self layoutAttributesForDecorationViewOfKind:@"decoration" atIndexPath:indexPath];
    [layoutAttributesArr addObject:attributes];
    return layoutAttributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(kCellItemWidth, kCellItemWidth);
    attributes.center = CGPointMake(cvCenter.x+radius*cosf(2*M_PI*indexPath.item/cellCount), cvCenter.y+radius*sinf(2*M_PI*indexPath.item/cellCount));
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:@"firstSupplementary"]) {
        attributes.size = CGSizeMake(self.collectionView.bounds.size.width/2, kCellItemWidth);
        attributes.center = CGPointMake(cvSize.width/2,100);
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:@"decoration"]) {
        attributes.size = CGSizeMake(self.collectionView.bounds.size.width/2, kCellItemWidth);
        attributes.center = CGPointMake(cvCenter.x+radius*cosf(2*M_PI*indexPath.item/cellCount), cvCenter.y+radius*sinf(2*M_PI*indexPath.item/cellCount));
    }
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldRect = self.collectionView.frame;
    if (CGRectGetWidth(oldRect) != CGRectGetWidth(newBounds)) {
        return YES;
    }
    return NO;
}

@end
