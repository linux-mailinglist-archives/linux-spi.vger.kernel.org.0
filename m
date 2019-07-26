Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C59B67656F
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfGZMMt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 08:12:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfGZMMh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QFyNsBYUDBAHIzrPox44pwuc+XGAKO01u83Rw2A0Shk=; b=URY8uHdkgOUK
        w04LlThdxDwnYE8JX/TnI2p0iFXzNweCVjtM4LzRZyphA1McGF4jPqoShhY/vU19ce0tv1JgbQoQj
        fHJn5x8/PzfrFszK17wUU4729ye10oigKLKg4I1di+FJpF9/CBSueYauyLtgKZyghlS0GfmM5sH0p
        vnZns=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqz5E-0001aV-PR; Fri, 26 Jul 2019 12:12:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 491122742B63; Fri, 26 Jul 2019 13:12:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sherry Zong <sherry.zong@unisoc.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, robh+dt@kernel.org, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, weicx@spreadst.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: sprd: adi: Add a reset reason for factory test mode" to the spi tree
In-Reply-To: <8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190726121224.491122742B63@ypsilon.sirena.org.uk>
Date:   Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: adi: Add a reset reason for factory test mode

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

From 9d9aa1cc91d68e2140e5948c15947b8254e008e2 Mon Sep 17 00:00:00 2001
From: Sherry Zong <sherry.zong@unisoc.com>
Date: Fri, 26 Jul 2019 15:20:50 +0800
Subject: [PATCH] spi: sprd: adi: Add a reset reason for factory test mode

Add a new reset flag to indicate that the system need enter factory test
mode after restarting system.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0b3f23ad6479..509ce6943adc 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -98,6 +98,7 @@
 #define HWRST_STATUS_AUTODLOADER	0xa0
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_FACTORYTEST	0xe0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -339,6 +340,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_SPRDISK;
 	else if (!strncmp(cmd, "tospanic", 8))
 		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strncmp(cmd, "factorytest", 11))
+		reboot_mode = HWRST_STATUS_FACTORYTEST;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
2.20.1

