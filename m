Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D63B7672
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhF2Qbz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 12:31:55 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44695 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhF2Qbz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 12:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624984168; x=1656520168;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1XXS9KyKsFznlwdvk/wsv4ZZwVL2Za1i0nmt5WzDiTA=;
  b=ZoHvOtF1TS2CCw51IHcjPBy4HnXKWYReaHhlqMXEHXsZJ3cW0dXvy3lO
   BzLWfuIGl1UW3du7YxgCnJMupd5yTNvzMG3WnV3DaV1ABPfHSn58X7IwW
   km0HnvzOq7GaZgoLq+SCyDfFywQvO/sXFni2UdrOWvZwmQfv7tQfTO467
   MiszZGwRpaWQ0AGmv2m0+k3k7u4xKdVcIAjovfVc+uAbq5TdQX+nnlIzM
   JgxEoGcx3SAZDM+DL2BcngMJTFNlFRO5OpAWglN5IVOdAChJZ/okQiqdF
   +aOlyVbIoyx7YN+LdGNe3wr/vEuhDizYXrWaSu13jStuvVZk7LqdW2utk
   w==;
IronPort-SDR: qVB0RpgGwH1F6dz2tl5iAwN+ANVx04yKK5k/AZKa9EocSRYmfKm9oKlYKFnSYVZnO60yQwtanR
 9Q15S52M3LHM3H1+XtlbITRhK8WBwbvdD/wLvzzh5yjA+93in1zSOVmiu9b/M3o7KIeEbZ6fe+
 3eomNmG1wl62cNr7eSiDC2cyOyjs10I0nV/q8Jc2jonMOQTgbA4UdL852shIsUcHsLkvcofm1L
 KQWSyeOkWvzif9hHcbKQgbrdBM0N+ATBe79WS3TuXcchkndmkwQMdw0Fh4VUv7tPoWTU/37VOt
 X1c=
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="122951173"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2021 09:29:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 09:29:26 -0700
Received: from dan-linux.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 09:29:26 -0700
From:   Dan Sneddon <dan.sneddon@microchip.com>
To:     Mark Brown <broonie@kernel.org>,
        Dan Sneddon <dan.sneddon@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] spi: atmel: Fix CS and initialization bug
Date:   Tue, 29 Jun 2021 09:29:14 -0700
Message-ID: <20210629162914.23286-1-dan.sneddon@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
method") switched to using transfer_one and set_cs.  However, the driver
expects to call cs_activate even with a gpio controlled chip select.  If
cs_activate isn't called the settings programmed with the call to
spi_setup won't get programmed into the hardware.  This patch makes
sure the cs_activate call is made even with a gpio controlled chip
select.

Fixes: 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer method")

Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
---
 drivers/spi/spi-atmel.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 2ef74885ffa2..84d902c469cf 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -352,8 +352,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (spi->cs_gpiod)
-			gpiod_set_value(spi->cs_gpiod, 1);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
@@ -369,8 +367,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
-		if (spi->cs_gpiod)
-			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
 
@@ -400,8 +396,6 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
-	else
-		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
 static void atmel_spi_lock(struct atmel_spi *as) __acquires(&as->lock)
@@ -1271,9 +1265,9 @@ static void atmel_spi_set_cs(struct spi_device *spi, bool enable)
 	 * since we already have routines for activate/deactivate translate
 	 * high/low to active/inactive
 	 */
-	enable = (!!(spi->mode & SPI_CS_HIGH) == enable);
 
-	if (enable) {
+	if ((enable && (spi->mode & SPI_CS_HIGH))
+			|| (!enable && !(spi->mode & SPI_CS_HIGH))) {
 		cs_activate(as, spi);
 	} else {
 		cs_deactivate(as, spi);
@@ -1483,7 +1477,8 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = 4;
 	master->setup = atmel_spi_setup;
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
+	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX |
+			SPI_MASTER_GPIO_SS);
 	master->transfer_one = atmel_spi_one_transfer;
 	master->set_cs = atmel_spi_set_cs;
 	master->cleanup = atmel_spi_cleanup;
-- 
2.17.1

