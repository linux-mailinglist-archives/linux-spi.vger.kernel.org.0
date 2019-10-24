Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31AFE319F
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409254AbfJXL6B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:58:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53666 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409253AbfJXL6A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NwY0+e/21+fQpJVaYWikXqj2GnmkWOwotVlTdrqTWwg=; b=Zlacs+o0ZY4D
        9KwJbesgdEuhb2xJ33sV0tFBqG+zqVDoRdaGm29/sgcZV9qU/NtUMU/psmyknRFodNppEYkjMdmzy
        kgH/8/F8d424sNP1RsnnJCB0gYmhePV8X1GOs2yF6atOFUbMnpDqxCBFdTIunlXAiNw93nCJh6h50
        DZHRU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNbkb-0003Rh-TL; Thu, 24 Oct 2019 11:57:57 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5EB4C274293C; Thu, 24 Oct 2019 12:57:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: Applied "spi: xilinx: Add DT support for selecting transfer word width" to the spi tree
In-Reply-To: <20191024110757.25820-3-alvaro.gamez@hazent.com>
X-Patchwork-Hint: ignore
Message-Id: <20191024115757.5EB4C274293C@ypsilon.sirena.org.uk>
Date:   Thu, 24 Oct 2019 12:57:57 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: xilinx: Add DT support for selecting transfer word width

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

From e58f7d15e6beb255b3907054a0536db77c979a31 Mon Sep 17 00:00:00 2001
From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Date: Thu, 24 Oct 2019 13:07:56 +0200
Subject: [PATCH] spi: xilinx: Add DT support for selecting transfer word width

This core supports either 8, 16 or 32 bits as word width. This value is only
settable on instantiation, and thus we need to support any of them by means
of the device tree.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Link: https://lore.kernel.org/r/20191024110757.25820-3-alvaro.gamez@hazent.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-xilinx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d5f9d5fbb3e8..8dd2bb99cb4d 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -391,7 +391,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	struct xilinx_spi *xspi;
 	struct xspi_platform_data *pdata;
 	struct resource *res;
-	int ret, num_cs = 0, bits_per_word = 8;
+	int ret, num_cs = 0, bits_per_word;
 	struct spi_master *master;
 	u32 tmp;
 	u8 i;
@@ -403,6 +403,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	} else {
 		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
 					  &num_cs);
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "xlnx,num-transfer-bits",
+					   &bits_per_word);
+		if (ret)
+			bits_per_word = 8;
 	}
 
 	if (!num_cs) {
-- 
2.20.1

