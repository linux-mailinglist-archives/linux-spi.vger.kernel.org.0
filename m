Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB23405151
	for <lists+linux-spi@lfdr.de>; Thu,  9 Sep 2021 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbhIIMfh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Sep 2021 08:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350144AbhIIM1Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Sep 2021 08:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A17CF61B30;
        Thu,  9 Sep 2021 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188327;
        bh=jx3iPFxkRDrPIG54QGHiyXX9r1sllxvnwVHKPI+4HlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tI+tgAPTis0uKBWcyCp/744nnOXINiMIBmk7tLPZDhagYrNG+Ev5A58JXRnzsMSMq
         orowA3YfoLOOLUYL3waaAB4w/cv25KJVKjZNWMyP2VU8oXcOts0etnwsS1avbAulhO
         TY+XUJYJk4xMqmAqD8dYlziWqtOsXKJ7kwXxuXdG5+M9JaiRBuldk1Bfd+H8oyOD8Z
         QicOKS7cAsm56xHTxRG/G1YG6s8N0LKJ0h3gYnLIMS+GcPOIFpW3Z6p7bcVZuAhiKf
         wc78J3EKnKP89NOfkzaZp+mVrh0UXD8eJPUH4BWbnw+iCIKguHun1Ghel4pVfosxHW
         kyBt47qYHjfxw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 038/176] spi: imx: fix ERR009165
Date:   Thu,  9 Sep 2021 07:49:00 -0400
Message-Id: <20210909115118.146181-38-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115118.146181-1-sashal@kernel.org>
References: <20210909115118.146181-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

[ Upstream commit 980f884866eed4dda2a18de888c5a67dde67d640 ]

Change to XCH  mode even in dma mode, please refer to the below
errata:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 0e3bc0b0a526..2652130eda6a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -622,8 +622,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -637,7 +637,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1280,10 +1280,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 {
 	int ret;
 
-	/* use pio mode for i.mx6dl chip TKT238285 */
-	if (of_machine_is_compatible("fsl,imx6dl"))
-		return 0;
-
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-- 
2.30.2

