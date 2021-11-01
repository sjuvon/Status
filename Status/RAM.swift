//
//  RAM.swift
//  Status
//
//  Created by Sjuvon Chung on 10/28/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
import Foundation


func rounder(x: Double) -> Double {
    /*  Function for rounding to three decimal places.  */
    return round(x*1000)/1000
}


public class RAM {
    /*  Default attributes.
     
        N.B.:
        (1) total = free + speculative + active + inactive + wired + compressor (used by)
        (2) used = pageable (AKA internal count) - purgeable + wired + compressor
        (3) 'app memory' = pageable - purgeable
        (4) 'cached' = external + purgeable
        (5) Estimates for Memory Pressure:
            Yellow <~~~> Compressed 2.5 - 4.5 GB
            Red    <~~~> Compressed 4.5+
    */
    let factor: Double = Double( Double(4096) / Double(1024*1024*1024) )
    
    var free: Double
    var speculative: Double
    var active: Double
    var inactive: Double
    var wired: Double
    var compressor: Double
    var pageable: Double
    var purgeable: Double
    var app: Double
    var total: Double
    var used: Double
    var percentUsed: Double
    var percentFree: Double
    var percentCompressed: Double
    var percentFI: Double
    var percentWA: Double
    
    
    public init() {
        let vm = vm_stat()!
        
        let temp_free: Double = Double(vm.free_count)*self.factor
        let temp_speculative: Double = Double(vm.speculative_count)*self.factor
        let temp_active: Double = Double(vm.active_count)*self.factor
        let temp_inactive: Double = Double(vm.inactive_count)*self.factor
        let temp_wired: Double = Double(vm.wire_count)*self.factor
        let temp_compressor: Double = Double(vm.compressor_page_count)*self.factor
        let temp_pageable: Double =  Double(vm.internal_page_count)*self.factor
        let temp_purgeable: Double = Double(vm.purgeable_count)*self.factor
        let temp_app: Double = temp_pageable - temp_purgeable
        let temp_total: Double = temp_free + temp_speculative + temp_active + temp_inactive + temp_wired + temp_compressor
        let temp_used: Double = temp_app + temp_wired + temp_compressor
        
        self.free = rounder(x: temp_free)
        self.speculative = rounder(x: temp_speculative)
        self.active = rounder(x: temp_active)
        self.inactive = rounder(x: temp_inactive)
        self.wired = rounder(x: temp_wired)
        self.compressor = rounder(x: temp_compressor)
        self.pageable = rounder(x: temp_pageable)
        self.purgeable = rounder(x: temp_purgeable)
        self.app = rounder(x: temp_app)
        self.total = rounder(x: temp_total)
        self.used = rounder(x: temp_used)
        self.percentUsed = rounder(x: (temp_used/temp_total)*100)
        self.percentFree = rounder(x: (temp_free/temp_total)*100)
        self.percentCompressed = rounder(x: 100 - ((temp_compressor/temp_total)*100))
        self.percentFI = rounder(x: ((temp_free + temp_inactive)/temp_total)*100)
        self.percentWA = rounder(x: ((temp_wired + temp_active)/temp_total)*100)
    }
    
    
    public func update() {
        /*  :(  */
        let vm = vm_stat()!
        
        let temp_free: Double = Double(vm.free_count)*self.factor
        let temp_speculative: Double = Double(vm.speculative_count)*self.factor
        let temp_active: Double = Double(vm.active_count)*self.factor
        let temp_inactive: Double = Double(vm.inactive_count)*self.factor
        let temp_wired: Double = Double(vm.wire_count)*self.factor
        let temp_compressor: Double = Double(vm.compressor_page_count)*self.factor
        let temp_pageable: Double =  Double(vm.internal_page_count)*self.factor
        let temp_purgeable: Double = Double(vm.purgeable_count)*self.factor
        let temp_app: Double = temp_pageable - temp_purgeable
        let temp_total: Double = temp_free + temp_speculative + temp_active + temp_inactive + temp_wired + temp_compressor
        let temp_used: Double = temp_app + temp_wired + temp_compressor
        
        self.free = rounder(x: temp_free)
        self.speculative = rounder(x: temp_speculative)
        self.active = rounder(x: temp_active)
        self.inactive = rounder(x: temp_inactive)
        self.wired = rounder(x: temp_wired)
        self.compressor = rounder(x: temp_compressor)
        self.pageable = rounder(x: temp_pageable)
        self.purgeable = rounder(x: temp_purgeable)
        self.app = rounder(x: temp_app)
        self.total = rounder(x: temp_total)
        self.used = rounder(x: temp_used)
        self.percentUsed = rounder(x: (temp_used/temp_total)*100)
        self.percentFree = rounder(x: (temp_free/temp_total)*100)
        self.percentCompressed = rounder(x: 100 - ((temp_compressor/temp_total)*100))
        self.percentFI = rounder(x: ((temp_free + temp_inactive)/temp_total)*100)
        self.percentWA = rounder(x: ((temp_wired + temp_active)/temp_total)*100)
    }
    
    
}


