Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC46E179B69
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgCDWCJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36582 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388539AbgCDWCI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so3503989wme.1;
        Wed, 04 Mar 2020 14:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzn44GYWIDseGnHDTXhrNsjH7nM5qe+h4ik7P6IWnpI=;
        b=ZowA7PC40wqYnLNe77kaKCvBeyY8/5FZ3VwVbtl/PjeBdO0KKd+LEyf6ee7o45+E5G
         6VEwCYuC3zOwlnUMB+fphG8jRcQOPZszxQwIOdPK5pKGOcpNJeSJhiuM6DsR5OflJnpF
         5mYnLoBP2Hh0V2zkX+kIBXys1px6/virmFC5MUV90c1RnA1EyfnIklzrtowMLUfHlit/
         Dd12XwcJJT0Fnj/ZMlOj7k8f4p+qH5mKmZCUYwOZjqDHSucA1718os1GIxjNtxnSZt8y
         RFfSeO9c8a4JYMBl2GlBRuKr3xk0KsODnp0zsTutYEFtuGob104WRNXgv829i/y9KlIL
         jgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzn44GYWIDseGnHDTXhrNsjH7nM5qe+h4ik7P6IWnpI=;
        b=FSdi0atq0uWKxjmE7gsbhrQpznYbCL/IMv9xA71EmFTmyhXkawCmmdsTN75BD4t9pC
         EXlDHWGIausXC5za4jxLcwD6oYyrxh/Nbv6ExUCLElCm+n8MQ4HkkKKsiteX6fva3OT5
         Lh8qX0m5muW7dSSO83t0B9ss1lHM7B4ogYjoSunYEBfKqHzjWvWJfvt2AIK7/PI7rQtJ
         q3qc1xnqVe2d9v3yAT9rrtw0lGmbqSKyOI6I35laTimOfSUEd7KwX0IK1alvXBhQgn7i
         NuQSd6yv6DuTYZx1dnUIAMHb45io2n1Zd6UIF4m7Lg9iLiZLfeDRAjYChx9DgFrh0HWs
         ce+Q==
X-Gm-Message-State: ANhLgQ3drYiMIjYV4h7HQKb3LfktoiGCWTwhL8Xm/c8PMdfHaHyEBLIO
        qB43vKGD+BFzD8sMSWnXCos=
X-Google-Smtp-Source: ADFU+vvAVgNyGEyzThxT/2NXaun3XlIMxRKGIdmtJBQU086Mi28uzDeNkk90IEsBe9a5eCnI+eFBEw==
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr5333266wmb.28.1583359326844;
        Wed, 04 Mar 2020 14:02:06 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:06 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 11/12] spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode
Date:   Thu,  5 Mar 2020 00:00:43 +0200
Message-Id: <20200304220044.11193-12-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The EOQ mode has a hardware limitation in that it stops the transmission
(including the deassertion of the chip select signal) once the host CPU
requests end-of-queue for a particular word in the TX FIFO.

And XSPI mode has a limitation in that we need a separate CMD FIFO entry
for the last byte in the buffer, where the chip select signal needs to
be deasserted. It's not a functional limitation, but it's rather clunky
and the fact that we need to halt the pipeline and write a single entry
to the TX FIFO whenever a buffer ends brings the throughput down when
transmitting small buffers.

So the idea here is to use EOQ's limitation in our favor when using XSPI
mode. Stop special-casing that final word in the buffer, and just kill
the chip select signal by issuing an EOQ for that last word. Now it can
be mixed in with all the other words in the current TX FIFO train.

A small trick here is that we still keep using the XSPI-specific
signaling via the CMDTCFQ interrupt in RSER, and not enabling the EOQ
interrupt, in order to avoid hardware weirdness (potential races with
separate interrupts being raised for CMDTCFQ and EOQ for what is in fact
the end of the same transmission). That is just theoretical, but it's
good to be cautious, and the EOQ interrupt isn't needed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index df4944353ed5..d5983be32180 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -656,10 +656,8 @@ static void dspi_pushr_write(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
-static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
+static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 {
-	u16 cmd = dspi->tx_cmd;
-
 	/*
 	 * The only time when the PCS doesn't need continuation after this word
 	 * is when it's last. We need to look ahead, because we actually call
@@ -680,8 +678,13 @@ static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
 }
 
-static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
+static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
 {
+	u16 tx_cmd = dspi->tx_cmd;
+
+	if (eoq)
+		tx_cmd |= SPI_PUSHR_CMD_EOQ;
+
 	/* Update CTARE */
 	regmap_write(dspi->regmap, SPI_CTARE(0),
 		     SPI_FRAME_EBITS(dspi->oper_bits_per_word) |
@@ -691,7 +694,7 @@ static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt)
 	 * Write the CMD FIFO entry first, and then the two
 	 * corresponding TX FIFO entries (or one...).
 	 */
-	dspi_pushr_cmd_write(dspi);
+	dspi_pushr_cmd_write(dspi, tx_cmd);
 
 	/* Fill TX FIFO with as many transfers as possible */
 	while (cnt--) {
@@ -707,6 +710,7 @@ static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
 {
 	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	int bytes_in_flight;
+	bool eoq = false;
 
 	/* In XSPI mode each 32-bit word occupies 2 TX FIFO entries */
 	if (dspi->oper_word_size == 4)
@@ -732,11 +736,11 @@ static void dspi_xspi_fifo_write(struct fsl_dspi *dspi)
 	 * So send one word less during this go, to force a split and a command
 	 * with a single word next time, when CONT will be unset.
 	 */
-	if (bytes_in_flight == dspi->len && dspi->words_in_flight > 1 &&
-	    !(dspi->tx_cmd & SPI_PUSHR_CMD_CONT))
-		dspi->words_in_flight--;
+	if (!(dspi->tx_cmd & SPI_PUSHR_CMD_CONT) &&
+	    bytes_in_flight == dspi->len)
+		eoq = true;
 
-	dspi_xspi_write(dspi, dspi->words_in_flight);
+	dspi_xspi_write(dspi, dspi->words_in_flight, eoq);
 }
 
 static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
-- 
2.17.1

