Return-Path: <linux-spi+bounces-3925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA6193961E
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 00:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7641F225A6
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31845812F;
	Mon, 22 Jul 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l7TKhBO4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2384964A
	for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685692; cv=none; b=We5wD4RShyoDMICp0KWyvGAG0w4RB/I+LQJ+s29Uxqkm9JkiMh3oJk2p/uDykdQGatDzBQJmpsCBtSfan7J/3uPgWmFTYyM3XzeL1HQ+Dkui8Ru4TqEYSmct7PSiR6UiWS5LsrjFOYwROy38fEHXs16gGTSN4+jYq+u6AoXIhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685692; c=relaxed/simple;
	bh=808d+A6Mqi2CTqpKZgsdKFxVcRnoQ41DCr0T6w4Q/j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUq+Z1K0roD7eobKxIqpj8BoDhIzXwT0yyFk8nGhTkJqZpSecmLl95UjeQcRVwqrWv/guhRz33uSPmiaXvgp1q8LzGBZefXN2PuIHcLC7etJftRhEfOzWjyji1sBMi7Q0lpcFpl+2sJ3w9MFRxmbT2uX7DwNrBOVKOjDv1yPxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l7TKhBO4; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-706dea920f3so2294057a34.1
        for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685689; x=1722290489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUS5JqRwM1ZEUN77AhcB6AZ8bgFbxFdByix5JbJ/Oks=;
        b=l7TKhBO42yTL066wVScBh4oalfr6KnJnjiULVhted52WA/MVqd1euKG4257ATx+lnM
         3z4w2o7jg10OFVYynLJZ9IDVzMzYxwzOTEciYRxZRF4pOs8DDMlm/glDS+hUH1UKW3ov
         f2sjLL5qVg8DPPBzhz7GlrUO2F+75xCdNPN7TrNQQTeXfW1e/TCPhE32SHGRircCLyiy
         VNBEVM8YeT2RNbp7KSKpxveBQ3IxPQwjvBJuLYjzYQ8Qvhg3eti69K38GwFMQrm/Lr+n
         zbPld7LmdU1CLNRdofw4WiacZHXw0okvkdF64ogHWy5P2uunYdpyRhLfhrTQk7b5wY2Q
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685689; x=1722290489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUS5JqRwM1ZEUN77AhcB6AZ8bgFbxFdByix5JbJ/Oks=;
        b=fGAeqSb4dVMndL2gs4gCchHIFPkZUKX73vf14tuelVGISVpuER8sdkJ6gYIPt2afTr
         oBcdZBTlMVDbExcsQoE30+At6JeR9umkz3TsVt8cx2ou+6ioB49ilPQUXITS5dHEYtcq
         PDjxn1qwEY57QzyhqSeDQwMTcEOUmhbeaQ3w8syE8rs3tXYlbPrA5LX4bSVwZ5364dJq
         KoKURwdHzgL5ueLL2UNx4g8vhPzlQCuEm9Yqz1H3ULA1rUKoW1+lcirntlmUcw2KsVY/
         V/6vJaIdLpJReaE7Dc7trZhJl2aOIyH82Zw3OBdxyQ0e1DTOT0gH3zvkCeVRL+bL4ZQG
         1XRA==
X-Forwarded-Encrypted: i=1; AJvYcCVuSMplvBb9NLl4JXG3q4tVhU/tuo0YvJkYknHuFQSKoXAzrmPX2YZ2yatq8rtZXuCs1ZHi6UKOCIU2+sESRBGiElxm1HbAA7/I
X-Gm-Message-State: AOJu0YyySzAOG6ra9bqha/Qr6mrdJI4jV2XN2e841Bu6oSX6oVx/L1TR
	wHxxG4mPiqyOVxrR8zTkHwzgGFtx9ClKLq8HM+E2Jq6y84Rc2CxHpMS1RAMyP6o=
X-Google-Smtp-Source: AGHT+IHCKw3qiAfR3cucyHwYioXnYz5pH3obtA6YVtcrcIQNCW9xK6H4m0p3HPHBYSjoKe3B8zYk8Q==
X-Received: by 2002:a05:6830:388f:b0:703:da11:4389 with SMTP id 46e09a7af769-7091aae7bbfmr147079a34.6.1721685689521;
        Mon, 22 Jul 2024 15:01:29 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 4/9] spi: add offload TX/RX streaming APIs
Date: Mon, 22 Jul 2024 16:57:11 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-4-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Most configuration of SPI offloads is handled opaquely using the
function ID that is passed to the various offload functions. However,
there are some offload features that need to be controlled on a per
transfer basis.

This patch adds a flag field to the spi_transfer structure to allow
specifying such features. The first feature to be added is the ability
to stream data to/from a hardware sink/source rather than using a tx or
rx buffer. Additional flags can be added in the future as needed.

A flags field is also added to the controller struct for controllers to
indicate which flags are supported. This allows for generic checking of
offload capabilities during __spi_validate() so that each controller
doesn't have to provide their own validation.

As a first users of this streaming capability, getter functions are
added to get a DMA channel that is directly connected to the offload.
Peripheral drivers will use this to get a DMA channel and configure it
to suit their needs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Added spi_offload_{tx,rx}_stream_get_dma_chan() functions.

v2 changes:

This is also split out from "spi: add core support for controllers with
offload capabilities".

In the previous version, we were using (void *)-1 as a sentinel value
that could be assigned, e.g. to rx_buf. But this was naive since there
is core code that would try to dereference this pointer. So instead,
we've added a new flags field to the spi_transfer structure for this
sort of thing. This also has the advantage of being able to be used in
the future for other arbitrary features.
---
 drivers/spi/spi.c       |  9 +++++++
 include/linux/spi/spi.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7488e71f159f..0ee741d911d3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4214,6 +4214,15 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (_spi_xfer_word_delay_update(xfer, spi))
 			return -EINVAL;
+
+		/* make sure controller supports required offload features */
+		if (xfer->offload_flags) {
+			if (!message->offload)
+				return -EINVAL;
+
+			if (xfer->offload_flags & ~ctlr->offload_xfer_flags)
+				return -EINVAL;
+		}
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 685548883004..a4a7449c4259 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -500,6 +500,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
  * @mem_caps: controller capabilities for the handling of memory operations.
+ * @offload_xfer_flags: flags supported by this controller for offloading
+ *	transfers. See struct spi_transfer for the list of flags.
  * @offload_ops: operations for controllers with offload support.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
@@ -752,6 +754,7 @@ struct spi_controller {
 	const struct spi_controller_mem_caps *mem_caps;
 
 	/* Operations for controllers with offload support. */
+	unsigned int offload_xfer_flags;
 	const struct spi_controller_offload_ops *offload_ops;
 
 	/* GPIO chip select */
@@ -995,6 +998,7 @@ struct spi_res {
  * @rx_sg_mapped: If true, the @rx_sg is mapped for DMA
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
+ * @offload_flags: flags for xfers that use special hardware offload features
  * @ptp_sts_word_pre: The word (subject to bits_per_word semantics) offset
  *	within @tx_buf for which the SPI device is requesting that the time
  *	snapshot for this transfer begins. Upon completing the SPI transfer,
@@ -1115,6 +1119,12 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	unsigned int	offload_flags;
+/* this is write xfer but TX uses external data stream rather than tx_buf */
+#define SPI_OFFLOAD_XFER_TX_STREAM	BIT(0)
+/* this is read xfer but RX uses external data stream rather than rx_buf */
+#define SPI_OFFLOAD_XFER_RX_STREAM	BIT(1)
+
 	unsigned int	ptp_sts_word_pre;
 	unsigned int	ptp_sts_word_post;
 
@@ -1622,6 +1632,20 @@ struct spi_controller_offload_ops {
 	 * hardware offload trigger that is connected to a clock.
 	 */
 	struct clk *(*hw_trigger_get_clk)(struct spi_device *spi, const char *id);
+	/**
+	 * @tx_stream_get_dma_chan: Optional callback for controllers that have
+	 * an offload where the TX data stream is connected directly to a DMA
+	 * channel.
+	 */
+	struct dma_chan *(*tx_stream_get_dma_chan)(struct spi_device *spi,
+						   const char *id);
+	/**
+	 * @rx_stream_get_dma_chan: Optional callback for controllers that have
+	 * an offload where the RX data stream is connected directly to a DMA
+	 * channel.
+	 */
+	struct dma_chan *(*rx_stream_get_dma_chan)(struct spi_device *spi,
+						   const char *id);
 };
 
 extern int spi_offload_prepare(struct spi_device *spi, const char *id,
@@ -1651,6 +1675,54 @@ struct clk *spi_offload_hw_trigger_get_clk(struct spi_device *spi, const char *i
 	return ctlr->offload_ops->hw_trigger_get_clk(spi, id);
 }
 
+/**
+ * spi_offload_tx_stream_get_dma_chan - Get the DMA channel for the TX stream
+ * @spi: SPI device
+ * @id: Function ID if SPI device uses more than one offload or NULL.
+ *
+ * This is the DMA channel that will provide data to transfers that use the
+ * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
+ *
+ * The caller is responsible for calling dma_release_channel() on the returned
+ * DMA channel.
+ *
+ * Return: The DMA channel for the TX stream, or negative error code
+ */
+static inline struct dma_chan
+*spi_offload_tx_stream_get_dma_chan(struct spi_device *spi, const char *id)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	if (!ctlr->offload_ops || !ctlr->offload_ops->tx_stream_get_dma_chan)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return ctlr->offload_ops->tx_stream_get_dma_chan(spi, id);
+}
+
+/**
+ * spi_offload_rx_stream_get_dma_chan - Get the DMA channel for the RX stream
+ * @spi: SPI device
+ * @id: Function ID if SPI device uses more than one offload or NULL.
+ *
+ * This is the DMA channel that will receive data from transfers that use the
+ * %SPI_OFFLOAD_XFER_RX_STREAM offload flag.
+ *
+ * The caller is responsible for calling dma_release_channel() on the returned
+ * DMA channel.
+ *
+ * Return: The DMA channel for the RX stream, or negative error code
+ */
+static inline struct dma_chan
+*spi_offload_rx_stream_get_dma_chan(struct spi_device *spi, const char *id)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	if (!ctlr->offload_ops || !ctlr->offload_ops->rx_stream_get_dma_chan)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return ctlr->offload_ops->rx_stream_get_dma_chan(spi, id);
+}
+
 /*---------------------------------------------------------------------------*/
 
 /*

-- 
2.43.0


