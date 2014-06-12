//
//  BBViewController.m
//  BBGallery
//
//  Created by Sham X ALL on 13.11.2013.
//  Copyright (c) 2013 Betik Bilisim. All rights reserved.
//

#import "BBViewController.h"
#import "BBGalleryContainer.h"

@interface BBViewController ()

@end

@implementation BBViewController


-(void)resimleriCek{
    Sorgu *sorgu = [[Sorgu alloc]init];
    sorgu.delegate = self;
    [sorgu sorguYapFonksiyonIle:@"http://api.dribbble.com/shots/everyone?per_page=50" veParametre:@""];
}

-(void)sorguSonuc:(Sorgu *)sorguObject cevab:(NSDictionary *)gelenDict{
    NSArray *resimler = [gelenDict objectForKey:@"shots"];
    BBGalleryContainer *galleryContainer = [[BBGalleryContainer alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width,self.view.frame.size.height-20)];
    [galleryContainer setURLList:resimler];
    [galleryContainer fillGallery];
    [self.view addSubview:galleryContainer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resimleriCek];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
