Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80C24335C7
	for <lists+linux-spi@lfdr.de>; Tue, 19 Oct 2021 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhJSMVi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Oct 2021 08:21:38 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35705 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhJSMVh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Oct 2021 08:21:37 -0400
Received: by mail-il1-f199.google.com with SMTP id q17-20020a92c011000000b00259ba4244faso602953ild.2
        for <linux-spi@vger.kernel.org>; Tue, 19 Oct 2021 05:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u4h+JasE+UgdWU3HgmCdpjnPSgHQ+U9Mz1BP3T6NEMw=;
        b=DQF6z85NsVmJfUA6mucyKrb2HGi6YOgfQd9rF8ywR3dGrxUR7dQUZUQGc2bdkwz7MP
         di+pTDAgv7IY0XgwGuXpausOTN2yyjdg/jqzyvxlu5gcz8WDbSUQkKscVrq9aYId39NV
         yC73QxFKR0wnm6ysVc0BwWV1u5aUsoEfT1tdugtN/bhxb2Xv8q8zdHUKX+2DSeQyjUhQ
         lO3edUCjjHWK2NbrHsg8IoFLgyyfyeZb3W7CqfBtlysT4w1Oexi044qpp0//rHTD+W+5
         l4JAUQnzcQ0qAx8tF81iKsMmr/HgLDZSObjsgxVmrU1KahbmrTdk/smqTJzIlWZ08sp+
         YFSQ==
X-Gm-Message-State: AOAM531iUcMUmbtRN0HknAVYEPDXFfGTqSh2La38UL3tSF66SpJQQd1N
        BDkyWKejZUtZKTs20c/tj2SKX2T9ajNVgEERGME4J7+nqOX1
X-Google-Smtp-Source: ABdhPJx1Vk6JadIa2t3ny/l1kHXliDoJe0WB9QAcGBrOhvzGY7nnck+m3MN2JzJGL+psrrZaZ4qfgASwFEOlzZNaUrFgthSCJ1Fl
MIME-Version: 1.0
X-Received: by 2002:a02:5444:: with SMTP id t65mr4003610jaa.42.1634645964820;
 Tue, 19 Oct 2021 05:19:24 -0700 (PDT)
Date:   Tue, 19 Oct 2021 05:19:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011175a05ceb3ac4f@google.com>
Subject: [syzbot] WARNING: held lock freed in spi_unregister_controller
From:   syzbot <syzbot+5fcfdc26bc84536f79bd@syzkaller.appspotmail.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e871ccb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
dashboard link: https://syzkaller.appspot.com/bug?extid=5fcfdc26bc84536f79bd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1185f368b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127697f4b00000

Bisection is inconclusive: the first bad commit could be any of:

0ee50b47532a namei: change filename_parentat() calling conventions
584d3226d665 namei: make do_mkdirat() take struct filename

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1195e010b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fcfdc26bc84536f79bd@syzkaller.appspotmail.com

usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
msi2500 1-1:0.0: Registered as swradio16
msi2500 1-1:0.0: SDR API is still slightly experimental and functionality changes may follow
usb 1-1: USB disconnect, device number 2
=========================
WARNING: held lock freed!
5.15.0-rc5-next-20211015-syzkaller #0 Not tainted
-------------------------
kworker/0:3/6868 is freeing memory ffff88801c10e000-ffff88801c10efff, with a lock still held there!
ffff88801c10e668 (&ctlr->add_lock){+.+.}-{3:3}, at: spi_unregister_controller+0x57/0x3b0 drivers/spi/spi.c:3084
8 locks held by kworker/0:3/6868:
 #0: ffff88814159ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88814159ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88814159ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88814159ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff88814159ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88814159ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2268
 #1: ffffc900033cfdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2272
 #2: ffff888147a51220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888147a51220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88806dfad220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88806dfad220 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x78e drivers/usb/core/hub.c:2216
 #4: ffff888076e1d1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff888076e1d1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
 #4: ffff888076e1d1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
 #4: ffff888076e1d1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1259
 #5: ffff88801c10cd38 (&dev->vb_queue_lock){+.+.}-{3:3}, at: msi2500_disconnect+0x5d/0x160 drivers/media/usb/msi2500/msi2500.c:571
 #6: ffff88801c10cca8 (&dev->v4l2_lock){+.+.}-{3:3}, at: msi2500_disconnect+0x67/0x160 drivers/media/usb/msi2500/msi2500.c:572
 #7: ffff88801c10e668 (&ctlr->add_lock){+.+.}-{3:3}, at: spi_unregister_controller+0x57/0x3b0 drivers/spi/spi.c:3084

stack backtrace:
CPU: 0 PID: 6868 Comm: kworker/0:3 Not tainted 5.15.0-rc5-next-20211015-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_freed_lock_bug kernel/locking/lockdep.c:6388 [inline]
 debug_check_no_locks_freed.cold+0x9d/0xa9 kernel/locking/lockdep.c:6421
 slab_free_hook mm/slub.c:1672 [inline]
 slab_free_freelist_hook+0x73/0x1c0 mm/slub.c:1726
 slab_free mm/slub.c:3491 [inline]
 kfree+0xf6/0x560 mm/slub.c:4539
 device_release+0x9f/0x240 drivers/base/core.c:2230
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3501
 spi_unregister_controller+0x2a8/0x3b0 drivers/spi/spi.c:3106
 msi2500_disconnect+0xd2/0x160 drivers/media/usb/msi2500/msi2500.c:577
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5199 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1183 [inline]
BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0xa6/0x5e0 kernel/locking/mutex.c:901
Read of size 8 at addr ffff88801c10e600 by task kworker/0:3/6868

CPU: 0 PID: 6868 Comm: kworker/0:3 Not tainted 5.15.0-rc5-next-20211015-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1183 [inline]
 __mutex_unlock_slowpath+0xa6/0x5e0 kernel/locking/mutex.c:901
 msi2500_disconnect+0xd2/0x160 drivers/media/usb/msi2500/msi2500.c:577
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5199 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Allocated by task 6868:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 __spi_alloc_controller+0x35/0x310 drivers/spi/spi.c:2665
 spi_alloc_master include/linux/spi/spi.h:726 [inline]
 msi2500_probe+0x679/0xbf0 drivers/media/usb/msi2500/msi2500.c:1223
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3394
 usb_set_configuration+0x101e/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3394
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5348 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 6868:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1726
 slab_free mm/slub.c:3491 [inline]
 kfree+0xf6/0x560 mm/slub.c:4539
 device_release+0x9f/0x240 drivers/base/core.c:2230
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3501
 spi_unregister_controller+0x2a8/0x3b0 drivers/spi/spi.c:3106
 msi2500_disconnect+0xd2/0x160 drivers/media/usb/msi2500/msi2500.c:577
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3581
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5199 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff88801c10e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1536 bytes inside of
 4096-byte region [ffff88801c10e000, ffff88801c10f000)
The buggy address belongs to the page:
page:ffffea0000704200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c108
head:ffffea0000704200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888010c42140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6530, ts 69622938520, free_ts 69608701256
 prep_new_page mm/page_alloc.c:2416 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4147
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5386
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 alloc_slab_page mm/slub.c:1770 [inline]
 allocate_slab mm/slub.c:1907 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1970
 ___slab_alloc+0x947/0x1040 mm/slub.c:3001
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3088
 slab_alloc_node mm/slub.c:3179 [inline]
 slab_alloc mm/slub.c:3220 [inline]
 kmem_cache_alloc_trace+0x300/0x3b0 mm/slub.c:3237
 kmalloc include/linux/slab.h:590 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x18a/0x1ee0 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x34d/0xf00 security/tomoyo/common.c:2097
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x419/0x590 security/tomoyo/file.c:734
 security_file_ioctl+0x50/0xb0 security/security.c:1540
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb3/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1336 [inline]
 free_pcp_prepare+0x373/0x870 mm/page_alloc.c:1387
 free_unref_page_prepare mm/page_alloc.c:3307 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3386
 __unfreeze_partials+0x343/0x360 mm/slub.c:2502
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3212 [inline]
 __kmalloc_node+0x242/0x370 mm/slub.c:4445
 kmalloc_node include/linux/slab.h:613 [inline]
 kvmalloc_node+0x61/0x120 mm/util.c:587
 kvmalloc include/linux/slab.h:741 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x7e7/0x1240 fs/seq_file.c:210
 kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
 call_read_iter include/linux/fs.h:2153 [inline]
 new_sync_read+0x421/0x6e0 fs/read_write.c:404
 vfs_read+0x35c/0x600 fs/read_write.c:485
 ksys_read+0x12d/0x250 fs/read_write.c:623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88801c10e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801c10e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801c10e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801c10e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801c10e700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
