//
//  GQSApi.h
//  FBSnapshotTestCase
//
//  Created by 郭桥生 on 2018/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GQSApi : NSObject


/**
 初始化

 @param gqsSecret app注册secret
 */
+ (void)initWithSecret:(NSString *)gqsSecret;


/**
 检查secret是否注册成功

 @return 有效Yes
 */
+ (BOOL)secretValid;

@end

NS_ASSUME_NONNULL_END
