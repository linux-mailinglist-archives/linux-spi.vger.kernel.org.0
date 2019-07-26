Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4A7655D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfGZMMg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 08:12:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfGZMMg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 08:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BMtU9YJUxgrsyYdv4yLoBRiCh3Jg5LDz29y8MvcJIpo=; b=fVDrdNX2Mzfc
        RFWfg+HAikW6jEmkqYX4BPF/R4nKboZXDGEvdnd0JdgXqaRX8ChT+5Q3DfgskS10hZV5K/BmKFz/r
        4memv61usG+3A1h0UqcuNq9heoBswCLJcTcpwDPhV6pogbPqQvPpOV1s5HnIes286ixoNwpo4+4pa
        +MOEA=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqz5F-0001ad-CG; Fri, 26 Jul 2019 12:12:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BD6AA2742B66; Fri, 26 Jul 2019 13:12:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        sherry.zong@unisoc.com, vincent.guittot@linaro.org,
        weicx@spreadst.com, zhang.lyra@gmail.com
Subject: Applied "spi: sprd: adi: Remove redundant address bits setting" to the spi tree
In-Reply-To: <3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190726121224.BD6AA2742B66@ypsilon.sirena.org.uk>
Date:   Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: adi: Remove redundant address bits setting

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

From c627c58acdc48055a9e4d40d6f9f1b434222a68d Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 26 Jul 2019 15:20:48 +0800
Subject: [PATCH] spi: sprd: adi: Remove redundant address bits setting

The ADI default transfer address bits is 12bit on Spreadtrum SC9860
platform, thus there is no need to set again, remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index df5960bddfe6..11880db08ce9 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -380,9 +380,6 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 	const __be32 *list;
 	u32 tmp;
 
-	/* Address bits select default 12 bits */
-	writel_relaxed(0, sadi->base + REG_ADI_CTRL0);
-
 	/* Set all channels as default priority */
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIL);
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIH);
-- 
2.20.1

