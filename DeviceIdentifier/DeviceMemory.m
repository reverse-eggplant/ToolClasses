//
//  DeviceMemory.m
//  LightApp
//
//  Created by malong on 14/11/17.
//  Copyright (c) 2014年 malong. All rights reserved.
//

#import "DeviceMemory.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/task_info.h>
#import <mach/task.h>


@implementation DeviceMemory

// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
+ (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

+ (void) logMemoryInfo {
    
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
//    vm_statistics_data_t vmstat;
//    if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmstat, &count) != KERN_SUCCESS)
//    {
//        DLog(@"Failed to get VM statistics.");
//        [dic setObject:@"Failed to get VM statistics." forKey:@"KTTMemorySize_Wire"];
//    }
//    else
//    {
//        float total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
//        float wired = vmstat.wire_count / total * 100;
//        float active = vmstat.active_count / total * 100;
//        float inactive = vmstat.inactive_count / total * 100;
//        float free = vmstat.free_count / total * 100;
//        NSString *str = [NSString stringWithFormat:@"%d %d %d %d %.2f %.2f %.2f %.2f %.0f %.0f"
//                                                         , vmstat.wire_count, vmstat.active_count, vmstat.inactive_count, vmstat.free_count
//                                                         , wired, active, inactive, free
//                                                         , total
//                                                         ];
//        DLog(@"str = %@",str);
//        
//    }

//    
//    int mib[6];
//    mib[0] = CTL_HW;
//    mib[1] = HW_PAGESIZE;
//    
//    int pagesize;
//    size_t length;
//    length = sizeof (pagesize);
//    if (sysctl (mib, 2, &pagesize, &length, NULL, 0) < 0)
//    {
//        fprintf (stderr, "getting page size");
//    }
//    
//    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
//    
//    vm_statistics_data_t vmstat;
//    if (host_statistics (mach_host_self (), HOST_VM_INFO, (host_info_t) &vmstat, &count) != KERN_SUCCESS)
//    {
//        fprintf (stderr, "Failed to get VM statistics.");
//    }
//    task_basic_info_64_data_t info;
//    unsigned size = sizeof (info);
//    task_info (mach_task_self (), TASK_BASIC_INFO_64, (task_info_t) &info, &size);
//    
//    double unit = 1024 * 1024;
//    double total = (vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count) * pagesize / unit;
//    double wired = vmstat.wire_count * pagesize / unit;
//    double active = vmstat.active_count * pagesize / unit;
//    double inactive = vmstat.inactive_count * pagesize / unit;
//    double free = vmstat.free_count * pagesize / unit;
//    double resident = info.resident_size / unit;
//    DLog(@"===================================================");
//    DLog(@"Total:%.2lfMb", total);
//    DLog(@"Wired:%.2lfMb", wired);
//    DLog(@"Active:%.2lfMb", active);
//    DLog(@"Inactive:%.2lfMb", inactive);
//    DLog(@"Free:%.2lfMb", free);
//    DLog(@"Resident:%.2lfMb", resident);
}

//BOOL memoryInfo(vm_statistics_data_t *vmStats) {
//    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
//    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)vmStats, &infoCount);
//    
//    return kernReturn == KERN_SUCCESS;
//}
//
//void logMemoryInfo() {
//    vm_statistics_data_t vmStats;
//    
//    if (memoryInfo(&vmStats)) {
//        NSLog(@"free: %u\nactive: %u\ninactive: %u\nwire: %u\nzero fill: %u\nreactivations: %u\npageins: %u\npageouts: %u\nfaults: %u\ncow_faults: %u\nlookups: %u\nhits: %u",
//              vmStats.free_count * vm_page_size,
//              vmStats.active_count * vm_page_size,
//              vmStats.inactive_count * vm_page_size,
//              vmStats.wire_count * vm_page_size,
//              vmStats.zero_fill_count * vm_page_size,
//              vmStats.reactivations * vm_page_size,
//              vmStats.pageins * vm_page_size,
//              vmStats.pageouts * vm_page_size,
//              vmStats.faults,
//              vmStats.cow_faults,
//              vmStats.lookups,
//              vmStats.hits
//              );
//    } 
//}

@end
