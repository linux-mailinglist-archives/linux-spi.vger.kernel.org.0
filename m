Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101B0276A29
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgIXHLh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 03:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgIXHLb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 03:11:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D345C0613D3
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 00:11:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so2556890wrn.6
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4u6onsjNQAkiyKVPFStn7UMSA1vGrvkOxMgEEn1VI8=;
        b=VvV8gFrLifCsCoj+X0Wi0ZEDDpxi+3XlTGnBd8ZM9d82iDEu/KWjUUP2XbmxZ8VywW
         JLSwa3ddcLlVBP1MwmoYQbvlLwGLLYgbRNhpoh7oLu/oeOXUvblT9LfvSVYLP0j8F1O4
         /AlE6z4kG30aKIFyhKnAE+AOwJbsvEpbI+FZ/uxcHjh58JATQEJffmRI+z6S1pL/EvAK
         jpMjc43ozw2Q0593PcSS/fjV5QsbIZayDoq7YHWbzfMvPJfbAwbFTWhQn0RlnZbYfW8/
         ohT3WomFdG588TtdQZI+LxK1pBLepQu/n4X+Tyo/vd9Iy2coWC6Ac4KKRZL6n1v3eRuQ
         YYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=E4u6onsjNQAkiyKVPFStn7UMSA1vGrvkOxMgEEn1VI8=;
        b=tsBHULAFLGYvg//miP5o0fKhOl+lXR0E5G4egYwBacY4sdCd6F4fVoDooDznWO4sqU
         nTeCPAlPSbQCy7kVhoAxNtbjQmgQmVzlfjajR0CKH9MFpIE39ZJXuJpxZchty2uqGNsx
         /utc6QBRC7FLqjx9K22KTSJg09PxHOG/yq+dr/50XfN2ZlUUmJJBZu8cLgXLj2Ft7xEh
         IBHr1ipWh2vYERj03KJEhSyvXnUqih7pnKrqI5MD3ayI+1poNr6fIVm1NtrI0Vp2c88T
         JmVlSQBskMvN3uQMBKv62BqoNI5b22uJqzKDKLq4JQ+TFuCU8x+mTuC0WYXPzGcL5yWG
         9i9A==
X-Gm-Message-State: AOAM533NMUCs7Z19gyrt5UOyhS/qVItFltLEXXbYbx+0Tzxmj5dYa+F8
        m/ZfC98nYXDgN6NU/woqCj0PnQ==
X-Google-Smtp-Source: ABdhPJx1lB2GSaJXhR5AfoItpRpCWhYYEu68XMGAO+MpVTExlkmJSxL8aHckdqMdQycv6vQHUWEjGw==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr3788781wrm.0.1600931489909;
        Thu, 24 Sep 2020 00:11:29 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i15sm2457469wrb.91.2020.09.24.00.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:11:29 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     broonie@kernel.org
Cc:     amit.kumar-mahapatra@xilinx.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND v2 PATCH 3/3] spi: spi-zynqmp-gqspi: Fix incorrect indentation
Date:   Thu, 24 Sep 2020 09:11:19 +0200
Message-Id: <2b246b6f0925c8a2a767a4240e8738ffeefd62be.1600931476.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600931476.git.michal.simek@xilinx.com>
References: <cover.1600931476.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Fixed incorrect indentation in ZynqMP qspi controller driver.

Addresses-checkpatch: "Alignment should match open parenthesis"
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/spi/spi-zynqmp-gqspi.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 7f57923f76ea..c8fa6ee18ae7 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -326,8 +326,8 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 				 GQSPI_SELECT_FLASH_BUS_LOWER);
 	/* Initialize DMA */
 	zynqmp_gqspi_write(xqspi,
-			GQSPI_QSPIDMA_DST_CTRL_OFST,
-			GQSPI_QSPIDMA_DST_CTRL_RESET_VAL);
+			   GQSPI_QSPIDMA_DST_CTRL_OFST,
+			   GQSPI_QSPIDMA_DST_CTRL_RESET_VAL);
 
 	/* Enable the GQSPI */
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
@@ -374,8 +374,8 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	/* Manually start the generic FIFO command */
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-			GQSPI_CFG_START_GEN_FIFO_MASK);
+			   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
+			   GQSPI_CFG_START_GEN_FIFO_MASK);
 
 	timeout = jiffies + msecs_to_jiffies(1000);
 
@@ -384,10 +384,9 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 		statusreg = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
 
 		if ((statusreg & GQSPI_ISR_GENFIFOEMPTY_MASK) &&
-			(statusreg & GQSPI_ISR_TXEMPTY_MASK))
+		    (statusreg & GQSPI_ISR_TXEMPTY_MASK))
 			break;
-		else
-			cpu_relax();
+		cpu_relax();
 	} while (!time_after_eq(jiffies, timeout));
 
 	if (time_after_eq(jiffies, timeout))
@@ -549,7 +548,7 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *xqspi, u32 size)
 
 	while ((count < size) && (xqspi->bytes_to_receive > 0)) {
 		if (xqspi->bytes_to_receive >= 4) {
-			(*(u32 *) xqspi->rxbuf) =
+			(*(u32 *)xqspi->rxbuf) =
 			zynqmp_gqspi_read(xqspi, GQSPI_RXD_OFST);
 			xqspi->rxbuf += 4;
 			xqspi->bytes_to_receive -= 4;
@@ -645,14 +644,14 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 	u32 config_reg, genfifoentry;
 
 	dma_unmap_single(xqspi->dev, xqspi->dma_addr,
-				xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
+			 xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
 	xqspi->rxbuf += xqspi->dma_rx_bytes;
 	xqspi->bytes_to_receive -= xqspi->dma_rx_bytes;
 	xqspi->dma_rx_bytes = 0;
 
 	/* Disabling the DMA interrupts */
 	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_DIS_OFST,
-					GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
+			   GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
 
 	if (xqspi->bytes_to_receive > 0) {
 		/* Switch to IO mode,for remaining bytes to receive */
@@ -670,14 +669,15 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 
 		/* Manual start */
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-			(zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-			GQSPI_CFG_START_GEN_FIFO_MASK));
+				   (zynqmp_gqspi_read(xqspi,
+						      GQSPI_CONFIG_OFST) |
+				   GQSPI_CFG_START_GEN_FIFO_MASK));
 
 		/* Enable the RX interrupts for IO mode */
 		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
-				GQSPI_IER_GENFIFOEMPTY_MASK |
-				GQSPI_IER_RXNEMPTY_MASK |
-				GQSPI_IER_RXEMPTY_MASK);
+				   GQSPI_IER_GENFIFOEMPTY_MASK |
+				   GQSPI_IER_RXNEMPTY_MASK |
+				   GQSPI_IER_RXEMPTY_MASK);
 	}
 }
 
@@ -708,7 +708,7 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 		dma_status =
 			zynqmp_gqspi_read(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST);
 		zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST,
-								dma_status);
+				   dma_status);
 	}
 
 	if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
@@ -725,8 +725,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
-	if ((xqspi->bytes_to_receive == 0) && (xqspi->bytes_to_transfer == 0)
-			&& ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
+	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
+	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
 		complete(&xqspi->data_completion);
 		ret = IRQ_HANDLED;
@@ -744,8 +744,8 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 	dma_addr_t addr;
 	u64 dma_align =  (u64)(uintptr_t)xqspi->rxbuf;
 
-	if ((xqspi->bytes_to_receive < 8) ||
-		((dma_align & GQSPI_DMA_UNALIGN) != 0x0)) {
+	if (xqspi->bytes_to_receive < 8 ||
+	    ((dma_align & GQSPI_DMA_UNALIGN) != 0x0)) {
 		/* Setting to IO mode */
 		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
 		config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
@@ -759,17 +759,17 @@ static void zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 	rx_bytes = (xqspi->bytes_to_receive - rx_rem);
 
 	addr = dma_map_single(xqspi->dev, (void *)xqspi->rxbuf,
-						rx_bytes, DMA_FROM_DEVICE);
+			      rx_bytes, DMA_FROM_DEVICE);
 	if (dma_mapping_error(xqspi->dev, addr))
 		dev_err(xqspi->dev, "ERR:rxdma:memory not mapped\n");
 
 	xqspi->dma_rx_bytes = rx_bytes;
 	xqspi->dma_addr = addr;
 	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_OFST,
-				(u32)(addr & 0xffffffff));
+			   (u32)(addr & 0xffffffff));
 	addr = ((addr >> 16) >> 16);
 	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_MSB_OFST,
-				((u32)addr) & 0xfff);
+			   ((u32)addr) & 0xfff);
 
 	/* Enabling the DMA mode */
 	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
-- 
2.28.0

