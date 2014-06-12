//
//  Sorgu.h
//  denemeService
//
//  Created by Sham X ALL on 11.11.2013.
//  Copyright (c) 2013 shamxal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sorgu;

@protocol SorguDelegate <NSObject>

@optional

-(void)sorguSonuc:(Sorgu *) sorguObject cevab:(NSDictionary *) gelenDict;

@end

@interface Sorgu : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *receivedData;
}
@property (nonatomic, retain) id <SorguDelegate> delegate;
-(void)sorguYapFonksiyonIle:(NSString *)fonksiyon veParametre:(NSString *)parametre;

@end
