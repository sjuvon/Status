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


func vm_stat() -> vm_statistics64? {
    /*  Mach kernel API call to retrieve memory status.  */
    let host_port: host_t = mach_host_self()
    var host_size: mach_msg_type_number_t = mach_msg_type_number_t(
        MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride
    )
    
    var vm_stat: vm_statistics64 = vm_statistics64()
    let pointer_vm_stat = UnsafeMutablePointer<vm_statistics64>.allocate(capacity: 1)
    
    pointer_vm_stat.initialize(
        from: &vm_stat,
        count: 1
    )
    
    pointer_vm_stat.withMemoryRebound(to: integer_t.self, capacity: 1) {
        host_statistics64(
            host_port,
            HOST_VM_INFO64,
            $0,
            &host_size
        )
    }
    
    // To do: nil-optional
    return pointer_vm_stat.pointee
}


func swap_usage() -> xsw_usage? {
    /*  Kernel API call to retrieve memory swap usage.  */
    var sizeT: size_t = MemoryLayout<xsw_usage>.stride
    var swapUsage: xsw_usage = xsw_usage()
    
    sysctlbyname("vm.swapusage", &swapUsage, &sizeT, nil, 0)
    
    return swapUsage
}


public struct RAM {
    /*  Model for RAM statistics */
    let factor: Double = Double( Double(4096) / Double(1024*1024*1024) )
    var display: [String:Double] = [:]
    
    
    public init() {
        let vm = vm_stat()!
        let swap = swap_usage()!
        
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
        
        let temp_swap: Double = Double(Double(swap.xsu_used)/Double(1024*1024))
        display["swap"] = rounder(x: temp_swap)
        
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
    }
    
    
}



