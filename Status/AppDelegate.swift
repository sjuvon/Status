//
//  AppDelegate.swift
//  Status
//
//  Created by Sjuvon Chung on 10/27/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var RAM = globalVariables.globalRAM
    let menuBarItem = NSStatusBar.system.statusItem( withLength: 110 )
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /*  Initialise app.
        
        Out of the box, the app will initialise with a window and dock icon.  To remove:
        1)  Add the following to Info.plist:
                <key>LSUIElement</key>
                <string>true</string>
            This takes care of the dock icon.
        2)  If using Storyboards, delete Window Controller to remove the initialising window.
            Question: How do we do this without Storyboards?  Figure this out.
            E.g., An ad-hoc solution:
                $ NSApplication.shared.windows.last!.close()
        */
        menuBarIconSetter()
        popover.contentViewController = StatusViewController.freshController()
        vm_Timer()
        
        eventMonitor = EventMonitor( mask: [.leftMouseDown, .rightMouseDown] ) {
            [weak self] event in if let strongSelf = self,
                strongSelf.popover.isShown {
                    strongSelf.closePopover(sender: event)
                }
        }

    }
    
    
    func vm_Timer() {
        /*  Main function: Timer for updating state of app.  */
        let vm_statsTimer = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(refresher),
            userInfo: nil,
            repeats: true
        )
        vm_statsTimer.tolerance = 0.4
        RunLoop.current.add(
            vm_statsTimer,
            forMode: .commonModes
        )
    }
    
    
    @objc func refresher() {
        /*  To update the state of the app.  */
        RAM.update()
        menuBarIconSetter()
        
        NotificationCenter.default.post(
            name: Notification.Name("NewFunctionName"),
            object: nil
        )
    }
    
    @objc func menuBarIconSetter() {
        /*  To set the app's menu bar icon.  */
        if let button = menuBarItem.button {
            button.title = "RAM: \(RAM.percentCompressed)%"
            button.action = #selector(togglePopover(_:))
        }
    }
    

    @objc func togglePopover(_ sender: Any?) {
        /* Toggle the popover */
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    
    func showPopover(sender: Any?) {
        /* Show the popover */
        if let button = menuBarItem.button {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.minY
            )
        }
        eventMonitor?.start()
    }
    
    
    func closePopover(sender: Any?) {
        /* Close the popover */
        popover.performClose(sender)
        eventMonitor?.stop()
    }

}

