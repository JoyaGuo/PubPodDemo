//
//  GQSApi.m
//  FBSnapshotTestCase
//
//  Created by 郭桥生 on 2018/10/9.
//

#import "GQSApi.h"

@interface GQSApi ()

@property (nonatomic, strong) NSString *gqsSecret;

@end

@implementation GQSApi

+ (GQSApi *)sharedInstance {
    static GQSApi *shareGQSApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareGQSApi = [[GQSApi alloc] init];
    });
    return shareGQSApi;
}

+ (void)initWithSecret:(NSString *)gqsSecret {
    [GQSApi sharedInstance].gqsSecret = gqsSecret;
}

+ (BOOL)secretValid {
    if ([GQSApi sharedInstance].gqsSecret.length == 0) {
        return NO;
    } else {
        return YES;
    }
}

@end
