Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827A12A0E91
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 20:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgJ3TYf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 15:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgJ3TXW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 15:23:22 -0400
Received: from [10.0.0.34] (cpe-70-114-140-30.austin.res.rr.com [70.114.140.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1659A206E3;
        Fri, 30 Oct 2020 19:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604085798;
        bh=is9WIt3k3/+a8li9lS5Q0NiwaztN5NGPgmJT+RXdMGM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xdq+kHPWOdIJx4fLs3BGVBH5EuJAZnFZGCJYQLm1D1GEdGYz6Yw0KrI8nuEzIEiUM
         JoohJ/4R1uUx5UBSoV3Q/JRtyvd2ueRdXozflupWLJkXqiTmviG2++wymhZ+YhhcNj
         /Bq6/p5wTn+U1EY6kZ09gDb8PeEpu4G6ExzXAFqo=
Subject: Re: [RFC] Accessing QSPI device under mtd
To:     Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Tudor.Ambarus@microchip.com, Mark Brown <broonie@kernel.org>,
        Richard Gong <richard.gong@intel.com>
References: <7918ea88-3ede-743e-4444-587d0f625c2e@kernel.org>
 <b881ec8a-694f-8025-1dd0-e1c979e43816@ti.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3d216597-c7d5-be37-2008-abd0dc2ea75e@kernel.org>
Date:   Fri, 30 Oct 2020 14:23:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b881ec8a-694f-8025-1dd0-e1c979e43816@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vignesh,

I'm using the standard arm64 defconfig. Attached are 2 bootlogs, v5.8
and v5.9. On the v5.8, I can see the QSPI devices under /dev/mtdX, and
has this in the bootlog:

[    1.073562] cadence-qspi ff8d2000.spi: mt25qu02g (262144 Kbytes)
[    1.079865] 2 fixed-partitions partitions found on MTD device
ff8d2000.spi.0
[    1.086917] Creating 2 MTD partitions on "ff8d2000.spi.0":
[    1.092401] 0x000000000000-0x000003fe0000 : "Boot and fpga data"
[    1.103073] 0x000003fe0000-0x000010000000 : "Root Filesystem - JFFS2"

In v5.9, I don't see the above output in the bootlog, and there are no
/dev/mtdX. I did a bisect and it resulted in commit "a314f6367787ee mtd:
spi-nor: Convert cadence-quadspi to use spi-mem framework". If I revert
this patch, then QSPI device is under /dev/mtdX.

There were no changes in the Stratix10 DTS files between v5.8 and v5.9
that should have any affect on QSPI.

v5.9:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.9.0 (dinguyen@linux-builds1)
(aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011, GNU ld
(Linaro_Binutils-2017.11) 2.28.2.20170706) #34 SMP PREEMPT Fri Oct 30
13:44:04 CDT 2020
[    0.000000] Machine model: SoCFPGA Stratix 10 SoCDK
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at
0x0000000000000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node svcbuffer@0,
compatible id shared-dma-pool
[    0.000000] cma: Reserved 32 MiB at 0x000000007d800000
[    0.000000] earlycon: uart0 at MMIO32 0x00000000ffc02000 (options
'115200n8')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x1ff7f2100-0x1ff7f3fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000001000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000180000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv65535.65535 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 23 pages/cpu s54104 r8192 d31912 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
1028160
[    0.000000] Policy zone: Normal
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
[    0.000000] Memory: 3968324K/4177920K available (14268K kernel code,
2280K rwdata, 7676K rodata, 5760K init, 487K bss, 176828K reserved,
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] random: get_random_bytes called from
start_kernel+0x314/0x4f0 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 400.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.000004] sched_clock: 56 bits at 400MHz, resolution 2ns, wraps
every 4398046511103ns
[    0.008243] Console: colour dummy device 80x25
[    0.012675] printk: console [tty0] enabled
[    0.016763] printk: bootconsole [uart0] disabled
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.9.0 (dinguyen@linux-builds1)
(aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011, GNU ld
(Linaro_Binutils-2017.11) 2.28.2.20170706) #34 SMP PREEMPT Fri Oct 30
13:44:04 CDT 2020
[    0.000000] Machine model: SoCFPGA Stratix 10 SoCDK
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at
0x0000000000000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node svcbuffer@0,
compatible id shared-dma-pool
[    0.000000] cma: Reserved 32 MiB at 0x000000007d800000
[    0.000000] earlycon: uart0 at MMIO32 0x00000000ffc02000 (options
'115200n8')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x1ff7f2100-0x1ff7f3fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000001000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000180000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv65535.65535 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 23 pages/cpu s54104 r8192 d31912 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
1028160
[    0.000000] Policy zone: Normal
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
[    0.000000] Memory: 3968324K/4177920K available (14268K kernel code,
2280K rwdata, 7676K rodata, 5760K init, 487K bss, 176828K reserved,
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] random: get_random_bytes called from
start_kernel+0x314/0x4f0 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 400.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.000004] sched_clock: 56 bits at 400MHz, resolution 2ns, wraps
every 4398046511103ns
[    0.008243] Console: colour dummy device 80x25
[    0.012675] printk: console [tty0] enabled
[    0.016763] printk: bootconsole [uart0] disabled
[    0.021451] Calibrating delay loop (skipped), value calculated using
timer frequency.. 800.00 BogoMIPS (lpj=1600000)
[    0.021475] pid_max: default: 32768 minimum: 301
[    0.021567] LSM: Security Framework initializing
[    0.021651] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.021686] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.023233] rcu: Hierarchical SRCU implementation.
[    0.024262] EFI services will not be available.
[    0.024460] smp: Bringing up secondary CPUs ...
[    0.024866] Detected VIPT I-cache on CPU1
[    0.024914] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.025334] Detected VIPT I-cache on CPU2
[    0.025363] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.025792] Detected VIPT I-cache on CPU3
[    0.025820] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.025882] smp: Brought up 1 node, 4 CPUs
[    0.025939] SMP: Total of 4 processors activated.
[    0.025952] CPU features: detected: 32-bit EL0 Support
[    0.025964] CPU features: detected: CRC32 instructions
[    0.025976] CPU features: detected: 32-bit EL1 Support
[    0.037628] CPU: All CPU(s) started at EL2
[    0.037663] alternatives: patching kernel code
[    0.039512] devtmpfs: initialized
[    0.042617] KASLR disabled due to lack of seed
[    0.042964] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.042995] futex hash table entries: 1024 (order: 4, 65536 bytes,
linear)
[    0.044205] pinctrl core: initialized pinctrl subsystem
[    0.045323] DMI not present or invalid.
[    0.045954] NET: Registered protocol family 16
[    0.047280] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic
allocations
[    0.047430] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.047609] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.047655] audit: initializing netlink subsys (disabled)
[    0.047820] audit: type=2000 audit(0.040:1): state=initialized
audit_enabled=0 res=1
[    0.048694] thermal_sys: Registered thermal governor 'step_wise'
[    0.048697] thermal_sys: Registered thermal governor 'power_allocator'
[    0.048897] cpuidle: using governor menu
[    0.049188] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.049264] ASID allocator initialised with 65536 entries
[    0.050473] Serial: AMBA PL011 UART driver
[    0.057486] OF: /soc/gpio@ffc03300/gpio-controller@0: could not find
phandle
[    0.058265] OF: /soc/gpio@ffc03300/gpio-controller@0: could not find
phandle
[    0.072286] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.072307] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.072322] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.072337] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.073383] cryptd: max_cpu_qlen set to 1000
[    0.075337] ACPI: Interpreter disabled.
[    0.076717] iommu: Default domain type: Translated
[    0.076944] vgaarb: loaded
[    0.077273] SCSI subsystem initialized
[    0.077625] usbcore: registered new interface driver usbfs
[    0.077673] usbcore: registered new interface driver hub
[    0.077741] usbcore: registered new device driver usb
[    0.077878] usb_phy_generic soc:usbphy@0: supply vcc not found, using
dummy regulator
[    0.078567] pps_core: LinuxPPS API ver. 1 registered
[    0.078581] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.078609] PTP clock support registered
[    0.078714] EDAC MC: Ver: 3.0.0
[    0.080102] Intel Service Layer Driver Initialized
[    0.080797] FPGA manager framework
[    0.080889] Advanced Linux Sound Architecture Driver Initialized.
[    0.081724] clocksource: Switched to clocksource arch_sys_counter
[    0.081935] VFS: Disk quotas dquot_6.6.0
[    0.081999] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.082267] pnp: PnP ACPI: disabled
[    0.088209] NET: Registered protocol family 2
[    0.088623] tcp_listen_portaddr_hash hash table entries: 2048 (order:
3, 32768 bytes, linear)
[    0.088692] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.088954] TCP bind hash table entries: 32768 (order: 7, 524288
bytes, linear)
[    0.089453] TCP: Hash tables configured (established 32768 bind 32768)
[    0.089575] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.089677] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes,
linear)
[    0.089916] NET: Registered protocol family 1
[    0.090275] RPC: Registered named UNIX socket transport module.
[    0.090289] RPC: Registered udp transport module.
[    0.090301] RPC: Registered tcp transport module.
[    0.090312] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.090333] PCI: CLS 0 bytes, default 64
[    0.091238] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
counters available
[    0.091517] kvm [1]: IPA Size Limit: 40bits
[    0.092440] kvm [1]: Hyp mode initialized successfully
[    0.095507] Initialise system trusted keyrings
[    0.095633] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    0.102243] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.102915] NFS: Registering the id_resolver key type
[    0.102950] Key type id_resolver registered
[    0.102962] Key type id_legacy registered
[    0.103061] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.103188] 9p: Installing v9fs 9p2000 file system support
[    0.147015] Key type asymmetric registered
[    0.147030] Asymmetric key parser 'x509' registered
[    0.147072] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 245)
[    0.147091] io scheduler mq-deadline registered
[    0.147103] io scheduler kyber registered
[    0.154865] EINJ: ACPI disabled.
[    0.165130] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.166994] ffc02000.serial: ttyS0 at MMIO 0xffc02000 (irq = 25,
base_baud = 6250000) is a 16550A
[    1.038814] printk: console [ttyS0] enabled
[    1.043878] SuperH (H)SCI(F) driver initialized
[    1.048799] msm_serial: driver initialized
[    1.054045] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    1.067040] loop: module loaded
[    1.070987] megasas: 07.714.04.00-rc1
[    1.079406] libphy: Fixed MDIO Bus: probed
[    1.084219] tun: Universal TUN/TAP device driver, 1.6
[    1.089867] thunder_xcv, ver 1.0
[    1.093119] thunder_bgx, ver 1.0
[    1.096384] nicpf, ver 1.0
[    1.099954] hclge is initializing
[    1.103302] hns3: Hisilicon Ethernet Network Driver for Hip08 Family
- version
[    1.110515] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.115855] e1000: Intel(R) PRO/1000 Network Driver
[    1.120725] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.126501] e1000e: Intel(R) PRO/1000 Network Driver
[    1.131458] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.137402] igb: Intel(R) Gigabit Ethernet Network Driver
[    1.142789] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.148382] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    1.154636] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.160790] sky2: driver version 1.30
[    1.165125] socfpga-dwmac ff800000.ethernet: IRQ eth_wake_irq not found
[    1.171731] socfpga-dwmac ff800000.ethernet: IRQ eth_lpi not found
[    1.178011] socfpga-dwmac ff800000.ethernet: PTP uses main clock
[    1.184244] socfpga-dwmac ff800000.ethernet: User ID: 0x11, Synopsys
ID: 0x37
[    1.191373] socfpga-dwmac ff800000.ethernet:         DWMAC1000
[    1.196593] socfpga-dwmac ff800000.ethernet: DMA HW capability
register supported
[    1.204065] socfpga-dwmac ff800000.ethernet: RX Checksum Offload
Engine supported
[    1.211533] socfpga-dwmac ff800000.ethernet: COE Type 2
[    1.216749] socfpga-dwmac ff800000.ethernet: TX Checksum insertion
supported
[    1.223782] socfpga-dwmac ff800000.ethernet: Enhanced/Alternate
descriptors
[    1.230729] socfpga-dwmac ff800000.ethernet: Enabled extended descriptors
[    1.237502] socfpga-dwmac ff800000.ethernet: Ring mode enabled
[    1.243325] socfpga-dwmac ff800000.ethernet: Enable RX Mitigation via
HW Watchdog Timer
[    1.251318] socfpga-dwmac ff800000.ethernet: device MAC address
62:21:ab:72:92:dc
[    1.259232] libphy: stmmac: probed
[    1.264638] VFIO - User Level meta-driver version: 0.3
[    1.270859] dwc2 ffb00000.usb: supply vusb_d not found, using dummy
regulator
[    1.278116] dwc2 ffb00000.usb: supply vusb_a not found, using dummy
regulator
[    1.285467] dwc2 ffb00000.usb: EPs: 16, dedicated fifos, 8064 entries
in SPRAM
[    1.292954] dwc2 ffb00000.usb: DWC OTG Controller
[    1.297673] dwc2 ffb00000.usb: new USB bus registered, assigned bus
number 1
[    1.304727] dwc2 ffb00000.usb: irq 26, io mem 0xffb00000
[    1.310589] hub 1-0:1.0: USB hub found
[    1.314362] hub 1-0:1.0: 1 port detected
[    1.319433] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.325984] ehci-pci: EHCI PCI platform driver
[    1.330455] ehci-platform: EHCI generic platform driver
[    1.335779] ehci-orion: EHCI orion driver
[    1.339868] ehci-exynos: EHCI Exynos driver
[    1.344118] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.350294] ohci-pci: OHCI PCI platform driver
[    1.354768] ohci-platform: OHCI generic platform driver
[    1.360066] ohci-exynos: OHCI Exynos driver
[    1.364641] usbcore: registered new interface driver usb-storage
[    1.372661] i2c /dev entries driver
[    1.381578] sdhci: Secure Digital Host Controller Interface driver
[    1.387779] sdhci: Copyright(c) Pierre Ossman
[    1.392535] Synopsys Designware Multimedia Card Interface Driver
[    1.398770] dw_mmc ff808000.dwmmc0: IDMAC supports 32-bit address mode.
[    1.405392] dw_mmc ff808000.dwmmc0: Using internal DMA controller.
[    1.411568] dw_mmc ff808000.dwmmc0: Version ID is 280a
[    1.416736] dw_mmc ff808000.dwmmc0: DW MMC controller at irq 11,32
bit host data width,1024 deep fifo
[    1.426116] mmc_host mmc0: card is polling.
[    1.442905] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
400000Hz, actual 396825HZ div = 63)
[    1.465765] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.472784] ledtrig-cpu: registered to indicate activity on CPUs
[    1.480005] usbcore: registered new interface driver usbhid
[    1.485589] usbhid: USB HID core driver
[    1.493170] NET: Registered protocol family 17
[    1.497783] 9pnet: Installing 9P2000 support
[    1.502113] Key type dns_resolver registered
[    1.506733] registered taskstats version 1
[    1.510832] Loading compiled-in X.509 certificates
[    1.517839] dma-pl330 ffda0000.pdma: Loaded driver for PL330 DMAC-341330
[    1.518009] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
50000000Hz, actual 50000000HZ div = 0)
[    1.524537] dma-pl330 ffda0000.pdma:         DBUFF-512x8bytes
Num_Chans-8 Num_Peri-32 Num_Events-8
[    1.534290] mmc0: new high speed SDHC card at address 0007
[    1.548816] mmcblk0: mmc0:0007 SD4GB 3.71 GiB
[    1.555540]  mmcblk0: p1 p2
[    1.613738] socfpga-dwmac ff800000.ethernet eth0: PHY [stmmac-0:04]
driver [Micrel KSZ9031 Gigabit PHY] (irq=POLL)
[    1.635567] socfpga-dwmac ff800000.ethernet eth0: No Safety Features
support found
[    1.643135] socfpga-dwmac ff800000.ethernet eth0: IEEE 1588-2008
Advanced Timestamp supported
[    1.651772] socfpga-dwmac ff800000.ethernet eth0: registered PTP clock
[    1.658296] socfpga-dwmac ff800000.ethernet eth0: configuring for
phy/rgmii link mode
[    1.845763] usb 1-1: new high-speed USB device number 2 using dwc2
[    2.060679] usb-storage 1-1:1.0: USB Mass Storage device detected
[    2.067104] scsi host0: usb-storage 1-1:1.0
[    3.074277] scsi 0:0:0:0: Direct-Access
 0.00 PQ: 0 ANSI: 2
[    3.082874] sd 0:0:0:0: [sda] 15773696 512-byte logical blocks: (8.08
GB/7.52 GiB)
[    3.090564] sd 0:0:0:0: [sda] Write Protect is off
[    3.095508] sd 0:0:0:0: [sda] Asking for cache data failed
[    3.100989] sd 0:0:0:0: [sda] Assuming drive cache: write through
[    3.109209]  sda: sda1
[    3.123423] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    3.715320] socfpga-dwmac ff800000.ethernet eth0: Link is Up -
100Mbps/Full - flow control rx/tx
[    3.737733] Sending DHCP requests .., OK


v5.8

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.8.0 (dinguyen@linux-builds1)
(aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011, GNU ld
(Linaro_Binutils-2017.11) 2.28.2.20170706) #33 SMP PREEMPT Fri Oct 30
13:28:16 CDT 2020
[    0.000000] Machine model: SoCFPGA Stratix 10 SoCDK
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at
0x0000000000000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node svcbuffer@0,
compatible id shared-dma-pool
[    0.000000] cma: Reserved 32 MiB at 0x000000007d800000
[    0.000000] earlycon: uart0 at MMIO32 0x00000000ffc02000 (options
'115200n8')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x1ff7f3100-0x1ff7f4fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000001000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000180000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv65535.65535 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 23 pages/cpu s53912 r8192 d32104 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
1028160
[    0.000000] Policy zone: Normal
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
[    0.000000] Memory: 3969032K/4177920K available (14012K kernel code,
2170K rwdata, 7516K rodata, 5632K init, 483K bss, 176120K reserved,
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] random: get_random_bytes called from
start_kernel+0x314/0x4f0 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 400.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.000004] sched_clock: 56 bits at 400MHz, resolution 2ns, wraps
every 4398046511103ns
[    0.008248] Console: colour dummy device 80x25
[    0.012680] printk: console [tty0] enabled
[    0.016769] printk: bootconsole [uart0] disabled
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.8.0 (dinguyen@linux-builds1)
(aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011, GNU ld
(Linaro_Binutils-2017.11) 2.28.2.20170706) #33 SMP PREEMPT Fri Oct 30
13:28:16 CDT 2020
[    0.000000] Machine model: SoCFPGA Stratix 10 SoCDK
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created DMA memory pool at
0x0000000000000000, size 16 MiB
[    0.000000] OF: reserved mem: initialized node svcbuffer@0,
compatible id shared-dma-pool
[    0.000000] cma: Reserved 32 MiB at 0x000000007d800000
[    0.000000] earlycon: uart0 at MMIO32 0x00000000ffc02000 (options
'115200n8')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x1ff7f3100-0x1ff7f4fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000001000000-0x000000003fffffff]
[    0.000000]   DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000180000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000001000000-0x00000001ffffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv65535.65535 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 23 pages/cpu s53912 r8192 d32104 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
1028160
[    0.000000] Policy zone: Normal
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
[    0.000000] Memory: 3969032K/4177920K available (14012K kernel code,
2170K rwdata, 7516K rodata, 5632K init, 483K bss, 176120K reserved,
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=4.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] random: get_random_bytes called from
start_kernel+0x314/0x4f0 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 400.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.000004] sched_clock: 56 bits at 400MHz, resolution 2ns, wraps
every 4398046511103ns
[    0.008248] Console: colour dummy device 80x25
[    0.012680] printk: console [tty0] enabled
[    0.016769] printk: bootconsole [uart0] disabled
[    0.021460] Calibrating delay loop (skipped), value calculated using
timer frequency.. 800.00 BogoMIPS (lpj=1600000)
[    0.021483] pid_max: default: 32768 minimum: 301
[    0.021580] LSM: Security Framework initializing
[    0.021666] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.021701] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.023241] rcu: Hierarchical SRCU implementation.
[    0.024252] EFI services will not be available.
[    0.024452] smp: Bringing up secondary CPUs ...
[    0.024859] Detected VIPT I-cache on CPU1
[    0.024910] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.025337] Detected VIPT I-cache on CPU2
[    0.025365] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.025798] Detected VIPT I-cache on CPU3
[    0.025825] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.025888] smp: Brought up 1 node, 4 CPUs
[    0.025944] SMP: Total of 4 processors activated.
[    0.025956] CPU features: detected: 32-bit EL0 Support
[    0.025969] CPU features: detected: CRC32 instructions
[    0.025981] CPU features: detected: 32-bit EL1 Support
[    0.037553] CPU: All CPU(s) started at EL2
[    0.037589] alternatives: patching kernel code
[    0.039396] devtmpfs: initialized
[    0.042341] KASLR disabled due to lack of seed
[    0.042680] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.042711] futex hash table entries: 1024 (order: 4, 65536 bytes,
linear)
[    0.043965] pinctrl core: initialized pinctrl subsystem
[    0.044990] thermal_sys: Registered thermal governor 'step_wise'
[    0.044994] thermal_sys: Registered thermal governor 'power_allocator'
[    0.045123] DMI not present or invalid.
[    0.045775] NET: Registered protocol family 16
[    0.046320] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic
allocations
[    0.046468] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.046613] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.046658] audit: initializing netlink subsys (disabled)
[    0.046818] audit: type=2000 audit(0.040:1): state=initialized
audit_enabled=0 res=1
[    0.047790] cpuidle: using governor menu
[    0.048057] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.048134] ASID allocator initialised with 65536 entries
[    0.049312] Serial: AMBA PL011 UART driver
[    0.055892] OF: /soc/gpio@ffc03300/gpio-controller@0: could not find
phandle
[    0.056333] OF: /soc/gpio@ffc03300/gpio-controller@0: could not find
phandle
[    0.069208] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.069230] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.069246] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.069261] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.070365] cryptd: max_cpu_qlen set to 1000
[    0.072305] ACPI: Interpreter disabled.
[    0.073536] iommu: Default domain type: Translated
[    0.073767] vgaarb: loaded
[    0.074083] SCSI subsystem initialized
[    0.074451] usbcore: registered new interface driver usbfs
[    0.074505] usbcore: registered new interface driver hub
[    0.074571] usbcore: registered new device driver usb
[    0.074706] usb_phy_generic soc:usbphy@0: supply vcc not found, using
dummy regulator
[    0.075304] pps_core: LinuxPPS API ver. 1 registered
[    0.075318] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.075346] PTP clock support registered
[    0.075449] EDAC MC: Ver: 3.0.0
[    0.076804] Intel Service Layer Driver Initialized
[    0.077474] FPGA manager framework
[    0.077565] Advanced Linux Sound Architecture Driver Initialized.
[    0.078390] clocksource: Switched to clocksource arch_sys_counter
[    0.078600] VFS: Disk quotas dquot_6.6.0
[    0.078662] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.078864] pnp: PnP ACPI: disabled
[    0.084675] NET: Registered protocol family 2
[    0.085074] tcp_listen_portaddr_hash hash table entries: 2048 (order:
3, 32768 bytes, linear)
[    0.085145] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.085405] TCP bind hash table entries: 32768 (order: 7, 524288
bytes, linear)
[    0.085900] TCP: Hash tables configured (established 32768 bind 32768)
[    0.086021] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.086123] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes,
linear)
[    0.086343] NET: Registered protocol family 1
[    0.086783] RPC: Registered named UNIX socket transport module.
[    0.086798] RPC: Registered udp transport module.
[    0.086810] RPC: Registered tcp transport module.
[    0.086821] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.086842] PCI: CLS 0 bytes, default 64
[    0.087769] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
counters available
[    0.088031] kvm [1]: IPA Size Limit: 40bits
[    0.088954] kvm [1]: Hyp mode initialized successfully
[    0.092147] Initialise system trusted keyrings
[    0.092268] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    0.098852] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.099540] NFS: Registering the id_resolver key type
[    0.099571] Key type id_resolver registered
[    0.099583] Key type id_legacy registered
[    0.099602] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.099766] 9p: Installing v9fs 9p2000 file system support
[    0.144215] Key type asymmetric registered
[    0.144230] Asymmetric key parser 'x509' registered
[    0.144276] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 245)
[    0.144295] io scheduler mq-deadline registered
[    0.144308] io scheduler kyber registered
[    0.151925] EINJ: ACPI disabled.
[    0.161970] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.163767] ffc02000.serial: ttyS0 at MMIO 0xffc02000 (irq = 25,
base_baud = 6250000) is a 16550A
[    1.035736] printk: console [ttyS0] enabled
[    1.040752] SuperH (H)SCI(F) driver initialized
[    1.045679] msm_serial: driver initialized
[    1.050922] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    1.063841] loop: module loaded
[    1.067786] megasas: 07.714.04.00-rc1
[    1.073562] cadence-qspi ff8d2000.spi: mt25qu02g (262144 Kbytes)
[    1.079865] 2 fixed-partitions partitions found on MTD device
ff8d2000.spi.0
[    1.086917] Creating 2 MTD partitions on "ff8d2000.spi.0":
[    1.092401] 0x000000000000-0x000003fe0000 : "Boot and fpga data"
[    1.103073] 0x000003fe0000-0x000010000000 : "Root Filesystem - JFFS2"
[    1.113616] libphy: Fixed MDIO Bus: probed
[    1.118466] tun: Universal TUN/TAP device driver, 1.6
[    1.124085] thunder_xcv, ver 1.0
[    1.127350] thunder_bgx, ver 1.0
[    1.130612] nicpf, ver 1.0
[    1.134155] hclge is initializing
[    1.137510] hns3: Hisilicon Ethernet Network Driver for Hip08 Family
- version
[    1.144720] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.150065] e1000: Intel(R) PRO/1000 Network Driver - version
7.3.21-k8-NAPI
[    1.157099] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.162870] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.168691] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.174632] igb: Intel(R) Gigabit Ethernet Network Driver - version
5.6.0-k
[    1.181579] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.187184] igbvf: Intel(R) Gigabit Virtual Function Network Driver -
version 2.4.0-k
[    1.194997] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.201146] sky2: driver version 1.30
[    1.205343] socfpga-dwmac ff800000.ethernet: IRQ eth_wake_irq not found
[    1.211950] socfpga-dwmac ff800000.ethernet: IRQ eth_lpi not found
[    1.218231] socfpga-dwmac ff800000.ethernet: PTP uses main clock
[    1.224433] socfpga-dwmac ff800000.ethernet: User ID: 0x11, Synopsys
ID: 0x37
[    1.231561] socfpga-dwmac ff800000.ethernet:         DWMAC1000
[    1.236782] socfpga-dwmac ff800000.ethernet: DMA HW capability
register supported
[    1.244255] socfpga-dwmac ff800000.ethernet: RX Checksum Offload
Engine supported
[    1.251724] socfpga-dwmac ff800000.ethernet: COE Type 2
[    1.256942] socfpga-dwmac ff800000.ethernet: TX Checksum insertion
supported
[    1.263976] socfpga-dwmac ff800000.ethernet: Enhanced/Alternate
descriptors
[    1.270923] socfpga-dwmac ff800000.ethernet: Enabled extended descriptors
[    1.277698] socfpga-dwmac ff800000.ethernet: Ring mode enabled
[    1.283520] socfpga-dwmac ff800000.ethernet: Enable RX Mitigation via
HW Watchdog Timer
[    1.291514] socfpga-dwmac ff800000.ethernet: device MAC address
f6:7b:ae:83:e3:6f
[    1.299404] libphy: stmmac: probed
[    1.304506] VFIO - User Level meta-driver version: 0.3
[    1.310679] dwc2 ffb00000.usb: supply vusb_d not found, using dummy
regulator
[    1.317858] dwc2 ffb00000.usb: supply vusb_a not found, using dummy
regulator
[    1.325209] dwc2 ffb00000.usb: EPs: 16, dedicated fifos, 8064 entries
in SPRAM
[    1.332722] dwc2 ffb00000.usb: DWC OTG Controller
[    1.337445] dwc2 ffb00000.usb: new USB bus registered, assigned bus
number 1
[    1.344503] dwc2 ffb00000.usb: irq 26, io mem 0xffb00000
[    1.350353] hub 1-0:1.0: USB hub found
[    1.354133] hub 1-0:1.0: 1 port detected
[    1.359164] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.365686] ehci-pci: EHCI PCI platform driver
[    1.370173] ehci-platform: EHCI generic platform driver
[    1.375501] ehci-orion: EHCI orion driver
[    1.379582] ehci-exynos: EHCI Exynos driver
[    1.383828] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.390005] ohci-pci: OHCI PCI platform driver
[    1.394475] ohci-platform: OHCI generic platform driver
[    1.399772] ohci-exynos: OHCI Exynos driver
[    1.404336] usbcore: registered new interface driver usb-storage
[    1.412340] i2c /dev entries driver
[    1.420237] sdhci: Secure Digital Host Controller Interface driver
[    1.426425] sdhci: Copyright(c) Pierre Ossman
[    1.431089] Synopsys Designware Multimedia Card Interface Driver
[    1.437308] dw_mmc ff808000.dwmmc0: IDMAC supports 32-bit address mode.
[    1.443930] dw_mmc ff808000.dwmmc0: Using internal DMA controller.
[    1.450107] dw_mmc ff808000.dwmmc0: Version ID is 280a
[    1.455282] dw_mmc ff808000.dwmmc0: DW MMC controller at irq 11,32
bit host data width,1024 deep fifo
[    1.464588] mmc_host mmc0: card is polling.
[    1.481378] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
400000Hz, actual 396825HZ div = 63)
[    1.504141] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.511144] ledtrig-cpu: registered to indicate activity on CPUs
[    1.518376] usbcore: registered new interface driver usbhid
[    1.523989] usbhid: USB HID core driver
[    1.531595] NET: Registered protocol family 17
[    1.536209] 9pnet: Installing 9P2000 support
[    1.540529] Key type dns_resolver registered
[    1.545180] registered taskstats version 1
[    1.549284] Loading compiled-in X.509 certificates
[    1.555146] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
50000000Hz, actual 50000000HZ div = 0)
[    1.556216] dma-pl330 ffda0000.pdma: Loaded driver for PL330 DMAC-341330
[    1.564912] mmc0: new high speed SDHC card at address 0007
[    1.571553] dma-pl330 ffda0000.pdma:         DBUFF-512x8bytes
Num_Chans-8 Num_Peri-32 Num_Events-8
[    1.586054] mmcblk0: mmc0:0007 SD4GB 3.71 GiB
[    1.592655]  mmcblk0: p1 p2
[    1.634399] socfpga-dwmac ff800000.ethernet eth0: PHY [stmmac-0:04]
driver [Micrel KSZ9031 Gigabit PHY] (irq=POLL)
[    1.656718] socfpga-dwmac ff800000.ethernet eth0: No Safety Features
support found
[    1.664286] socfpga-dwmac ff800000.ethernet eth0: IEEE 1588-2008
Advanced Timestamp supported
[    1.672926] socfpga-dwmac ff800000.ethernet eth0: registered PTP clock
[    1.679452] socfpga-dwmac ff800000.ethernet eth0: configuring for
phy/rgmii link mode
[    1.886407] usb 1-1: new high-speed USB device number 2 using dwc2
[    2.101354] usb-storage 1-1:1.0: USB Mass Storage device detected
[    2.107705] scsi host0: usb-storage 1-1:1.0
[    3.138934] scsi 0:0:0:0: Direct-Access
 0.00 PQ: 0 ANSI: 2
[    3.147481] sd 0:0:0:0: [sda] 15773696 512-byte logical blocks: (8.08
GB/7.52 GiB)
[    3.155175] sd 0:0:0:0: [sda] Write Protect is off
[    3.160113] sd 0:0:0:0: [sda] Asking for cache data failed
[    3.165596] sd 0:0:0:0: [sda] Assuming drive cache: write through
[    3.173760]  sda: sda1
[    3.185550] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    3.747979] socfpga-dwmac ff800000.ethernet eth0: Link is Up -
100Mbps/Full - flow control rx/tx
[    3.774401] Sending DHCP requests .., OK


Dinh

On 10/29/20 11:42 PM, Vignesh Raghavendra wrote:
> Hi,
> 
> On 10/30/20 1:17 AM, Dinh Nguyen wrote:
>> Hi,
>>
>> With commit "a314f6367787ee mtd: spi-nor: Convert cadence-quadspi to use
>> spi-mem framework", I can no longer access the QSPI device under
>> /dev/mtd<n> on the Intel Stratix10 and Agilex platforms and is breaking
>> a few tests we have in-house.
>>
>> Can someone point me to how to access the QSPI device using the spi-mem
>> framework?
>>
> 
> There is should be no visible change to userspace. /dev/mtdX devices
> should still get created based on cmdline or ofpart.
> 
> Could you elaborate what fails? Is the flash detected and /dev/mtdX
> devices created? Is the issue with read or write or erase?
> 
> Also what is the kernel version and .config being used? Full bootlog +
> testcase that fails would be helpful.
> 
> Regards
> Vignesh
> 
