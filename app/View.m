#import "View.h"

@implementation View

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
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
