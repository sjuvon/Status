//
//  RAM.swift
//  Status
//
//  Created by Sjuvon Chung on 10/28/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Cocoa
import Foundation
// from vm_stat import vm_stat


func rounder(x: Double) -> Double {
    /*  Function for rounding to three decimal places.  */
    return round(x*1000)/1000
}


public struct RAM {
    /*  Model for RAM statistics */
    let factor: Double = Double( Double(4096) / Double(1024*1024*1024) )
    var display: [String:Double] = [:]
    
    
    public init() {
        let vm = vm_stat()!
        
        let temp_free: Double = Double(vm.free_count)*factor
        let temp_speculative: Double = Double(vm.speculative_count)*factor
        let temp_active: Double = Double(vm.active_count)*factor
        let temp_inactive: Double = Double(vm.inactive_count)*factor
        let temp_wired: Double = Double(vm.wire_count)*factor
        let temp_compressor: Double = Double(vm.compressor_page_count)*factor
        let temp_pageable: Double =  Double(vm.internal_page_count)*factor
        let temp_purgeable: Double = Double(vm.purgeable_count)*factor
        let temp_app: Double = temp_pageable - temp_purgeable
        let temp_total: Double = temp_free + temp_speculative + temp_active + temp_inactive + temp_wired + temp_compressor
        let temp_used: Double = temp_app + temp_wired + temp_compressor
        
        display["free"] = rounder(x: temp_free)
        display["speculative"] = rounder(x: temp_speculative)
        display["active"] = rounder(x: temp_active)
        display["inactive"] = rounder(x: temp_inactive)
        display["wired"] = rounder(x: temp_wired)
        display["compressor"] = rounder(x: temp_compressor)
        display["pageable"] = rounder(x: temp_pageable)
        display["purgeable"] = rounder(x: temp_purgeable)
        display["app"] = rounder(x: temp_app)
        display["total"] = rounder(x: temp_total)
        display["used"] = rounder(x: temp_used)
        
        display["percentUsed"] = rounder(x: (temp_used/temp_total)*100)
        display["percentFree"] = rounder(x: (temp_free/temp_total)*100)
        display["percentCompressed"] = rounder(x: 100 - ((temp_compressor/temp_total)*100))
        display["percentFI"] = rounder(x: ((temp_free + temp_inactive)/temp_total)*100)
        display["percentWA"] = rounder(x: ((temp_wired + temp_active)/temp_total)*100)
    }
    
    
}



