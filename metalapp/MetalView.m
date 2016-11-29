#import "MetalView.h"

@implementation MetalView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if ((self = [super initWithCoder:coder]))
    {
        // Initialization code here.
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frameRect
                       device:(id<MTLDevice>)device
{
    if ((self = [super initWithFrame:frameRect device:device]))
    {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    CVDisplayLinkSetOutputCallback(displayLink, &displayLinkCallback, (__bridge void*)self);
    CVDisplayLinkSetCurrentCGDisplay(displayLink, 0); // TODO Pass correct display id.
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
    CVReturn result = [(__bridge MetalView*)displayLinkContext getFrameForTime:outputTime];
    return result;
}

- (void) drawView
{
    // TODO Implement this function.
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
