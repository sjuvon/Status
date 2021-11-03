//
//  ViewController_Status
//  Status
//
//  Created by Sjuvon Chung on 10/27/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa


class ViewController_Status: NSViewController {
    
    @IBOutlet var view_total: NSTextField!
    @IBOutlet var view_used: NSTextField!
    @IBOutlet var view_free: NSTextField!
    @IBOutlet var view_app: NSTextField!
    @IBOutlet var view_wired: NSTextField!
    @IBOutlet var view_compressor: NSTextField!
    @IBOutlet var view_percentFI: NSTextField!
    @IBOutlet var view_percentWA: NSTextField!
    
    
    @IBAction func changeView_statusToList(_ sender: NSButton) {
        // NSApplication.shared.terminate(sender)
        // omg thank you, Mark, from https://stackoverflow.com/questions/28139294/how-does-one-display-a-new-view-controller-in-the-same-mac-window !
        if let settingVC = self.storyboard?.instantiateController(
            withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ViewController_List")
            ) as? ViewController_List {
            self.view.window?.contentViewController = settingVC
        }
    }
    
    @IBAction func changeView_statusToSettings(_ sender: NSButton) {
        // NSApplication.shared.terminate(sender)
        // omg thank you, Mark, from https://stackoverflow.com/questions/28139294/how-does-one-display-a-new-view-controller-in-the-same-mac-window !
        if let settingVC = self.storyboard?.instantiateController(
            withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ViewController_Settings")
        ) as? ViewController_Settings {
            self.view.window?.contentViewController = settingVC
        }
    }
    
    var RAM = globalVariables.globalRAM
    
    
    override func viewDidLoad() {
        /*  View setup  */
        super.viewDidLoad()
        
        status_initial()
    }
    
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(status_updated),
            name: Notification.Name("NewFunctionName"),
            object: nil
        )
    }
    
    
    func status_initial() -> Void {
        view_total.stringValue = "\(RAM.total)"
        view_free.stringValue = "\(RAM.free)"
        view_used.stringValue = "\(RAM.used)"
        view_app.stringValue = "\(RAM.app)"
        view_wired.stringValue = "\(RAM.wired)"
        view_compressor.stringValue = "\(RAM.compressor)"
        
        view_percentFI.stringValue = "\(RAM.display["FI"]!)%"
        view_percentWA.stringValue = "\(RAM.display["WA"]!)%"
        /*
        view_percentFI.stringValue = "\(RAM.percentFI)%"
        view_percentWA.stringValue = "\(RAM.percentWA)%"
        */
        
        view_total.textColor = NSColor.systemGreen
        view_free.textColor = NSColor.systemGreen
        view_used.textColor = NSColor.systemGreen
        view_app.textColor = NSColor.systemGreen
        view_wired.textColor = NSColor.systemGreen
        view_compressor.textColor = NSColor.systemGreen
        view_percentFI.textColor = NSColor.systemGreen
        view_percentWA.textColor = NSColor.systemGreen
    }
    
    
    @objc func status_updated(_ notification: NSNotification) -> Void {
        view_total.stringValue = "\(RAM.total)"
        view_free.stringValue = "\(RAM.free)"
        view_used.stringValue = "\(RAM.used)"
        view_app.stringValue = "\(RAM.app)"
        view_wired.stringValue = "\(RAM.wired)"
        view_compressor.stringValue = "\(RAM.compressor)"
        
        view_percentFI.stringValue = "\(RAM.display["FI"]!)%"
        view_percentWA.stringValue = "\(RAM.display["WA"]!)%"
        
        /*
        view_percentFI.stringValue = "\(RAM.percentFI)%"
        view_percentWA.stringValue = "\(RAM.percentWA)%"
        */
        
        view_total.textColor = NSColor.systemGreen
        view_free.textColor = NSColor.systemGreen
        view_used.textColor = NSColor.systemGreen
        view_app.textColor = NSColor.systemGreen
        view_wired.textColor = NSColor.systemGreen
        view_compressor.textColor = NSColor.systemGreen
        view_percentFI.textColor = NSColor.systemGreen
        view_percentWA.textColor = NSColor.systemGreen
    }
}


extension ViewController_Status {
    /*  Storyboard instantiation.  */
    static func freshController() -> ViewController_Status {
        let storyboard = NSStoryboard(
            name: NSStoryboard.Name(rawValue: "Main"),
            bundle: nil
        )
        
        let identifier = NSStoryboard.SceneIdentifier(
            rawValue: "ViewController_Status"
        )
        
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier)
            as? ViewController_Status else {
                fatalError("Whatever")
        }
        
        return viewcontroller
    }
}



