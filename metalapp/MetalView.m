#import "MetalView.h"

#include <stdio.h>

@implementation MetalView

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
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    CVDisplayLinkSetOutputCallback(displayLink, &displayLinkCallback, self);
    CVDisplayLinkStart(displayLink);
}

- (CVReturn) render
{
    return kCVReturnSuccess;
}

- (void)dealloc
{
    CVDisplayLinkRelease(displayLink);

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

    [(MetalView*)displayLinkContext render];
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
