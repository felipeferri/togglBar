//
//  StatusMenuController.swift
//  TogglBar
//
//  Created by Felipe Augusto Sviaghin Ferri on 1/4/17.
//  Copyright © 2017 Felipe Augusto Sviaghin Ferri. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    let bm = BusinessModel.sharedInstance
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    lazy var statusItem: NSStatusItem = { [unowned self] in
        let item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        item.title = "Wait for it..."
        item.menu = self.statusMenu
        return item
        }()
    
    override func awakeFromNib() {
        let _ = statusItem // Force instantiation of statusItem
        BusinessModel.sharedInstance.delegate = self
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
}

extension StatusMenuController: BusinessModelDelegate {
    func didUpdateTotalGrand(totalMilliseconds: Int) {
        let nf = NumberFormatter()
        nf.currencySymbol = bm.currency
        nf.numberStyle = .currency
        if let hourlyRate = bm.hourlyRate {
            nf.maximumFractionDigits = 0
            let earned = nf.string(from: NSNumber(value: hourlyRate*Double(totalMilliseconds)/(3600*1000.0)))
            statusItem.title = earned
        } else {
            statusItem.title = "\(totalMilliseconds/(3600*1000)) hours"
        }
        
    }
}
