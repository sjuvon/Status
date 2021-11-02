//
//  ViewController_Settings.swift
//  Status
//
//  Created by Sjuvon Chung on 11/1/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa

class ViewController_Settings: NSViewController {

    @IBAction func changeView_settingsToStatus(_ sender: NSButton) {
        if let svc = self.storyboard?.instantiateController(
            withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "StatusViewController")
            ) as? StatusViewController {
            self.view.window?.contentViewController = svc
        }
    }
    
    @IBAction func quitApp(_ sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension ViewController_Settings {
    static func freshController() -> ViewController_Settings {
        let storyboard = NSStoryboard(
            name: NSStoryboard.Name(rawValue: "Main"),
            bundle: nil
        )
        
        let identifier = NSStoryboard.SceneIdentifier(
            rawValue: "ViewController_Settings"
        )
        guard let viewcontroller = storyboard.instantiateController(
            withIdentifier: identifier
            ) as? ViewController_Settings else {
                fatalError("Whatever in C")
        }
        return viewcontroller
    }
}
