#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RequestModel;

@class RequestModel;
@class ResponseModel;

@interface NetworkManager: NSObject

+ (void)sendRequest:(RequestModel *)request withCompletion:(void(^)(ResponseModel *model))completionBlock;

@end

NS_ASSUME_NONNULL_END
