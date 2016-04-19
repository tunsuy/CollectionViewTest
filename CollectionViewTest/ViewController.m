//
//  ViewController.m
//  CollectionViewTest
//
//  Created by tunsuy on 16/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"
#import "CircleLayout.h"
#import "DecorationReusableView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *const cellID = @"cell";
static NSString *const supplementaryID = @"supplementary";

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    使用系统自带的layout布局
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.minimumInteritemSpacing = 20.0f;
//    layout.minimumLineSpacing = 20.0f;
//    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
//    layout.itemSize = CGSizeMake(100.0f, 100.0f);
    
//    使用自定义的layout布局
    CircleLayout *layout = [[CircleLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [collectionView registerClass:[DecorationReusableView class] forSupplementaryViewOfKind:@"firstSupplementary" withReuseIdentifier:supplementaryID];
    
    [self.view addSubview:collectionView];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%2 == 0) {
        return CGSizeMake(50.0f, 50.0f);
    }
    return CGSizeMake(100.0f, 100.0f);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1.0];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:@"firstSupplementary"]) {
        DecorationReusableView *firstSupplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:supplementaryID forIndexPath:indexPath];
        return firstSupplementaryView;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    NSLog(@"select action name: %@", NSStringFromSelector(action));
    NSString *actionName = NSStringFromSelector(action);
    if ([actionName isEqualToString:@"cut:"]) {
        NSLog(@"想要剪切吗？");
    }
    else if ([actionName isEqualToString:@"copy:"]) {
        NSLog(@"想要复制吗？");
    }
    else if ([actionName isEqualToString:@"paste:"]){
        NSLog(@"想要粘贴吗？");
    }
    
}

//以上三个方法需要同时实现才能显示长按菜单功能

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
