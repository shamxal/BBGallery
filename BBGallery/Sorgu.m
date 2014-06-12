//
//  Sorgu.m
//  denemeService
//
//  Created by Sham X ALL on 11.11.2013.
//  Copyright (c) 2013 shamxal. All rights reserved.
//

#import "Sorgu.h"
#import <TouchJSON/CJSONDeserializer.h>

#define URL @"http://212.175.135.148/MobilVatandas/?yordam="

@implementation Sorgu

/*
-(NSDictionary *)yordamIle:(NSString *)strYordam
{
    if ([strYordam hasPrefix:@"tamHava"]) {
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@", URL, strYordam];
    }else if ([strYordam hasPrefix:@"kurGetir"])
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@",URL,strYordam];
    else if ([strYordam hasPrefix:@"borcS"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"borcA"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"sicilS"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"borcD"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    
    else if ([strYordam hasPrefix:@"basvuruTur"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"cinsiyetG"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"egitimDu"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"mahalleG"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"sokakG"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    
    else if ([strYordam hasPrefix:@"imar"])
        str = [NSString stringWithFormat:@"http://212.175.135.148/MobilVatandas/?yordam=%@",strYordam];
    else if ([strYordam hasPrefix:@"turkce"])
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@",URL,strYordam];
    else if ([strYordam hasPrefix:@"tamTarih"])
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@",URL,strYordam];
    else if ([strYordam hasPrefix:@"yillar"])
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@",URL,strYordam];
    else if ([strYordam hasPrefix:@"borcT"])
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@",URL,strYordam];
    else
        str = [NSString stringWithFormat:@"http://%@/MobilVatandas/?yordam=%@",URL,strYordam];
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    receivedData = [NSMutableData data];
    jsonData1 = [[NSData alloc] init];
    jsonData2 = [[NSData alloc] init];
    dict = [[NSDictionary alloc] init];
    
    conntecion = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conntecion) {
        [conntecion start];
    }
    
    jsonData1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    jsonStr = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    jsonData2 = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    error = nil;
    
  //  CJSONDeserializer *theDeserializer = [CJSONDeserializer deserializer];
    
    dict = [NSDictionary dictionary];
 //   dict = [theDeserializer deserializeAsDictionary:jsonData2 error:nil];
    
    return dict;
}
*/

-(void)sorguYapFonksiyonIle:(NSString *)fonksiyon veParametre:(NSString *)parametre{
    
    receivedData = [NSMutableData data];
    
    NSString *tamAdres = [NSString stringWithFormat:@"%@&%@",fonksiyon,parametre];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:tamAdres] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    
    NSURLConnection *conntecion = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conntecion) {
        [conntecion start];
    }
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hata" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
    UIImageView *imgError = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
    [imgError setImage:[UIImage imageNamed:@"icon_hata.png"]];
    [alert show];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    CJSONDeserializer *deserializer = [CJSONDeserializer deserializer];
    deserializer.nullObject = @"";
    NSDictionary *dict = [deserializer deserializeAsDictionary:receivedData error:&error];
    
    if ([dict objectForKey:@"hata"] != nil){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hata!" message:[dict objectForKey:@"hata"] delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        UIImageView *imgError = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
        [imgError setImage:[UIImage imageNamed:@"icon_hata.png"]];
        [alert addSubview:imgError];
    }
    else if ([dict objectForKey:@"uyari"] != nil){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uyarı!" message:[dict objectForKey:@"uyari"] delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        UIImageView *imgError = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
        [imgError setImage:[UIImage imageNamed:@""]];
        [alert addSubview:imgError];
    }
    [self.delegate sorguSonuc:self cevab:dict];
}


@end
