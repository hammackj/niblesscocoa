#import <Cocoa/Cocoa.h>
#import <MetalKit/MTKView.h>
#import <QuartzCore/QuartzCore.h>


@interface MetalView : MTKView
{
    CVDisplayLinkRef displayLink;
}
@end
