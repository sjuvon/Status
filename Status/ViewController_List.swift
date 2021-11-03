//
//  ViewController_List.swift
//  Status
//
//  Created by Sjuvon Chung on 11/3/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa

class ViewController_List: NSViewController {
    
    @IBOutlet var view_list: NSTextField!
    
    @IBAction func changeView_listToStatus(_ sender: NSButton) {
        // NSApplication.shared.terminate(sender)
        // omg thank you, Mark, from https://stackoverflow.com/questions/28139294/how-does-one-display-a-new-view-controller-in-the-same-mac-window !
        if let statusVC2 = self.storyboard?.instantiateController(
            withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ViewController_Status")
            ) as? ViewController_Status {
            self.view.window?.contentViewController = statusVC2
        }
    }

    var RAM = globalVariables.globalRAM

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view_list.stringValue = RAM.listy
        print(RAM.listy.virtual_size)
    }
    
}
