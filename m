Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD422189299
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 01:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCRARP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 20:17:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56315 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgCRARO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 20:17:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so1303305wmi.5;
        Tue, 17 Mar 2020 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtJjhRPIy7AYBnH/+FNJCutzC44JnMplfSDwQrTUa8w=;
        b=jbSOl1Awue/1LPRRc+xSPb9r+8QvOIlbvb25O6i8BGZgfpAtA1ZOnCyPHRosISF29I
         Ezp/SyZTuH3p2oeNcSk8B51hijLOv/S3UhcF+MUiHyRbxdPUKZRHALBHAuOPiqEJ4tCF
         J4orZviFR1gSge+5sFACQXQmzWW8/PeBHnW6qDaRYMYeAXVX+j32QzRO4LaKXnaWXJCT
         jeNkLOHqZaHk7fICB7yV0wQTrRJX1W6pa1Scdx3JhTrzqUMeGEC+MXUaAZGeUu5ygi1r
         hk0En70j4+s45QLwK7KAnIcZ+2+/7WB5LE9ZjRNtvS/WR9VSU4DnkyX7qjvc3gi3LDI2
         dMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtJjhRPIy7AYBnH/+FNJCutzC44JnMplfSDwQrTUa8w=;
        b=KLbno19G/uX4BmOYYXLeGvJCeCAdFfxMjwu7qVG/rI7pcG3SRfiC+z62Do79Umvk/C
         5dJ5cHc2P3CtCyzcewGwRSl1gjvonbsnFxZQMSbNLZhpTUnGgwYac8x7fA5bQSFiCgrl
         NPgtdnfkns12KXWcbm33v3ZBGK0le4j/cA9qcOo3U9HjIR1iZKjqX/NUmE2GpbvrWQmW
         XTr66LWse8sFDIWntu/ElsyBI0KAXNdvzTF4FBTR2WaWGxYoOMwLbHzzrNMbTUIbD9mF
         kvKNF39eg+CpIdLEVZ3d3q8huMzKK+7fErQm+06viw2mLP+qQHneAIKsLsbsVIeuFM9k
         I0aw==
X-Gm-Message-State: ANhLgQ01IuxCxCxw0zC4IPfwjKt1km7I2FFcFfxDa7rZE6mfFPn5MJeg
        3DrlMni7vyPb4eBeYGr5iFEgc7/N0X2+Iw==
X-Google-Smtp-Source: ADFU+vv2Vh7Eu15pOeJ/8F/ptvM5dbg6R3B92VKZ7YtIKaJesNpIXOy/Yipqg7DRWKcpi43GLhf52w==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr1539863wmg.70.1584490632322;
        Tue, 17 Mar 2020 17:17:12 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id i6sm6584600wru.40.2020.03.17.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:17:11 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v5 04/12] spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
Date:   Wed, 18 Mar 2020 02:15:55 +0200
Message-Id: <20200318001603.9650-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318001603.9650-1-olteanv@gmail.com>
References: <20200318001603.9650-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

If dspi->words_in_flight is populated with the hardware FIFO size,
then in dspi_fifo_read it will attempt to read more data at the end of a
buffer that is not a multiple of 16 bytes in length. It will probably
time out attempting to do so.

So limit the num_fifo_entries variable to the actual number of FIFO
entries that is going to be used.

Fixes: d59c90a2400f ("spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
None.

Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8f2b73cc6ed7..51224b772680 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -739,13 +739,16 @@ static void dspi_eoq_fifo_write(struct fsl_dspi *dspi)
 	int num_fifo_entries = dspi->devtype_data->fifo_size;
 	u16 xfer_cmd = dspi->tx_cmd;
 
+	if (num_fifo_entries * dspi->oper_word_size > dspi->len)
+		num_fifo_entries = dspi->len / dspi->oper_word_size;
+
 	dspi->words_in_flight = num_fifo_entries;
 
 	/* Fill TX FIFO with as many transfers as possible */
-	while (dspi->len && num_fifo_entries--) {
+	while (num_fifo_entries--) {
 		dspi->tx_cmd = xfer_cmd;
 		/* Request EOQF for last transfer in FIFO */
-		if (dspi->len == dspi->oper_word_size || num_fifo_entries == 0)
+		if (num_fifo_entries == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
 		/* Write combined TX FIFO and CMD FIFO entry */
 		dspi_pushr_write(dspi);
-- 
2.17.1

