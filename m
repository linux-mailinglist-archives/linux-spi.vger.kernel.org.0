Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213EB273E97
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIVJcs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgIVJcs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Sep 2020 05:32:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36DC061755
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 02:32:48 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0004VB-Vb; Tue, 22 Sep 2020 11:32:30 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0000WB-1U; Tue, 22 Sep 2020 11:32:30 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/6] Fix use-after-free in SPI drivers
Date:   Tue, 22 Sep 2020 11:32:22 +0200
Message-Id: <20200922093228.24917-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Several SPI drivers continue to use private driver data after it has
been freed in spi_unregister_controller(). This results in a
use-after-free trace in KASan, see below for an example on the fsl-dspi
driver. This series fixes this on all drivers which follow the same
pattern. It is runtime tested on a Layerscape SoC with the fsl-dspi
driver, patches for the other drivers have been compile tested only.

=================================================================
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

Sascha Hauer (6):
  spi: fsl-dspi: Use devm_spi_register_controller()
  spi: atmel-quadspi: Use devm_spi_register_controller()
  spi: bcm2835: Use devm_spi_register_controller()
  spi: dw: Use devm_spi_register_controller()
  spi: pxa2xx: Use devm_spi_register_controller()
  spi: rpc-if: Use devm_spi_register_controller()

 drivers/spi/atmel-quadspi.c | 3 +--
 drivers/spi/spi-bcm2835.c   | 4 +---
 drivers/spi/spi-dw-core.c   | 4 +---
 drivers/spi/spi-fsl-dspi.c  | 5 +----
 drivers/spi/spi-pxa2xx.c    | 4 +---
 drivers/spi/spi-rpc-if.c    | 3 +--
 6 files changed, 6 insertions(+), 17 deletions(-)

-- 
2.28.0

