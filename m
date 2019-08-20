Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53AE95F9C
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfHTNOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:30 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:43874 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbfHTNO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:29 -0400
Received: by mail-wr1-f99.google.com with SMTP id y8so12346783wrn.10
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=L9qblUjBLlWeGQ9u/SmU+qjLbbZ61/6OBd5oCHDCR1E=;
        b=uMjD8LhT1y5XQ7s+3keMJm6W2KD/pKVBzE7rAbqFkyScJmtQnhOVhxJJPsgBXh3tEy
         T14J4tjM1wcGc+gp6IpZ22C2GngAP+ul2u6KX1q26txzTD2V1GQRzYm2PQpxfPsnRvS3
         T6eIj1lXVwauxaogg1/PJ5yhd4ioR3FUT9mobf9qbxkGpW5YKFbq3xI34NoOggUAoNs2
         0Q8+4BdOFeKmRfN5ZbrrXjH9DG6jcXrpzeMLXLmi6HrFCtSiLkrAkejeYlFUkEBq0DG3
         /Zt785lKAxaO4SvnBPIPm3EZTFqLp33TFsG/IZRDURsiV3EnCShYmcuc/9Qywl/1I0Fa
         ssnQ==
X-Gm-Message-State: APjAAAXZRwpqofEQTR7XHf66FEffaZ0mh4j/2Hs/RbsgBWIJjNN3qiS1
        shKQPsUC1vQbnn2h77alMHG0g7iNGo82hukb58GzbESkRQE6Y20ueIajSuxOa8/b6Q==
X-Google-Smtp-Source: APXvYqziUSosF9hi8y5cWHGgGjCnWkY6FwuQznXeYx+V7oHUiOTufSla0lC5wD3XA/Ye9RwCuTxYF8qWTM8d
X-Received: by 2002:a5d:4083:: with SMTP id o3mr21384152wrp.150.1566306867022;
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id v4sm274034wru.23.2019.08.20.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xy-0002Lh-RT; Tue, 20 Aug 2019 13:14:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 48C78274314C; Tue, 20 Aug 2019 14:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Fix typos" to the spi tree
In-Reply-To: <20190818180115.31114-12-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131426.48C78274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:26 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Fix typos

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 206175306da1de0c116e8bc12db3230edb230d5a Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:12 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Fix typos

mask of -> mask off
at and -> and

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-12-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e2e71bd73b5c..6128c695d06f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -232,7 +232,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (!dspi->rx)
 		return;
 
-	/* Mask of undefined bits */
+	/* Mask off undefined bits */
 	rxdata &= (1 << dspi->bits_per_word) - 1;
 
 	if (dspi->bytes_per_word == 1)
@@ -642,7 +642,7 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 {
 	int fifo_size = DSPI_FIFO_SIZE;
 
-	/* Read one FIFO entry at and push to rx buffer */
+	/* Read one FIFO entry and push to rx buffer */
 	while ((dspi->rx < dspi->rx_end) && fifo_size--)
 		dspi_push_rx(dspi, fifo_read(dspi));
 }
-- 
2.20.1

