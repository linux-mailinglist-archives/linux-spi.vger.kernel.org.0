Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28884C1895
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiBWQ24 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiBWQ2z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 11:28:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DFAE009
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 08:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A8FFB81EB0
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 16:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AC8C340E7;
        Wed, 23 Feb 2022 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645633703;
        bh=WImtVpnh1zVUtarGjZ58o12AGwBq7JIEUVHkxtoCtO4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L5vK3wSJgHyPdXcz2XHHPVjthob7t9dn+ImyBLuuDb8Xcy2k1L7fg9GtdvajmpQ2o
         594z/K4YmRXVCNZxAny57CWz8BJZMm2Nxcq1GZblkY56GwKjygb0r32/0hmTfwQDPQ
         mnXgjpQX/K+P722yZwzVPEJE1v3KdyfpffrD1t4IXFRnlZqvqJz2IsMbwW4/C64inH
         Ut+TB/BiN4O+xoO2rLr6obQQuV+mAb1EEwl9ZNGDGO9OzUIYNx/FtJXPN++rTsWRs/
         pvJUGOuqjwXMBUU6XzM7BXuPgSd1Nda1VEpaE0fytz4fpuidcN7nXcVgL/h7YWmQg6
         HAoR0ohMUBhvA==
Message-ID: <cd1e80f1-b12e-d8c4-e7f2-bfbc21ebf57c@kernel.org>
Date:   Wed, 23 Feb 2022 10:28:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
 <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
 <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
 <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
 <8060ae0e-700e-3b72-3ab9-e7ca8e19ad9e@denx.de>
 <8dc7a7d6-d24f-b3a6-32b9-64cdb8c6f3be@kernel.org>
 <bbc84e6b-68ce-84cb-7bc2-3ac844ec3710@denx.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <bbc84e6b-68ce-84cb-7bc2-3ac844ec3710@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/22/22 18:54, Marek Vasut wrote:
> On 2/22/22 22:32, Dinh Nguyen wrote:
>>
>>
>> On 2/22/22 12:30, Marek Vasut wrote:
>>> On 2/22/22 16:49, Dinh Nguyen wrote:
>>>>
>>>>
>>>> On 2/21/22 11:05, Marek Vasut wrote:
>>>>> On 2/21/22 17:38, Dinh Nguyen wrote:
>>>>>>
>>>>>>
>>>>>> On 2/20/22 22:32, Marek Vasut wrote:
>>>>>>> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
>>>>>>> leads to data abort, disable DAC to avoid triggering it:
>>>>>>>
>>>>>>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>>>>>>> [0400d3e9] *pgd=00000000
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>>>>> ---
>>>>>>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>>>>>>> b/drivers/spi/spi-cadence-quadspi.c
>>>>>>> index b808c94641fa6..65f2c2449be09 100644
>>>>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>>>>> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata 
>>>>>>> intel_lgm_qspi = {
>>>>>>>   };
>>>>>>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>>>>>>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>>> +    .quirks = CQSPI_DISABLE_DAC_MODE | 
>>>>>>> CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>>>   };
>>>>>>>   static const struct cqspi_driver_platdata versal_ospi = {
>>>>>>
>>>>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>>>>
>>>>> Is this DAC really not working on socfpga gen5 or is there some 
>>>>> other issue ?
>>>>
>>>> I don't know the answer to this question. What is the DAC in the 
>>>> QSPI module and how do I go about testing it?
>>>
>>> DAC = direct access.
>>>
>>> How do you go about testing this -- compile kernel with/without this 
>>> patch, boot on SoCFPGA Gen5 with QSPI NOR attached, the kernel 
>>> crashes without this patch on imprecise external abort.
>>
>> Hmm...I just tested v5.17-rc3 on a C5 board and QSPI looks to be 
>> working fine:
>>
>> [    1.744489] spi-nor spi1.0: found n25q512ax3, expected mt25qu02g
>> [    1.750534] dma-pl330 ffe01000.pdma: Reset Channel-0  CS-f FTC-40000
>> [    1.756941] spi-nor spi1.0: n25q512ax3 (65536 Kbytes)
>> [    1.762369] 2 fixed-partitions partitions found on MTD device 
>> ff705000.spi.0
>> [    1.769425] Creating 2 MTD partitions on "ff705000.spi.0":
>> [    1.774925] 0x000000000000-0x000000800000 : "Flash 0 Raw Data"
>> [    1.781942] 0x000000800000-0x000008000000 : "Flash 0 jffs2 Filesystem"
>> [    1.788468] mtd: partition "Flash 0 jffs2 Filesystem" extends 
>> beyond the end of device "ff705000.spi.0" -- size truncated to 0x3800000
> 
> I wonder if we might be missing some clock enable somewhere.
> 
> Can you mail me the whole boot log ? (I'm using u-boot 2022.01 btw.)

I tested with U-Boot 2022.01 as well:


=> run nfsboot_dinh
Kernel image @ 0x1000000 [ 0x000000 - 0x54edd0 ]
## Flattened Device Tree blob at 02000000
    Booting using the fdt blob at 0x2000000
    Loading Device Tree to 09ff8000, end 09fffeb1 ... OK

Starting kernel ...

Deasserting all peripheral resets
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.17.0-rc3 (dinguyen@linux-builds1) 
(arm-linux-gnue abihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0, 
GNU ld (GNU Binutils for U buntu) 2.30) #1 SMP Wed Feb 23 08:51:18 CST 2022
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), 
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instructio n cache
[    0.000000] OF: fdt: Machine model: Altera SOCFPGA Cyclone V SoC 
Development  Kit
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x000000003fffffff]
[    0.000000] percpu: Embedded 15 pages/cpu s29068 r8192 d24180 u61440
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line: root=/dev/nfs rw 
nfsroot=10.122.105.166:/hom e/dnguyen/rootfs_yocto,tcp ip=dhcp
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes,  linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes, li near)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1026164K/1048576K available (9216K kernel code, 
769K rwda ta, 1888K rodata, 1024K init, 139K bss, 22412K reserved, 0K 
cma-reserved, 262144 K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] ftrace: allocating 30749 entries in 91 pages
[    0.000000] ftrace: allocated 91 pages with 5 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 10 jif fies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 8 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x76460001
[    0.000000] random: get_random_bytes called from 
start_kernel+0x528/0x6cc wit h crng_init=0
[    0.000000] clocksource: timer1: mask: 0xffffffff max_cycles: 
0xffffffff, max _idle_ns: 19112604467 ns
[    0.000000] sched_clock: 32 bits at 100MHz, resolution 10ns, wraps 
every 2147 4836475ns
[    0.000017] Switching to timer-based delay loop, resolution 10ns
[    0.000303] Console: colour dummy device 80x30
[    0.000691] printk: console [tty0] enabled
[    0.000734] Calibrating delay loop (skipped), value calculated using 
timer fr equency.. 200.00 BogoMIPS (lpj=1000000)
[    0.000765] pid_max: default: 32768 minimum: 301
[    0.000894] Mount-cache hash table entries: 2048 (order: 1, 8192 
bytes, linea r)
[    0.000923] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 
bytes,  linear)
[    0.001517] CPU: Testing write buffer coherency: ok
[    0.001575] CPU0: Spectre v2: using BPIALL workaround
[    0.001761] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002324] cblist_init_generic: Setting adjustable number of 
callback queues .
[    0.002356] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.002460] Setting up static identity map for 0x100000 - 0x100060
[    0.002595] rcu: Hierarchical SRCU implementation.
[    0.002912] smp: Bringing up secondary CPUs ...
[    0.003517] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.003534] CPU1: Spectre v2: using BPIALL workaround
[    0.003668] smp: Brought up 1 node, 2 CPUs
[    0.003695] SMP: Total of 2 processors activated (400.00 BogoMIPS).
[    0.003714] CPU: All CPU(s) started in SVC mode.
[    0.004253] devtmpfs: initialized
[    0.008177] VFP support v0.3: implementor 41 architecture 3 part 30 
variant 9  rev 4
[    0.008388] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, ma x_idle_ns: 19112604462750000 ns
[    0.008426] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.009172] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.010014] DMA: preallocated 256 KiB pool for atomic coherent 
allocations
[    0.010998] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 
watchpoint  registers.
[    0.011030] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.029091] vgaarb: loaded
[    0.029322] SCSI subsystem initialized
[    0.029505] usbcore: registered new interface driver usbfs
[    0.029563] usbcore: registered new interface driver hub
[    0.029619] usbcore: registered new device driver usb
[    0.029847] usb_phy_generic soc:usbphy: supply vcc not found, using 
dummy reg ulator
[    0.030261] pps_core: LinuxPPS API ver. 1 registered
[    0.030285] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giome tti giometti@linux.it<mailto:giometti@linux.it>
[    0.030319] PTP clock support registered
[    0.030470] FPGA manager framework
[    0.031309] clocksource: Switched to clocksource timer1
[    0.065908] NET: Registered PF_INET protocol family
[    0.066131] IP idents hash table entries: 16384 (order: 5, 131072 
bytes, line ar)
[    0.067138] tcp_listen_portaddr_hash hash table entries: 512 (order: 
0, 6144  bytes, linear)
[    0.067193] TCP established hash table entries: 8192 (order: 3, 32768 
bytes,  linear)
[    0.067276] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, 
linear)
[    0.067400] TCP: Hash tables configured (established 8192 bind 8192)
[    0.067523] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.067580] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, 
linear)
[    0.067751] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.071713] RPC: Registered named UNIX socket transport module.
[    0.071746] RPC: Registered udp transport module.
[    0.071762] RPC: Registered tcp transport module.
[    0.071776] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.071799] PCI: CLS 0 bytes, default 64
[    0.725286] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 
counter s available
[    0.726528] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.732082] NFS: Registering the id_resolver key type
[    0.732133] Key type id_resolver registered
[    0.732151] Key type id_legacy registered
[    0.732174] Installing knfsd (copyright (C) 1996 
okir@monad.swb.de<mailto:okir@monad.swb.de>).
[    0.732909] ntfs: driver 2.1.32 [Flags: R/W].
[    0.733097] jffs2: version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
[    0.733690] bounce: pool size: 64 pages
[    0.733795] io scheduler mq-deadline registered
[    0.733816] io scheduler kyber registered
[    0.737748] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.738777] ffc02000.serial0: ttyS0 at MMIO 0xffc02000 (irq = 43, 
base_baud =  6250000) is a 16550A
[    1.377771] printk: console [ttyS0] enabled
[    1.382603] ffc03000.serial1: ttyS1 at MMIO 0xffc03000 (irq = 44, 
base_baud =  6250000) is a 16550A
[    1.393068] brd: module loaded
[    1.400992] loop: module loaded
[    1.407175] CAN device driver interface
[    1.411647] c_can_platform ffc00000.can: c_can_platform device 
registered (re gs=(ptrval), irq=30)
[    1.420796] socfpga-dwmac ff702000.ethernet: IRQ eth_wake_irq not found
[    1.427438] socfpga-dwmac ff702000.ethernet: IRQ eth_lpi not found
[    1.433718] socfpga-dwmac ff702000.ethernet: PTP uses main clock
[    1.439902] socfpga-dwmac ff702000.ethernet: Version ID not available
[    1.446361] socfpga-dwmac ff702000.ethernet:         DWMAC1000
[    1.451588] socfpga-dwmac ff702000.ethernet: DMA HW capability 
register suppo rted
[    1.459053] socfpga-dwmac ff702000.ethernet: RX Checksum Offload 
Engine suppo rted
[    1.466524] socfpga-dwmac ff702000.ethernet: COE Type 2
[    1.471743] socfpga-dwmac ff702000.ethernet: TX Checksum insertion 
supported
[    1.478770] socfpga-dwmac ff702000.ethernet: Enhanced/Alternate 
descriptors
[    1.485724] socfpga-dwmac ff702000.ethernet: Extended descriptors not 
support ed
[    1.493023] socfpga-dwmac ff702000.ethernet: Ring mode enabled
[    1.498848] socfpga-dwmac ff702000.ethernet: device MAC address 
0a:70:a0:4c:e 4:6f
[    1.514527] Micrel KSZ9021 Gigabit PHY stmmac-0:04: attached PHY 
driver (mii_ bus:phy_addr=stmmac-0:04, irq=POLL)
[    1.526181] dwc2 ffb40000.usb: supply vusb_d not found, using dummy 
regulator
[    1.533470] dwc2 ffb40000.usb: supply vusb_a not found, using dummy 
regulator
[    1.540831] dwc2 ffb40000.usb: EPs: 16, dedicated fifos, 8064 entries 
in SPRA M
[    1.548368] dwc2 ffb40000.usb: DWC OTG Controller
[    1.553116] dwc2 ffb40000.usb: new USB bus registered, assigned bus 
number 1
[    1.560172] dwc2 ffb40000.usb: irq 45, io mem 0xffb40000
[    1.566125] hub 1-0:1.0: USB hub found
[    1.569911] hub 1-0:1.0: 1 port detected
[    1.574627] usbcore: registered new interface driver usb-storage
[    1.580807] i2c_dev: i2c /dev entries driver
[    1.585982] Synopsys Designware Multimedia Card Interface Driver
[    1.592409] ledtrig-cpu: registered to indicate activity on CPUs
[    1.598541] usbcore: registered new interface driver usbhid
[    1.604129] usbhid: USB HID core driver
[    1.609205] NET: Registered PF_INET6 protocol family
[    1.615138] Segment Routing with IPv6
[    1.618827] In-situ OAM (IOAM) with IPv6
[    1.622844] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.629277] NET: Registered PF_PACKET protocol family
[    1.634369] NET: Registered PF_KEY protocol family
[    1.639152] can: controller area network core
[    1.643568] NET: Registered PF_CAN protocol family
[    1.648351] can: raw protocol
[    1.651328] can: broadcast manager protocol
[    1.655508] can: netlink gateway - max_hops=1
[    1.659989] 8021q: 802.1Q VLAN Support v1.8
[    1.664225] Key type dns_resolver registered
[    1.668566] ThumbEE CPU extension supported.
[    1.672846] Registering SWP/SWPB emulation handler
[    1.681725] at24 0-0051: supply vcc not found, using dummy regulator
[    1.689287] at24 0-0051: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    1.701762] rtc-ds1307 0-0068: registered as rtc0
[    1.708271] rtc-ds1307 0-0068: setting system clock to 
2018-03-17T01:43:02 UT C (1521250982)
[    1.720866] dma-pl330 ffe01000.pdma: Loaded driver for PL330 DMAC-341330
[    1.727602] dma-pl330 ffe01000.pdma:         DBUFF-512x8bytes 
Num_Chans-8 Num _Peri-32 Num_Events-8
[    1.736593] spi-nor spi1.0: found n25q512ax3, expected mt25qu02g
[    1.742662] dma-pl330 ffe01000.pdma: Reset Channel-0  CS-f FTC-40000
[    1.749048] spi-nor spi1.0: n25q512ax3 (65536 Kbytes)
[    1.754479] 2 fixed-partitions partitions found on MTD device 
ff705000.spi.0
[    1.761556] Creating 2 MTD partitions on "ff705000.spi.0":
[    1.767035] 0x000000000000-0x000000800000 : "Flash 0 Raw Data"
[    1.774038] 0x000000800000-0x000008000000 : "Flash 0 jffs2 Filesystem"
[    1.780562] mtd: partition "Flash 0 jffs2 Filesystem" extends beyond 
the end  of device "ff705000.spi.0" -- size truncated to 0x3800000
[    1.794865] dw_mmc ff704000.dwmmc0: IDMAC supports 32-bit address mode.
[    1.801560] dw_mmc ff704000.dwmmc0: Using internal DMA controller.
[    1.807737] dw_mmc ff704000.dwmmc0: Version ID is 240a
[    1.812917] dw_mmc ff704000.dwmmc0: DW MMC controller at irq 38,32 
bit host d ata width,1024 deep fifo
[    1.822428] dw_mmc ff704000.dwmmc0: Got CD GPIO
[    1.827005] mmc_host mmc0: card is polling.
[    1.841337] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 
400000Hz , actual 396825HZ div = 63)
[    1.865228] socfpga-dwmac ff702000.ethernet eth0: PHY [stmmac-0:04] 
driver [M icrel KSZ9021 Gigabit PHY] (irq=POLL)
[    1.875810] socfpga-dwmac ff702000.ethernet eth0: Register 
MEM_TYPE_PAGE_POOL  RxQ-0
[    1.886679] socfpga-dwmac ff702000.ethernet eth0: No Safety Features 
support  found
[    1.897468] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 
50000000 Hz, actual 50000000HZ div = 0)
[    1.904448] socfpga-dwmac ff702000.ethernet eth0: registered PTP clock
[    1.907277] mmc0: new high speed SDHC card at address 0001
[    1.919446] socfpga-dwmac ff702000.ethernet eth0: configuring for 
phy/rgmii l ink mode
[    1.919714] mmcblk0: mmc0:0001 SD8GB 7.24 GiB
[    1.933945]  mmcblk0: p1 p2 p3
[    6.072231] socfpga-dwmac ff702000.ethernet eth0: Link is Up - 
1Gbps/Full - f low control rx/tx
[    6.080856] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    6.131319] Sending DHCP requests .., OK
[    9.375268] IP-Config: Got DHCP answer from 10.122.105.2, my address 
is 10.12 2.105.45
[    9.383105] IP-Config: Complete:
[    9.386328]      device=eth0, hwaddr=0a:70:a0:4c:e4:6f, 
ipaddr=10.122.105.45,  mask=255.255.255.0, gw=10.122.105.1
[    9.396572]      host=10.122.105.45, domain=an.intel.com, 
nis-domain=(none)
[    9.403526]      bootserver=10.122.105.30, rootserver=10.122.105.166, 
rootpat h=
[    9.403536]      nameserver0=10.248.2.1, nameserver1=10.2.71.6, 
nameserver2=1 0.31.40.4
[    9.419206] dw-apb-uart ffc02000.serial0: forbid DMA for kernel console
[    9.440415] VFS: Mounted root (nfs filesystem) on device 0:13.
[    9.446908] devtmpfs: mounted
[    9.452213] Freeing unused kernel image (initmem) memory: 1024K
[    9.491560] Run /sbin/init as init process
INIT: version 2.88 booting
[    9.707166] random: fast init done
Starting Bootlog daemon: bootlogd.
mount: mounting 10.122.105.166:/home/dnguyen/rootfs_yocto on / failed: 
Invalid a rgument
Starting portmap daemon...
INIT: Entering runlevel: 5
Starting OpenBSD Secure Shell server: sshd
[   10.594905] random: sshd: uninitialized urandom read (32 bytes read)
done.
creating NFS state directory: done
starting 8 nfsd kernel threads: rpc.nfsd: unable to resolve ANYADDR:nfs 
to inet  address: Servname not supported for ai_socktype
rpc.nfsd: unable to set any sockets for nfsd
done
starting mountd: done
starting statd: done
Starting system log daemon...start-stop-daemon: can't execute 
'/sbin/syslogd': N o such file or directory
1
Starting kernel log daemon...start-stop-daemon: can't execute 
'/sbin/klogd': No  such file or directory
1
Starting Lighttpd Web Server: [   10.978345] random: lighttpd: 
uninitialized ura ndom read (4096 bytes read)
lighttpd.
Stopping Bootlog daemon: bootlogd.

Poky 8.0 (Yocto Project 1.3 Reference Distro) 1.3 socfpga_cyclone5 ttyS0

socfpga_cyclone5 login: root
login[158]: root login  on `ttyS0'

root@socfpga_cyclone5:~#
