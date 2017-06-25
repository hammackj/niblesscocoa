#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGL/gl3.h>

@interface OpenGLView : NSOpenGLView
{
    CVDisplayLinkRef displayLink;
}
@end
