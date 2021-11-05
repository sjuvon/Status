//
//  ViewController_List.swift
//  Status
//
//  Created by Sjuvon Chung on 11/3/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
// from Globals import GlobalVariables


class ViewController_List: NSViewController {
    
    @IBOutlet var view_list: NSTextField!

    @IBAction func changeView_listToStatus(_ sender: NSButton) {
        if let statusVC2 = self.storyboard?.instantiateController(
                    withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ViewController_Status")
               ) as? ViewController_Status {
            self.view.window?.contentViewController = statusVC2
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To do: Process list
    }
    
}
