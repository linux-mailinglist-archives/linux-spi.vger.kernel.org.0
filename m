Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44C179B76
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbgCDWCC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55887 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388483AbgCDWCB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id 6so3981242wmi.5;
        Wed, 04 Mar 2020 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7usjeEtnLelRZFqfBWE5WZWkvf+bS5tSXzwRcAo6Mj8=;
        b=J4SVbPYSzmVam37DjyguQpOymuECa5BijnCH9xLTjm92LsrT3Bqp9T59mK4qpqEmpv
         NFipA1l0LfQhwwWZO8TNynkv4OeU18HB4lAi5DtMesOGeTxc9anMMw2+4TqyaV19XCv+
         lRAKsQDzrkSZUJQPTbn25mll9LiIU9vKUySc0T7UcBuIDeQ1BrJ6hlLNumuXbFyDSpfO
         zlPKrAKhlVrZV4EuQIOvxvO+XiBU/wVv7kst3v6wO4tXsEGUYzC0SZPCQIgwWVpPQZon
         Rz5IFpVnSlbWMpoRFrINm/AmQvLUzagy395sQvEQjMy3a9XJjPAysaIDbQhfg1lEaq3o
         nz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7usjeEtnLelRZFqfBWE5WZWkvf+bS5tSXzwRcAo6Mj8=;
        b=KRgkzD45FSBnOymw91q5C7n+/Y6RdX2Ii5HH4VrmKX+JCN/zMXDzt4Rj+dAbkcdAJb
         ctliom3/pZ+iXHTpIjBrNrcDzCptAYYJNNoXJpT5+4b+6lCkyXxtgW+MK75uyK7Wt2yq
         n0/UVB1xoAp9SOAEGHkHSCpFoeqlJq9y0p0ui5dL4d5X/WZpveK3A5l6oQctc4Cwm25Y
         6vwe8w5vPvtTMM4Tnc9XqZCYhS6RYuQvQLnfsIetJNIypKpfJbQcRmbixl713EyOKspx
         AQ3yuoBBSbvM7VLU8Z4uZTEDDWiUwiOVybz2UL9p7ZwrEycW//cQGkkMqE/OA5lp1pZH
         IG5A==
X-Gm-Message-State: ANhLgQ113RLmoCU3UviFpf9btiOa6RGZRuzi9Yg27CTA9b7qVjOyYu5A
        cxTT5XAuytrBHxkz6nMWfAw=
X-Google-Smtp-Source: ADFU+vs6REbQIkGOj+OTlmaB4siXuM1v/v23pW3AjDLVW6ldBzqWTtmjYTqUJXJ912bqGN/BwDSPng==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr5575917wma.80.1583359320233;
        Wed, 04 Mar 2020 14:02:00 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:01:59 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 05/12] spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write
Date:   Thu,  5 Mar 2020 00:00:37 +0200
Message-Id: <20200304220044.11193-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

These function names are very generic and it is easy to get confused.
Rename them after the hardware register that they are accessing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a8077d4903c7..f37090ad7ad1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -601,12 +601,12 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	}
 }
 
-static void fifo_write(struct fsl_dspi *dspi)
+static void dspi_pushr_write(struct fsl_dspi *dspi)
 {
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
-static void cmd_fifo_write(struct fsl_dspi *dspi)
+static void dspi_pushr_cmd_write(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd;
 
@@ -615,7 +615,7 @@ static void cmd_fifo_write(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
 }
 
-static void tx_fifo_write(struct fsl_dspi *dspi, u16 txdata)
+static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
 	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
 }
@@ -631,18 +631,18 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
-		cmd_fifo_write(dspi);
-		tx_fifo_write(dspi, data & 0xFFFF);
-		tx_fifo_write(dspi, data >> 16);
+		dspi_pushr_cmd_write(dspi);
+		dspi_pushr_txdata_write(dspi, data & 0xFFFF);
+		dspi_pushr_txdata_write(dspi, data >> 16);
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
 		 * simultaneously.
 		 */
-		fifo_write(dspi);
+		dspi_pushr_write(dspi);
 	}
 }
 
-static u32 fifo_read(struct fsl_dspi *dspi)
+static u32 dspi_popr_read(struct fsl_dspi *dspi)
 {
 	u32 rxdata = 0;
 
@@ -652,7 +652,7 @@ static u32 fifo_read(struct fsl_dspi *dspi)
 
 static void dspi_tcfq_read(struct fsl_dspi *dspi)
 {
-	dspi_push_rx(dspi, fifo_read(dspi));
+	dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
 static void dspi_eoq_write(struct fsl_dspi *dspi)
@@ -670,7 +670,7 @@ static void dspi_eoq_write(struct fsl_dspi *dspi)
 		if (fifo_size == (dspi->devtype_data->fifo_size - 1))
 			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 		/* Write combined TX FIFO and CMD FIFO entry */
-		fifo_write(dspi);
+		dspi_pushr_write(dspi);
 	}
 }
 
@@ -680,7 +680,7 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 
 	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
-		dspi_push_rx(dspi, fifo_read(dspi));
+		dspi_push_rx(dspi, dspi_popr_read(dspi));
 }
 
 static int dspi_rxtx(struct fsl_dspi *dspi)
-- 
2.17.1

