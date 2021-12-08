//
//  ImageDownloader.m
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+ (void)downloadImage:(NSURL*)url withCompletion: (void (^)(UIImage *image))completionBlock {
    NSLog(@"API Request: %@", url);
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL: url];
    [[[NSURLSession sharedSession]
      dataTaskWithRequest: urlRequest
      completionHandler:^(NSData * _Nullable data,
                          NSURLResponse * _Nullable response,
                          NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"Request failed with error %@", error.localizedDescription);
        }
        
        if (!data)
        {
            NSLog(@"Request failed with error.", nil);
            return completionBlock(nil);
        }
        UIImage *image = [[UIImage alloc] initWithData: data];
        if (!image) {
            NSLog(@"Failed to generate image from data", nil);
            return completionBlock(nil);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(image);
        });
    }] resume];
}

@end
