//
//  BBGalleryContainer.m
//  BBGallery
//
//  Created by Sham X ALL on 13.11.2013.
//  Copyright (c) 2013 Betik Bilisim. All rights reserved.
//

#import "BBGalleryContainer.h"
#import <SDWebImage/UIButton+WebCache.h>



@implementation BBGalleryContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)fillGallery{
    for (int i = 0; i<_URLList.count; i++) {
        UIButton *thumb = [UIButton buttonWithType:UIButtonTypeCustom];
        [thumb addTarget:self action:@selector(thumbSelected:) forControlEvents:UIControlEventTouchUpInside];
        thumb.tag = i;
        [thumb setFrame:CGRectMake((i%4)*(270/4+10)+10, (i/4)*(270/4+5)+5, 270/4, 270/4)];
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect frame = activity.frame;
        frame.origin.x = thumb.frame.size.width/2-frame.size.width/2;
        frame.origin.y = thumb.frame.size.height/2-frame.size.height/2;
        activity.frame = frame;
        [thumb addSubview:activity];
        [activity setHidesWhenStopped:YES];
        activity.hidden = NO;
        [activity startAnimating];
        [thumb setImageWithURL:[NSURL URLWithString:[[_URLList objectAtIndex:i] objectForKey:@"image_url"]] forState:UIControlStateNormal placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
            [activity stopAnimating];
        }];
        [self addSubview:thumb];
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width, (_URLList.count/4)*(270/4+10)+20);
    
}

-(void)thumbSelected:(UIButton *)sender{
    NSLog(@"selected");
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<_URLList.count; i++) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[_URLList objectAtIndex:i] objectForKey:@"image_url"]]]];
    }
    self.photos = photos;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.wantsFullScreenLayout = YES;
    browser.zoomPhotosToFill = YES;
    [browser setCurrentPhotoIndex:sender.tag];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.window.rootViewController presentModalViewController:nc animated:YES];
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _URLList.count;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %i", index);
}

@end
