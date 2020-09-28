Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1F27AA07
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgI1I4A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 04:56:00 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38875 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1I4A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Sep 2020 04:56:00 -0400
X-Greylist: delayed 4175 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 04:55:58 EDT
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5219E23E40;
        Mon, 28 Sep 2020 10:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601283357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Okg/8vp+zzsmnCMZvYIcfv0Dps7pb340pkA+BoMZ14=;
        b=OSFBGaOBXCXoCneOqm+6YrgMT7OUsnN62YMJ/yMfKvhH5NiKM3tlWApDfOJz2v71FEcvgS
        s2BFw0+cnqu5usnc2OlgMNnhB4x4UWAPUrfLCnS/9MKChDz6WlW2F37oCWAUUREeI6uZOK
        uzCByyB8M5zwGnGhE9PJE4Vlw6CNJzk=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3] spi: fsl-dspi: fix NULL pointer dereference
Date:   Mon, 28 Sep 2020 10:55:00 +0200
Message-Id: <20200928085500.28254-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove
path") this driver causes a kernel oops:

[    1.891065] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
[..]
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

This is because since this commit, the allocation of the drivers private
data is done explicitly and in this case spi_alloc_master() won't set the
correct pointer.

Also move the platform_set_drvdata() to have both next to each other.

Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
changes since v2:
 - trimmed the commit message, suggested by Krzysztof.

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

