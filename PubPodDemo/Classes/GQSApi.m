//
//  GQSApi.m
//  FBSnapshotTestCase
//
//  Created by 郭桥生 on 2018/10/9.
//

#import "GQSApi.h"
#import <WXApi.h>
#import <WXApiObject.h>

@interface GQSApi () <WXApiDelegate>

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
    [WXApi registerApp:gqsSecret enableMTA:NO];
}

+ (BOOL)secretValid {
    if ([GQSApi sharedInstance].gqsSecret.length == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (void)shareToWX:(NSDictionary *)infoDictionary {
    [WXApi registerApp:[GQSApi sharedInstance].gqsSecret enableMTA:false];
    NSInteger shareType = [infoDictionary[@"0"] integerValue];
    NSString *title = infoDictionary[@"1"]?:@"";
    NSString *text = infoDictionary[@"2"]?:@"";
    NSString *imageUrl = infoDictionary[@"3"];
    UIImage *image;
    if ([imageUrl hasPrefix:@"http"]) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        image = [UIImage imageWithData:imageData];
    }else{
        image = [UIImage imageNamed:imageUrl];
    }
    NSString *urlStr = infoDictionary[@"4"];
    NSInteger shareFlag = [infoDictionary[@"5"] integerValue];
    NSString *wxMiniAppPath = infoDictionary[@"6"] ?: @"";
    NSString *wx_miniappid = infoDictionary[@"7"] ?: @"";
    NSInteger wx_miniapptype = [infoDictionary[@"8"] ?: @"" integerValue];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    if (shareType == 1) {
        req.bText = YES;
        req.text = text;
    }else if(shareType == 2){
        WXMediaMessage *message = [WXMediaMessage message];
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = UIImagePNGRepresentation(image);
        message.mediaObject = imageObject;
        
        req.bText = NO;
        req.message = message;
    }else if (shareType == 3){
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = text;
        [message setThumbImage:image];
        
        WXWebpageObject *webObject = [WXWebpageObject object];
        webObject.webpageUrl = urlStr;
        message.mediaObject = webObject;
        
        req.bText = NO;
        req.message = message;
    } else if (shareType == 4) {
        WXMiniProgramObject *wxMiniProgramObj = [WXMiniProgramObject object];
        wxMiniProgramObj.userName = wx_miniappid;
        wxMiniProgramObj.path = wxMiniAppPath;
        wxMiniProgramObj.webpageUrl = urlStr;
        wxMiniProgramObj.miniProgramType = wx_miniapptype;
        wxMiniProgramObj.hdImageData = UIImagePNGRepresentation(image);
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = text;
        message.mediaObject = wxMiniProgramObj;
        req.bText = NO;
        req.message = message;
    }
    
    if (shareFlag == 1) {
        req.scene = WXSceneSession;
    }else if (shareFlag == 2){
        req.scene = WXSceneTimeline;
    }else if (shareFlag == 3){
        req.scene = WXSceneFavorite;
    }
    
    [WXApi sendReq:req];
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        switch (resp.errCode) {
            case 0:
                NSLog(@"分享成功");
                break;
            case -2:
                NSLog(@"分享取消");
                break;
            default:
                NSLog(@"分享失败");
                break;
        }
    }
}

@end
