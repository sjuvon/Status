//
//  vm_stat.swift
//  Status
//
//  Created by Sjuvon Chung on 10/29/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Foundation


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
    
    return pointer_vm_stat.pointee
}

