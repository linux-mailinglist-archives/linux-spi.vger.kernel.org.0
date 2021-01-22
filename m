Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D467D2FFE10
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 09:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbhAVIWK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 03:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbhAVIWI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jan 2021 03:22:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A1CC0613D6;
        Fri, 22 Jan 2021 00:21:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e15so3586004wme.0;
        Fri, 22 Jan 2021 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIov58JYpMWXYAc4LiGP6ZzAFZsr1Wt1BbAslAKCrgs=;
        b=p+MfCjgPUdBI5/7GBfXLj+UmuknaLtUf9H9/HyXDc2qZZwieN2HBtz37LNJ2U6CvpO
         AOFN0q9KuQ6RbxSIu8MKx+kVDouVVKzvpZOQxFCwn690dB0B0JLRW6tLb4YKW9j3TlrK
         0zmsun9ipxuPhb2wiBobvMVQjvlWbKb2hMJagkctqTwDNRUaAkPCB3mwTsVEJSe7+q/Z
         qFI0+d7JlHZX4ri2aTxJroP2IlrYkBYldGBrMYdSwMY8dB72Ob2+YHeWFiRsQFa/4Nkq
         mlsmqB61bSR+2tgEkiHy6UkK853uWXFn/BBXoJpuo7XsRxz+ZuJIVZP/WDUgvbIPpqfx
         Y2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIov58JYpMWXYAc4LiGP6ZzAFZsr1Wt1BbAslAKCrgs=;
        b=g1Ncb5H6AVERZFrCecPYD5cJcsaaaMug/vE4bCzO9Q9yKDjftxpy1GwfCL3xmFNx2N
         1TTlYUjAL/Q48M5JmgxgEq0SBWt4nvOWWgR/+p5FqNpkJseeUoFk2/uOzPQQnpEeXNgV
         b2WdKVQD1uWaLJjCi5RNxhNzrPQtU4xMfpDqCE03amBeBYN8zSm3L9N/yB8X/V3WvO9J
         MPR2vnj2SZKhWteAp0ejYa2V2SQa3NPrTkMI+PIilH/hHH4R/bdMszUt8vClFI6J4gFN
         bAOvsQCJQWhDpw+ZnuQXuQYigIfPYYorORYLN1+Yg2+hy0velJZVFr+8VFCjD5tyPAFx
         Yxgg==
X-Gm-Message-State: AOAM531YHMyFxNcV5csLAihA9X7NGRnGbwRyWgZlAwRqYLIoP1yGk832
        FffDd0ufcvYUgmndgPRqXw0=
X-Google-Smtp-Source: ABdhPJxxCqelGf+rxQGEbhJh4Iv4dQwW6jPm81pbZ2qdHzqhNjFirxZ63+qIt1+TfWmfymo0IwcJdQ==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr2740656wmh.38.1611303686427;
        Fri, 22 Jan 2021 00:21:26 -0800 (PST)
Received: from localhost.localdomain ([37.170.192.23])
        by smtp.googlemail.com with ESMTPSA id g132sm11266513wmg.2.2021.01.22.00.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 00:21:25 -0800 (PST)
From:   corentin <corentin.noel56@gmail.com>
X-Google-Original-From: corentin <corentin.noel.external@stormshield.eu>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        corentin <corentin.noel56@gmail.com>
Subject: [PATCH] drivers: spi: spi-au1550: Fix various whitespace warnings
Date:   Fri, 22 Jan 2021 09:20:40 +0100
Message-Id: <20210122082040.30788-1-corentin.noel.external@stormshield.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: corentin <corentin.noel56@gmail.com>

Signed-off-by: corentin <corentin.noel56@gmail.com>
---
 drivers/spi/spi-au1550.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index dfb7196f4caf..ca9121ce668d 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -74,8 +74,7 @@ struct au1550_spi {
 
 
 /* we use an 8-bit memory device for dma transfers to/from spi fifo */
-static dbdev_tab_t au1550_spi_mem_dbdev =
-{
+static dbdev_tab_t au1550_spi_mem_dbdev = {
 	.dev_id			= DBDMA_MEM_CHAN,
 	.dev_flags		= DEV_FLAGS_ANYUSE|DEV_FLAGS_SYNC,
 	.dev_tsize		= 0,
@@ -399,10 +398,10 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 			DMA_FROM_DEVICE);
 	}
 	/* unmap buffers if mapped above */
-	if (t->rx_buf && t->rx_dma == 0 )
+	if (t->rx_buf && t->rx_dma == 0)
 		dma_unmap_single(hw->dev, dma_rx_addr, t->len,
 			DMA_FROM_DEVICE);
-	if (t->tx_buf && t->tx_dma == 0 )
+	if (t->tx_buf && t->tx_dma == 0)
 		dma_unmap_single(hw->dev, dma_tx_addr, t->len,
 			DMA_TO_DEVICE);
 
@@ -493,12 +492,12 @@ static void au1550_spi_tx_word_##size(struct au1550_spi *hw)		\
 	wmb(); /* drain writebuffer */					\
 }
 
-AU1550_SPI_RX_WORD(8,0xff)
-AU1550_SPI_RX_WORD(16,0xffff)
-AU1550_SPI_RX_WORD(32,0xffffff)
-AU1550_SPI_TX_WORD(8,0xff)
-AU1550_SPI_TX_WORD(16,0xffff)
-AU1550_SPI_TX_WORD(32,0xffffff)
+AU1550_SPI_RX_WORD(8, 0xff)
+AU1550_SPI_RX_WORD(16, 0xffff)
+AU1550_SPI_RX_WORD(32, 0xffffff)
+AU1550_SPI_TX_WORD(8, 0xff)
+AU1550_SPI_TX_WORD(16, 0xffff)
+AU1550_SPI_TX_WORD(32, 0xffffff)
 
 static int au1550_spi_pio_txrxb(struct spi_device *spi, struct spi_transfer *t)
 {
@@ -636,12 +635,14 @@ static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
 static int au1550_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+
 	return hw->txrx_bufs(spi, t);
 }
 
 static irqreturn_t au1550_spi_irq(int irq, void *dev)
 {
 	struct au1550_spi *hw = dev;
+
 	return hw->irq_callback(hw);
 }
 
@@ -872,6 +873,7 @@ static int au1550_spi_probe(struct platform_device *pdev)
 	{
 		int min_div = (2 << 0) * (2 * (4 + 1));
 		int max_div = (2 << 3) * (2 * (63 + 1));
+
 		master->max_speed_hz = hw->pdata->mainclk_hz / min_div;
 		master->min_speed_hz =
 				hw->pdata->mainclk_hz / (max_div + 1) + 1;
-- 
2.25.1

