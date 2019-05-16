Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2DE20346
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPKRf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 06:17:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53458 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKRf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 06:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dw4n1CRUmr0TOcqF8BkUbKvooQyZdTTXk/zrQRua+xU=; b=mYKTtYOBVMxt
        ++UfUygP9UnJ7Ioz3qu5TQ173UlSDEZzN6A+/8t2BL4R1cSUIcD1ev3Zlf7/Zq/LIKkHoSfXTwZMq
        CuYthRbo+7VofzKNje1MeaFu7PWvqeW9jyjbafzp1mvWayz8S7tmujZdR/ZmGL3Li+fZZ1kBNHA3y
        tM+5c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRDS3-00062P-Ix; Thu, 16 May 2019 10:17:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 291021126D45; Thu, 16 May 2019 11:17:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     albeu@free.fr, axel.lin@ingics.com, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bitbang: Fix NULL pointer dereference in spi_unregister_master" to the spi tree
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190516101722.291021126D45@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 11:17:22 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: bitbang: Fix NULL pointer dereference in spi_unregister_master

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5caaf29af5ca82d5da8bc1d0ad07d9e664ccf1d8 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 16 May 2019 15:56:56 +0800
Subject: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master

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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 4243e53f9f7b..e8fd95276315 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -415,7 +415,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	if (ret)
 		spi_master_put(master);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_start);
 
-- 
2.20.1

