Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461C318929C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCRARV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42913 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgCRARS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so28140554wrm.9;
        Tue, 17 Mar 2020 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=do7ELkqPnkaQdQSXxeirNxxb2K6EQjDuUS0MOsNqAx0=;
        b=nF80gTQePFcG6c8yIYXVht24MAiuD6AdREzl1+Co6qjbvmpJhY5B/bXdWORSmaLc8J
         /XwYdjJuVVYuYhc0ZrBRHWJxv0efsOj/HMeN/NUyGi0FDeDbClfGNNawBOYxBrCZu/ZZ
         t876/49RrpHuhtZIbCb3y+PsmO25U0zxv5EfS9Jz8WifFxXdBLcbqIo9IpnhpP+vkBkh
         UU9h280KDbmDiajlwBEVnvsxqaHfHBnWSNsmuZ5YULONIjCJJQbroUXaPJ77Dzq3lRM2
         TiEtVmIri5A66vcUTarwwVbCBATretv4Ji6Gd2wa9W7yTxln1/MX2OVUagwrvrEEn9m/
         YI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=do7ELkqPnkaQdQSXxeirNxxb2K6EQjDuUS0MOsNqAx0=;
        b=NyjUWyRqt85R4KopTw+x79Au45sUC2GiGfq1yL5QXLjA7rW2SKvZmhJ5iQEow9kqc9
         HQSUi6V5389EXFGNseNypD9f/dNNOl+6ikNtK5BSeT8zk5R0sKohwlIVurDuZG7bmsMt
         d35qOopHNPkjAws+ONNJwsdl+SG/t+STMaF+xmPfsgWlmScJkUOX3W/54anyglpasOMa
         Bck+Xv4N5zy+pFH4AqCLwC2Z7lzYLn3HlU0ZXhwLPO4k2AH4z5W9n5zWJNWHDnYFL61b
         VT+Uv9PyObHX6u5wlsMp3Vp4cRx3IVZywK7HXjk16DC1d3Af/PlJbgWjKliOvO/clmhL
         NMbg==
X-Gm-Message-State: ANhLgQ3ZsZBecH3xo+k/wqxnWS4KHiWeld8/Olmzh2mUtsFAZu/l0Cbh
        cXe/VkFS70aW5Mp9Rm1XsVw=
X-Google-Smtp-Source: ADFU+vstrTQcynMf9WAA55e8it4/BwbpsEpc3yAFiGVSlVNtYsJjVRRU5nNXXh0X0tGtvFCg9+iPHQ==
X-Received: by 2002:adf:97d5:: with SMTP id t21mr1542972wrb.45.1584490636460;
        Tue, 17 Mar 2020 17:17:16 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:15 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 07/12] spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
Date:   Wed, 18 Mar 2020 02:15:58 +0200
Message-Id: <20200318001603.9650-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The driver does not create the dspi->dma structure unless operating in
DSPI_DMA_MODE, so it makes sense to check for that.

Fixes: f4b323905d8b ("spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b65c21d048f9..81e22b6eadc7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1192,8 +1192,10 @@ static int dspi_slave_abort(struct spi_master *master)
 	 * Terminate all pending DMA transactions for the SPI working
 	 * in SLAVE mode.
 	 */
-	dmaengine_terminate_sync(dspi->dma->chan_rx);
-	dmaengine_terminate_sync(dspi->dma->chan_tx);
+	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
+		dmaengine_terminate_sync(dspi->dma->chan_rx);
+		dmaengine_terminate_sync(dspi->dma->chan_tx);
+	}
 
 	/* Clear the internal DSPI RX and TX FIFO buffers */
 	regmap_update_bits(dspi->regmap, SPI_MCR,
-- 
2.17.1

