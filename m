Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953F8179B7B
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgCDWCA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDWB7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:01:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id n7so4411261wrt.11;
        Wed, 04 Mar 2020 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKtUnbnCDPAHUPw1HurGDuA6lHZnQeUDjcK4VLHPbLM=;
        b=JY1t4OZ9N00wP7OviW2anDxcnO5bjGI1gHaeVVMg5PuqdkMibSlkP/OkrxbEEhRoL0
         CvbE6Uyl6ZZcv34JaxE2uYSTI3wh4R8txNxN6oeSAEm8UUlnVEA99R6hFcqjhrzMnSOk
         gozg2lYI32u8NjFIZPfaDZW17hk+w8CnYc7DhsSgy96EZEHixgMTAxWpIVJ6Btlbicbu
         wR+peaRH46mCbjzpmHHAK8dP7aKSByFhT5b9XbHaNhzI6uI0QRkQQHYCDI397AMOxsAL
         iBN6bgNZ1jBY2hu3SZyKkjkbaTCHCXyiKUxzJMUabR6namwDTVaFWNZy4uJMTXzaSs13
         gIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKtUnbnCDPAHUPw1HurGDuA6lHZnQeUDjcK4VLHPbLM=;
        b=Ue/SPFJD7lqZMHCGtV1CI855hblk2WYKMIbyC2rFrZJB1sjAW1M4AnlA2foLLMEqmy
         4MWTUFq10Hs257vvpkfHAYIcXKzMHWJIAjrR6U2zFfxTdYOMWmjIQYYQzlragtPWnvOR
         DfBhWnP5bSwWcMHm4vwo+SXHZFxiYBxmXF3iWQGCryRbJiF3LWAzToayPZ8l80W+ahPs
         J3Kz/Jg4ab+5i4kd/CX+hK/z5tWNU3VnNeS+t4h9kqA6y5NgVqcjX9dGdR4QE5tTKeaF
         /1DUwYdRI/zzsrLy0s9oOJt0lWsT/DWUV0383qDinKQYMIn5OB9A3V2qXWF3jlThKrtq
         Tcjw==
X-Gm-Message-State: ANhLgQ2WLDDmu5J04iSN9Aq7aHc3ArIEic1UqSL1gTlXnvgh7j5+Qdq+
        rGZH9oM4KemHsnFKkLzU4CE=
X-Google-Smtp-Source: ADFU+vvt8RSj6uUID0ESiDY4iOV6VEibME60xB1AZdc+Bn8U47ESEYs1gamcKtnt/xMrc9yozBiOjg==
X-Received: by 2002:adf:b609:: with SMTP id f9mr5606100wre.380.1583359316058;
        Wed, 04 Mar 2020 14:01:56 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:01:55 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 01/12] spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics
Date:   Thu,  5 Mar 2020 00:00:33 +0200
Message-Id: <20200304220044.11193-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Reduce the if-then-else-if-then-else sequence to:
 - a simple division in the case of bytes_per_word calculation
 - a memcpy command with a variable size. The semantics of larger-than-8
   xfer->bits_per_word is that those words are to be interpreted and
   transmitted in CPU native endianness.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c357c3247232..896d7a0f45b0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -252,12 +252,7 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	u32 txdata = 0;
 
 	if (dspi->tx) {
-		if (dspi->bytes_per_word == 1)
-			txdata = *(u8 *)dspi->tx;
-		else if (dspi->bytes_per_word == 2)
-			txdata = *(u16 *)dspi->tx;
-		else  /* dspi->bytes_per_word == 4 */
-			txdata = *(u32 *)dspi->tx;
+		memcpy(&txdata, dspi->tx, dspi->bytes_per_word);
 		dspi->tx += dspi->bytes_per_word;
 	}
 	dspi->len -= dspi->bytes_per_word;
@@ -284,12 +279,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	/* Mask off undefined bits */
 	rxdata &= (1 << dspi->bits_per_word) - 1;
 
-	if (dspi->bytes_per_word == 1)
-		*(u8 *)dspi->rx = rxdata;
-	else if (dspi->bytes_per_word == 2)
-		*(u16 *)dspi->rx = rxdata;
-	else /* dspi->bytes_per_word == 4 */
-		*(u32 *)dspi->rx = rxdata;
+	memcpy(dspi->rx, &rxdata, dspi->bytes_per_word);
 	dspi->rx += dspi->bytes_per_word;
 }
 
@@ -814,12 +804,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		dspi->progress = 0;
 		/* Validated transfer specific frame size (defaults applied) */
 		dspi->bits_per_word = transfer->bits_per_word;
-		if (transfer->bits_per_word <= 8)
-			dspi->bytes_per_word = 1;
-		else if (transfer->bits_per_word <= 16)
-			dspi->bytes_per_word = 2;
-		else
-			dspi->bytes_per_word = 4;
+		dspi->bytes_per_word = DIV_ROUND_UP(dspi->bits_per_word, 8);
 
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-- 
2.17.1

