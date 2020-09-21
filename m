Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7B2721D3
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIULII (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 07:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIULII (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Sep 2020 07:08:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56BEC061755
        for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2020 04:08:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKJfy-0004B2-5u; Mon, 21 Sep 2020 13:08:06 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKJfx-0004TE-OR; Mon, 21 Sep 2020 13:08:05 +0200
Date:   Mon, 21 Sep 2020 13:08:05 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: users of spi_unregister_controller() broken?
Message-ID: <20200921110805.GI21278@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:48:16 up 214 days, 18:18, 150 users,  load average: 0.04, 0.11,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

I see the following KASan use-after-free messages from the fsl-dspi
driver. It seems that after spi_unregister_controller() has been called
no references to the SPI controller device are left and the device is
freed in spi_controller_release(). This also frees the driver data
structure which is allocated with spi_alloc_master(). Nevertheless all
users of spi_unregister_controller() still use their driver data after
having called spi_unregister_controller().

Any idea what to do about this?

Sascha

==================================================================
BUG: KASAN: use-after-free in dspi_remove+0x48/0x1f8
Read of size 8 at addr ffff0009301b7610 by task systemd-shutdow/1

CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 5.9.0-rc2-00019-g74a89d7f9ed7 #22
Hardware name: TQ TQMLS1046A SoM on Arkona AT1130 (C300) board (DT)
Call trace:
 dump_backtrace+0x0/0x2b0
 show_stack+0x14/0x20
 dump_stack+0xe8/0x150
 print_address_description.constprop.0+0x6c/0x4e0
 kasan_report+0x130/0x1f8
 __asan_load8+0x88/0xc0
 dspi_remove+0x48/0x1f8
 dspi_shutdown+0xc/0x18
 platform_drv_shutdown+0x34/0x40
 device_shutdown+0x1ec/0x420
 kernel_restart_prepare+0x40/0x50
 kernel_restart+0x14/0x60
 __do_sys_reboot+0x294/0x2c0
 __arm64_sys_reboot+0x50/0x60
 el0_svc_common.constprop.0+0xa0/0x1d8
 do_el0_svc_compat+0x2c/0x58
 el0_sync_compat_handler+0x94/0x184
 el0_sync_compat+0x144/0x180

Allocated by task 1:
 kasan_save_stack+0x24/0x50
 __kasan_kmalloc.isra.0+0xc0/0xe0
 kasan_kmalloc+0xc/0x18
 __kmalloc+0x208/0x360
 __spi_alloc_controller+0x2c/0xe8
 dspi_probe+0xb0/0xcc8
 platform_drv_probe+0x6c/0xc8
 really_probe+0x144/0x510
 driver_probe_device+0xc8/0xe0
 device_driver_attach+0x94/0xa0
 __driver_attach+0x70/0x110
 bus_for_each_dev+0xe4/0x158
 driver_attach+0x30/0x40
 bus_add_driver+0x21c/0x2b8
 driver_register+0xbc/0x1d0
 __platform_driver_register+0x7c/0x88
 fsl_dspi_driver_init+0x18/0x20
 do_one_initcall+0xa4/0x24c
 kernel_init_freeable+0x26c/0x2d4
 kernel_init+0x10/0x11c
 ret_from_fork+0x10/0x18

Freed by task 1:
 kasan_save_stack+0x24/0x50
 kasan_set_track+0x24/0x38
 kasan_set_free_info+0x20/0x40
 __kasan_slab_free+0xfc/0x170
 kasan_slab_free+0x10/0x18
 kfree+0xac/0x318
 spi_controller_release+0xc/0x18
 device_release+0x7c/0xf0
 kobject_put+0xa4/0x170
 device_unregister+0x20/0x30
 spi_unregister_controller+0x104/0x178
 dspi_remove+0x40/0x1f8
 dspi_shutdown+0xc/0x18
 platform_drv_shutdown+0x34/0x40
 device_shutdown+0x1ec/0x420
 kernel_restart_prepare+0x40/0x50
 kernel_restart+0x14/0x60
 __do_sys_reboot+0x294/0x2c0
 __arm64_sys_reboot+0x50/0x60
 el0_svc_common.constprop.0+0xa0/0x1d8
 do_el0_svc_compat+0x2c/0x58
 el0_sync_compat_handler+0x94/0x184
 el0_sync_compat+0x144/0x180

The buggy address belongs to the object at ffff0009301b7000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1552 bytes inside of
 2048-byte region [ffff0009301b7000, ffff0009301b7800)
The buggy address belongs to the page:
page:00000000debc463d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9b01b0
head:00000000debc463d order:3 compound_mapcount:0 compound_pincount:0
flags: 0x2ffff00000010200(slab|head)
raw: 2ffff00000010200 dead000000000100 dead000000000122 ffff000932003680
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0009301b7500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0009301b7580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0009301b7600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff0009301b7680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0009301b7700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
