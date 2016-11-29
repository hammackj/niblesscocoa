#import "OpenGLView.h"

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
    CVDisplayLinkSetOutputCallback(displayLink, &displayLinkCallback, (__bridge void*)self);
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
    CVDisplayLinkStart(displayLink);

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:[self window]];
}

- (void) windowWillClose:(NSNotification*)notification
{    
    CVDisplayLinkStop(displayLink);
}

- (CVReturn) getFrameForTime:(const CVTimeStamp*)outputTime
{
    // There is no autorelease pool when this method is called
    // because it will be called from a background thread.
    // It's important to create one or app can leak objects.
    @autoreleasepool {
        [self drawView];
    }
    return kCVReturnSuccess;
}

static CVReturn displayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
{
    CVReturn result = [(__bridge OpenGLView*)displayLinkContext getFrameForTime:outputTime];
    return result;
}

- (void)prepareOpenGL
{
    [super prepareOpenGL];

    [[self openGLContext] makeCurrentContext];
    GLint swapInt = 1;
    [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];

    // init rendererer here.
}

- (void) drawView
{
    [[self openGLContext] makeCurrentContext];

    CGLLockContext([[self openGLContext] CGLContextObj]);

    glClearColor(0.0f, 1.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    CGLFlushDrawable([[self openGLContext] CGLContextObj]);
    CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

- (void)reshape
{
    [super reshape];

    CGLLockContext([[self openGLContext] CGLContextObj]);

    // resize renderer here.

    CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

- (void)dealloc
{
    CVDisplayLinkStop(displayLink);

    CVDisplayLinkRelease(displayLink);

    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self drawView];
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
