CC     ?= cc
CFLAGS ?= -O2 -g

LFLAGS = $(LIB) -framework Cocoa -framework Metal -framework MetalKit -framework QuartzCore

all: MetalApp.app/Contents/MacOS/MetalApp

MetalApp.app/Contents/MacOS/MetalApp: AppDelegate.m MetalView.m main.m
	/bin/sh makeapp.sh MetalApp
	$(CC) $(CFLAGS) AppDelegate.m MetalView.m main.m $(LFLAGS) -o MetalApp.app/Contents/MacOS/MetalApp

clean:
	rm -rf app app.dSYM/ metalapp.app/
