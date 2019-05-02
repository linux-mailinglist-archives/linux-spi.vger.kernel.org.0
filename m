Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC311159
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEBCUU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:20:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56768 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfEBCTK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EVE8bSshKnItl0eubjnAOH03ySne216GQtby64RJnLw=; b=o/KTDwk9QvFN
        JbyIwDUjCkoApEnDiMcp9eGEfksDBNbbkmixJ9q/eSkc5uf5H6M0obEMaeddqAgL8hk/PRnu4e9Te
        5mKxR1TIbJaifkAs6AjbZ1aGIhQliBJMt8vkmthjnB1bHjAT38RgLDP9jzaUe7RLx+kCGXaUb4K+M
        JYbLE=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1JJ-0005ul-Lx; Thu, 02 May 2019 02:18:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C9DFB441D3C; Thu,  2 May 2019 03:18:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Applied "spi: stm32: return the get_irq error" to the spi tree
In-Reply-To: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021854.C9DFB441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: stm32: return the get_irq error

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

From 8d1467a68426c61807c97163459b481ecb714523 Mon Sep 17 00:00:00 2001
From: Fabien Dessenne <fabien.dessenne@st.com>
Date: Wed, 24 Apr 2019 14:38:44 +0200
Subject: [PATCH] spi: stm32: return the get_irq error

During probe, return the "get_irq" error value instead of -ENOENT. This
allows the driver to be defer probed if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Acked-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4186ed20d796..b222ce8d083e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1839,8 +1839,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 	spi->irq = platform_get_irq(pdev, 0);
 	if (spi->irq <= 0) {
-		dev_err(&pdev->dev, "no irq: %d\n", spi->irq);
-		ret = -ENOENT;
+		ret = spi->irq;
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
-- 
2.20.1

