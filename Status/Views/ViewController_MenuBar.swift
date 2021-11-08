//
//  View_MenuBar.swift
//  Status
//
//  Created by Sjuvon Chung on 11/3/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
import Foundation
// from AppDelegate import AppDelegate
// from Globals import GlobalVariables


struct MenuBarLeft {
    /*  Gross... */
    static let iconLeft = NSStatusBar.system.statusItem( withLength: NSStatusItem.variableLength )
    
    public init() {
        if let butty = MenuBarLeft.iconLeft.button {
            butty.title = "RAM:"
            butty.action = #selector(AppDelegate().showPopoverLeft(sender: ))
        }
    }
    
}


struct MenuBarRight {
    /*  ...But this works :\  */
    static var iconRight = NSStatusBar.system.statusItem( withLength: 73 )
    static var display: String = "used"
    
    public init() {
        if let button = MenuBarRight.iconRight.button {
            let titleAttributed = NSAttributedString(
                string: "\(GlobalVariables.globalRAM.display[MenuBarRight.display]!) GB",
                attributes: [
                    NSAttributedStringKey.foregroundColor: NSColor.systemGreen,
                    NSAttributedStringKey.font: NSFont.systemFont(ofSize: 14)
                ]
            )
            
            button.attributedTitle = titleAttributed
            button.action = #selector(AppDelegate().showPopoverRight(sender: ))
        }
    }
    
}

