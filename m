Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44DDAFBD
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbfJQOUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 10:20:23 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36737 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394836AbfJQOUX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Oct 2019 10:20:23 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 905F2100008;
        Thu, 17 Oct 2019 14:20:21 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 1/7] spi: atmel: Remove and fix erroneous comments
Date:   Thu, 17 Oct 2019 16:18:40 +0200
Message-Id: <20191017141846.7523-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017141846.7523-1-gregory.clement@bootlin.com>
References: <20191017141846.7523-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since CSAAT functionality support has been added. Some comments become
wrong. Fix them to match the current driver behavior.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/spi/spi-atmel.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index e34ab587b980..7a17c3e2a8ee 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -312,11 +312,9 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
  * transmitted")  Not so!  Workaround uses nCSx pins as GPIOs; or newer
  * controllers have CSAAT and friends.
  *
- * Since the CSAAT functionality is a bit weird on newer controllers as
- * well, we use GPIO to control nCSx pins on all controllers, updating
- * MR.PCS to avoid confusing the controller.  Using GPIOs also lets us
- * support active-high chipselects despite the controller's belief that
- * only active-low devices/systems exists.
+ * Even controller newer than ar91rm9200, using GPIOs can make sens as
+ * it lets us support active-high chipselects despite the controller's
+ * belief that only active-low devices/systems exists.
  *
  * However, at91rm9200 has a second erratum whereby nCS0 doesn't work
  * right when driven with GPIO.  ("Mode Fault does not allow more than one
@@ -1193,8 +1191,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 	if (!as->use_cs_gpios)
 		csr |= SPI_BIT(CSAAT);
 
-	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 */
 	csr |= SPI_BF(DLYBS, 0);
 
 	word_delay_csr = atmel_word_delay_csr(spi, as);
-- 
2.23.0

