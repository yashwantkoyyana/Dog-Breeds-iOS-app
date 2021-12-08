//
//  DogBreedsNetworkService.m
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

#import "NetworkManager.h"
#import "DogBreedsApp-Swift.h"
#import "DogBreedsNetworkService.h"

@implementation DogBreedsNetworkService

+ (void)breedsWithCompletion:(void (^)(NSArray<Breed*> *breeds))completionBlock {
    [NetworkManager sendRequest:[BreedsRequestModel new] withCompletion:^(ResponseModel *model)
    {
        completionBlock(((BreedsResponseModel *)model).breeds);
    }];
}

+ (void)breedImage:(NSString*)breed withCompletion:(void (^)(NSString *image))completionBlock {
    BreedImageRequestModel * reqModel = [[BreedImageRequestModel alloc] initWithBreed: breed];
    [NetworkManager sendRequest:reqModel withCompletion:^(ResponseModel *model) {
        completionBlock(((BreedImageResponseModel *)model).message);
    }];
}

+ (void)breedCollageImages:(NSString*)breed  withCompletion:(void (^)(NSArray<NSString*> *images))completionBlock {
    BreedCollageImagesRequestModel * reqModel = [[BreedCollageImagesRequestModel alloc] initWithBreed: breed];
    [NetworkManager sendRequest:reqModel withCompletion:^(ResponseModel *model) {
        completionBlock(((BreedCollageImagesResponseModel *)model).message);
    }];
}

@end
