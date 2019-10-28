Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF4E742E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2019 15:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbfJ1O45 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Oct 2019 10:56:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40088 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390461AbfJ1O44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Oct 2019 10:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=le0uDCgGujH8CUVq/g9+3lWEiEFwcja0kTihGY6f+ic=; b=qqJ1uci6dSdK
        xT4wb+ckK/TxS2XswsvYaKZ0cQFhSbNytK+Dgbs8yg3AyCdAT8W87Dtk9W9u3rheKL1ETKcxQd0ku
        3Ujgleaq2Tw8PB3vVMu9H9jgbfWhvU2WVXP9gBruNVxQAMQTPQnrh2LqX+bv+WzpDQ5o4dU0TFlhv
        6UUmQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Ru-0008Tn-QH; Mon, 28 Oct 2019 14:56:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 137E127403E4; Mon, 28 Oct 2019 14:56:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lingling Xu <ling_ling.xu@unisoc.com>
Cc:     baolin.wang7@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        baolin.wang@linaro.org, broonie@kernel.org,
        ling_ling.xu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: Applied "spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting" to the spi tree
In-Reply-To: <5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20191028145650.137E127403E4@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:49 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 1d00a67c2da2d8d82e6dcc5b398d9f6db656d9be Mon Sep 17 00:00:00 2001
From: Lingling Xu <ling_ling.xu@unisoc.com>
Date: Mon, 28 Oct 2019 18:10:31 +0800
Subject: [PATCH] spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting

When rebooting system, the PMIC watchdog time loading may not be loaded
correctly when another system is feeding the PMIC watchdog, since we did
not check the watchdog busy status before loading time values.

Thus we should set the BIT_WDG_NEW bit before loading time values, that
can support multiple loads without checking busy status to make sure the
time values can be loaded successfully to avoid this potential issue.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9613cfe3c0a2..87dadb6b8ebf 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -77,6 +77,7 @@
 
 /* Bits definitions for register REG_WDG_CTRL */
 #define BIT_WDG_RUN			BIT(1)
+#define BIT_WDG_NEW			BIT(2)
 #define BIT_WDG_RST			BIT(3)
 
 /* Registers definitions for PMIC */
@@ -383,6 +384,10 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	/* Unlock the watchdog */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
+	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	val |= BIT_WDG_NEW;
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+
 	/* Load the watchdog timeout value, 50ms is always enough. */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-- 
2.20.1

