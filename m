Return-Path: <linux-spi+bounces-5715-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDCF9CF5D7
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 21:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935DD1F21DA5
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 20:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10CA1F8917;
	Fri, 15 Nov 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sJ8yRa/U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362771F706F
	for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701948; cv=none; b=gn7NOGjh9CZ3GgaLdEgYJyBGuwL7KyyiEcGeoNSwVKcbCiyb1IA5wCfB6HScygISIasvlQsbpra/ZYZ2yp8F8aTfAxl4SX1PYdGvdW6ILGeP8y8NSkUt42hLN59xedhWDsvJTXtJUltZWo8FGA9CrBVVDjMjrynFz05Gi1eUwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701948; c=relaxed/simple;
	bh=nByoFKUVSmX22QOrB5tKOE6hy2vdogrk8IlWYmMb7iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tcyq0PUQMTYdSCnNY+Ezwk1f3Ut55cXcS9szT1WBWdrA8e9KLUcSYWfLEroIMEn6SBkMvCo+RugLUeigm7z8DzqBN5VTgA9S3n3e3ZLgwg1Ebzuqy4chaVDQb89+KEvp/Bn7Rk8o1T4PbK4tGOobjsodK9f9XFfAhC5dGOdFdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sJ8yRa/U; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7181c0730ddso782375a34.2
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701944; x=1732306744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQ9TBdpHxWzvzSyVZJpMzkKE9PvbJoCuWgBYWs06guk=;
        b=sJ8yRa/Utq4US7mqGjtp09jKg2wwKGJuVrHGEesX5c7N7HAPjhNBipsa+NlrX0nL8K
         wL/UOwxJgIG81dqzE+jo36b+szK8oGAuvBEtXkTUtGWyr6tiJfwbXAysivb81Hy8ut8l
         lc0W3Jz6fJsEgrko/e/H+JTKL/a9HFFvdxrv27SJqZicxZQ1VBVEi/IPcqz7xxsLtwlP
         ge3wSeHSbVaZK8AB+xSfZyR/Ox+xhj3i/hxisdhISUs05k6Xu3i7KW1S81qMaOfj1d1o
         2bL6gICF0X0osl8nrPnUSC1E0mBul9Q2Y9fM4ged6EMHZ4ad1zZKI/3gp7pMwtm5z+cn
         FlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701944; x=1732306744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ9TBdpHxWzvzSyVZJpMzkKE9PvbJoCuWgBYWs06guk=;
        b=dw6vH7ayUt01vCMvB2LJoeBsjCkVQ1TLmdaXm91mnZbkCvhi0W23yc2DssNk9vweEi
         fBtpfXom1y8gVaIntuP32GxosJ1Wvnhly+7/+Y38EKEjGz6hmetIKZeSVi69W/ZAGOLl
         TfLR1eEahauZu7I2MEfN7FfGOn8+ZwIjZeyfBgXO02CYB4ykVPS71Is46B809jANw4q4
         dnaaxRnWf4JKbpgGkpKzFjaSInM2H8KSZnx1Pp5tmBZYqLRQQ7xhr1cN3ZyyOjy7WjdA
         zuZHi6/0m1uU4Qn2d0wQDyraRvgGk/zt7Ntx+LMnjM+3AL5iFfMd13SkvQbpeCpZ/sJe
         uyiw==
X-Forwarded-Encrypted: i=1; AJvYcCXFlNhTQwXzuFrb5hhdnu1cBA77CSJyOPqEETJ55Iuy9TZgNiDiS6p04ZsrR2uimyW5GhtBvbqBCwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFbNpnchoqpNyENQoCQjgSkE7uSnZ9SYd/tJ7XzbCcoQUUSAH
	2RtH9DPT6eVNQR1Vw9wg4sTdJZ0cUPQ456Bels2e8xptOBFsfdEOaGRHFwriWN0=
X-Google-Smtp-Source: AGHT+IFpIObwug+gjtaFB8EYgLYodh+d7CpNa3uZrjGmbI+QPIYY+qYFAjZ6xzpN4D9Z/f4yyjISHA==
X-Received: by 2002:a05:6830:64ca:b0:718:194d:8ab with SMTP id 46e09a7af769-71a77a55f3cmr4663542a34.27.1731701944380;
        Fri, 15 Nov 2024 12:19:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:49 -0600
Subject: [PATCH v5 10/16] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-10-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
cases where the DMA channel is managed by the caller rather than being
requested and released by the iio_dmaengine module.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: none

v4 changes:
* This replaces "iio: buffer-dmaengine: generalize requesting DMA channel"
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 107 +++++++++++++++------
 include/linux/iio/buffer-dmaengine.h               |   5 +
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 054af21dfa65..602cb2e147a6 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -33,6 +33,7 @@ struct dmaengine_buffer {
 	struct iio_dma_buffer_queue queue;
 
 	struct dma_chan *chan;
+	bool owns_chan;
 	struct list_head active;
 
 	size_t align;
@@ -216,28 +217,23 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
-static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan,
+						     bool owns_chan)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
 	struct dma_slave_caps caps;
-	struct dma_chan *chan;
 	int ret;
 
 	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
-	if (!dmaengine_buffer)
-		return ERR_PTR(-ENOMEM);
-
-	chan = dma_request_chan(dev, channel);
-	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		goto err_free;
+	if (!dmaengine_buffer) {
+		ret = -ENOMEM;
+		goto err_release;
 	}
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_release;
+		goto err_free;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -252,6 +248,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);
 	dmaengine_buffer->chan = chan;
+	dmaengine_buffer->owns_chan = owns_chan;
 	dmaengine_buffer->align = width;
 	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
 
@@ -263,10 +260,12 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
-err_release:
-	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
+err_release:
+	if (owns_chan)
+		dma_release_channel(chan);
+
 	return ERR_PTR(ret);
 }
 
@@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 		iio_buffer_to_dmaengine_buffer(buffer);
 
 	iio_dma_buffer_exit(&dmaengine_buffer->queue);
-	dma_release_channel(dmaengine_buffer->chan);
-
 	iio_buffer_put(buffer);
+
+	if (dmaengine_buffer->owns_chan)
+		dma_release_channel(dmaengine_buffer->chan);
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
+static struct iio_buffer
+*__iio_dmaengine_buffer_setup_ext(struct iio_dev *indio_dev,
+				  struct dma_chan *chan, bool owns_chan,
+				  enum iio_buffer_direction dir)
+{
+	struct iio_buffer *buffer;
+	int ret;
+
+	buffer = iio_dmaengine_buffer_alloc(chan, owns_chan);
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
+
 /**
  * iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
  * @dev: DMA channel consumer device
@@ -308,24 +333,13 @@ struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  const char *channel,
 						  enum iio_buffer_direction dir)
 {
-	struct iio_buffer *buffer;
-	int ret;
-
-	buffer = iio_dmaengine_buffer_alloc(dev, channel);
-	if (IS_ERR(buffer))
-		return ERR_CAST(buffer);
-
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
-	buffer->direction = dir;
+	struct dma_chan *chan;
 
-	ret = iio_device_attach_buffer(indio_dev, buffer);
-	if (ret) {
-		iio_dmaengine_buffer_free(buffer);
-		return ERR_PTR(ret);
-	}
+	chan = dma_request_chan(dev, channel);
+	if (IS_ERR(chan))
+		return ERR_CAST(chan);
 
-	return buffer;
+	return __iio_dmaengine_buffer_setup_ext(indio_dev, chan, true, dir);
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
@@ -362,6 +376,37 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
+/**
+ * devm_iio_dmaengine_buffer_setup_ext2() - Setup a DMA buffer for an IIO device
+ * @dev: Device for devm ownership
+ * @indio_dev: IIO device to which to attach this buffer.
+ * @chan: DMA channel
+ * @dir: Direction of buffer (in or out)
+ *
+ * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
+ * and attaches it to an IIO device with iio_device_attach_buffer().
+ * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
+ * IIO device.
+ *
+ * This is the same as devm_iio_dmaengine_buffer_setup_ext() except that the
+ * caller manages requesting and releasing the DMA channel.
+ */
+int devm_iio_dmaengine_buffer_setup_ext2(struct device *dev,
+					 struct iio_dev *indio_dev,
+					 struct dma_chan *chan,
+					 enum iio_buffer_direction dir)
+{
+	struct iio_buffer *buffer;
+
+	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, false, dir);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
+					buffer);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext2, IIO_DMAENGINE_BUFFER);
+
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 81d9a19aeb91..7bdb979b59f2 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -11,6 +11,7 @@
 
 struct iio_dev;
 struct device;
+struct dma_chan;
 
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
@@ -26,6 +27,10 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					const char *channel,
 					enum iio_buffer_direction dir);
+int devm_iio_dmaengine_buffer_setup_ext2(struct device *dev,
+					 struct iio_dev *indio_dev,
+					 struct dma_chan *chan,
+					 enum iio_buffer_direction dir);
 
 #define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
 	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\

-- 
2.43.0


