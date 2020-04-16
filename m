Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E861ABF2E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633054AbgDPL3R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 07:29:17 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:45020 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505842AbgDPLJa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 07:09:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id E483227E0BEB;
        Thu, 16 Apr 2020 13:09:27 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Kl8XApNDOTIE; Thu, 16 Apr 2020 13:09:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 8437127E0B48;
        Thu, 16 Apr 2020 13:09:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 8437127E0B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1587035367;
        bh=BTeyNExfyxQjnOaSPJGAKwarwW1+gJT+EEBl7fj1eRk=;
        h=From:To:Date:Message-Id;
        b=Aqfdl3Bof+6vnT8DAxK7JRGpaIYA7auThwnIeG0tN+r09Xs4mk8wQZVhbwb0dMcOf
         Zg0DGIG7nE6LR+LEp46uiwdIzZCoji/+yZ7dtyOC+l6Fxg3v8w79TrNdFWnse5AGp9
         lNouqjIaCfFt/fvsgCnhylfkPHJ3TIpPmd30NTOg=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qYJlB-6xkymO; Thu, 16 Apr 2020 13:09:27 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 7166827E02FA;
        Thu, 16 Apr 2020 13:09:27 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH 2/2] spi: dw: remove cs_control and poll_mode members from chip_data
Date:   Thu, 16 Apr 2020 13:09:16 +0200
Message-Id: <20200416110916.22633-2-cleger@kalray.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416110916.22633-1-cleger@kalray.eu>
References: <20200416110823.22565-1-cleger@kalray.eu>
 <20200416110916.22633-1-cleger@kalray.eu>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since these members were initialized only with previous dw_spi_chip
struct members and that there is no user anymore, remove them. Along
this removal, remove code path which were using these members.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/spi/spi-dw.c | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index fda8d433a769..2b79c5a983c0 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -24,11 +24,8 @@ struct chip_data {
 	u8 tmode;		/* TR/TO/RO/EEPROM */
 	u8 type;		/* SPI/SSP/MicroWire */
 
-	u8 poll_mode;		/* 1 means use poll mode */
-
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
-	void (*cs_control)(u32 command);
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -127,11 +124,6 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
-	struct chip_data *chip = spi_get_ctldata(spi);
-
-	/* Chip select logic is inverted from spi_set_cs() */
-	if (chip && chip->cs_control)
-		chip->cs_control(!enable);
 
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
@@ -265,18 +257,6 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	return dws->transfer_handler(dws);
 }
 
-/* Must be called inside pump_transfers() */
-static int poll_transfer(struct dw_spi *dws)
-{
-	do {
-		dw_writer(dws);
-		dw_reader(dws);
-		cpu_relax();
-	} while (dws->rx_end > dws->rx);
-
-	return 0;
-}
-
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
@@ -324,22 +304,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
-	/*
-	 * Adjust transfer mode if necessary. Requires platform dependent
-	 * chipselect mechanism.
-	 */
-	if (chip->cs_control) {
-		if (dws->rx && dws->tx)
-			chip->tmode = SPI_TMOD_TR;
-		else if (dws->rx)
-			chip->tmode = SPI_TMOD_RO;
-		else
-			chip->tmode = SPI_TMOD_TO;
-
-		cr0 &= ~SPI_TMOD_MASK;
-		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
-	}
-
 	dw_writel(dws, DW_SPI_CTRL0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
@@ -359,7 +323,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			spi_enable_chip(dws, 1);
 			return ret;
 		}
-	} else if (!chip->poll_mode) {
+	} else {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
 		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
 
@@ -379,9 +343,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			return ret;
 	}
 
-	if (chip->poll_mode)
-		return poll_transfer(dws);
-
 	return 1;
 }
 
-- 
2.17.1

