Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2712E706
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2020 15:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgABOEv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 09:04:51 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:41590 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgABOEn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 09:04:43 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id lS4g210095USYZQ01S4gFL; Thu, 02 Jan 2020 15:04:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in15c-0006GP-Au; Thu, 02 Jan 2020 15:04:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in0gG-0007eR-Et; Thu, 02 Jan 2020 14:38:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/6] spi: rspi: Use dev_warn_once() instead of open-coding
Date:   Thu,  2 Jan 2020 14:38:19 +0100
Message-Id: <20200102133822.29346-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the helper introduced by commit e135303bd5bebcd2 ("device: Add
dev_<level>_once variants") instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 74a12f4dee849125..e54a25f848ea38c7 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -620,9 +620,8 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 		dmaengine_terminate_all(rspi->ctlr->dma_rx);
 no_dma_rx:
 	if (ret == -EAGAIN) {
-		pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
-			     dev_driver_string(&rspi->ctlr->dev),
-			     dev_name(&rspi->ctlr->dev));
+		dev_warn_once(&rspi->ctlr->dev,
+			      "DMA not available, falling back to PIO\n");
 	}
 	return ret;
 }
-- 
2.17.1

