//
//  BBGalleryContainer.h
//  BBGallery
//
//  Created by Sham X ALL on 13.11.2013.
//  Copyright (c) 2013 Betik Bilisim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface BBGalleryContainer : UIScrollView <MWPhotoBrowserDelegate>

@property (strong, nonatomic) NSArray *URLList;
@property (nonatomic, strong) NSMutableArray *photos;

-(void)fillGallery;

@end
