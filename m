Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38976562
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfGZMMi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 08:12:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfGZMMh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EyTcmkaxIVBIMz3VoCoT3OSxpRCKeYj4J4P9xwOIfLw=; b=HHvRJaBignUu
        jLe9O7KYKpqnKoC4Su73djWg0V/BAycEVjyq6h3FAqF28APpeT0KhOO9AwPjAKQx0R5EoIwifLE6/
        W/EdsHkTd3YrX/x4wZaWTuugz/ZVQ0fJuKr3vVUwLALshfmDYw07CyAgwLmjDriPJVgP2tD91uxy+
        kYJpU=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqz5E-0001aR-Ne; Fri, 26 Jul 2019 12:12:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0FE5C2742B9F; Fri, 26 Jul 2019 13:12:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sherry Zong <sherry.zong@unisoc.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, robh+dt@kernel.org, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, weicx@spreadst.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: sprd: adi: Add a reset reason for watchdog mode" to the spi tree
In-Reply-To: <1563f3de43c6c2262d597a25d6138b5de61ea23d.1564125131.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190726121224.0FE5C2742B9F@ypsilon.sirena.org.uk>
Date:   Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: adi: Add a reset reason for watchdog mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From e6d722ca09c1eebba5660e58b6bcac30c1ccc7ca Mon Sep 17 00:00:00 2001
From: Sherry Zong <sherry.zong@unisoc.com>
Date: Fri, 26 Jul 2019 15:20:51 +0800
Subject: [PATCH] spi: sprd: adi: Add a reset reason for watchdog mode

When the system was rebooted by watchdog, now we did not save the watchdog
reset mode which will make system enter a incorrect mode after rebooting.

Thus we should set the watchdog reset mode as default when opening the
watchdog configuration, that means if the system was rebooted by other
reason through the restart_handler(), then we will clear the default
watchdog reset mode to save the correct reset mode.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/1563f3de43c6c2262d597a25d6138b5de61ea23d.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 509ce6943adc..0d767eb67fcf 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -99,6 +99,7 @@
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
 #define HWRST_STATUS_FACTORYTEST	0xe0
+#define HWRST_STATUS_WATCHDOG		0xf0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -309,6 +310,18 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return 0;
 }
 
+static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
+{
+#ifdef CONFIG_SPRD_WATCHDOG
+	u32 val;
+
+	/* Set default watchdog reboot mode */
+	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val |= HWRST_STATUS_WATCHDOG;
+	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
+#endif
+}
+
 static int sprd_adi_restart_handler(struct notifier_block *this,
 				    unsigned long mode, void *cmd)
 {
@@ -347,6 +360,7 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 
 	/* Record the reboot mode */
 	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val &= ~HWRST_STATUS_WATCHDOG;
 	val |= reboot_mode;
 	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
 
@@ -475,6 +489,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	}
 
 	sprd_adi_hw_init(sadi);
+	sprd_adi_set_wdt_rst_mode(sadi);
 
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
-- 
2.20.1

