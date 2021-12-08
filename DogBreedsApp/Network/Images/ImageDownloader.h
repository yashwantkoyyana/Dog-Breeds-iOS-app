//
//  ImageDownloader.h
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloader : NSObject

+ (void)downloadImage:(NSURL*)url withCompletion: (void (^)(UIImage *image))completionBlock;

@end

NS_ASSUME_NONNULL_END
