Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644A0301F2B
	for <lists+linux-spi@lfdr.de>; Sun, 24 Jan 2021 23:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAXWSy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Jan 2021 17:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbhAXWSw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Jan 2021 17:18:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67270C061573
        for <linux-spi@vger.kernel.org>; Sun, 24 Jan 2021 14:18:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id jx18so1830394pjb.5
        for <linux-spi@vger.kernel.org>; Sun, 24 Jan 2021 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OqmWKFgrNUflJ6LxYheGG2wEX3U+Swxg7aiGM75A98=;
        b=u5UgUo3/AmtgLV74TIiuvKKDbY/B5ZVzKN+5jO34/tyAG2/uo2i1GPt07EwB1it59K
         YM9nbT0TJrORxlxdLy9ikPw+3XEEVXxch9d1vwezAHJ/Pmk6Z7i7qWAch9iogvUj/gLm
         5xB9ppZolDbMNhV89IFObQicPqchAHMnjsysRS6w7WR/tnac7ay8JZkjRmDSLpuq6aA+
         yfPLADDOnuELyjafkXRLgjSAWUwOu6uKVeJI4gwGsR/IRi/ZtSRXRIOqwRtds+euaQDy
         09Ltnh/bZI9roaTyHPA2R3pr6awFUtCYT85g9ypaz6wN/MODOiuQNKTcMfv/3rM44MU1
         LoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OqmWKFgrNUflJ6LxYheGG2wEX3U+Swxg7aiGM75A98=;
        b=AzqpuPWWyBfeX05lwQeNquYb0cfkc+MnkC01NL0BKl08FiNGEQEsRBLNzrrW/HBpmh
         6De+CHK5tpxGeM48PKu5PflFhxsdeZi875AFzHMshx6gbUKOSERCKnTVhvDA/SIHtgUH
         fAcdOmgnyslvZ4F6LUtoHYRryNaLUo3J8L6H7m5mcPhb0U+w0ljJzS1Ia/k86Ca0eyGV
         izjyN1n8aTjKnj0zaQiAzSemV0KemtETgS4kH2barfG9cm3mFk1RRniJbJC7I6UV4k/Q
         tUwCScPMjnsQgrEz7ZOz7PEI6YjJl3leY5qvUOY+XVtV3xvdKufWYW0ekX9quTMBoX3D
         prgA==
X-Gm-Message-State: AOAM530E4rkAjO/B5BpT5JUMsxC362/c3IoBRYK2C5v3aWTH0iuGKEg/
        WOi5yqMSq7lxC+8PEcnPQ5rA/1w6sP0=
X-Google-Smtp-Source: ABdhPJxqc1DRT6hbtrknyV64xPi7Oaj/O2Rt1Rt/idfaBDtlxbDDfP0GSuRAxzBsEAwNnTxsCz/guA==
X-Received: by 2002:a17:90b:1107:: with SMTP id gi7mr2075272pjb.123.1611526691645;
        Sun, 24 Jan 2021 14:18:11 -0800 (PST)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id q22sm13887973pgi.66.2021.01.24.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 14:18:10 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     ard.biesheuvel@linaro.org, jaswinder.singh@linaro.org,
        masahisa.kojima@linaro.org
Subject: spi: spi-synquacer: fix set_cs handling
Date:   Sun, 24 Jan 2021 16:17:55 -0600
Message-Id: <20210124221755.1587718-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Respect the set_cs() request by actually flushing the FIFOs
and start/stop the SPI instance.

Fixes: b0823ee35cf9b ("spi: Add spi driver for Socionext SynQuacer platform")
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/spi/spi-synquacer.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.14.2

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index f99abd85c50a..3905d1e1dea6 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -365,11 +365,6 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 	val &= ~SYNQUACER_HSSPI_DMSTOP_STOP;
 	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
 
-	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
-	val |= SYNQUACER_HSSPI_FIFOCFG_RX_FLUSH;
-	val |= SYNQUACER_HSSPI_FIFOCFG_TX_FLUSH;
-	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
-
 	/*
 	 * See if we can transfer 4-bytes as 1 word
 	 * to maximize the FIFO buffer efficiency.
@@ -463,10 +458,6 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 			msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
 		writel(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
 
-		/* stop RX and clean RXFIFO */
-		val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
-		val |= SYNQUACER_HSSPI_DMSTOP_STOP;
-		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
 		sspi->rx_buf = buf;
 		sspi->rx_words = SYNQUACER_HSSPI_FIFO_DEPTH;
 		read_fifo(sspi);
@@ -486,11 +477,25 @@ static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
 	struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
 	u32 val;
 
+	if (!(spi->mode & SPI_CS_HIGH))
+		enable = !enable;
+
 	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
 	val &= ~(SYNQUACER_HSSPI_DMPSEL_CS_MASK <<
 		 SYNQUACER_HSSPI_DMPSEL_CS_SHIFT);
 	val |= spi->chip_select << SYNQUACER_HSSPI_DMPSEL_CS_SHIFT;
-	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+	if (enable)
+		val &= ~SYNQUACER_HSSPI_DMSTOP_STOP;
+	else
+		val |= SYNQUACER_HSSPI_DMSTOP_STOP;
+
+	writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+	val |= SYNQUACER_HSSPI_FIFOCFG_RX_FLUSH;
+	val |= SYNQUACER_HSSPI_FIFOCFG_TX_FLUSH;
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
 }
 
 static int synquacer_spi_wait_status_update(struct synquacer_spi *sspi,
