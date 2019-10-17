Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1023DAFC2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440046AbfJQOUb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 10:20:31 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50449 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440027AbfJQOUb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Oct 2019 10:20:31 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B2D26E000A;
        Thu, 17 Oct 2019 14:20:28 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 7/7] spi: atmel: Improve CS0 case support on AT91RM9200
Date:   Thu, 17 Oct 2019 16:18:46 +0200
Message-Id: <20191017141846.7523-8-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017141846.7523-1-gregory.clement@bootlin.com>
References: <20191017141846.7523-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thanks to the recent change in this driver, it is now possible to
prevent using the CS0 with GPIO during setup. It then allows to remove
the special handling of this case in the cs_activate() and
cs_deactivate() functions.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/spi/spi-atmel.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ac5e2ddf9e1b..d88e2aa64839 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -371,7 +371,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
-		if (spi->cs_gpiod && spi->chip_select != 0)
+		if (spi->cs_gpiod)
 			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
@@ -402,7 +402,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
-	else if (atmel_spi_is_v2(as) || spi->chip_select != 0)
+	else
 		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
@@ -1193,7 +1193,16 @@ static void initialize_native_cs_for_gpio(struct atmel_spi *as)
 	if (!master->cs_gpiods)
 		return; /* No CS GPIO */
 
-	for (i = 0; i < 4; i++)
+	/*
+	 * On the first version of the controller (AT91RM9200), CS0
+	 * can't be used associated with GPIO
+	 */
+	if (atmel_spi_is_v2(as))
+		i = 0;
+	else
+		i = 1;
+
+	for (; i < 4; i++)
 		if (master->cs_gpiods[i])
 			as->native_cs_free |= BIT(i);
 
-- 
2.23.0

