Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C61D16BE
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbgEMOAp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:00:45 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48473 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387927AbgEMOAp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378444; x=1620914444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E2LeTrXG5USlLqv6CmJsbBQmCdfRXDqsQ0KDLdpn/wA=;
  b=Z+QNjf30+ZDVzxmA8gpkDu2pxVVIKzyVmGSBOT/nBWfZ5ZOCa/fD8bPm
   +qjIAd21fyvJ8h4LdhckvLEVkj6JuVP+dUyu4yCY+bO/d3CitxAxd/Itm
   q/R4IyE9x/NJO4z6WxLZNvE7SiG6TzFtU/YtwD+bzzhNJRBjTy/fidgz8
   5sZtY1ArYIOh0QoCgUEwO+Vja/ZYXa+ygqdy8P846wDPPyVbVT9wrOM95
   6r6oCVTrbJeNiax99kbDxaJmYo7i038acylNitqRCuA90Rt8LRn90O4Gr
   d8w/CQ35GXskR9lBoiBg/hm/h/m49Pda6pG4OM6OjEXYLd9Nw8Wi5k2yH
   A==;
IronPort-SDR: fnwxvPcGQmcXFxqzx53KJMTcVAUAw6CucJ/tFsnpig2jxsTO5+7WvUQWlnhFHUS/c2LTWCinxk
 Ccy0u6/nP64oHUmfXqSWqSqMeCVJGnUEo1dEh0BbjPWAtZeAXcEivImlBrGMGRS/HnEqtji1Jp
 yPRZuRc3ai+OFB6qQ7jEW7rwfSKDZpSS2eP7pbq72WEPmGcU4YTAc/cfO3pRaYbNvpzVW5uX9N
 /zCcOHOQr0mcR2Y26nPKaysX8AVwbrTX04V0gKn4mWzdreHR4Qs9EI9W+0R7kOtzeOo4Bo2Zzd
 PXg=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="79447442"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:00:46 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:41 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 01/10] spi: dw: Add support for polled operation via no IRQ specified in DT
Date:   Wed, 13 May 2020 16:00:22 +0200
Message-ID: <20200513140031.25633-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With this change a SPI controller can be added without having a IRQ
associated, and causing all transfers to be polled. For SPI controllers
without DMA, this can significantly improve performance by less
interrupt handling overhead.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 31e3f866d11a7..e572eb34a3c1a 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -19,6 +19,8 @@
 #include <linux/debugfs.h>
 #endif

+#define VALID_IRQ(i) (i >= 0)
+
 /* Slave spi_dev related */
 struct chip_data {
 	u8 tmode;		/* TR/TO/RO/EEPROM */
@@ -359,7 +361,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			spi_enable_chip(dws, 1);
 			return ret;
 		}
-	} else if (!chip->poll_mode) {
+	} else if (!chip->poll_mode && VALID_IRQ(dws->irq)) {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
 		dw_writel(dws, DW_SPI_TXFLTR, txlevel);

@@ -379,7 +381,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			return ret;
 	}

-	if (chip->poll_mode)
+	if (chip->poll_mode || !VALID_IRQ(dws->irq))
 		return poll_transfer(dws);

 	return 1;
@@ -487,11 +489,13 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)

 	spi_controller_set_devdata(master, dws);

-	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
-			  master);
-	if (ret < 0) {
-		dev_err(dev, "can not get IRQ\n");
-		goto err_free_master;
+	if (VALID_IRQ(dws->irq)) {
+		ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
+				  dev_name(dev), master);
+		if (ret < 0) {
+			dev_err(dev, "can not get IRQ\n");
+			goto err_free_master;
+		}
 	}

 	master->use_gpio_descriptors = true;
@@ -539,7 +543,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
-	free_irq(dws->irq, master);
+	if (VALID_IRQ(dws->irq))
+		free_irq(dws->irq, master);
 err_free_master:
 	spi_controller_put(master);
 	return ret;
--
2.26.2
