Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43509398FA5
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFBQKV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 12:10:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16512 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhFBQKU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 12:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622650118; x=1654186118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xM1Z4XPCdE5QfVSLjvhJSs57E9XcJ2Y6MAuOiSOnj9U=;
  b=HiH2upfNOCpBPWXzXNPyx8w1HjM3qqbJvoTgT1T9e+ZWrqpaXlRrfa+D
   52id4VbV29ZXKYfpTzCizlsGDGuDekPDuwU0iU89yJnpN7a/YVA80bZWF
   kV3KlCWiUbcFwSveJv8MDL72YwrqXr+j2YQ+mWRBUS9SEeid87MmLQFvG
   V4alnpVEYxfufvonv8H3V9BLiDuc8B/CCdscd78X2HJCgYhgEY0HxIig/
   NTnH1UjDOKp5gmBbSuyeUIvbO3PWfrpBmy8QZMbyq+Va9W4g9OQM/mxzP
   aghmAVmDqxoeYDewioq9/tkBRRIelBCHqpWUMQXpuKG8M/TVz/hvS/+3i
   Q==;
IronPort-SDR: lnKl10SvjnU5CCbCAzOVyTkuRemZZf9aV2vQmLZBkqnlh0mZGVM7+AR2oOaQl5SPwwu4Eyv2SW
 innJFxDpjploJtbMbDkiv4amsqHM/ZbsF0Xju/QU3JW/7Nr10UpUc/NH881V7rCJnbq4qwcSQ7
 MIu86H9RTV5R9U1uP3YBb7XUxOAHYgF82GTPGvyuyK3PfeUBoDDN1/rKhuYku0DvkAhZXpJ3RH
 09P9gNKxiFzkmvRsycUQCE+mJctnHOhjDIprSXhRYe0t+K2ZzohTt91TA6xF1tPw6cWRHRLeGP
 fyQ=
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="123275443"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2021 09:08:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:08:36 -0700
Received: from dan-linux.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 2 Jun 2021 09:08:36 -0700
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
Subject: [PATCH 2/2] spi: atmel: Reduce spin lock usage
Date:   Wed, 2 Jun 2021 09:08:15 -0700
Message-ID: <20210602160816.4890-2-dan.sneddon@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602160816.4890-1-dan.sneddon@microchip.com>
References: <20210602160816.4890-1-dan.sneddon@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The current implementation of the driver holds a spin lock for the
duration of the transfer, releasing it only to enable interrupts for
short periods of time.  As this would prevent any interrupt from
happening, this could cause system performance issues every time a SPI
message is sent.  Since the spi core now handles message syncronization
we can reduce the amount of time the spin-lock is held to the regions
where both the calling thread and the interrupt might interract.

Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
---
 drivers/spi/spi-atmel.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0e693e72c922..2ef74885ffa2 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -700,7 +700,6 @@ static void atmel_spi_next_xfer_pio(struct spi_master *master,
 static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 				struct spi_transfer *xfer,
 				u32 *plen)
-	__must_hold(&as->lock)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct dma_chan		*rxchan = master->dma_rx;
@@ -716,8 +715,6 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	if (!rxchan || !txchan)
 		return -ENODEV;
 
-	/* release lock for DMA operations */
-	atmel_spi_unlock(as);
 
 	*plen = xfer->len;
 
@@ -786,15 +783,12 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	rxchan->device->device_issue_pending(rxchan);
 	txchan->device->device_issue_pending(txchan);
 
-	/* take back lock */
-	atmel_spi_lock(as);
 	return 0;
 
 err_dma:
 	spi_writel(as, IDR, SPI_BIT(OVRES));
 	atmel_spi_stop_dma(master);
 err_exit:
-	atmel_spi_lock(as);
 	return -ENOMEM;
 }
 
@@ -1053,8 +1047,6 @@ atmel_spi_pump_pio_data(struct atmel_spi *as, struct spi_transfer *xfer)
 
 /* Interrupt
  *
- * No need for locking in this Interrupt handler: done_status is the
- * only information modified.
  */
 static irqreturn_t
 atmel_spi_pio_interrupt(int irq, void *dev_id)
@@ -1302,8 +1294,6 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	unsigned long		dma_timeout;
 
 	as = spi_master_get_devdata(master);
-	/* This lock was orignally taken in atmel_spi_trasfer_one_message */
-	atmel_spi_lock(as);
 
 	asd = spi->controller_state;
 	bits = (asd->csr >> 4) & 0xf;
@@ -1332,7 +1322,9 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		reinit_completion(&as->xfer_completion);
 
 		if (as->use_pdc) {
+			atmel_spi_lock(as);
 			atmel_spi_pdc_next_xfer(master, xfer);
+			atmel_spi_unlock(as);
 		} else if (atmel_spi_use_dma(as, xfer)) {
 			len = as->current_remaining_bytes;
 			ret = atmel_spi_next_xfer_dma_submit(master,
@@ -1348,14 +1340,13 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 					as->current_remaining_bytes = 0;
 			}
 		} else {
+			atmel_spi_lock(as);
 			atmel_spi_next_xfer_pio(master, xfer);
+			atmel_spi_unlock(as);
 		}
 
-		/* interrupts are disabled, so free the lock for schedule */
-		atmel_spi_unlock(as);
 		dma_timeout = wait_for_completion_timeout(&as->xfer_completion,
 							  SPI_DMA_TIMEOUT);
-		atmel_spi_lock(as);
 		if (WARN_ON(dma_timeout == 0)) {
 			dev_err(&spi->dev, "spi transfer timeout\n");
 			as->done_status = -EIO;
@@ -1403,8 +1394,6 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	if (as->use_pdc)
 		atmel_spi_disable_pdc_transfer(as);
 
-	atmel_spi_unlock(as);
-
 	return as->done_status;
 }
 
-- 
2.17.1

