Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224F23BD6B5
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jul 2021 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhGFMnh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 6 Jul 2021 08:43:37 -0400
Received: from mxwww.masterlogin.de ([95.129.51.170]:36070 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhGFMdL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 6 Jul 2021 08:33:11 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 08:33:11 EDT
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 054512C56A;
        Tue,  6 Jul 2021 12:16:40 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id D2F385FD7A;
        Tue,  6 Jul 2021 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1625573790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w+0SBSUfYC3IZ2toT3plFnDlL4t7/7g6JGGmovdpmIo=;
        b=Eg1vBxqzviKvZ8o78u+KviTUpdj5DILeTvZUPkhqOl/TSu+GiJs+yZcJcqtedFvY3I8h+5
        h63IZSMGSRVAtks99stKZfrkHjuCV2kDuHwIRjN88rhDqaoOYq3RlsHx2fmOiSurcbnHgq
        BOArSBgvtxmnQm+Q30dKHvOJ6ZU3VxU=
Received: from localhost.localdomain (fttx-pool-80.245.79.159.bambit.de [80.245.79.159])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 1121C360303;
        Tue,  6 Jul 2021 12:16:29 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Hess <peter.hess@ph-home.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH] spi: mediatek: fix fifo rx mode
Date:   Tue,  6 Jul 2021 14:16:09 +0200
Message-Id: <20210706121609.680534-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a6ee19e1-dfe1-4f41-9d14-ba7ac2cd4326
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Peter Hess <peter.hess@ph-home.de>

In FIFO mode were two problems:
- RX mode was never handled and
- in this case the tx_buf pointer was NULL and caused an exception

fix this by handling RX mode in mtk_spi_fifo_transfer

Fixes: a568231f4632 ("spi: mediatek: Add spi bus for Mediatek MT8173")
Signed-off-by: Peter Hess <peter.hess@ph-home.de>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/spi/spi-mt65xx.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 976f73b9e299..8d5fa7f1e506 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -427,13 +427,23 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	mtk_spi_setup_packet(master);
 
 	cnt = xfer->len / 4;
-	iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
+	if (xfer->tx_buf)
+		iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
+
+	if (xfer->rx_buf)
+		ioread32_rep(mdata->base + SPI_RX_DATA_REG, xfer->rx_buf, cnt);
 
 	remainder = xfer->len % 4;
 	if (remainder > 0) {
 		reg_val = 0;
-		memcpy(&reg_val, xfer->tx_buf + (cnt * 4), remainder);
-		writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+		if (xfer->tx_buf) {
+			memcpy(&reg_val, xfer->tx_buf + (cnt * 4), remainder);
+			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+		}
+		if (xfer->rx_buf) {
+			reg_val = readl(mdata->base + SPI_RX_DATA_REG);
+			memcpy(xfer->rx_buf + (cnt * 4), &reg_val, remainder);
+		}
 	}
 
 	mtk_spi_enable_transfer(master);
-- 
2.25.1

