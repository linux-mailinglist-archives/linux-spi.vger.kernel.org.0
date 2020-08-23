Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96F24EFDA
	for <lists+linux-spi@lfdr.de>; Sun, 23 Aug 2020 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgHWV1F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 23 Aug 2020 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWV1F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 23 Aug 2020 17:27:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F48C061573;
        Sun, 23 Aug 2020 14:27:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so8726814ejz.0;
        Sun, 23 Aug 2020 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcCugnZtUf9EcdHZzAdpWyC7YtIPD+wlHx18QDFMkeA=;
        b=Ov4rrPDx0whCuZe1U34iy0hzc2I7RNo7LBhJx3P4bLi4ieABp1HynodJ3pySbP3YPa
         qRuG0vzWxMwehD9Z+QIlsv3ECfyzkd7t24rl9ZFUcUPzk8ZevcJWVE47t7n8Gz3DD+BK
         km+VUQ+Pf7flm7ZQPXzfwCTKilbOMSZKm2mJ/55+KkhyDjejZAaTS50I4ROez4/RqMS0
         Sfx4WUoEkrNRlQiMROM4wNqukl3H1sxww480rPkaTFauoCYnA+6UXCi7ZGTH3GPfV87Y
         jgYp5RAAXK/NjaC72HNHB1Vsh9Xb5YUa9vT2KpHbepVusA0RXqUSctAuP3J7JWHlPAgZ
         /ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcCugnZtUf9EcdHZzAdpWyC7YtIPD+wlHx18QDFMkeA=;
        b=cvuTdqzZX3fHr0yfMBcbAidofZR2UyJZFsKwBY10lFOwhQozIofrQQtZErZ6Fa1fMC
         z6vkpvK1gAMDZa+b8hopopJ0tSFMxWUuXdbnnH+26BhdGoUVOR8gGTsL0/48UUCHwONF
         cicbZXLDPx+0+hUxTUXGQqHmt+aVxoZZeGzWXyEfpIY5j6UXxLyZJKrTRfT9/0EdOfEw
         2GuiXIO7wrJ83SKhgnsrEvvdwyCMOKj+OVhbDTKFrQ3CcYZR6Gm/wiiG+hkkXNjlE+FM
         wN0oTQUOjXeOwc6f7Mi9r7d69wagVvUG6WHexciurbA9/M/OT5H8Bq61Z2ZziZKlaxL9
         8TEQ==
X-Gm-Message-State: AOAM530vAnGj6PhY2/rNxyCQAoERXWHds/8BKK8qK6P9snsSWKMokHPE
        4xy8rzGfQqxvuKSKvVHQwWE=
X-Google-Smtp-Source: ABdhPJyt/4b6xfFADsr3nS/4mP8hBYXqkEGngXAANdtzAuyylwhhDwKenjVSiyKFH7lMXULbkOC/bA==
X-Received: by 2002:a17:906:cb86:: with SMTP id mf6mr2932493ejb.415.1598218023225;
        Sun, 23 Aug 2020 14:27:03 -0700 (PDT)
Received: from localhost.localdomain ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id d17sm5233305edr.78.2020.08.23.14.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 14:27:02 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelo.dureghello@timesys.com
Subject: [PATCH] spi: spi-fsl-dspi: delete EOQ transfer mode
Date:   Mon, 24 Aug 2020 00:26:57 +0300
Message-Id: <20200823212657.2400075-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After the only user of the limited EOQ mode has now been converted to
DMA as of commit b09058bbf5f0 ("spi: spi-fsl-dspi: set ColdFire to DMA
mode"), we can finally delete this code.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 56 ++++----------------------------------
 1 file changed, 5 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5b9a285d84a7..c739cc7e4561 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -53,7 +53,6 @@
 
 #define SPI_SR				0x2c
 #define SPI_SR_TCFQF			BIT(31)
-#define SPI_SR_EOQF			BIT(28)
 #define SPI_SR_TFUF			BIT(27)
 #define SPI_SR_TFFF			BIT(25)
 #define SPI_SR_CMDTCF			BIT(23)
@@ -62,7 +61,7 @@
 #define SPI_SR_TFIWF			BIT(18)
 #define SPI_SR_RFDF			BIT(17)
 #define SPI_SR_CMDFFF			BIT(16)
-#define SPI_SR_CLEAR			(SPI_SR_TCFQF | SPI_SR_EOQF | \
+#define SPI_SR_CLEAR			(SPI_SR_TCFQF | \
 					SPI_SR_TFUF | SPI_SR_TFFF | \
 					SPI_SR_CMDTCF | SPI_SR_SPEF | \
 					SPI_SR_RFOF | SPI_SR_TFIWF | \
@@ -75,7 +74,6 @@
 
 #define SPI_RSER			0x30
 #define SPI_RSER_TCFQE			BIT(31)
-#define SPI_RSER_EOQFE			BIT(28)
 #define SPI_RSER_CMDTCFE		BIT(23)
 
 #define SPI_PUSHR			0x34
@@ -114,7 +112,6 @@ struct chip_data {
 };
 
 enum dspi_trans_mode {
-	DSPI_EOQ_MODE = 0,
 	DSPI_XSPI_MODE,
 	DSPI_DMA_MODE,
 };
@@ -671,11 +668,6 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	}
 }
 
-static void dspi_pushr_write(struct fsl_dspi *dspi)
-{
-	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
-}
-
 static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 {
 	/*
@@ -735,21 +727,6 @@ static void dspi_xspi_fifo_write(struct fsl_dspi *dspi, int num_words)
 	}
 }
 
-static void dspi_eoq_fifo_write(struct fsl_dspi *dspi, int num_words)
-{
-	u16 xfer_cmd = dspi->tx_cmd;
-
-	/* Fill TX FIFO with as many transfers as possible */
-	while (num_words--) {
-		dspi->tx_cmd = xfer_cmd;
-		/* Request EOQF for last transfer in FIFO */
-		if (num_words == 0)
-			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
-		/* Write combined TX FIFO and CMD FIFO entry */
-		dspi_pushr_write(dspi);
-	}
-}
-
 static u32 dspi_popr_read(struct fsl_dspi *dspi)
 {
 	u32 rxdata = 0;
@@ -818,7 +795,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 	dspi->oper_word_size = DIV_ROUND_UP(dspi->oper_bits_per_word, 8);
 
 	/*
-	 * Update CTAR here (code is common for EOQ, XSPI and DMA modes).
+	 * Update CTAR here (code is common for XSPI and DMA modes).
 	 * We will update CTARE in the portion specific to XSPI, when we
 	 * also know the preload value (DTCP).
 	 */
@@ -862,10 +839,7 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 
 	spi_take_timestamp_pre(dspi->ctlr, xfer, dspi->progress, !dspi->irq);
 
-	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
-		dspi_eoq_fifo_write(dspi, num_words);
-	else
-		dspi_xspi_fifo_write(dspi, num_words);
+	dspi_xspi_fifo_write(dspi, num_words);
 	/*
 	 * Everything after this point is in a potential race with the next
 	 * interrupt, so we must never use dspi->words_in_flight again since it
@@ -898,7 +872,7 @@ static int dspi_poll(struct fsl_dspi *dspi)
 		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 		regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-		if (spi_sr & (SPI_SR_EOQF | SPI_SR_CMDTCF))
+		if (spi_sr & SPI_SR_CMDTCF)
 			break;
 	} while (--tries);
 
@@ -916,7 +890,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_CMDTCF)))
+	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
 	if (dspi_rxtx(dspi) == 0)
@@ -1204,9 +1178,6 @@ static int dspi_init(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 
 	switch (dspi->devtype_data->trans_mode) {
-	case DSPI_EOQ_MODE:
-		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-		break;
 	case DSPI_XSPI_MODE:
 		regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
 		break;
@@ -1245,22 +1216,6 @@ static int dspi_slave_abort(struct spi_master *master)
 	return 0;
 }
 
-/*
- * EOQ mode will inevitably deassert its PCS signal on last word in a queue
- * (hardware limitation), so we need to inform the spi_device that larger
- * buffers than the FIFO size are going to have the chip select randomly
- * toggling, so it has a chance to adapt its message sizes.
- */
-static size_t dspi_max_message_size(struct spi_device *spi)
-{
-	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
-
-	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
-		return dspi->devtype_data->fifo_size;
-
-	return SIZE_MAX;
-}
-
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1283,7 +1238,6 @@ static int dspi_probe(struct platform_device *pdev)
 
 	ctlr->setup = dspi_setup;
 	ctlr->transfer_one_message = dspi_transfer_one_message;
-	ctlr->max_message_size = dspi_max_message_size;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
-- 
2.25.1

