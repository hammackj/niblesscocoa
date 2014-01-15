#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#include <OpenGL/gl3.h>
#import <QuartzCore/QuartzCore.h>

@interface OpenGLView : NSOpenGLView
{
	CVDisplayLinkRef displayLink;
}
@end
