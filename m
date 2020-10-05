Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560E828366E
	for <lists+linux-spi@lfdr.de>; Mon,  5 Oct 2020 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJENWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Oct 2020 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJENWj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Oct 2020 09:22:39 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB367C0613CE
        for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2020 06:22:38 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C4h9760Hqz1s5VH;
        Mon,  5 Oct 2020 15:22:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C4h97537gz1qqkK;
        Mon,  5 Oct 2020 15:22:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id bzkkvaEfiYd1; Mon,  5 Oct 2020 15:22:34 +0200 (CEST)
X-Auth-Info: 8ge+jIr5f8nayvLs8bUvV5P8XW8PWVTtHbnAQLSHH3I=
Received: from desktop.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  5 Oct 2020 15:22:34 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robin Gong <b38343@freescale.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: imx: Fix freeing of DMA channels if spi_bitbang_start() fails
Date:   Mon,  5 Oct 2020 15:22:29 +0200
Message-Id: <20201005132229.513119-1-marex@denx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the SPI controller has has_dmamode = true and spi_bitbang_start() fails
in spi_imx_probe(), then the driver must release the DMA channels acquired
in spi_imx_sdma_init() by calling spi_imx_sdma_exit() in the fail path.

Fixes: f62caccd12c1 ("spi: spi-imx: add DMA support")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Robin Gong <b38343@freescale.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-spi@vger.kernel.org
---
 drivers/spi/spi-imx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 38a5f1304cec..e38e5ad3c706 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1707,7 +1707,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_runtime_pm_put;
+		goto out_bitbang_start;
 	}
 
 	dev_info(&pdev->dev, "probed\n");
@@ -1717,6 +1717,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	return ret;
 
+out_bitbang_start:
+	if (spi_imx->devtype_data->has_dmamode)
+		spi_imx_sdma_exit(spi_imx);
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_put_sync(spi_imx->dev);
-- 
2.28.0

