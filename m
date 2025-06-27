Return-Path: <linux-spi+bounces-8842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33BDAEC323
	for <lists+linux-spi@lfdr.de>; Sat, 28 Jun 2025 01:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52F81C25A29
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA742291157;
	Fri, 27 Jun 2025 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CpRqtJD8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A2292B28
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067690; cv=none; b=M6N+1XPoD7YCI5NZQ1QTXIIzs+n/WFqr54uH5/n2j+VA8D2xeAIHaEB+5GWRRnLAekl3fKJX7nu+/z6dRRzEqwaCzcQJTEKlbOE3mAlS/F9E430ceEIeBy2hcheow0E9O4ixfwDf64uKOG3elxU0L5ow5OsshTw9bPIRB+pSSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067690; c=relaxed/simple;
	bh=FtjSefgJ38MUOtssdwwTVZxqFU2P60mzs7S3a2VVXcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzsE4zprhIe5DrOFAwl7Uf7zIaRxjesWxGxP51thxqo0iWs4aArMDGCsc7qsSnmLzuakhwb1zfbsMgKNsx0aHcrx8Kfag33nxCN/pEU23pnu1cJ41Kr9asNVi/TDSYHyzWIS26n0JmZuKnFrzPAOWUq57cBcxZDkTb4/Nxz5MSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CpRqtJD8; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40a6692b75cso319022b6e.1
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067688; x=1751672488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL6Ufncylm91/QYr6Kod6l5M+E3FlraXlz8+iem4HYU=;
        b=CpRqtJD8I3FaITabLXXFCXLy9UqtyHpbFzYZ2X7xRVKMyAbcSzB+A3aFkhvfrpyIUS
         8A7iQWDGma334dnjrrNZas4UvR5cOqa/wYUZBqbyncbCrITOtH6h/XEVSAfGCN3jLkWk
         TewrmHj348mIhMA7kV3+nSVZdLdpQMTpU3k8JxkGpPEQ7atXdZ9tMVWprq9vPFluutvF
         K4bdXbiYfMja5FLMtnxfbmTF5SP20BiZoWwnc6xNR7jbbIpECi8uQWyfIIXz8oy866Z6
         eAQ7iO0OhlZ1supEP5LlV9Mc0fgwZcC4E9aznTE6KDSSbUnGAge5Ax3JSudYm3SjutP4
         RUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067688; x=1751672488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL6Ufncylm91/QYr6Kod6l5M+E3FlraXlz8+iem4HYU=;
        b=YB4DH9FV/Aj91GehYhE8FpQhWa1jgIAORjLIvu9rgW79UdCZBGpR4Z1SwzN0pK+pwl
         ccXMZLCrldY8TeITlje3qtWNLChCpF0hoi6ADV4OPnh5r2YqjDLXmLAzWLIrTQETV6sV
         sSAA/tDMZZb3akjXkmtFCIe5oJV4ba4jzHJGPHNCYKMBRwPH18JNKQISL8o4KakT7i/Z
         EYpTwbCM/shqRrs9v5uv2N/8SbTptpav6S4DCxaU1xGsFF0QezbZc7mOv4SnftvlCiv9
         l0zqyt0VSbXmLlEiFLlVs3tidnGT2Bmv8ectMNWSgjui4UFgfD7wpcUSO8ATSk6xYUGw
         Yy6g==
X-Forwarded-Encrypted: i=1; AJvYcCUF+EcYkgxrf1rnMYfJaZnzpUvRADiCSBunfZnIDt7WXJWoZigb5wI7kLM+n7aTXgdbdy0yInt3rbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGKZ+EFDmm64jXvBEOSUXcjtZAbhLjN+DQUyLYKsXppSsuN1S
	ZVLqtbe0siPNbdwKGpF+xI5f78HTN7k4j8Pzk/4IA5+p+DiszDLyidL6xve8Qw1V6Zg=
X-Gm-Gg: ASbGncsRbcXRdSSXeJ11fuo+Awmc6cpqFcmukIUpbOlWSfhhNcaKUBG4cMEFbQHSdIa
	HO/gNvK330nG5JLTUD9pZiXAh2lqXoXDjyLasZLV3Sr9MNQUYHgqdZGKvqaxFszIBLJLLJ3MaKz
	VbHYspA9lqxJiNUIEpx8g/VKErBWJlAsqG6F/+z9SSdZrBArwhpyHuSyTsBCx5N5dDxyH5hqBwN
	ZJoMh/X9yDn4ooySk6GDPEfZENjaEKhkCVXb4X5fmHgKVdZbSIVZvcjCjOO9SmkC/qW6ebpgH/B
	lB/JZOlolUQ458L0G1k62gGbVwkTPkPCKOlaOSl5kZx9gxQNvYXGHV/6scWAH8V15JorS3tmx5l
	3Gw==
X-Google-Smtp-Source: AGHT+IHR03eEjSR93QjKaZGA+fwHzKuMIoLnqyT7gtlUk04SI5qr4Fi8EmUf2eK9bWFOFHHXkHTItw==
X-Received: by 2002:a05:6808:13c9:b0:409:f8e:72a6 with SMTP id 5614622812f47-40b33c2c383mr4121274b6e.1.1751067687796;
        Fri, 27 Jun 2025 16:41:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:39:59 -0500
Subject: [PATCH v2 03/11] iio: adc: ad_sigma_delta: use u8 instead of
 uint8_t
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-3-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=FtjSefgJ38MUOtssdwwTVZxqFU2P60mzs7S3a2VVXcU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvnjgL+AcWVVuCuh0G2vwDavgU50pexnV6KF
 JP4pRWUeReJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r5wAKCRDCzCAB/wGP
 wBOWCACITc4y7+7dT+N6nLT0/YeUisIgoQNW7rs52NvZS9TlWHaxl/isKmF6pdjeEP7uCPvaVM4
 yJlR14Kr31ezOc/vAdLWOFfiqO8kJ0f0x5mplsLsKGNF8sGBihExprPNChFem46W60vngDMX6h7
 PmULjDuX+o89cz+WOONAEvJkFs19uIjMCsRy4utgGPhtD+J3m8OCNVwNqo53so6EcJTle2jG8sQ
 68hxZUaTkcj8Ut8zIPWPzk0Yi0/R84mn+CNo/kbWKNah5Gdggn5TTeCrjikSYfbF73MZYPY0KDm
 2BmlwPhS8v/WIRnFMPhyEqWG8xgp2FNW7BjZV2OzXTffM2cF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace uint8_t with u8 in the ad_sigma_delta driver.

Technically, uint8_t comes from the C standard library, while u8 is a
Linux kernel type. Since we don't use the C standard library in the
kernel, we should use the kernel types instead.

There is also one instance where int64_t is replaced with s64.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 17 +++++++++--------
 include/linux/iio/adc/ad_sigma_delta.h | 10 +++++-----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5cdd73160c6d6d4d9308eaa3a5aec14529475676..5362157966d89cbf0e602716aaaf0b78f3921b11 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/adc/ad_sigma_delta.h>
@@ -38,7 +39,7 @@
  * @sigma_delta: The sigma delta device
  * @comm: New value for the communications register
  */
-void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm)
+void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, u8 comm)
 {
 	/* Some variants use the lower two bits of the communications register
 	 * to select the channel */
@@ -59,7 +60,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, "IIO_AD_SIGMA_DELTA");
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val)
 {
-	uint8_t *data = sigma_delta->tx_buf;
+	u8 *data = sigma_delta->tx_buf;
 	struct spi_transfer t = {
 		.tx_buf		= data,
 		.len		= size + 1,
@@ -99,9 +100,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 EXPORT_SYMBOL_NS_GPL(ad_sd_write_reg, "IIO_AD_SIGMA_DELTA");
 
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
-	unsigned int reg, unsigned int size, uint8_t *val)
+			      unsigned int reg, unsigned int size, u8 *val)
 {
-	uint8_t *data = sigma_delta->tx_buf;
+	u8 *data = sigma_delta->tx_buf;
 	int ret;
 	struct spi_transfer t[] = {
 		{
@@ -185,8 +186,8 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, "IIO_AD_SIGMA_DELTA");
 int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
 	unsigned int reset_length = sigma_delta->info->num_resetclks;
-	uint8_t *buf;
 	unsigned int size;
+	u8 *buf;
 	int ret;
 
 	size = DIV_ROUND_UP(reset_length, 8);
@@ -454,7 +455,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int i, slot, samples_buf_size;
 	unsigned int channel;
-	uint8_t *samples_buf;
+	u8 *samples_buf;
 	int ret;
 
 	if (sigma_delta->num_slots == 1) {
@@ -488,7 +489,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
-	samples_buf_size += sizeof(int64_t);
+	samples_buf_size += sizeof(s64);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);
 	if (!samples_buf)
@@ -543,7 +544,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	uint8_t *data = sigma_delta->rx_buf;
+	u8 *data = sigma_delta->rx_buf;
 	unsigned int transfer_size;
 	unsigned int sample_size;
 	unsigned int sample_pos;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f242b285081b8d304ca25ae95337425e5842269a..5056677c9941afadc2383febbcafeb02e23a4f44 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -94,7 +94,7 @@ struct ad_sigma_delta {
 	bool			bus_locked;
 	bool			keep_cs_asserted;
 
-	uint8_t			comm;
+	u8			comm;
 
 	const struct ad_sigma_delta_info *info;
 	unsigned int		active_slots;
@@ -105,7 +105,7 @@ struct ad_sigma_delta {
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;
-	uint8_t			*samples_buf;
+	u8			*samples_buf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -114,8 +114,8 @@ struct ad_sigma_delta {
 	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
 	 * rounded to 16 bytes to take into account padding.
 	 */
-	uint8_t				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
-	uint8_t				rx_buf[16] __aligned(8);
+	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
+	u8				rx_buf[16] __aligned(8);
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
@@ -177,7 +177,7 @@ static inline int ad_sigma_delta_postprocess_sample(struct ad_sigma_delta *sd,
 	return 0;
 }
 
-void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, uint8_t comm);
+void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, u8 comm);
 int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int val);
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,

-- 
2.43.0


