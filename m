Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D743CD0E9
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 11:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhGSIvm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 04:51:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49314 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234965AbhGSIvl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 04:51:41 -0400
X-UUID: 3519a6341a8647e8841fa04a7a71d309-20210719
X-UUID: 3519a6341a8647e8841fa04a7a71d309-20210719
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1573343760; Mon, 19 Jul 2021 17:32:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Jul 2021 17:32:15 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Jul 2021 17:32:15 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leilk.liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 1/3] spi: move cs spi_delay to spi_device
Date:   Mon, 19 Jul 2021 17:16:12 +0800
Message-ID: <20210719091611.15303-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

As we know, spi core layer has removed spi_set_cs_timing() API.
So this patch moved spi_delay for cs_timing from spi_controller
to spi_device, because cs timing should be set by spi_device but
not controller.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi.c       |  6 +++---
 include/linux/spi/spi.h | 20 +++++++++-----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c99181165321..5d68e6cd2a18 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -842,9 +842,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
 	    !spi->controller->set_cs_timing) {
 		if (activate)
-			spi_delay_exec(&spi->controller->cs_setup, NULL);
+			spi_delay_exec(&spi->cs_setup, NULL);
 		else
-			spi_delay_exec(&spi->controller->cs_hold, NULL);
+			spi_delay_exec(&spi->cs_hold, NULL);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
@@ -887,7 +887,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
 	    !spi->controller->set_cs_timing) {
 		if (!activate)
-			spi_delay_exec(&spi->controller->cs_inactive, NULL);
+			spi_delay_exec(&spi->cs_inactive, NULL);
 	}
 }
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 97b8d12b5f2b..651e19ba3415 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -147,7 +147,11 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	not using a GPIO line)
  * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
- *
+ * @cs_setup: delay to be introduced by the controller after CS is asserted
+ * @cs_hold: delay to be introduced by the controller before CS is deasserted
+ * @cs_inactive: delay to be introduced by the controller after CS is
+ *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
+ *	two delays will be added up.
  * @statistics: statistics for the spi_device
  *
  * A @spi_device is used to interchange data between an SPI slave
@@ -188,6 +192,10 @@ struct spi_device {
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
 	struct spi_delay	word_delay; /* inter-word delay */
+	/* CS delays */
+	struct spi_delay	cs_setup;
+	struct spi_delay	cs_hold;
+	struct spi_delay	cs_inactive;
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -412,11 +420,6 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	     controller has native support for memory like operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
- * @cs_setup: delay to be introduced by the controller after CS is asserted
- * @cs_hold: delay to be introduced by the controller before CS is deasserted
- * @cs_inactive: delay to be introduced by the controller after CS is
- *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
- *	two delays will be added up.
  * @cs_gpios: LEGACY: array of GPIO descs to use as chip select lines; one per
  *	CS number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself). Use the cs_gpiods
@@ -638,11 +641,6 @@ struct spi_controller {
 	/* Optimized handlers for SPI memory-like operations. */
 	const struct spi_controller_mem_ops *mem_ops;
 
-	/* CS delays */
-	struct spi_delay	cs_setup;
-	struct spi_delay	cs_hold;
-	struct spi_delay	cs_inactive;
-
 	/* gpio chip select */
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
-- 
2.18.0

