Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92C398FA4
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFBQKU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 12:10:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16512 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFBQKU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 12:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622650118; x=1654186118;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=UjDEAZpz89SSiZ6EJwwrCicKYWz8Tlvi693/IFwHgWA=;
  b=1vUMzj+empbFOLZ300eWUQToxs6BHPJ3Ct9GmV6FQwvi8SlC5wX2CzmI
   jdLLCRi2sPmGLlzvz+pj1V7vXbl0J60ClRhGUTu5vhcHr3qyeIxaWn+NU
   CmoWsPZh+f6UcuPJJ4XUVIUnPovdGOJmBOsQRxS96O+BSrWU6CvGv9W6H
   287a9Bb9WAQlGAjDImuhJWp6Tn3EQlBZ0yzlMPmMTyikBavu3kB+UnHd9
   9r7uy85yABexKgH/Qb13dFWALJmBkB/5t0VdIjezsPLGKlk76v65dz7Py
   ML5YjIlGlkTecSuA3Z/9zcr7NA4NzWDfbfexRkfA64ujanhtXmOXhIcLd
   Q==;
IronPort-SDR: uEmO9FZw+ftc1lc44Cm3/4/qLkejKle6n4xy2E1HDTxzE4tynPRqhR0EZ8QuGNyvHpcg07HNog
 W6Ls2yXYkCUSEqMLudMK4TA7Nt2R7I1EyEof8/7UVZsTRK0x3LBHakqCuVdOC289qrkZE+I4v/
 trlvU8/na6ZXXJqxvwM9mIG8hFuGGYHCSAtutHituM2HEoLdf0B2cpuwosttou8+ck7RsHQKQk
 wWkyRQ+hPsuviiQixgPEKf7+w68SZJ64JPjyhxLP/TdevSGePQ5myPGkJuL0hgwzpDr15hVA6N
 xM8=
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="123275440"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2021 09:08:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:08:35 -0700
Received: from dan-linux.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 2 Jun 2021 09:08:35 -0700
From:   Dan Sneddon <dan.sneddon@microchip.com>
To:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Sneddon <dan.sneddon@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 1/2] spi: atmel: Switch to transfer_one transfer method
Date:   Wed, 2 Jun 2021 09:08:14 -0700
Message-ID: <20210602160816.4890-1-dan.sneddon@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch from using our own transfer_one_message routine to using the one
provided by the SPI core.

Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
---
 drivers/spi/spi-atmel.c | 124 +++++++++++-----------------------------
 1 file changed, 33 insertions(+), 91 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 7cd5fe00dfc1..0e693e72c922 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -863,7 +863,6 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
  * lock is held, spi irq is blocked
  */
 static void atmel_spi_pdc_next_xfer(struct spi_master *master,
-					struct spi_message *msg,
 					struct spi_transfer *xfer)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
@@ -879,12 +878,12 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 	spi_writel(as, RPR, rx_dma);
 	spi_writel(as, TPR, tx_dma);
 
-	if (msg->spi->bits_per_word > 8)
+	if (xfer->bits_per_word > 8)
 		len >>= 1;
 	spi_writel(as, RCR, len);
 	spi_writel(as, TCR, len);
 
-	dev_dbg(&msg->spi->dev,
+	dev_dbg(&master->dev,
 		"  start xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 		xfer, xfer->len, xfer->tx_buf,
 		(unsigned long long)xfer->tx_dma, xfer->rx_buf,
@@ -898,12 +897,12 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 		spi_writel(as, RNPR, rx_dma);
 		spi_writel(as, TNPR, tx_dma);
 
-		if (msg->spi->bits_per_word > 8)
+		if (xfer->bits_per_word > 8)
 			len >>= 1;
 		spi_writel(as, RNCR, len);
 		spi_writel(as, TNCR, len);
 
-		dev_dbg(&msg->spi->dev,
+		dev_dbg(&master->dev,
 			"  next xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 			xfer, xfer->len, xfer->tx_buf,
 			(unsigned long long)xfer->tx_dma, xfer->rx_buf,
@@ -1273,12 +1272,28 @@ static int atmel_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static void atmel_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct atmel_spi *as = spi_master_get_devdata(spi->master);
+	/* the core doesn't really pass us enable/disable, but CS HIGH vs CS LOW
+	 * since we already have routines for activate/deactivate translate
+	 * high/low to active/inactive
+	 */
+	enable = (!!(spi->mode & SPI_CS_HIGH) == enable);
+
+	if (enable) {
+		cs_activate(as, spi);
+	} else {
+		cs_deactivate(as, spi);
+	}
+
+}
+
 static int atmel_spi_one_transfer(struct spi_master *master,
-					struct spi_message *msg,
+					struct spi_device *spi,
 					struct spi_transfer *xfer)
 {
 	struct atmel_spi	*as;
-	struct spi_device	*spi = msg->spi;
 	u8			bits;
 	u32			len;
 	struct atmel_spi_device	*asd;
@@ -1287,11 +1302,8 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	unsigned long		dma_timeout;
 
 	as = spi_master_get_devdata(master);
-
-	if (!(xfer->tx_buf || xfer->rx_buf) && xfer->len) {
-		dev_dbg(&spi->dev, "missing rx or tx buf\n");
-		return -EINVAL;
-	}
+	/* This lock was orignally taken in atmel_spi_trasfer_one_message */
+	atmel_spi_lock(as);
 
 	asd = spi->controller_state;
 	bits = (asd->csr >> 4) & 0xf;
@@ -1305,13 +1317,13 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
 	 */
-	if ((!msg->is_dma_mapped)
+	if ((!master->cur_msg_mapped)
 		&& as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
 	}
 
-	atmel_spi_set_xfer_speed(as, msg->spi, xfer);
+	atmel_spi_set_xfer_speed(as, spi, xfer);
 
 	as->done_status = 0;
 	as->current_transfer = xfer;
@@ -1320,7 +1332,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		reinit_completion(&as->xfer_completion);
 
 		if (as->use_pdc) {
-			atmel_spi_pdc_next_xfer(master, msg, xfer);
+			atmel_spi_pdc_next_xfer(master, xfer);
 		} else if (atmel_spi_use_dma(as, xfer)) {
 			len = as->current_remaining_bytes;
 			ret = atmel_spi_next_xfer_dma_submit(master,
@@ -1328,7 +1340,8 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			if (ret) {
 				dev_err(&spi->dev,
 					"unable to use DMA, fallback to PIO\n");
-				atmel_spi_next_xfer_pio(master, xfer);
+				as->done_status = ret;
+				break;
 			} else {
 				as->current_remaining_bytes -= len;
 				if (as->current_remaining_bytes < 0)
@@ -1381,90 +1394,18 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		} else if (atmel_spi_use_dma(as, xfer)) {
 			atmel_spi_stop_dma(master);
 		}
-
-		if (!msg->is_dma_mapped
-			&& as->use_pdc)
-			atmel_spi_dma_unmap_xfer(master, xfer);
-
-		return 0;
-
-	} else {
-		/* only update length if no error */
-		msg->actual_length += xfer->len;
 	}
 
-	if (!msg->is_dma_mapped
+	if (!master->cur_msg_mapped
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-	spi_transfer_delay_exec(xfer);
-
-	if (xfer->cs_change) {
-		if (list_is_last(&xfer->transfer_list,
-				 &msg->transfers)) {
-			as->keep_cs = true;
-		} else {
-			cs_deactivate(as, msg->spi);
-			udelay(10);
-			cs_activate(as, msg->spi);
-		}
-	}
-
-	return 0;
-}
-
-static int atmel_spi_transfer_one_message(struct spi_master *master,
-						struct spi_message *msg)
-{
-	struct atmel_spi *as;
-	struct spi_transfer *xfer;
-	struct spi_device *spi = msg->spi;
-	int ret = 0;
-
-	as = spi_master_get_devdata(master);
-
-	dev_dbg(&spi->dev, "new message %p submitted for %s\n",
-					msg, dev_name(&spi->dev));
-
-	atmel_spi_lock(as);
-	cs_activate(as, spi);
-
-	as->keep_cs = false;
-
-	msg->status = 0;
-	msg->actual_length = 0;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		trace_spi_transfer_start(msg, xfer);
-
-		ret = atmel_spi_one_transfer(master, msg, xfer);
-		if (ret)
-			goto msg_done;
-
-		trace_spi_transfer_stop(msg, xfer);
-	}
-
 	if (as->use_pdc)
 		atmel_spi_disable_pdc_transfer(as);
 
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		dev_dbg(&spi->dev,
-			"  xfer %p: len %u tx %p/%pad rx %p/%pad\n",
-			xfer, xfer->len,
-			xfer->tx_buf, &xfer->tx_dma,
-			xfer->rx_buf, &xfer->rx_dma);
-	}
-
-msg_done:
-	if (!as->keep_cs)
-		cs_deactivate(as, msg->spi);
-
 	atmel_spi_unlock(as);
 
-	msg->status = as->done_status;
-	spi_finalize_current_message(spi->master);
-
-	return ret;
+	return as->done_status;
 }
 
 static void atmel_spi_cleanup(struct spi_device *spi)
@@ -1554,7 +1495,8 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = 4;
 	master->setup = atmel_spi_setup;
 	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
-	master->transfer_one_message = atmel_spi_transfer_one_message;
+	master->transfer_one = atmel_spi_one_transfer;
+	master->set_cs = atmel_spi_set_cs;
 	master->cleanup = atmel_spi_cleanup;
 	master->auto_runtime_pm = true;
 	master->max_dma_len = SPI_MAX_DMA_XFER;
-- 
2.17.1

