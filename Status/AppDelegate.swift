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
        popover.contentViewController = ViewController_Status.freshController()
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
        RAM.update()
        menuBarIconSetter()
        
        NotificationCenter.default.post(
            name: Notification.Name("NewFunctionName"),
            object: nil
        )
    }
    
    class jimBlock: NSTextBlock {
        override init() {
            super.init()
            self.setValue(1, type: .percentageValueType, for: .width)
            //self.setContentWidth(1.0, type: .absoluteValueType)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    @objc func menuBarIconSetter() {
        /*  To set the app's menu bar icon.  */
        if let button = menuBarItem.button {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .left
            // paragraph.textBlocks = NSTextBlock.setValue(50, type: .percentageValueType, for: .width)
            
            let jimmy = jimBlock()
            paragraph.textBlocks = [jimmy]
            
            
            let titleAligned =  NSAttributedString(
                string: "RAM: \(RAM.display["compressed"]!)%",
                attributes: [
                    NSAttributedStringKey.paragraphStyle: paragraph,
                    NSAttributedStringKey.foregroundColor: NSColor.systemGreen,
                    NSAttributedStringKey.font: NSFont.systemFont(ofSize: 14)
                ]
            )
            
            button.attributedTitle = titleAligned
            button.action = #selector(togglePopover(_:))
            // button.imagePosition = NSControl.ImagePosition.imageRight
            // button.font = NSFont(name: "typeFace", size: 14)
            /*
            button.frame = CGRect(
                x: -10.0,
                y: 0.5,
                width: button.frame.width,
                height: button.frame.height
            )
            */
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
                preferredEdge: NSRectEdge.maxX
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

