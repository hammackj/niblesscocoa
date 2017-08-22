#import "AppDelegate.h"

@implementation AppDelegate

- (id)init
{
	if ( self = [super init] )
	{
		// create a reference rect
		NSRect contentSize = NSMakeRect(0.0f, 0.0f, 800.0f, 600.0f);

		// allocate window
		window = [[NSWindow alloc] initWithContentRect:contentSize styleMask:NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:YES];

		// allocate view
		view = [[MetalView alloc] initWithFrame:contentSize device:MTLCreateSystemDefaultDevice()];
		[view awakeFromNib];
	}
	return self;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	// attach the view to the window
	[window setContentView:view];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	// Build Menu
	[self populateMainMenu];

	// make the window visible.
	[window makeKeyAndOrderFront:self];
}

- (void)dealloc
{
	[view release];
	[window release];

	[super dealloc];
}

- (void) populateMainMenu
{
	NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];
	NSMenuItem *menuItem;
	NSMenu *submenu;

	menuItem = [mainMenu addItemWithTitle:@"Apple" action:NULL keyEquivalent:@""];
	submenu = [[NSMenu alloc] initWithTitle:@"Apple"];
	[NSApp performSelector:NSSelectorFromString(@"setAppleMenu:") withObject:submenu];
	[self populateApplicationMenu:submenu];
	[mainMenu setSubmenu:submenu forItem:menuItem];

	[NSApp setMainMenu:mainMenu];
}

- (void)populateApplicationMenu:(NSMenu *)aMenu
{
	NSString *applicationName = [[NSProcessInfo processInfo] processName];
	NSMenuItem *menuItem;

	menuItem = [aMenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"About", nil), applicationName] action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
	[menuItem setTarget:NSApp];

	[aMenu addItem:[NSMenuItem separatorItem]];

	menuItem = [aMenu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Quit", nil), applicationName] action:@selector(terminate:) keyEquivalent:@"q"];
	[menuItem setTarget:NSApp];
}
@end
