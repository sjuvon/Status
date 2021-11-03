//
//  AppDelegate.swift
//  Status
//
//  Created by Sjuvon Chung on 10/27/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
/*  from EventMonitor import EventMonitor
    from globals import GlobalVariables
    from View_MenuBar import menuBar
*/


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        popover.contentViewController = ViewController_Status.freshController()
        app_refresher()
        vm_Timer()
        
        eventMonitor = EventMonitor( mask: [.leftMouseDown, .rightMouseDown] ) {
            [weak self] event in if let strongSelf = self,
                strongSelf.popover.isShown {
                    strongSelf.closePopover(sender: event)
                }
        }

    }
    
    
    func vm_Timer() {
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
        MenuBar()
        
        NotificationCenter.default.post(
            name: Notification.Name("App Refresh"),
            object: nil
        )
    }
    

    @objc func togglePopover(_ sender: Any?) {
        /* Toggle the popover. */
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    
    func showPopover(sender: Any?) {
        /* Show the popover. */
        if let button = MenuBar.icon.button {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.maxX
            )
        }
        eventMonitor?.start()
    }
    
    
    func closePopover(sender: Any?) {
        /* Close the popover. */
        popover.performClose(sender)
        eventMonitor?.stop()
    }

}

