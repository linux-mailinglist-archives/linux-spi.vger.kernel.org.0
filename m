Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473A127A989
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgI1Ics (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1Ics (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Sep 2020 04:32:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE6C0613CE;
        Mon, 28 Sep 2020 01:32:47 -0700 (PDT)
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A2B9723E40;
        Mon, 28 Sep 2020 10:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601281966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=84nf58r4xfqTwvxmnC0LUvWYNLFQ3GSFYprQkKFhSqI=;
        b=gluXADInXin5bmV70jihLsfY0tV16qLmrz3jGsppU9+j064Gk8CGdIADcdW8o6QamrE92B
        lweLrYiOp3FPnPFZ2cwa40pkHRT7Tq24A1VGAmg0Ehd6jFF4dE/Ebl4d1YgstXPRlFFnbp
        IQ6JmsbI96aVnDHNN/x8uZgr5ZmpGs0=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] spi: fsl-dspi: fix NULL pointer dereference
Date:   Mon, 28 Sep 2020 10:32:38 +0200
Message-Id: <20200928083238.27137-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove
path") this driver causes a kernel oops:

[    1.891065] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
[    1.899889] Mem abort info:
[    1.902692]   ESR = 0x96000004
[    1.905754]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.911089]   SET = 0, FnV = 0
[    1.914156]   EA = 0, S1PTW = 0
[    1.917303] Data abort info:
[    1.920193]   ISV = 0, ISS = 0x00000004
[    1.924044]   CM = 0, WnR = 0
[    1.927022] [0000000000000080] user address but active_mm is swapper
[    1.933403] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    1.938995] Modules linked in:
[    1.942060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc6-next-20200925-00026-gae556cc74e28-dirty #94
[    1.951838] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
[    1.960135] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[    1.966168] pc : dspi_setup+0xc8/0x2e0
[    1.969926] lr : dspi_setup+0xbc/0x2e0
[    1.973684] sp : ffff80001139b930
[    1.977005] x29: ffff80001139b930 x28: ffff00207a5d2000
[    1.982338] x27: 0000000000000006 x26: ffff00207a44d410
[    1.987669] x25: ffff002079c08100 x24: ffff00207a5d2400
[    1.993000] x23: ffff00207a5d2600 x22: ffff800011169948
[    1.998332] x21: ffff800010cbcd20 x20: ffff00207a58a800
[    2.003663] x19: ffff00207a76b700 x18: 0000000000000010
[    2.008994] x17: 0000000000000001 x16: 0000000000000019
[    2.014326] x15: ffffffffffffffff x14: 0720072007200720
[    2.019657] x13: 0720072007200720 x12: ffff8000111fc5e0
[    2.024989] x11: 0000000000000003 x10: ffff8000111e45a0
[    2.030320] x9 : 0000000000000000 x8 : ffff00207a76b780
[    2.035651] x7 : 0000000000000000 x6 : 000000000000003f
[    2.040982] x5 : 0000000000000040 x4 : ffff80001139b918
[    2.046313] x3 : 0000000000000001 x2 : 64b62cc917af5100
[    2.051643] x1 : 0000000000000000 x0 : 0000000000000000
[    2.056973] Call trace:
[    2.059425]  dspi_setup+0xc8/0x2e0
[    2.062837]  spi_setup+0xcc/0x248
[    2.066160]  spi_add_device+0xb4/0x198
[    2.069918]  of_register_spi_device+0x250/0x370
[    2.074462]  spi_register_controller+0x4f4/0x770
[    2.079094]  dspi_probe+0x5bc/0x7b0
[    2.082594]  platform_drv_probe+0x5c/0xb0
[    2.086615]  really_probe+0xec/0x3c0
[    2.090200]  driver_probe_device+0x60/0xc0
[    2.094308]  device_driver_attach+0x7c/0x88
[    2.098503]  __driver_attach+0x60/0xe8
[    2.102263]  bus_for_each_dev+0x7c/0xd0
[    2.106109]  driver_attach+0x2c/0x38
[    2.109692]  bus_add_driver+0x194/0x1f8
[    2.113538]  driver_register+0x6c/0x128
[    2.117385]  __platform_driver_register+0x50/0x60
[    2.122105]  fsl_dspi_driver_init+0x24/0x30
[    2.126302]  do_one_initcall+0x54/0x2d0
[    2.130149]  kernel_init_freeable+0x1ec/0x258
[    2.134520]  kernel_init+0x1c/0x120
[    2.138018]  ret_from_fork+0x10/0x34
[    2.141606] Code: 97e0b11d aa0003f3 b4000680 f94006e0 (f9404000)
[    2.147723] ---[ end trace 26cf63e6cbba33a8 ]---
[    2.152374] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.160061] SMP: stopping secondary CPUs
[    2.163999] Kernel Offset: disabled
[    2.167496] CPU features: 0x0040022,20006008
[    2.171777] Memory Limit: none
[    2.174840] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

This is because since this commit, the allocation of the drivers private
data is done explicitly and in this case spi_alloc_master() won't set the
correct pointer.

Also move the platform_set_drvdata() to have both next to each other.

Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
---

changes since v1:
 - moved platform_set_drvdata(), suggested by Krzysztof.

 drivers/spi/spi-fsl-dspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a939618f5e47..3967afa465f0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1236,6 +1236,9 @@ static int dspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
+	spi_controller_set_devdata(ctlr, dspi);
+	platform_set_drvdata(pdev, dspi);
+
 	dspi->pdev = pdev;
 	dspi->ctlr = ctlr;
 
@@ -1371,8 +1374,6 @@ static int dspi_probe(struct platform_device *pdev)
 	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
 		ctlr->ptp_sts_supported = true;
 
-	platform_set_drvdata(pdev, dspi);
-
 	ret = spi_register_controller(ctlr);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
-- 
2.20.1

