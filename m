Return-Path: <linux-spi+bounces-6667-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F6A2CDB7
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF4188DC31
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF11D6DA3;
	Fri,  7 Feb 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y661FKNP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E41B87E2
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958982; cv=none; b=geWZv+0ctCZhGtlMKD2AqN6kHUlwJzRcZ8CKczF+NYcMZqf26e7K7Rrp777CEkdOrUc6sdbGnDSbTE3NC2SlzJDl11Eje8AW3MyGNbdSGvhIQnrwTtantHHdFqVdjUjt+0EePFBnsJk5toY+VKsc+iDr2H8M7g08jcR6MzXRV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958982; c=relaxed/simple;
	bh=WTRyrDP74Be0UzziUCgrAt1IiqdEqmSclPtrQfncLY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0Du4/ucy3D2SOejoFbVfJvCiJK2PSQuRrP31uBR+m5yPeb1+Pxk+V9zxU1QLkbqLGRDyEymNaV/hgXxjRSgrYhGn7Ddj1otQsFfE7zxg/wLr4iNw/vIyev+BiQjYHqdQplhSitveUOfMEm7LMksau1JK9kC4Rt7Wnz+hAXmTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y661FKNP; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e15717a2dso1285895a34.3
        for <linux-spi@vger.kernel.org>; Fri, 07 Feb 2025 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958979; x=1739563779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdMxJLVUyi4W3/XAWZvTW+GcXmKoS+IN/gS3t7thlds=;
        b=Y661FKNPqJqCh1hpvQ4Tno47aIqz5DvxhlO2GhL2FXNXXH7GU6yQXaxqrkFWWzXm+y
         irsbyI0mt/jcFkoBAb1CBan9ov3WVxsC4Z4R/ac1P7ENbNmI+8P5yeyHA+gseTVME18T
         YUmVxDF9WLQ6iIYyUMAqKjtF8fhsj9O4IFq8KojqhbA8kVrc8vlenfAdQD6jWsDJL+Ng
         nhiBQXGdKODUNvht28P9jqUB5AWQc+2F9HWu3rL7RnlhBjWjXCO08Qs7XmHMkj0pC18T
         2Yt4+nZOXNuMHpZm/mlOT96tJXcUjOdh51aN5lmuCDo5KQqJ7rNydp5UwQidgjx3RMzX
         OzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958979; x=1739563779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdMxJLVUyi4W3/XAWZvTW+GcXmKoS+IN/gS3t7thlds=;
        b=DDpl0/IkU/AOb79A/z0GD7URzodcE9CNfx+h1DF+5vSmNl1EOFrMX7U5XMKd5wLzXu
         NDz1qkEhV56d1xJ86kEr6U2NuQHma1bgKHR3bDwOciHjqhezoljz4/u/TH7/SchhfxZV
         H8Hc6mck59Pq2gaHwBQpBLl3TYW80/Xs/8izftYgVfZ3o1di6WpEKtlxzLsGFhC5Tm5G
         OMiFvOW7Q5gU9kMGm+4l/688L/hCUL2ABuKNFaAkJAK5JKUhqlVHjG9QzgG/knSDhn8a
         WDLv7qZz8Fnd8NBCYVNd/QG1Hq64i23mQxU0BzdtTP3Ay421UF6BZU/z7CTdcu6bqQrf
         X6gA==
X-Forwarded-Encrypted: i=1; AJvYcCW0mPmRtDHZ8HYJ0ZiUcqgPRhwzerKTxZaXG4o7wuZfd+4Hz9HWHnAQIJpF4/PWUymMBgIMyynLA1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiZD3NVUApftcZoZjYdJGoLfP22DgwNAo0MvE4s83WO8Xy7hf
	Mb1R8pIdeF45B/Kmc4mO+E0NfzJ/B45umD8ly07DkywBFPAYTWjdkW9r3b1bi4I=
X-Gm-Gg: ASbGncsPIkEid7j8bh42xy5o2wP8uATGeDGi12I5fgUya7zZWgE5++Hh5kuytnIfUPD
	SWYthncKQM+yzT5G3eDKL8/Q/FesbwCaWiJi+GXsCCEdd+QaJnu2ucjMn0oPktCbjeMgG74Qiaq
	l48ae7q0rGyAU9FUdz7t8/Qzg7g8+eycQSmJS9/STgERuhmSBwLDRBOTrnfXvbJPd48rHdYyqNK
	3gPHy3hValq+Fm+TKgwl16JnceWlF29Mm984RqFJM6NXL7RzIaIcsYNApKbHQpqz6JKJDxb9B1d
	iu5k2iQKLxzEVLz/26mupaWY4SPuiS4Za8BLrSIjX3aamec=
X-Google-Smtp-Source: AGHT+IH5sh7VymPtzuwCp1Fwk/GTYtt6arEUE6mdjwiN9mTxM2PbOcR5pHPX9Vehw6fyomKaJMOOAw==
X-Received: by 2002:a05:6830:698d:b0:71d:fc52:1ab6 with SMTP id 46e09a7af769-726b88a3e27mr2735801a34.23.1738958979574;
        Fri, 07 Feb 2025 12:09:39 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:05 -0600
Subject: [PATCH v8 08/17] iio: buffer-dmaengine: split requesting DMA
 channel from allocating buffer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-8-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Refactor the IIO dmaengine buffer code to split requesting the DMA
channel from allocating the buffer. We want to be able to add a new
function where the IIO device driver manages the DMA channel, so these
two actions need to be separate.

To do this, calling dma_request_chan() is moved from
iio_dmaengine_buffer_alloc() to iio_dmaengine_buffer_setup_ext(). A new
__iio_dmaengine_buffer_setup_ext() helper function is added to simplify
error unwinding and will also be used by a new function in a later
patch.

iio_dmaengine_buffer_free() now only frees the buffer and does not
release the DMA channel. A new iio_dmaengine_buffer_teardown() function
is added to unwind everything done in iio_dmaengine_buffer_setup_ext().
This keeps things more symmetrical with obvious pairs alloc/free and
setup/teardown.

Calling dma_get_slave_caps() in iio_dmaengine_buffer_alloc() is moved so
that we can avoid any gotos for error unwinding.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Split out from patch that adds the new function
* Dropped owns_chan flag
* Introduced iio_dmaengine_buffer_teardown() so that
  iio_dmaengine_buffer_free() doesn't have to manage the DMA channel
---
 drivers/iio/adc/adi-axi-adc.c                      |   2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 106 ++++++++++++---------
 drivers/iio/dac/adi-axi-dac.c                      |   2 +-
 include/linux/iio/buffer-dmaengine.h               |   2 +-
 4 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7357601f0f869e57636f00bb1e26c059c3ab15c..a55db308baabf7b26ea98431cab1e6af7fe2a5f3 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -305,7 +305,7 @@ static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 static void axi_adc_free_buffer(struct iio_backend *back,
 				struct iio_buffer *buffer)
 {
-	iio_dmaengine_buffer_free(buffer);
+	iio_dmaengine_buffer_teardown(buffer);
 }
 
 static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 614e1c4189a9cdd5a8d9d8c5ef91566983032951..02847d3962fcbb43ec76167db6482ab951f20942 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -206,39 +206,29 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
 
 /**
  * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
- * @dev: DMA channel consumer device
- * @channel: DMA channel name, typically "rx".
+ * @chan: DMA channel.
  *
  * This allocates a new IIO buffer which internally uses the DMAengine framework
- * to perform its transfers. The parent device will be used to request the DMA
- * channel.
+ * to perform its transfers.
  *
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
-static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
 	struct dma_slave_caps caps;
-	struct dma_chan *chan;
 	int ret;
 
+	ret = dma_get_slave_caps(chan, &caps);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
 	if (!dmaengine_buffer)
 		return ERR_PTR(-ENOMEM);
 
-	chan = dma_request_chan(dev, channel);
-	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		goto err_free;
-	}
-
-	ret = dma_get_slave_caps(chan, &caps);
-	if (ret < 0)
-		goto err_release;
-
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
 		src_width = __ffs(caps.src_addr_widths);
@@ -262,12 +252,6 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;
 
 	return &dmaengine_buffer->queue.buffer;
-
-err_release:
-	dma_release_channel(chan);
-err_free:
-	kfree(dmaengine_buffer);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -276,17 +260,57 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
  *
  * Frees a buffer previously allocated with iio_dmaengine_buffer_alloc().
  */
-void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
+static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 {
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(buffer);
 
 	iio_dma_buffer_exit(&dmaengine_buffer->queue);
-	dma_release_channel(dmaengine_buffer->chan);
-
 	iio_buffer_put(buffer);
 }
-EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, "IIO_DMAENGINE_BUFFER");
+
+/**
+ * iio_dmaengine_buffer_teardown() - Releases DMA channel and frees buffer
+ * @buffer: Buffer to free
+ *
+ * Releases the DMA channel and frees the buffer previously setup with
+ * iio_dmaengine_buffer_setup_ext().
+ */
+void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer)
+{
+	struct dmaengine_buffer *dmaengine_buffer =
+		iio_buffer_to_dmaengine_buffer(buffer);
+	struct dma_chan *chan = dmaengine_buffer->chan;
+
+	iio_dmaengine_buffer_free(buffer);
+	dma_release_channel(chan);
+}
+EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_teardown, "IIO_DMAENGINE_BUFFER");
+
+static struct iio_buffer
+*__iio_dmaengine_buffer_setup_ext(struct iio_dev *indio_dev,
+				  struct dma_chan *chan,
+				  enum iio_buffer_direction dir)
+{
+	struct iio_buffer *buffer;
+	int ret;
+
+	buffer = iio_dmaengine_buffer_alloc(chan);
+	if (IS_ERR(buffer))
+		return ERR_CAST(buffer);
+
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+
+	buffer->direction = dir;
+
+	ret = iio_device_attach_buffer(indio_dev, buffer);
+	if (ret) {
+		iio_dmaengine_buffer_free(buffer);
+		return ERR_PTR(ret);
+	}
+
+	return buffer;
+}
 
 /**
  * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
@@ -300,7 +324,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, "IIO_DMAENGINE_BUFFER");
  * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
  * IIO device.
  *
- * Once done using the buffer iio_dmaengine_buffer_free() should be used to
+ * Once done using the buffer iio_dmaengine_buffer_teardown() should be used to
  * release it.
  */
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
@@ -308,30 +332,24 @@ struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  const char *channel,
 						  enum iio_buffer_direction dir)
 {
+	struct dma_chan *chan;
 	struct iio_buffer *buffer;
-	int ret;
-
-	buffer = iio_dmaengine_buffer_alloc(dev, channel);
-	if (IS_ERR(buffer))
-		return ERR_CAST(buffer);
-
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
-	buffer->direction = dir;
+	chan = dma_request_chan(dev, channel);
+	if (IS_ERR(chan))
+		return ERR_CAST(chan);
 
-	ret = iio_device_attach_buffer(indio_dev, buffer);
-	if (ret) {
-		iio_dmaengine_buffer_free(buffer);
-		return ERR_PTR(ret);
-	}
+	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir);
+	if (IS_ERR(buffer))
+		dma_release_channel(chan);
 
 	return buffer;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, "IIO_DMAENGINE_BUFFER");
 
-static void __devm_iio_dmaengine_buffer_free(void *buffer)
+static void devm_iio_dmaengine_buffer_teardown(void *buffer)
 {
-	iio_dmaengine_buffer_free(buffer);
+	iio_dmaengine_buffer_teardown(buffer);
 }
 
 /**
@@ -357,7 +375,7 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
-	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
+	return devm_add_action_or_reset(dev, devm_iio_dmaengine_buffer_teardown,
 					buffer);
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, "IIO_DMAENGINE_BUFFER");
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index ac4c96c4ccf37d752372b57acfcb8ad098930b58..7ed934dfc5fc9f08d59b2b0c33537669558ec884 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -168,7 +168,7 @@ static struct iio_buffer *axi_dac_request_buffer(struct iio_backend *back,
 static void axi_dac_free_buffer(struct iio_backend *back,
 				struct iio_buffer *buffer)
 {
-	iio_dmaengine_buffer_free(buffer);
+	iio_dmaengine_buffer_teardown(buffer);
 }
 
 enum {
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 81d9a19aeb9199dd58bb9d35a91f0ec4b00846df..72a2e3fd8a5bf5e8f27ee226ddd92979d233754b 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -12,7 +12,7 @@
 struct iio_dev;
 struct device;
 
-void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
+void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer);
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  struct iio_dev *indio_dev,
 						  const char *channel,

-- 
2.43.0


