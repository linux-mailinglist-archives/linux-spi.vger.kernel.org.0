Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C717EADB
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCIVIt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 17:08:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40125 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgCIVIt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 17:08:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so183624wme.5;
        Mon, 09 Mar 2020 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLh2NjBBYW6TYqNhJcIQ0RQRuYbC50iGuec37O254s8=;
        b=IHEMPvbKnUsleIzdoSoZFrMQWswYVIjuah/8IwTbpGVRMaPdwVtA1vqpDTEOcZ52fx
         VTpyLmPsMZLJxwVCQkb+q/qLkSheGc2Cy0G6y0XwoZGtnx/92GThEN3hRdBTVQzTx2AA
         tKEFpEj8F+v8Yvvurw68sHOtIuMEk2siC963UIHT8RDi19hRE+IvzT2H6nbqblk+enHR
         aM5HkXZhhqAwgEsoHTlecpMuIpvTSs7bhmnuGOVECa9cvdQ/r4okEO/hDf1pfpehUoD2
         AzUxydEC7h3QgB+aCJaEZCF4Quq34HK0Ke4OqOZUNU7xJ5Bo6LNI8ENC2fh8ZyGfoXrb
         dsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eLh2NjBBYW6TYqNhJcIQ0RQRuYbC50iGuec37O254s8=;
        b=m8WyWcaAiF1VcBVvaaEfMIe+u9BQCNFqnNJmSv2iD+rnB35SrVHPiKXVBpuYO8FK+Q
         1NrFa2/HMLycyCaQGnyFdtEHdNoEgBxyVC740dLzgNibiDAqfI1icvJ5HRrQOOKnG9nU
         enWRhGW2Bxo3UjRH0ixzfmYCbHonbZgKTC7+6ssJvVdSbUc7B4QqEDgE5FpP+127wxDT
         WRbfHJPPrW9sASnt3Z+sRRDCwrY2fQaQKk/d7lzakhJwNyEdkWyGxGaUYQO+72CDkE84
         TBYLYL4RUOFprS961B+JoAQhcUN+xfZtsGcjx/JvKTviTTFfohtelc8kYN0+Is1wM8ux
         gaIg==
X-Gm-Message-State: ANhLgQ3MoEt76awpSdbz+Bas/mlrfGf3B5HULkAk+9ULPasiphRK5yv1
        KnODOhlDtiy87tYxfCnGOVM=
X-Google-Smtp-Source: ADFU+vshM4FweUMxojHm86q+HJsdfR7vuFXRu8RG9OkcUeW+Bk5di7fPA1Gg4k2UsvTTLYsyzOOYfQ==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr1054476wmd.101.1583788127416;
        Mon, 09 Mar 2020 14:08:47 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id j205sm1016275wma.42.2020.03.09.14.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:08:46 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v2 3/6] spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
Date:   Mon,  9 Mar 2020 23:07:52 +0200
Message-Id: <20200309210755.6759-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In DMA mode, dspi_setup_accel does not get called, which results in the
dspi->oper_word_size variable (which is used by dspi_dma_xfer) to not be
initialized properly.

Because oper_word_size is zero, a few calculations end up being
incorrect, and the DMA transfer eventually times out instead of sending
anything on the wire.

Set up native transfers (or 8-on-16 acceleration) using dspi_setup_accel
for DMA mode too.

Fixes: 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
None.

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0483abd403a4..43d2d9fc8b92 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -359,6 +359,8 @@ static void dspi_rx_dma_callback(void *arg)
 	complete(&dma->cmd_rx_complete);
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
 	struct device *dev = &dspi->pdev->dev;
@@ -446,9 +448,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	int bytes_per_buffer;
 	int ret = 0;
 
+	dspi_setup_accel(dspi);
+
 	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
-			   dspi->devtype_data->fifo_size;
+	bytes_per_buffer = dspi->devtype_data->dma_bufsize;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
 		dma->curr_xfer_len = curr_remaining_bytes /
-- 
2.17.1

