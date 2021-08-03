Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC83DEB16
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 12:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhHCKk0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 06:40:26 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56142 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235505AbhHCKkZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Aug 2021 06:40:25 -0400
X-UUID: 4a1a8d6d54d74848a57a09f339b1a5b0-20210803
X-UUID: 4a1a8d6d54d74848a57a09f339b1a5b0-20210803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2001468748; Tue, 03 Aug 2021 18:40:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 18:40:10 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 18:40:09 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH v2 1/4] spi: move cs spi_delay to spi_device
Date:   Tue, 3 Aug 2021 18:23:34 +0800
Message-ID: <20210803102333.22568-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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

