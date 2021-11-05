//
//  AppDelegate.swift
//  Status
//
//  Created by Sjuvon Chung on 10/27/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
/*  from EventMonitor import EventMonitor
    from Globals import GlobalVariables
    from View_MenuBar import MenuBarLeft, MenuBarRight
*/


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        app_refresher()
        app_timer()
        
        eventMonitor = EventMonitor( mask: [.leftMouseDown, .rightMouseDown] ) {
            [weak self] event in
            
                if let strongSelf = self, strongSelf.popover.isShown {
                    strongSelf.closePopover(sender: event)
                }
        }
        
    }
    
    
    func app_timer() {
        /*  Timer for updating state of app.  */
        let vm_statsTimer = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(app_refresher),
            userInfo: nil,
            repeats: true
        )
        vm_statsTimer.tolerance = 0.4
        RunLoop.current.add(
            vm_statsTimer,
            forMode: .commonModes
        )
    }
    
    
    @objc func app_refresher() {
        /*  To update the state of the app.  */
        GlobalVariables.globalRAM = RAM()
        MenuBarRight()
        MenuBarLeft()
        
        NotificationCenter.default.post(
            name: Notification.Name("App Refresh"),
            object: nil
        )
    }

}


extension AppDelegate {
    /*  All of the popover functionality.  */
    
    @objc func togglePopover(_ sender: Any?) {
        /* Toggle the popover for the left icon. */
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    
    @objc func showPopover(sender: Any?) {
        /* Show the popover for the left icon. */
        popover.contentViewController = ViewController_Status.freshController()
        if let button = MenuBarRight.iconRight.button {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.maxX
            )
        }
        eventMonitor?.start()
    }
    
    
    @objc func togglePopoverRight(_ sender: Any?) {
        /* Toggle popover for the right icon. */
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopoverRight(sender: sender)
        }
    }
    
    
    @objc func showPopoverRight(sender: Any?) {
        /* Show the popover for the right icon. */
        popover.contentViewController = ViewController_Settings.freshController()
        if let button = MenuBarRight.iconRight.button {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.maxX
            )
        }
        eventMonitor?.start()
    }

    
    func closePopover(sender: Any?) {
        /* Close the popover altogether. */
        popover.performClose(sender)
        eventMonitor?.stop()
    }

    
}

