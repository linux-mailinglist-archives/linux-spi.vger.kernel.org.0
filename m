Return-Path: <linux-spi+bounces-1983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586588B61D
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 01:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A00EB43BEE
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A476913FF5;
	Mon, 25 Mar 2024 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ys+OZxVH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0651C6B6
	for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394601; cv=none; b=NZXRdvuSQxiCvOLG+emyY8foPmlMxzOZk6SK7oh4uEfW4rwsFqxGIcegDhnxbs+QBxdOQKh46gDZ6FQH4X7xqx+6Mjj3RxNUqDGbZD74zQ0SHhfy+Ouv7QmWPMMKa6gr5sxS48/TDljIc+utngBis33q8iLjozOHTW9JYDf6sTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394601; c=relaxed/simple;
	bh=Q6Z2QQzlHF9I5NpaFnlI0Qths5F3IE0lkEGmARz6L3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJ2fu5H5d4sge8oBq0xV54wAp+v2Ldy21bmkgqAg0+vZ7Fb1cbG2PgfY83qitRyUDHUQKtZTD6tJYwBhu+eCqP01MRSIc7YChGO1gzxXTWyAvYuS8V9JzvODKToQ90p6QrtAensfsJ8ZkH3g0pqiEQuf6P2Z+tCQCDwsPXLex/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ys+OZxVH; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c396fec63aso1637872b6e.0
        for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711394598; x=1711999398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3j5LMJ9YLbVm0kA7lcSoZPxPav8nH8W3FcX3pJtoBsM=;
        b=Ys+OZxVH68/21TkhTffqzpE/mbx9i0FzC7lXhWMRyTYnh8SUkphQV8Ew6+W44Buygv
         vehMJSm2GzmvwsQhOpkyxLcOmwXx3D8TQHYLFNSZVCfGncg2bqpG/l26IcAkKalp4suZ
         JemALtw/ZXJEeLsasTIzCLaLIfYMUur5JX0QTcZHKnDz0tVKiZIWp3XnMqJgKJXt5P1B
         1mqvWPzcg/Ft6CTijWQbOeiFJeQ8wVVi3Hn8x/YpqECjxo1CGqtg/oRfrMXzMgcqhW0W
         g4BvZea0h0JaF2VnrIUHLtavcltVdBhfnGGeC2v5NDfJqFHobH/KhuuzL47+EfU36Idb
         k0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394598; x=1711999398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3j5LMJ9YLbVm0kA7lcSoZPxPav8nH8W3FcX3pJtoBsM=;
        b=IcBoC+h+H2uv7fAGAi4LG9IM/W9zuwCpThqVtc2VN1Qzk+CwGNRIfEPz5Zbtlsmvma
         w2ICKtHZGUzaC4LhHxjM5tKuUBFnGwpc5hy1KTUYwsqQDmqy7ANL4JrukCmYbSz6hvfB
         tgrB+3RiJUFIaJnLjHQjedN01aJgZvu9uZR7m65jM09qS2m+0B90bsgGTX1NO+dtxSNW
         LlvM9+BwN0g5yMvUPeUmJrS5TEiZcAshOq+43QWaRobQlncePJxp1Delzdbvwx1KZBwP
         lJohkbIAf4nSsvQiBLenhH1hOG8n0WAJq9x1MWN2fSOWJdx5yKccSL892ToBhzWNoQGs
         N8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6OnzPF6b/KoFChxPdJjSDmQwsPjj6EbwsgS8BNGhjw3spYqm436cbpmBjNirJc169seuPN0qNsYI50Foei4U1D9Km4c+h5GsZ
X-Gm-Message-State: AOJu0YxxgoWKg/T4CuvNjB9JLWX3nzO+73q07ylXI9scXtO1CkixqrgI
	cz0H1UbkLOl78fpwPGqcM8pcyC21bM0i1O2e2lDF5r8FF5Y/YPZ7K5O2+QHUmis=
X-Google-Smtp-Source: AGHT+IGHn99553cofQdlrQJf3VdYdaDHWchMOXF7/JOZNMZ8wadbxXok1Nh1EAX1o+QkGhiNiUs7Gw==
X-Received: by 2002:a05:6808:3a0a:b0:3c3:a606:8084 with SMTP id gr10-20020a0568083a0a00b003c3a6068084mr1006102oib.46.1711394598318;
        Mon, 25 Mar 2024 12:23:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bo16-20020a056808229000b003c3829794d3sm1183052oib.28.2024.03.25.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:23:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] spi: remove struct spi_message::is_dma_mapped
Date: Mon, 25 Mar 2024 14:22:53 -0500
Message-ID: <20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

There are no more users of the deprecated is_dma_mapped in struct
spi_message so it can be removed.

References in documentation and comments are also removed.

A few similar checks if xfer->tx_dma or xfer->rx_dma are not NULL are
also removed since these are now guaranteed to be NULL because they
were previously set only if is_dma_mapped was true.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Fix spi-pxa2xx.c:947:29: error: unused variable ‘message’
- Link to v1: https://lore.kernel.org/r/20240315-spi-remove-is_dma_mapped-v1-1-ca876f9de1c5@baylibre.com
---
 Documentation/spi/pxa2xx.rst      |  3 ---
 Documentation/spi/spi-summary.rst |  4 ----
 drivers/spi/spi-atmel.c           |  8 ++------
 drivers/spi/spi-pxa2xx.c          | 11 -----------
 drivers/spi/spi.c                 |  7 -------
 include/linux/spi/spi.h           | 11 +++--------
 6 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 19479b801826..43e0b758803a 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -194,9 +194,6 @@ The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis::
 
   if spi_message.len > 65536 then
-	if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
-		reject premapped transfers
-
 	print "rate limited" warning
 	use PIO transfers
 
diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 546de37d6caf..f7f8b1573f25 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -419,10 +419,6 @@ any more such messages.
     to make extra copies unless the hardware requires it (e.g. working
     around hardware errata that force the use of bounce buffering).
 
-    If standard dma_map_single() handling of these buffers is inappropriate,
-    you can use spi_message.is_dma_mapped to tell the controller driver
-    that you've already provided the relevant DMA addresses.
-
   - The basic I/O primitive is spi_async().  Async requests may be
     issued in any context (irq handler, task, etc) and completion
     is reported using a callback provided with the message.
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bad34998454a..b62f57390d8f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -987,8 +987,6 @@ static void atmel_spi_pdc_next_xfer(struct spi_controller *host,
  * For DMA, tx_buf/tx_dma have the same relationship as rx_buf/rx_dma:
  *  - The buffer is either valid for CPU access, else NULL
  *  - If the buffer is valid, so is its DMA address
- *
- * This driver manages the dma address unless message->is_dma_mapped.
  */
 static int
 atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
@@ -1374,8 +1372,7 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 	 * DMA map early, for performance (empties dcache ASAP) and
 	 * better fault reporting.
 	 */
-	if ((!host->cur_msg->is_dma_mapped)
-		&& as->use_pdc) {
+	if (as->use_pdc) {
 		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
 			return -ENOMEM;
 	}
@@ -1454,8 +1451,7 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 		}
 	}
 
-	if (!host->cur_msg->is_dma_mapped
-		&& as->use_pdc)
+	if (as->use_pdc)
 		atmel_spi_dma_unmap_xfer(host, xfer);
 
 	if (as->use_pdc)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f2a856f6a99e..6c2a14418972 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -944,7 +944,6 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 				   struct spi_transfer *transfer)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
-	struct spi_message *message = controller->cur_msg;
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 dma_thresh = chip->dma_threshold;
 	u32 dma_burst = chip->dma_burst_size;
@@ -959,16 +958,6 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 
 	/* Check if we can DMA this transfer */
 	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
-
-		/* Reject already-mapped transfers; PIO won't always work */
-		if (message->is_dma_mapped
-				|| transfer->rx_dma || transfer->tx_dma) {
-			dev_err(&spi->dev,
-				"Mapped transfer length of %u is greater than %d\n",
-				transfer->len, MAX_DMA_LEN);
-			return -EINVAL;
-		}
-
 		/* Warn ... we force this to PIO mode */
 		dev_warn_ratelimited(&spi->dev,
 				     "DMA disabled for transfer length %u greater than %d\n",
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff75838c1b5d..a2f01116ba09 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3709,9 +3709,6 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	 * to the same values as *xferp, so tx_buf, rx_buf and len
 	 * are all identical (as well as most others)
 	 * so we just have to fix up len and the pointers.
-	 *
-	 * This also includes support for the depreciated
-	 * spi_message.is_dma_mapped interface.
 	 */
 
 	/*
@@ -3725,12 +3722,8 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 		/* Update rx_buf, tx_buf and DMA */
 		if (xfers[i].rx_buf)
 			xfers[i].rx_buf += offset;
-		if (xfers[i].rx_dma)
-			xfers[i].rx_dma += offset;
 		if (xfers[i].tx_buf)
 			xfers[i].tx_buf += offset;
-		if (xfers[i].tx_dma)
-			xfers[i].tx_dma += offset;
 
 		/* Update length */
 		xfers[i].len = min(maxsize, xfers[i].len - offset);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c459809efee4..b589e2547439 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -955,8 +955,8 @@ struct spi_res {
  * struct spi_transfer - a read/write buffer pair
  * @tx_buf: data to be written (DMA-safe memory), or NULL
  * @rx_buf: data to be read (DMA-safe memory), or NULL
- * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
- * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
+ * @tx_dma: DMA address of tx_buf, currently not for client use
+ * @rx_dma: DMA address of rx_buf, currently not for client use
  * @tx_nbits: number of bits used for writing. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
@@ -1066,8 +1066,7 @@ struct spi_transfer {
 	/*
 	 * It's okay if tx_buf == rx_buf (right?).
 	 * For MicroWire, one buffer must be NULL.
-	 * Buffers must work with dma_*map_single() calls, unless
-	 * spi_message.is_dma_mapped reports a pre-existing mapping.
+	 * Buffers must work with dma_*map_single() calls.
 	 */
 	const void	*tx_buf;
 	void		*rx_buf;
@@ -1111,8 +1110,6 @@ struct spi_transfer {
  * struct spi_message - one multi-segment SPI transaction
  * @transfers: list of transfer segments in this transaction
  * @spi: SPI device to which the transaction is queued
- * @is_dma_mapped: if true, the caller provided both DMA and CPU virtual
- *	addresses for each transfer buffer
  * @pre_optimized: peripheral driver pre-optimized the message
  * @optimized: the message is in the optimized state
  * @prepared: spi_prepare_message was called for the this message
@@ -1146,8 +1143,6 @@ struct spi_message {
 
 	struct spi_device	*spi;
 
-	unsigned		is_dma_mapped:1;
-
 	/* spi_optimize_message() was called for this message */
 	bool			pre_optimized;
 	/* __spi_optimize_message() was called for this message */

---
base-commit: 10402419f2d60890525f590b54d0eaec3de0d87a
change-id: 20240315-spi-remove-is_dma_mapped-ac067635662e

