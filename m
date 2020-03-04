Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAB179B6D
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbgCDWCP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39651 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388543AbgCDWCJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id j1so3495259wmi.4;
        Wed, 04 Mar 2020 14:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KdIcE5d8Uw19DbXJrimdSx5cb22qFvX6ysB7MYCKIMM=;
        b=DT74En0t8WP6H/Hexamx0rxCsqFPiiha4yzOdsehfam6IQBtGInXvKUFXioP5nUlSc
         poRsG9gB/iKu9aUyo4BV3OiWHggC+lF5BAdgv4OWBKzkt43Lkp6l+Z93hRtKrHKTtInp
         clG4/BfBouQT4C8CIZXzutBdqGBJG1wkUMF8M60X/sTGWL/dn4R63gi9ieQJzlIpdfU7
         nSn8McAArL3b8QLNSUTvkhx0CRSbC3hRK6XhrMymlW6D99UJSDTJz1WZv1tsFIY6xpeE
         N1Z06otI6bhcnCrFx4gnFri2Jg4/6PRCYtIaxmbZ+pm+R+00U5fo+o0NZbuG+61vpKXE
         7I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KdIcE5d8Uw19DbXJrimdSx5cb22qFvX6ysB7MYCKIMM=;
        b=SoFx1+n3gZcxdk7bsfdlWEcpbcxS5NLmGWsUJU6d660cDMh0cjB7iJh8QG+dRCggdV
         uY5wtN41qDKQ+Euy2Q3e+Io7wa19YwRwodvwOUYonZjHsm5QuXfCrR4rjuZgyskl0k7E
         wowIs9vmk7ePgPEYqkA4VyKo0D50FYrojoWBGNVnVXrwfkX5kBIj8SHTAYL/GOxeMuOh
         zquCxkabMNfyr71D6bmru+fWK089q0A9wzCLV6Of8bixO8pDiCJUFv21hpDqCsRPCtex
         3EDYewkOZcnLPdhthl+9o3w7hvMcs83a0tf4Vef02Px9tEyXhY8/BGSHgG3wXUR0ucro
         e/7w==
X-Gm-Message-State: ANhLgQ3+ypzmzKU+lN97DWXI0fY9RF42oK590Sps1E9Rw3/P32MGbL2W
        2HYzeXuvLUgQz1JolVIHD7o=
X-Google-Smtp-Source: ADFU+vs5VXV7lI5oAktJlLp9+JLzZTPIciZWhBuqWaMxv27GlCHOahYTOfLiGOWZ1UIwAfK67+gJWg==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr5516319wmi.20.1583359327911;
        Wed, 04 Mar 2020 14:02:07 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:07 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 12/12] spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write
Date:   Thu,  5 Mar 2020 00:00:44 +0200
Message-Id: <20200304220044.11193-13-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Although the SPI system timestamps are supposed to reflect the moment
that the peripheral has received a word rather than the moment when the
CPU has enqueued that word to the FIFO, in practice it is easier to just
record the latter time than the former (with a smaller error).

With the recent migration of TCFQ users from poll back to interrupt mode
(this time for XSPI FIFO), it's wiser to keep the interrupt latency
outside of the measurement of the PTP system timestamp itself. If there
proves to be any constant offset that requires static compensation, that
can always be added later. So far that does not appear to be the case at
least on the LS1021A-TSN board, where testing shows that the phc2sys
offset is able to remain within +/- 200 ns even after 68 hours of
testing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d5983be32180..b5ab0afbfa26 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -838,19 +838,18 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 
 static void dspi_fifo_write(struct fsl_dspi *dspi)
 {
+	struct spi_transfer *xfer = dspi->cur_transfer;
+	struct spi_message *msg = dspi->cur_msg;
+	int bytes_sent;
+
 	dspi_setup_accel(dspi);
 
+	spi_take_timestamp_pre(dspi->ctlr, xfer, dspi->progress, !dspi->irq);
+
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_fifo_write(dspi);
 	else
 		dspi_xspi_fifo_write(dspi);
-}
-
-static int dspi_rxtx(struct fsl_dspi *dspi)
-{
-	struct spi_transfer *xfer = dspi->cur_transfer;
-	struct spi_message *msg = dspi->cur_msg;
-	int bytes_sent;
 
 	/* Update total number of bytes that were transferred */
 	bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
@@ -859,16 +858,16 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 
 	spi_take_timestamp_post(dspi->ctlr, dspi->cur_transfer,
 				dspi->progress, !dspi->irq);
+}
 
+static int dspi_rxtx(struct fsl_dspi *dspi)
+{
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
 		return 0;
 
-	spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
-			       dspi->progress, !dspi->irq);
-
 	dspi_fifo_write(dspi);
 
 	return -EINPROGRESS;
-- 
2.17.1

