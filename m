Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41029624EED
	for <lists+linux-spi@lfdr.de>; Fri, 11 Nov 2022 01:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKKAat (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Nov 2022 19:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiKKAas (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Nov 2022 19:30:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC125F855
        for <linux-spi@vger.kernel.org>; Thu, 10 Nov 2022 16:30:46 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so3564327oia.9
        for <linux-spi@vger.kernel.org>; Thu, 10 Nov 2022 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2BiIqMCP18viZNfzOooOeiUvEi0CKdbDQR1rDFWitU=;
        b=ei5EVUtLOdwFB1I4lLKe/MGadb/TTalLSla+ndZAmaa7hssJtwlSrvQzdObLZ8Xq+8
         7L12+FqwKdA3c5yp++nwXAQLx/LRyOhx+bwqHFeEB1/AVVJp+/u7eS/AznVhuGidDZfg
         MWs6dN0Owr+eJ+fXWEXNBXvTFmsJ8Eu4DOtRzFNwHRG8cD0PF52hPny26uDgDR2Kmemo
         rkxd3pWBGJe3OoQgecbxUEql03QchRRCuXeg/2cTzFy3x0t8n1wUrRb11QF/SwBjHPPC
         8cL5Xik+/KYNlRRp3vSAuyUThfkbHeAOEiT6jnJQIs/OniuvlW81gFY9zgdVNJNtmxNk
         j9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2BiIqMCP18viZNfzOooOeiUvEi0CKdbDQR1rDFWitU=;
        b=dSyR3/LVBBaoZtImpkAY/SKnvJMpzKQ7bz+vj/VKYbMY3QU/ZrfHt9cOEks3KV/w/5
         SkTDqv5QgDJX4TYSDr/+cgEAO5OkizFVNnsGHfeWdhMXfYOAE4nXoApA1Pz0IbHJ4Ntc
         0wy3m3OJ+i4YYV+C2623f9wK2n2/82eWqq6s7ECN8DGPf+MWGvAqX0Mkw84VKxWlY+ck
         KOKSMj8rjXMQKoPcvXNd+U60xB4vXPzX3qNJSApYrvnrlLP1sa2QDPzsgTW9fYQ16Yhr
         oodzoH0mEV7I4+sWj9UOIpZTc4aOwd7WcWsSq+IvqjDbyPQGJyf0pSnp+PcJASXKBZjR
         STfA==
X-Gm-Message-State: ACrzQf2yBrG/sryTvn0Zn7A/YbY/FZUHPuGKEEpqy61QarQGRm9zZ37Q
        Sx6QfBEdFDWOjnXfen/1T2o=
X-Google-Smtp-Source: AMsMyM4znQtrXwbJpWHBz26gvYBHNXWJN/E9Xhi3J5MGcDJXzHEKSqKti9mAp290VYJkoshv62vIJQ==
X-Received: by 2002:a05:6808:3006:b0:354:93a1:191a with SMTP id ay6-20020a056808300600b0035493a1191amr2524516oib.78.1668126645793;
        Thu, 10 Nov 2022 16:30:45 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:4b69:6165:d687:de99:90f9])
        by smtp.gmail.com with ESMTPSA id 72-20020a9d034e000000b0066c45517c8fsm424510otv.52.2022.11.10.16.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:30:45 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     mkl@pengutronix.de, david@protonic.nl, linux-spi@vger.kernel.org,
        frieder.schrempf@kontron.de, Fabio Estevam <festevam@gmail.com>,
        stable@kernel.org
Subject: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling support"
Date:   Thu, 10 Nov 2022 21:30:32 -0300
Message-Id: <20221111003032.82371-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit 07e7593877882fbd07c55b26b7dcf88760449323.

Since commit 07e759387788 ("spi: spi-imx: add PIO polling support") it is
no longer possible to do successful SPI NOR programming on
imx8mm-kontron-n801x-som, even though the copy operation returns no errors
to the user.

After programming the SPI NOR flash from Linux, the board fails to
boot from SPI NOR, leading to an unbootable system.

Revert it to fix the regression.

Cc: stable@kernel.org
Fixes: 07e759387788 ("spi: spi-imx: add PIO polling support")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-imx.c | 66 -------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a4bda03d3a8e..b946d98a8d66 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -31,12 +31,6 @@ static bool use_dma = true;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Enable usage of DMA when available (default)");
 
-/* define polling limits */
-static unsigned int polling_limit_us = 30;
-module_param(polling_limit_us, uint, 0664);
-MODULE_PARM_DESC(polling_limit_us,
-		 "time in us to run a transfer in polling mode\n");
-
 #define MXC_RPM_TIMEOUT		2000 /* 2000ms */
 
 #define MXC_CSPIRXDATA		0x00
@@ -1490,54 +1484,6 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int spi_imx_poll_transfer(struct spi_device *spi,
-				 struct spi_transfer *transfer)
-{
-	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
-	unsigned long timeout;
-
-	spi_imx->tx_buf = transfer->tx_buf;
-	spi_imx->rx_buf = transfer->rx_buf;
-	spi_imx->count = transfer->len;
-	spi_imx->txfifo = 0;
-	spi_imx->remainder = 0;
-
-	/* fill in the fifo before timeout calculations if we are
-	 * interrupted here, then the data is getting transferred by
-	 * the HW while we are interrupted
-	 */
-	spi_imx_push(spi_imx);
-
-	timeout = spi_imx_calculate_timeout(spi_imx, transfer->len) + jiffies;
-	while (spi_imx->txfifo) {
-		/* RX */
-		while (spi_imx->txfifo &&
-		       spi_imx->devtype_data->rx_available(spi_imx)) {
-			spi_imx->rx(spi_imx);
-			spi_imx->txfifo--;
-		}
-
-		/* TX */
-		if (spi_imx->count) {
-			spi_imx_push(spi_imx);
-			continue;
-		}
-
-		if (spi_imx->txfifo &&
-		    time_after(jiffies, timeout)) {
-
-			dev_err_ratelimited(&spi->dev,
-					    "timeout period reached: jiffies: %lu- falling back to interrupt mode\n",
-					    jiffies - timeout);
-
-			/* fall back to interrupt mode */
-			return spi_imx_pio_transfer(spi, transfer);
-		}
-	}
-
-	return 0;
-}
-
 static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 				      struct spi_transfer *transfer)
 {
@@ -1587,7 +1533,6 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
-	unsigned long hz_per_byte, byte_limit;
 
 	spi_imx_setupxfer(spi, transfer);
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
@@ -1599,17 +1544,6 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	if (spi_imx->slave_mode)
 		return spi_imx_pio_transfer_slave(spi, transfer);
 
-	/*
-	 * Calculate the estimated time in us the transfer runs. Find
-	 * the number of Hz per byte per polling limit.
-	 */
-	hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
-	byte_limit = hz_per_byte ? transfer->effective_speed_hz / hz_per_byte : 1;
-
-	/* run in polling mode for short transfers */
-	if (transfer->len < byte_limit)
-		return spi_imx_poll_transfer(spi, transfer);
-
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
 
-- 
2.25.1

