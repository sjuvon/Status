//
//  vm_stat.swift
//  Status
//
//  Created by Sjuvon Chung on 10/29/21.
//  Copyright © 2021 Sjuvon Chung. All rights reserved.
//

import Foundation


func vm_stat() -> vm_statistics64? {
    /*  What needs to be done?

        (1) Call the kernel API
        (2) Read the API's message
     
        The catch: In order to ultimately display API message, need host_statistics64;
        however, host_statistics64 requires an out-value of integer_t, which
        vm_statistics64 isn't.  So we fashion a pointer of type integer_t along the way.
 
        N.B.: After a good deal of work, finally found the relevant documentation.
              See: https://www.gnu.org/software/hurd/gnumach-doc/index.html
    */
    
    /*  host_port: The port number of host (me)
        host_size: Size in integer_t's of vm_statistics64, in preparation for pointer conversion.
    */
    let host_port: host_t = mach_host_self()
    var host_size: mach_msg_type_number_t = mach_msg_type_number_t(
        MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride
    )
    
    
    /*  Provide an instance of vm_statistics64 to point to.  */
    var vm_stat: vm_statistics64 = vm_statistics64()
    let pointer_vm_stat = UnsafeMutablePointer<vm_statistics64>.allocate(capacity: 1)
    
    pointer_vm_stat.initialize(
        from: &vm_stat,
        count: 1
    )
    
    
    /*  Convert pointer, then call host_statistics64.
     
        Note: withMemoryRebound only converts original pointer pointer_vm_stat temporarily; the
        closure is precisely for working in this lifetime.
        Cf. Alternative solution below.
     */
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


    /*  // Alternative solution via bindMemory:
        // In general, use bindMemory when:
        // (1) We want the pointer to be converted permanently, and
        // (2) When pointer_converter has different memory stats (size & stride)
        //     from the original pointer_vm_stat.
    
    let pointer_converter = UnsafeMutableRawPointer(pointer_vm_stat).bindMemory(
        to: integer_t.self,
        capacity: Int(host_size)
    )
     
    host_statistics64(
        host_port,
        HOST_VM_INFO64,
        pointer_converter,
        &host_size)
    
    return pointer_vm_stat.pointee
    */


/*
func vm_list() -> task_basic_info_64 {
    var targetTask: task_t = mach_task_self_
    var taskInfoCount: mach_msg_type_number_t = mach_msg_type_number_t(
        MemoryLayout<task_basic_info_64_data_t>.stride / MemoryLayout<integer_t>.stride
    )
    
    var vm_list: task_basic_info_64 = task_basic_info_64()
    let pointer_vm_list = UnsafeMutablePointer<task_basic_info_64>.allocate(capacity: 1)
    
    pointer_vm_list.initialize(
        from: &vm_list,
        count: 1
    )
    
    
    // Thank you, Nate Cook, at https://stackoverflow.com/questions/27556807/swift-pointer-problems-with-mach-task-basic-info !
    pointer_vm_list.withMemoryRebound(to: integer_t.self, capacity: 1) {
        task_info(
            targetTask,
            task_flavor_t(TASK_BASIC_INFO_64),
            $0,
            &taskInfoCount
        )
    }
    
 
    return pointer_vm_list.pointee
}
*/


/*
@discardableResult
func shell() -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.launchPath = "/bin/sh"
    task.arguments = ["-c", String(format:"%@", "top -o mem")]
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}
 */


































