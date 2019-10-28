Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D9E742D
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2019 15:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbfJ1O45 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Oct 2019 10:56:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390462AbfJ1O44 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Oct 2019 10:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fhBvWtiG5AkvXJoQu4Sk0v43zUYuwbBg8njCoI45aaQ=; b=ERor1d7EYaK6
        1hX4DbuhxvUkGSGkFx92Dp9uPkE32lk8e9RS4RwYaX5sZNF9rU9jntFeukqVwhXKP5WxI8N7EOK1e
        htysfS7faUjn01WvhLt6LYk/I5XwiYaQVphwxQ0OezZh4eRNQmWw/Fd3x5LTl6/EW8t36ankVi8fN
        4QNzc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Rv-0008Tp-1K; Mon, 28 Oct 2019 14:56:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4A9B627403EE; Mon, 28 Oct 2019 14:56:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lingling Xu <ling_ling.xu@unisoc.com>
Cc:     baolin.wang7@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        baolin.wang@linaro.org, broonie@kernel.org,
        ling_ling.xu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: Applied "spi: sprd: adi: Add missing lock protection when rebooting" to the spi tree
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20191028145650.4A9B627403EE@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:50 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: adi: Add missing lock protection when rebooting

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

From 91ea1d70607e374b014b4b9bea771ce661f9f64b Mon Sep 17 00:00:00 2001
From: Lingling Xu <ling_ling.xu@unisoc.com>
Date: Mon, 28 Oct 2019 18:10:30 +0800
Subject: [PATCH] spi: sprd: adi: Add missing lock protection when rebooting

When rebooting the system, we should lock the watchdog after
configuration to make sure the watchdog can reboot the system
successfully.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9a051286f120..9613cfe3c0a2 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -393,6 +393,9 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
+	/* Lock the watchdog */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+
 	mdelay(1000);
 
 	dev_emerg(sadi->dev, "Unable to restart system\n");
-- 
2.20.1

