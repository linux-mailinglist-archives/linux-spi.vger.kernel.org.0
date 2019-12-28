Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64512BDB4
	for <lists+linux-spi@lfdr.de>; Sat, 28 Dec 2019 14:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfL1Nzv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 28 Dec 2019 08:55:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1Nzv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 28 Dec 2019 08:55:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so28635992wru.3
        for <linux-spi@vger.kernel.org>; Sat, 28 Dec 2019 05:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BpVCIC7qknl+jfWXyZNC079JWv5MUsv1JWVBIyCoLZs=;
        b=DCmdzsgrUPc0TVhxjRAeBoDDiqJVYqXORfaO85PQkUwVywoXLUB73j4AqUH7ZJH5or
         84DdRqde6yBFqHG7OyMwxXwEv6Oo+TaSiLXQchAHMz6oblk2VJ7Ur5fobB0RB6lbPuqH
         baRavLR7RTJyo7v4WZZd1fEHmiwMhT1MWDmTgvx9GJOwhuftZyB6Jq0rNDQ8lJEZ0L5L
         PHQroJfrSGLy1oA0BN7mZ8jtwmDryc/fG9rq9Oi0TDJC0lHNTPkX2ToCsdk9ZlKQt7UY
         hW/eiPvjLSLj2woB70aKOFHyAkYjbrUfAXHK4tt3TwzTxEBaiX4Rv4kl/3BRFeALpBHs
         RD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BpVCIC7qknl+jfWXyZNC079JWv5MUsv1JWVBIyCoLZs=;
        b=ik5uby/YYv6NKdm7iOXhYpAoJ5kr4CP5pIMJdi6rluJk03R64icqarnyWo9cedpA+a
         1wJ0Bm+Q67IijefeVlP0jl/leCq9KpBXYDmwqr6w0O3AGnNNkcVnHxY9H5dspK4fC5wC
         GpLDPF5asPRKs6ZfKdc6l8DGK62+cPs1aG4HiAMvY0LwbqbbtkavQXaBZJNzl/dif7y0
         abC3VpSHOfpGMh3XpbPPSCv8RVCIuRTTUZprLkRP4Lfj5ex5EH+rMGcVXxjuq0W1XK73
         BfV9oxcfXBwnfP2T4y3WNJUr1I9z4fBfFV8kNawIL0ws2btg25uWGm94hXZb7LDN4UlD
         8dwA==
X-Gm-Message-State: APjAAAWd3D3aZFy0Wfzq0iHLZfLb7TNoPoiAnHRzL7ck9u3HUibemjZ+
        QSPuPLSAylQ2/nAuVio64Og=
X-Google-Smtp-Source: APXvYqyewFCVCusJsb73wunOdgX/4HglgKGCihPZ2LYoQ/3X7rlXejxcteW9j7nBzZbNR+v4cvfkDQ==
X-Received: by 2002:adf:f501:: with SMTP id q1mr25649805wro.263.1577541349179;
        Sat, 28 Dec 2019 05:55:49 -0800 (PST)
Received: from localhost.localdomain ([188.25.254.226])
        by smtp.gmail.com with ESMTPSA id m7sm37620161wrr.40.2019.12.28.05.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 05:55:48 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Esben Haabendal <eha@deif.com>,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH spi] spi: spi-fsl-dspi: Fix 16-bit word order in 32-bit XSPI mode
Date:   Sat, 28 Dec 2019 15:55:36 +0200
Message-Id: <20191228135536.14284-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When used in Extended SPI mode on LS1021A, the DSPI controller wants to
have the least significant 16-bit word written first to the TX FIFO.

In fact, the LS1021A reference manual says:

33.5.2.4.2 Draining the TX FIFO

When Extended SPI Mode (DSPIx_MCR[XSPI]) is enabled, if the frame size
of SPI Data to be transmitted is more than 16 bits, then it causes two
Data entries to be popped from TX FIFO simultaneously which are
transferred to the shift register. The first of the two popped entries
forms the 16 least significant bits of the SPI frame to be transmitted.

So given the following TX buffer:

 +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
 | 0x0 | 0x1 | 0x2 | 0x3 | 0x4 | 0x5 | 0x6 | 0x7 | 0x8 | 0x9 | 0xa | 0xb |
 +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
 |     32-bit word 1     |     32-bit word 2     |     32-bit word 3     |
 +-----------------------+-----------------------+-----------------------+

The correct way that a little-endian system should transmit it on the
wire when bits_per_word is 32 is:

0x03020100
0x07060504
0x0b0a0908

But it is actually transmitted as following, as seen with a scope:

0x01000302
0x05040706
0x09080b0a

It appears that this patch has been submitted at least once before:
https://lkml.org/lkml/2018/9/21/286
but in that case Chuanhua Han did not manage to explain the problem
clearly enough and the patch did not get merged, leaving XSPI mode
broken.

Fixes: 8fcd151d2619 ("spi: spi-fsl-dspi: XSPI FIFO handling (in TCFQ mode)")
Cc: Esben Haabendal <eha@deif.com>
Cc: Chuanhua Han <chuanhua.han@nxp.com>
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 442cff71a0d2..a94eaa1cb4e7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -586,21 +586,14 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 	dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
 
 	if (dspi->devtype_data->xspi_mode && dspi->bits_per_word > 16) {
-		/* Write two TX FIFO entries first, and then the corresponding
-		 * CMD FIFO entry.
+		/* Write the CMD FIFO entry first, and then the two
+		 * corresponding TX FIFO entries.
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
-		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE) {
-			/* LSB */
-			tx_fifo_write(dspi, data & 0xFFFF);
-			tx_fifo_write(dspi, data >> 16);
-		} else {
-			/* MSB */
-			tx_fifo_write(dspi, data >> 16);
-			tx_fifo_write(dspi, data & 0xFFFF);
-		}
 		cmd_fifo_write(dspi);
+		tx_fifo_write(dspi, data & 0xFFFF);
+		tx_fifo_write(dspi, data >> 16);
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
 		 * simultaneously.
-- 
2.17.1

