#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

@interface DlibWrapper : NSObject

- (instancetype)init;
- (double *)doWorkOnSampleBuffer:(CMSampleBufferRef)sampleBuffer inRects:(NSArray<NSValue *> *)rects;
- (double *)doWorkOnSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (UIImage *)getLeftImage;
- (UIImage *)getRightImage;
- (void) removeMemory;
- (void)prepare;
@end

