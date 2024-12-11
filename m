Return-Path: <linux-spi+bounces-6027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9C9ED7B5
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 21:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AC9162E34
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E892368EF;
	Wed, 11 Dec 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lRPOfuJe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601F231A42
	for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950514; cv=none; b=etp3sbmDFaTy+V25ePJ5mivFRzSW1q/yMEnQphvcRNY6D4c1Hh7x00o+m/m2ApjKAz2v3sb5pLJsFUusKUPjGqugNrNbIBWzRJ0ACfZTjKVbbZJWhHIcvApCnNc9wLCoOXmy/WJXj45IZG7P9HQhuHUJAFlvZoz9Q6ThfZCe6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950514; c=relaxed/simple;
	bh=9eN/Mm2oP08RkM7OEZTBBS3KnWURqPbgm+Wn6qUO7ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nke+qnQhlvu3dCoTleJrTtEhL/tc32gvxyIewpl4Z3lE5rCW4tG3ZPG+3ZNDvnAh6Jvp+xOwy1DvlQ0AOUNmeCtG+dpJCrnxFdJCefpAzzq4JQIvwHeWZoG33hWUyYovW/5NIBdMqNt14epVlwDELREoyE1LRroholWaRWo+6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lRPOfuJe; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e0d4f2874so627747a34.2
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950511; x=1734555311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBuORrrjmBdkeZMAxKpvMkX3PIq0DDiCGF+o99GejT8=;
        b=lRPOfuJewvdrSZG0dgRphThRDBqo4R4XtFGB+EckZFWnyS0sZHp15vXnrZgxEPiAJe
         LtzpPX1nxT6zxCg/lI1l0tK4VAzIxY3zVXX00I5CfWjGeSryKTv9ERB48NmIarLB1Pa+
         4Hi/UeUr2YpmboAgtnbeyrxlFv3B278pPo//spFEn1G1ptOu9n6f54stEHd18519M4H3
         5jFYk3FryGujo3nQhOOIKSR/MorVM2rHWvp4rhBKmcPkCNPoDxYSzZ74JB4m0Q8r448V
         AUpKdIjzyHlHRYD4iA2TrP3hVEJmGTRW0KOyxUo4UgQ6/0rSMirtFwmXzpyM8KWJFXuF
         G9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950511; x=1734555311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBuORrrjmBdkeZMAxKpvMkX3PIq0DDiCGF+o99GejT8=;
        b=VAaNakCndo+1ZJPwd1IG/GICtnvWOFi8vwf4qAzc+CGBGykWBytvEV3/PDr40NJ1Du
         DaBiSjH84yUylwOI2koOOo1gVmmfPgxxE7UzOMlhPs/3uDICgXpsUMho6xvdplsM0BbG
         rWBpLeGt9QnsI6ZMPIbTgUegJOhQhAbQUTm1AzjcRacEUcbbEGrygwT+YMYClZdo117g
         9vuMarBevavz8xXZ+RtZoKMFWbU5dTUCSsRJeERyMGZr+Ge7f0WdFasnAP/EmfBhcFe4
         NxMp73XyxudaS3B1qszyLsE60j7uUXOxBl+9aXvxUUfeArdL6GAwwo6zww86+ulez8v9
         4Rbg==
X-Forwarded-Encrypted: i=1; AJvYcCXPj7T3aY53PNDDfqMlR1VE57bDqDlyEzhGy3sncTZrRe0N+BJY4biF+X38YcIxoyVF9sJbRwLcnX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlCybQhRD1tb36ogNUQJGDdrQ3q6GlkZmFRVgMbmy6UCvO8H7
	Ftib9OlhFg6JmAbHNmopAASZzmx2yoa4w7BOd9ZXeBJOs29gH6dHN10wgZY0MiU=
X-Gm-Gg: ASbGncvvFmL4gNU28sD1BucjVqB45dsdrDK/RRDsYJAkZfcbXJk2nzjTD+fcb30wdkb
	WB19ODpvOEAKTazRg+9sLryuRn7gOP8emQ8lffMM02jwOEdo/s0Qq/naEFvS9xIkpZE44vQzQop
	2tF0bmyAD7PnXOnY1qMhw+HoWJqsu39b8UrL2CELncsIOHlyhjHv5GCCPNVOUQUHaQajszrI9iL
	5qWINrTtibCDTV9UR0pttiWR08Sx7ovtwHn/7IfMWS0AWQKQSSXeRPn19ZE6q5vKXzbzaKOQeeB
	9O9DLkTvdg==
X-Google-Smtp-Source: AGHT+IHALwUFRvApBiwUAfD2ESw4PyZ8TKFUmee8UZP5rJIo9UG+69ZPEAlPJvfTtXV0ERJvFnYTFQ==
X-Received: by 2002:a05:6830:6c08:b0:718:10eb:1eab with SMTP id 46e09a7af769-71e29c3ab7cmr475166a34.11.1733950510852;
        Wed, 11 Dec 2024 12:55:10 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:45 -0600
Subject: [PATCH v6 08/17] iio: buffer-dmaengine: split requesting DMA
 channel from allocating buffer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-8-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

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
index b143f7ed6847277aeb49094627d90e5d95eed71c..5d5157af0a233143daff906b699bdae10f368867 100644
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


