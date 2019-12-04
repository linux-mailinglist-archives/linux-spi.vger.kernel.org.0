Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9960C112B2B
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 13:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfLDMPr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 07:15:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMPq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 07:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RC+7zXRqYsH/Z5uX+H5Hl29YUyIBfWV7tx5prRznMfA=; b=hj2ibWPZpWE1
        IcPuy11+8LfYQb6ykvMY99RVVIThhNll6CCNgiEB16q0NhUXwQhDvvo0ljO5Y3ZfoFdUST0jX7U6q
        8KBP7oZKHLs0jiOuM6xvncERo0IM++DASspd4yK094sfbGdzKKSDdXEwDA3m4GsnQs0hBG5eC2pYA
        F/cek=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1icTZF-0000Ag-7X; Wed, 04 Dec 2019 12:15:41 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EC183D003B4; Wed,  4 Dec 2019 12:15:40 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Huanpeng Xin <huanpeng.xin@unisoc.com>
Cc:     baolin.wang7@gmail.com, Baolin Wang <baolin.wang7@gmail.com>,
        broonie@kernel.org, huanpeng.xin@unisoc.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: sprd: Fix the incorrect SPI register" to the spi tree
In-Reply-To: <b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
Message-Id: <applied-b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com>
X-Patchwork-Hint: ignore
Date:   Wed,  4 Dec 2019 12:15:40 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: Fix the incorrect SPI register

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

From 5e9c5236b7b86779b53b762f7e66240c3f18314b Mon Sep 17 00:00:00 2001
From: Huanpeng Xin <huanpeng.xin@unisoc.com>
Date: Wed, 4 Dec 2019 15:13:59 +0800
Subject: [PATCH] spi: sprd: Fix the incorrect SPI register

The original code used an incorrect SPI register to initialize the SPI
controller in sprd_spi_init_hw(), thus fix it.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Huanpeng Xin <huanpeng.xin@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/b4f7f89ec0fdc595335687bfbd9f962213bc4a1d.1575443510.git.baolin.wang7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 2ee1feb41681..6678f1cbc566 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -678,7 +678,7 @@ static int sprd_spi_init_hw(struct sprd_spi *ss, struct spi_transfer *t)
 	if (d->unit != SPI_DELAY_UNIT_SCK)
 		return -EINVAL;
 
-	val = readl_relaxed(ss->base + SPRD_SPI_CTL7);
+	val = readl_relaxed(ss->base + SPRD_SPI_CTL0);
 	val &= ~(SPRD_SPI_SCK_REV | SPRD_SPI_NG_TX | SPRD_SPI_NG_RX);
 	/* Set default chip selection, clock phase and clock polarity */
 	val |= ss->hw_mode & SPI_CPHA ? SPRD_SPI_NG_RX : SPRD_SPI_NG_TX;
-- 
2.20.1

