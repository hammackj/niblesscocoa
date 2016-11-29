#import <Cocoa/Cocoa.h>
#import <MetalKit/MetalKit.h>

@interface MetalView : MTKView
{
	CVDisplayLinkRef displayLink;
}
@end
