Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1B44C4D4
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhKJQLg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKJQLf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 11:11:35 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A3C061764;
        Wed, 10 Nov 2021 08:08:47 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD8252223B;
        Wed, 10 Nov 2021 17:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1636560523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I/sw2fHYLNmbvIuORy+vioD4lwXP/w3fTznZEhQEVBc=;
        b=cjy7gre3QD9lNil6Qs5BOn/DEY4TYES2H49aApR8Pj/9jH8p1PFAWJeS6rm8thB5AA7pqY
        LJ9Lm2Tl00ZkjIWQqOkku1YGHDpPxUEW5l7iWINNaTtyoFrN/bjJMqfkcyqLw7S7oMdl04
        PW9bermQw+Hw04RSOGkxJ8CnP+0KaAg=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH] spi: fix use-after-free of the add_lock mutex
Date:   Wed, 10 Nov 2021 17:08:36 +0100
Message-Id: <20211110160836.3304104-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on
SPI buses") introduced a per-controller mutex. But mutex_unlock() of
said lock is called after the controller is already freed:

  spi_unregister_controller(ctlr)
   -> put_device(&ctlr->dev)
    -> spi_controller_release(dev)
  mutex_unlock(&ctrl->add_lock)

Move the put_device() after the mutex_unlock().

Fixes: 6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on SPI buses")
Signed-off-by: Michael Walle <michael@walle.cc>
---
I'm not sure if this is the correct fix. I don't know if the put_device()
will have to be protected by the add_lock (remember before, the add_lock
was a global lock).

For reference, the kernel oops is:
[   20.242505] Unable to handle kernel paging request at virtual address 0042a2203dc65260
[   20.250468] Mem abort info:
[   20.253270]   ESR = 0x96000044
[   20.256332]   EC = 0x25: DABT (current EL), IL = 32 bits
[   20.261662]   SET = 0, FnV = 0
[   20.264723]   EA = 0, S1PTW = 0
[   20.267869]   FSC = 0x04: level 0 translation fault
[   20.272764] Data abort info:
[   20.275646]   ISV = 0, ISS = 0x00000044
[   20.279494]   CM = 0, WnR = 1
[   20.282469] [0042a2203dc65260] address between user and kernel address ranges
[   20.289632] Internal error: Oops: 96000044 [#1] SMP
[   20.294525] Modules linked in:
[   20.297586] CPU: 1 PID: 1546 Comm: init Not tainted 5.15.0-next-20211109+ #1307
[   20.304919] Hardware name: Kontron KBox A-230-LS (DT)
[   20.309983] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   20.316968] pc : queued_spin_lock_slowpath+0x1a8/0x3a0
[   20.322127] lr : __mutex_unlock_slowpath.constprop.0+0x180/0x190
[   20.328156] sp : ffff800013c23b80
[   20.331475] x29: ffff800013c23b80 x28: ffff002003941040 x27: 0000000000000000
[   20.338639] x26: ffff002000e49c90 x25: ffff80001167de48 x24: ffff800011f55578
[   20.345802] x23: ffff002002b1d350 x22: 0000000000000002 x21: 0000000000000001
[   20.352964] x20: ffff800013c23bb8 x19: ffff002002b1d350 x18: 00000000fffffffb
[   20.360126] x17: 0000000000000001 x16: 0000000000000001 x15: 0000000000000020
[   20.367288] x14: 0000000000000001 x13: 0000000000000000 x12: ffff002002c27938
[   20.374450] x11: ffff002002c27908 x10: 0000000000000000 x9 : 0000000000080000
[   20.381612] x8 : 0000000000000000 x7 : ffff00207f7b7a00 x6 : ffff8000119d1a00
[   20.388774] x5 : ffff00207f7b7a00 x4 : 504322202c293830 x3 : ffff002002b1d358
[   20.395936] x2 : ffff8000119d1a30 x1 : ffff8000119d1a30 x0 : ffff00207f7b7a08
[   20.403098] Call trace:
[   20.405546]  queued_spin_lock_slowpath+0x1a8/0x3a0
[   20.410352]  mutex_unlock+0x5c/0x70
[   20.413849]  spi_unregister_controller+0xf0/0x170
[   20.418568]  dspi_remove+0x28/0xb0
[   20.421978]  dspi_shutdown+0x1c/0x30
[   20.425561]  platform_shutdown+0x30/0x40
[   20.429495]  device_shutdown+0x14c/0x420
[   20.433427]  __do_sys_reboot+0x214/0x29c
[   20.437361]  __arm64_sys_reboot+0x30/0x40
[   20.441380]  invoke_syscall+0x50/0x120
[   20.445140]  el0_svc_common.constprop.0+0x58/0x190
[   20.449944]  do_el0_svc+0x30/0x94
[   20.453267]  el0_svc+0x20/0x90
[   20.456327]  el0t_64_sync_handler+0x1a4/0x1b0
[   20.460694]  el0t_64_sync+0x1a0/0x1a4
[   20.464368] Code: 910020e0 8b0200c2 f861d884 aa0203e1 (f8246827) 
[   20.470479] ---[ end trace 9ee0c21f9e4bc5d5 ]---
[   21.475251] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
[   21.482940] Kernel Offset: disabled
[   21.486433] CPU features: 0x2,000001c2,40000846
[   21.490976] Memory Limit: none
[   21.494036] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---

 drivers/spi/spi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b23e675953e1..fdd530b150a7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3099,12 +3099,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	device_del(&ctlr->dev);
 
-	/* Release the last reference on the controller if its driver
-	 * has not yet been converted to devm_spi_alloc_master/slave().
-	 */
-	if (!ctlr->devm_allocated)
-		put_device(&ctlr->dev);
-
 	/* free bus id */
 	mutex_lock(&board_lock);
 	if (found == ctlr)
@@ -3113,6 +3107,12 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
 		mutex_unlock(&ctlr->add_lock);
+
+	/* Release the last reference on the controller if its driver
+	 * has not yet been converted to devm_spi_alloc_master/slave().
+	 */
+	if (!ctlr->devm_allocated)
+		put_device(&ctlr->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
-- 
2.30.2

