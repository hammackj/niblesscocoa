#import "OpenGLView.h"

#include <stdio.h>

@implementation OpenGLView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
    NSOpenGLPixelFormatAttribute attrs[] = {
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFADepthSize, 24,
        NSOpenGLPFAOpenGLProfile,
        NSOpenGLProfileVersion3_2Core,
        NSOpenGLPFASupersample,
        NSOpenGLPFASampleBuffers, 1,
        NSOpenGLPFASamples, 32,
        0
    };

    NSOpenGLPixelFormat *pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];

    if (!pf) {
        NSLog(@"No OpenGL pixel format");
        [NSApp terminate:self];
    }

    NSOpenGLContext* context = [[NSOpenGLContext alloc] initWithFormat:pf shareContext:nil];

    [self setPixelFormat:pf];
    [self setOpenGLContext:context];

    [pf release];
    [context release];

    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    CVDisplayLinkSetOutputCallback(displayLink, &displayLinkCallback, self);
    CVDisplayLinkStart(displayLink);
}

- (void)prepareOpenGL
{
    GLint vsync = 1;
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];

    [[self openGLContext] setValues:&vsync forParameter:NSOpenGLCPSwapInterval];
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);

    //initialize_opengl(cglContext);
}

- (CGLContextObj)willStartDrawing
{
    CGLContextObj cgl_ctx = [[self openGLContext] CGLContextObj];
    CGLSetCurrentContext(cgl_ctx);
    CGLLockContext(cgl_ctx);
    return cgl_ctx;
}

- (void)didFinishDrawing: (CGLContextObj) cgl_ctx;
{
    CGLUnlockContext(cgl_ctx);
}

- (CVReturn) render
{
    CGLContextObj cgl_ctx = [self willStartDrawing];
    //render(cgl_ctx);
    glClearColor(0.0f, 1.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    printf("%s\n", glGetString(GL_VERSION));

    CGLFlushDrawable(cgl_ctx);

    [self didFinishDrawing:cgl_ctx];

    return kCVReturnSuccess;
}

- (void)reshape
{
    CGLContextObj cgl_ctx = [self willStartDrawing];
    [super reshape];
    //reshape(cgl_ctx, [self bounds].size.width, [self bounds].size.height);
    [self didFinishDrawing:cgl_ctx];
}

- (void)update
{
    CGLContextObj cgl_ctx = [self willStartDrawing];
    [super update];
    [self didFinishDrawing:cgl_ctx];
}

- (void)dealloc
{
    CVDisplayLinkRelease(displayLink);
    //uninitialize_opengl([[self openGLContext] CGLContextObj]);
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

    [self render];
}

static CVReturn displayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
{
    float time = ((float)outputTime->videoTime)/((float)outputTime->videoTimeScale);
    //setElapsedTime(time);

    [(OpenGLView*)displayLinkContext render];
    return kCVReturnSuccess;
}

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (void)mouseDown:(NSEvent *)anEvent
{
	puts("mousedown!");
}

- (void)mouseDragged:(NSEvent *)anEvent
{
	puts("mousemoved!");
}

- (void)keyDown:(NSEvent *)anEvent
{
	puts("keydown!");
}

@end
