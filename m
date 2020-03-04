Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39040179B6B
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbgCDWCI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbgCDWCH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id g83so3503934wme.1;
        Wed, 04 Mar 2020 14:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UjBK8tKR5AcH0e1lqcZHMqMV2tpdAhqsgcfBSll5C30=;
        b=qpZa/IUeNxOuXyfe26nAWxrm5BQRIyLkhqaUG78muxIPvdRWpobfujY9IQLpIrExat
         iee1mB1RGO76HJX/XD56tka4lFzMGqxg80pvngJzb4YrHgF450jSHSSO8bXV7P9fN5fh
         PHT0YVEJbpEbAJrSS6ptzsLxBrEDPUi50959YmiCFwfOW3LqBCEBQO1xkwwMMXNaoQ8R
         W2P+DRfL5bPOQJGDf/uD3OgkuMLe3DodJw9zS1UzLMeQJ4zj0ft+JdFOXvI00VaKfbP3
         qch0nNctEqWdK2QdxpNPqL2jk2ld4QYQ1MIKTJKHPVUK+NdNeBVB1905m7lBc2A/ZvYq
         t19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UjBK8tKR5AcH0e1lqcZHMqMV2tpdAhqsgcfBSll5C30=;
        b=AWurrJAYsXhgr+ZRGy8SGzP2d+QEiqDV+RXbBqPVdG8VoAvAkoTkoxXeu44cPQIgnc
         Y3meOLFQfQnAuD/M6wdZrfz6G4KBXCxPisRWSOYtiYPxAikP+SOjV7z+Mh8i+ydiqT1R
         1IaXETSJcgfUySQ92vUHZT5gBhQp7VsrL9iFFEqgQ9Av9doxmKrURWpRMO5TSqC3Js46
         zjCebV1Mts/a38W8+sof4BKuSz4FPmMYPxaPRya1ga9bb83Ige7jObEF2bhYu+o4Xzpq
         RiRzdB8ZrieWWmSK6s21xtuECAtf3MaZhAbRxDMqYDj8cMyd3bVk/u73qY7OS+ovXokB
         //2w==
X-Gm-Message-State: ANhLgQ38GAcCny6MVhZu4f9gyiB4ykQ+3eqh7yzTMO/KYSVog4Vzl7NP
        3gGWtpiy1V6Lv47Q8fAFVh8=
X-Google-Smtp-Source: ADFU+vv8mVb+tYL9DUyPWHmEwJmvnIU0YQxJ/lDEH0WQEqUCv+ttU3wtIQ5+4FjXgkMvdEgp3ftFng==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr5405096wmm.123.1583359325807;
        Wed, 04 Mar 2020 14:02:05 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:05 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 10/12] spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest interrupt count
Date:   Thu,  5 Mar 2020 00:00:42 +0200
Message-Id: <20200304220044.11193-11-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Currently, a SPI transfer that is not multiple of the highest supported
word width (e.g. 4 bytes) will be transmitted as follows (assume a
30-byte buffer transmitted through a 32-bit wide FIFO that is 32 bytes
deep):

 - First 28 bytes are sent as 7 words of 32 bits each
 - Last 2 bytes are sent as 1 word of 16 bits size

But if the dspi_setup_accel function had decided to use a lower
oper_bits_per_word value (16 instead of 32), there would have been
enough space in the TX FIFO to fit the entire buffer in one go (15 words
of 16 bits each).

What we're actually trying to avoid is mixing word sizes within the same
run with the TX FIFO, since there is an erratum surrounding this, and
invalid data might get transmitted.

So this patch adds special cases for when the remaining length of the
buffer can be sent in one go as 8-bit or 16-bit words, otherwise it
falls back to the standard logic of sending as many bytes as possible at
the highest oper_bits_per_word value possible.

The benefit is that there will be one less CMDFQ/EOQ interrupt to
service when the entire buffer is transmitted during a single go, and
that will improve the overall latency of the transfer.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f5b802070d29..df4944353ed5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -775,20 +775,34 @@ static void dspi_fifo_read(struct fsl_dspi *dspi)
 static void dspi_setup_accel(struct fsl_dspi *dspi)
 {
 	struct spi_transfer *xfer = dspi->cur_transfer;
+	bool odd = !!(dspi->len & 1);
 
-	/* Start off with maximum supported by hardware */
-	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-		dspi->oper_bits_per_word = 32;
-	else
+	/* No accel for frames not multiple of 8 bits at the moment */
+	if (xfer->bits_per_word % 8)
+		goto no_accel;
+
+	if (!odd && dspi->len <= dspi->devtype_data->fifo_size * 2) {
 		dspi->oper_bits_per_word = 16;
+	} else if (odd && dspi->len <= dspi->devtype_data->fifo_size) {
+		dspi->oper_bits_per_word = 8;
+	} else {
+		/* Start off with maximum supported by hardware */
+		if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
+			dspi->oper_bits_per_word = 32;
+		else
+			dspi->oper_bits_per_word = 16;
 
-	/* And go down only if the buffer can't be sent with words this big */
-	do {
-		if (dspi->len >= DIV_ROUND_UP(dspi->oper_bits_per_word, 8))
-			break;
+		/*
+		 * And go down only if the buffer can't be sent with
+		 * words this big
+		 */
+		do {
+			if (dspi->len >= DIV_ROUND_UP(dspi->oper_bits_per_word, 8))
+				break;
 
-		dspi->oper_bits_per_word /= 2;
-	} while (dspi->oper_bits_per_word > 8);
+			dspi->oper_bits_per_word /= 2;
+		} while (dspi->oper_bits_per_word > 8);
+	}
 
 	if (xfer->bits_per_word == 8 && dspi->oper_bits_per_word == 32) {
 		dspi->dev_to_host = dspi_8on32_dev_to_host;
@@ -800,7 +814,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 		dspi->dev_to_host = dspi_16on32_dev_to_host;
 		dspi->host_to_dev = dspi_16on32_host_to_dev;
 	} else {
-		/* No acceleration needed (8<N<=16 on 16, 16<N<=32 on 32) */
+no_accel:
 		dspi->dev_to_host = dspi_native_dev_to_host;
 		dspi->host_to_dev = dspi_native_host_to_dev;
 		dspi->oper_bits_per_word = xfer->bits_per_word;
-- 
2.17.1

