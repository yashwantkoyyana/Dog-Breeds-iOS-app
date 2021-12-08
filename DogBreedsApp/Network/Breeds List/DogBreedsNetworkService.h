//
//  DogBreedsNetworkService.h
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@class Breed;

@interface DogBreedsNetworkService : NSObject

/**
    Fetch All Breeds
    
    - Parameter completion: closure block, returns NSArray of breeds
*/
+ (void)breedsWithCompletion:(void (^)(NSArray<Breed*> *breeds))completionBlock;

+ (void)breedImage:(NSString*)breed  withCompletion:(void (^)(NSString *image))completionBlock;
+ (void)breedCollageImages:(NSString*)breed  withCompletion:(void (^)(NSArray<NSString*> *images))completionBlock;

@end

NS_ASSUME_NONNULL_END
