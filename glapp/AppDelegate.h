#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGL/gl3.h>

#import "OpenGLView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
    OpenGLView *view;
}

- (void)populateMainMenu;
- (void)populateApplicationMenu:(NSMenu *)aMenu;

@end
