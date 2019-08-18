Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650399189E
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHRSBe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44169 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfHRSBe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so6341131wrf.11
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/xg6gUKDBN8ZxEbv2EvyGULrNPVyQC3bTtith/e3jOE=;
        b=cKXDLLh5TZUJST/j9gLC7yeUpF+0ynl/LSRmPghv0H+ZZKjBhXKH2WzELxd6yhK4/0
         BybCur2eV14lyPBEL0jXIAS1tDZBJv3etF8i49jDHXkURpDn+klslKHLWo7yAiypNyFf
         aiA+84FTKQm0LIB+gHEEGjOVwP47kbdpR0qis832CFzDSNM1leWonnVidrLQ5k4E7lVL
         JHv4SsH6Uxbp0E/P2fcBUR1Gxz1pHNi+emoVQrstX8eoTebQvnFHceKWxAsy98YVQof7
         F6/6IEUh5BiAhOkdghKmKkOZI2I3uAyRfoNmJKelvYZMO4/kEw/SD5MI8p9vkcEnWqLq
         D4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/xg6gUKDBN8ZxEbv2EvyGULrNPVyQC3bTtith/e3jOE=;
        b=kqsc2P0QgrjxnU7SNf1usYrQCgqyO95wD/bvNjIxkvj3TPUcP+oZw8UM82TNow7Mjk
         x2HnL73Pmgsjqr90hAt58KsJMYojLYCD9ap71pqS0Iw3RYn8+HnyUrnEgVkbtRR2YHq4
         cVeTTRsjMDl4Am23bEUD0mEGgniBH2weJul7/hnzASIpl0sNJzrkplIg5t6ZQ3zC3DCt
         8ITaFywlJY6FNvAmOJYUbJ61Z/Nn/A5VdpnztG/n3zDxQ+BJ8mOWBf4UMA+X5wvAnJFt
         cS8dvqqcid4/pN6gMjxOCpFzeKeZqj+fnMg73vwL+uVjyEbA9fO+z3UyjaZzMF4q6VYl
         PTrQ==
X-Gm-Message-State: APjAAAWhrHAKQm9FkVgGS1OmT6nWDXe/uKzm309KhGKkifSV9sVGdil9
        1cEYLXXIhVluSMKeJkdGscw=
X-Google-Smtp-Source: APXvYqxdF4lLLQARvnDxeV6hOUPi9iSndEfMWc5/ZIyYYgJno6j1jhpZjHfrC+noGy3qZ87Jg3W0AA==
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr21738218wrj.314.1566151292904;
        Sun, 18 Aug 2019 11:01:32 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:32 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 14/14] spi: spi-fsl-dspi: Remove impossible to reach error check
Date:   Sun, 18 Aug 2019 21:01:15 +0300
Message-Id: <20190818180115.31114-15-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dspi->devtype_data is under the total control of the driver. Therefore,
a bad value is a driver bug and checking it at runtime (and during an
ISR, at that!) is pointless.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 2993d15f640e..238bbe172b79 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -651,7 +651,6 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
 	struct spi_message *msg = dspi->cur_msg;
-	enum dspi_trans_mode trans_mode;
 	u32 spi_sr, spi_tcr;
 	u16 spi_tcnt;
 
@@ -666,19 +665,10 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	/* Update total number of bytes that were transferred */
 	msg->actual_length += spi_tcnt * dspi->bytes_per_word;
 
-	trans_mode = dspi->devtype_data->trans_mode;
-	switch (trans_mode) {
-	case DSPI_EOQ_MODE:
+	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_read(dspi);
-		break;
-	case DSPI_TCFQ_MODE:
+	else
 		dspi_tcfq_read(dspi);
-		break;
-	default:
-		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-			trans_mode);
-			return IRQ_HANDLED;
-	}
 
 	if (!dspi->len) {
 		dspi->waitflags = 1;
@@ -686,18 +676,10 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	switch (trans_mode) {
-	case DSPI_EOQ_MODE:
+	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_write(dspi);
-		break;
-	case DSPI_TCFQ_MODE:
+	else
 		dspi_tcfq_write(dspi);
-		break;
-	default:
-		dev_err(&dspi->pdev->dev,
-			"unsupported trans_mode %u\n",
-			trans_mode);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

