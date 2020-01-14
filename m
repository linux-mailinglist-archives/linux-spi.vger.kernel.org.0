Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C143513AE7E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgANQJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 11:09:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgANQJd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 11:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KnzzFRQVAj4uXpCR1TI5559XQTFDEbE+udZJZl8tRkY=; b=AjgZBkR4/z+z
        z9IwW85L2iFBz4XQgi88yrN8+2uSRMke8qAS0fKmlyr6fgo39TSJGcxaMKfbgs3uOpv4STGJqGpWr
        n3XmYbqbm0UOuw/Ae6LMTNLUvFwjP0SfJyhFd1hCa2Li3xfgI/ldJ+pXhKS/2051zCPM0j/YZYUkf
        0vlss=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkv-0001ZG-7m; Tue, 14 Jan 2020 16:09:25 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EB622D02C77; Tue, 14 Jan 2020 16:09:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fsl: simplify error path in of_fsl_spi_probe()" to the spi tree
In-Reply-To: <2a4a7e11b37cfa0558d68f0d35e90d6da858b059.1579017697.git.christophe.leroy@c-s.fr>
Message-Id: <applied-2a4a7e11b37cfa0558d68f0d35e90d6da858b059.1579017697.git.christophe.leroy@c-s.fr>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:24 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fsl: simplify error path in of_fsl_spi_probe()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 2f3d8035b0f7a8e781b60e0884551dd8a1173a75 Mon Sep 17 00:00:00 2001
From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 14 Jan 2020 16:02:40 +0000
Subject: [PATCH] spi: fsl: simplify error path in of_fsl_spi_probe()

No need to 'goto err;' for just doing a return.
return directly from where the error happens.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Link: https://lore.kernel.org/r/2a4a7e11b37cfa0558d68f0d35e90d6da858b059.1579017697.git.christophe.leroy@c-s.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index fb4159ad6bf6..3b81772fea0d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -706,8 +706,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct spi_master *master;
 	struct resource mem;
-	int irq = 0, type;
-	int ret = -ENOMEM;
+	int irq, type;
+	int ret;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
@@ -722,10 +722,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 		if (spisel_boot) {
 			pinfo->immr_spi_cs = ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
-			if (!pinfo->immr_spi_cs) {
-				ret = -ENOMEM;
-				goto err;
-			}
+			if (!pinfo->immr_spi_cs)
+				return -ENOMEM;
 		}
 #endif
 		/*
@@ -744,24 +742,15 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq = platform_get_irq(ofdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err;
-	}
+	if (irq < 0)
+		return irq;
 
 	master = fsl_spi_probe(dev, &mem, irq);
-	if (IS_ERR(master)) {
-		ret = PTR_ERR(master);
-		goto err;
-	}
-
-	return 0;
 
-err:
-	return ret;
+	return PTR_ERR_OR_ZERO(master);
 }
 
 static int of_fsl_spi_remove(struct platform_device *ofdev)
-- 
2.20.1

