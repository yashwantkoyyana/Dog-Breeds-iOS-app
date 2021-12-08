#import "NetworkManager.h"
#import "DogBreedsApp-Swift.h"

@implementation NetworkManager


+ (void)sendRequest:(RequestModel *)request withCompletion:(void(^)(ResponseModel *model))completionBlock
{
    NSLog(@"API Request: %@", request.path);
    [[[NSURLSession sharedSession]
      dataTaskWithRequest:[request urlRequest]
      completionHandler:^(NSData * _Nullable data,
                          NSURLResponse * _Nullable response,
                          NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"Request failed with error %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIWindow* window = [[[UIApplication sharedApplication] windows] firstObject];
                [[window rootViewController] showErrorAlertWith: error.localizedDescription];
            });
        }
        
        if (!data)
        {
            NSLog(@"Request failed with error.", nil);
            return completionBlock(nil);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock([request parseData:data]);
        });
    }] resume];
}

@end
