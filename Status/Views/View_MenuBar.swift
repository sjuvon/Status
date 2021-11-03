//
//  View_MenuBar.swift
//  Status
//
//  Created by Sjuvon Chung on 11/3/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
import Foundation
// from globals import GlobalVariables


struct MenuBar {
    static var icon = NSStatusBar.system.statusItem( withLength: 110 )
    static var display: String = "used"
    
    public init() {
        class JimBlock: NSTextBlock {
            override init() {
                super.init()
                self.setValue(1, type: .percentageValueType, for: .width)
                //self.setContentWidth(1.0, type: .absoluteValueType)
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
        
        if let button = MenuBar.icon.button {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .left
            // paragraph.textBlocks = NSTextBlock.setValue(50, type: .percentageValueType, for: .width)
            
            let jimmy = JimBlock()
            paragraph.textBlocks = [jimmy]
            
            let titleAligned =  NSAttributedString(
                string: "RAM: \(GlobalVariables.globalRAM.display[MenuBar.display]!)%",
                attributes: [
                    NSAttributedStringKey.paragraphStyle: paragraph,
                    NSAttributedStringKey.foregroundColor: NSColor.systemGreen,
                    NSAttributedStringKey.font: NSFont.systemFont(ofSize: 14)
                ]
            )
            
            button.attributedTitle = titleAligned
            button.action = #selector(AppDelegate().togglePopover(_:))
        }
        
        
        
    }
}

