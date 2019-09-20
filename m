Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16255B8ECC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2019 13:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438157AbfITLJt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Sep 2019 07:09:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43830 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438154AbfITLJt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Sep 2019 07:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Z5dOD+9ZrY4bJlHtSzZwLx5yP4utZlZkCbGX9HlEhco=; b=FU44sVc97lba
        y7AucrgrxRoSO4Fwpr8E6+lf9YfyDwtImRpmG+C1+Rv9QNhBdQheXjI82vF24W/THw8wZQPs7japX
        YbX26x6JWKwWKZTTdjfTytHaDHSP0bP//B9pOYBOaNYpe17NM+HdrIdDckoa/ZRECA34cLYDA9g4S
        EegnU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iBGnE-0001cm-QS; Fri, 20 Sep 2019 11:09:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5A0AB274293F; Fri, 20 Sep 2019 12:09:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Julien Su <juliensu@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Applied "spi: mxic: Select SPI_NOR type by default" to the spi tree
In-Reply-To: <20190919202504.9619-3-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190920110940.5A0AB274293F@ypsilon.sirena.org.uk>
Date:   Fri, 20 Sep 2019 12:09:40 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: mxic: Select SPI_NOR type by default

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

From 4a82fe0e184263b5ed8f9d8079f7dfd144598127 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 19 Sep 2019 22:25:03 +0200
Subject: [PATCH] spi: mxic: Select SPI_NOR type by default

The SPI_NAND bit is a (wrongly named) placeholder that is intended
to be used in the future. Right now SPI_NOR (which is currently
identical to SPI_NAND in this version of the IP) should be used in
both cases.

Suggested-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20190919202504.9619-3-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f48563c09b97..b641954fdc4b 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -275,7 +275,7 @@ static void mxic_spi_hw_init(struct mxic_spi *mxic)
 	writel(0, mxic->regs + HC_EN);
 	writel(0, mxic->regs + LRD_CFG);
 	writel(0, mxic->regs + LRD_CTRL);
-	writel(HC_CFG_NIO(1) | HC_CFG_TYPE(0, HC_CFG_TYPE_SPI_NAND) |
+	writel(HC_CFG_NIO(1) | HC_CFG_TYPE(0, HC_CFG_TYPE_SPI_NOR) |
 	       HC_CFG_SLV_ACT(0) | HC_CFG_MAN_CS_EN | HC_CFG_IDLE_SIO_LVL(1),
 	       mxic->regs + HC_CFG);
 }
-- 
2.20.1

