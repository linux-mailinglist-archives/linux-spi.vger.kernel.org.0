Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C41A12E701
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2020 15:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgABOEv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jan 2020 09:04:51 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:60180 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgABOEn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jan 2020 09:04:43 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id lS4g210095USYZQ06S4guB; Thu, 02 Jan 2020 15:04:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in15c-0006GP-Hk; Thu, 02 Jan 2020 15:04:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1in0gG-0007eU-GX; Thu, 02 Jan 2020 14:38:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/6] spi: rspi: Remove set_config_register() macro
Date:   Thu,  2 Jan 2020 14:38:20 +0100
Message-Id: <20200102133822.29346-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102133822.29346-1-geert+renesas@glider.be>
References: <20200102133822.29346-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The set_config_register() macro is used in a single place.
Make the code easier to read by just removing it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e54a25f848ea38c7..9eabef3d6cc478ff 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -426,8 +426,6 @@ static int qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
 	return n;
 }
 
-#define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
-
 static void rspi_enable_irq(const struct rspi_data *rspi, u8 enable)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | enable, RSPI_SPCR);
@@ -940,7 +938,7 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 	if (spi->mode & SPI_LOOP)
 		rspi->sppcr |= SPPCR_SPLP;
 
-	set_config_register(rspi, 8);
+	rspi->ops->set_config_register(rspi, 8);
 
 	if (msg->spi->mode &
 	    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)) {
-- 
2.17.1

