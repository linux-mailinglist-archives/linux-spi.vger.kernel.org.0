Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227B2200BB
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfEPH5V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 03:57:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPH5V (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 May 2019 03:57:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 191AD6544DF4DFBF316D;
        Thu, 16 May 2019 15:57:19 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 15:57:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <albeu@free.fr>, <lorenzo.bianconi@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
Date:   Thu, 16 May 2019 15:56:56 +0800
Message-ID: <20190516075656.25880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If spi_register_master fails in spi_bitbang_start
because device_add failure, We should return the
error code other than 0, otherwise calling
spi_bitbang_stop may trigger NULL pointer dereference
like this:

BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x45/0xd0
Read of size 8 at addr 0000000000000000 by task syz-executor.0/3661

CPU: 0 PID: 3661 Comm: syz-executor.0 Not tainted 5.1.0+ #28
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0xa9/0x10e
 ? __list_del_entry_valid+0x45/0xd0
 ? __list_del_entry_valid+0x45/0xd0
 __kasan_report+0x171/0x18d
 ? __list_del_entry_valid+0x45/0xd0
 kasan_report+0xe/0x20
 __list_del_entry_valid+0x45/0xd0
 spi_unregister_controller+0x99/0x1b0
 spi_lm70llp_attach+0x3ae/0x4b0 [spi_lm70llp]
 ? 0xffffffffc1128000
 ? klist_next+0x131/0x1e0
 ? driver_detach+0x40/0x40 [parport]
 port_check+0x3b/0x50 [parport]
 bus_for_each_dev+0x115/0x180
 ? subsys_dev_iter_exit+0x20/0x20
 __parport_register_driver+0x1f0/0x210 [parport]
 ? 0xffffffffc1150000
 do_one_initcall+0xb9/0x3b5
 ? perf_trace_initcall_level+0x270/0x270
 ? kasan_unpoison_shadow+0x30/0x40
 ? kasan_unpoison_shadow+0x30/0x40
 do_init_module+0xe0/0x330
 load_module+0x38eb/0x4270
 ? module_frob_arch_sections+0x20/0x20
 ? kernel_read_file+0x188/0x3f0
 ? find_held_lock+0x6d/0xd0
 ? fput_many+0x1a/0xe0
 ? __do_sys_finit_module+0x162/0x190
 __do_sys_finit_module+0x162/0x190
 ? __ia32_sys_init_module+0x40/0x40
 ? __mutex_unlock_slowpath+0xb4/0x3f0
 ? wait_for_completion+0x240/0x240
 ? vfs_write+0x160/0x2a0
 ? lockdep_hardirqs_off+0xb5/0x100
 ? mark_held_locks+0x1a/0x90
 ? do_syscall_64+0x14/0x2a0
 do_syscall_64+0x72/0x2a0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 702a4879ec33 ("spi: bitbang: Let spi_bitbang_start() take a reference to master")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index dd9a8c54..be95be4 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -403,7 +403,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	if (ret)
 		spi_master_put(master);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_start);
 
-- 
1.8.3.1


