Return-Path: <linux-spi+bounces-8693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD441AE2598
	for <lists+linux-spi@lfdr.de>; Sat, 21 Jun 2025 00:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D174F4A5497
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF624728E;
	Fri, 20 Jun 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tiJagRBB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E024678A
	for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458087; cv=none; b=jPFZNi3sPOdGe8oNnkyjVhL6Ixsaby8VphdoT4jwGzqEFWUy8uu0HLVgljWjueIgvrMA8QP5/C8VKC69ahjB9+6XWRg5g3X2E1ggXVQTzpFPQ/ER+hhJt7hAOCtCaRmmV8DBp/0Ab3rKkkX1VS4rNftItIHpebE5BD7uCr/emOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458087; c=relaxed/simple;
	bh=RN0qztNZZGlggYLxiyvfwi/AaXTnKzQQGMk8+t2oTno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOoN/zmTE5aCSuQ3cyX+fVAKbmS17K2A+Oa568mNk3UgsD/Xs7jXORM5rEtbwFYqgGS3HqDNvQqocgvALe49/D+JVmQeK5iqp3Nr434wjIyaTBqTWJwTLs+Svgs9hdn6ZK8Ao9Uil6OP5hj/Zzw/0dmpaTUPei8y8O7E3lxf01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tiJagRBB; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ea83f382c3so1426222fac.0
        for <linux-spi@vger.kernel.org>; Fri, 20 Jun 2025 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458085; x=1751062885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xISIxFWepJfY0GBl9vwUD9dWscdCP+konhwzDZnuj3A=;
        b=tiJagRBBrUAayLvZdbK7f2IQbZvZH4Li3UGSkjzWRCRifS+ezZmM71K+nkWaiYfadi
         DFuLWzkruPwybAQsj0DsQ9wqbCtIcWGiJ1VNel1P9XbgaWUIAqeJ91f4fbtwu2KQ0Upl
         oqqyw2jItOH/fmuAMXntIkxHNhsb/m5+dVUw4gZimiuZKH5RTGPT6qScX6IuRkyEZRRN
         bLoQpb5xiiXgntID2bkIIxReStkabhWmfzDOFZTPjRRk1NjequzhPrRBHNA1qDVyrKNG
         axo82GPvLv8tVyWK/b2tq06SGEU1at4ZrVNj3Uz5go/amtR+1tt839/eU2h91iLpbV29
         PvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458085; x=1751062885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xISIxFWepJfY0GBl9vwUD9dWscdCP+konhwzDZnuj3A=;
        b=Cz7nGl9Sf4H5u9Xh+aIGwi+mr87Vbdh8XxUhl+keQJjnQsxxHON77APLKtlBiY9fe/
         ox71GSwyIe+/VJpwbELlJanO7wi7TVJYS3mblzeBYGQ8VHisy1wjOdxcCfJqe4dL1Cvy
         StwVHqcHJu2J86mW4fnwcZaMEcTEHyZCSzzsoPG7UlQTqyj/BBXSPZf0W1VLW901nf8s
         OubYDrIlu+2/aZgoTAYbje9WCnvIx/9f/IJBPI++UUnwglkEuonixR6KzS1wSNF6+KB0
         Bino+rtW1ol4wS7mR0VVTNjtw/6SdfYgWh5HVDTfqXnRH2vPwlhN27DzDsOouWlVfVMk
         PGXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCMPQTwmT+qXP4KwKe6jYzjepHoNv6Bo2xqz1DK5srBR+eSiC/tktx0mdsDHwO2DgSvguXCWYZ1g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLt0iRPkVv9Ga1j4A2hKiRid2tbVTR1rTI11gv3V7cwwgEyqa
	jWP/pHoTR/Z/im0oKNSK+rXhYVTb9xdxYAKWsR3uRFm/+Qa8WE3A4i03zgzpoxp2il0=
X-Gm-Gg: ASbGncsuIKCvhSxVYdlFVE49jiIuu+3puQWItNEJX2WQqleuGPtHol8RwEccD5H073O
	aW9/T9OOZfuukQRpdiaLIC86jxEWVnmyclpyOEYs3hDPhQ3Ttp7MaYlWdzMFnW7MQP6Mlitf/nq
	pHzb4qEL6NBNO8cnpOEJcUOwcLfBL9vwZQY5jY3KDZGVqakfFNkbaXMEmbtEpMKPTVadyXgMApF
	jgtL3K32xRIwxCIcuWiKwKJs/PIEdpU2YEdHZUqV4Ukoaa980YyEnIJXSA7lvZYLfaGnypUiYsc
	CiNDOgiV+331RK8eZ+Xtdh3upYfs6zQtNGxb7VLbrOUEUq2qC3gXOsW8QVtg4/QVBlHc
X-Google-Smtp-Source: AGHT+IHOPAa1v82GyaqrTI5BfuLKv0C5wbzA4p6Q8lWHhrdb+T5d7REllL2ZKEjqRsOARSobLzzPcA==
X-Received: by 2002:a05:6870:35d6:b0:2d4:d820:6d82 with SMTP id 586e51a60fabf-2eeee5c31f0mr3395842fac.26.1750458085081;
        Fri, 20 Jun 2025 15:21:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:08 -0500
Subject: [PATCH 2/9] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-2-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4793; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=RN0qztNZZGlggYLxiyvfwi/AaXTnKzQQGMk8+t2oTno=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd6psRAij0KiZD2NLOLlOfQZ0h5gzStZ21ZRI
 DxsTLK1A0WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXeqQAKCRDCzCAB/wGP
 wNSxB/4l0o+TBzcerLJXqUYuiYCk1PBCkq6Bw+dpIbzMFcL0B4Dc36kgQLYh9Q3qP8guD1M3sxe
 XDYdrcNqmdD9CYX46jdVWRDAvuXFpoRwStzlARIPCLVHm74OQzs3xjSeNkLfFZh2xXQ4QeqUXVZ
 YRa3qfKwrHnmZjm+QMYPUuMBVTq0bEQIVldc2fJlLjp2TY3+5Yg1wE67/aNGXDO0e9reo/njQBQ
 6bdQrzJGdzLb/sU0Gas7gJkhHlrm/Dlvp5S8jktKb7Ze3DkHVutVR4Igqohb1RqHH2pNKBLfG6m
 z1wmJvhakNnmJ/fuYMQSjFBKiwTXN64ndFM8rlqbOYsOqyg5
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace uint8_t with u8 in the ad_sigma_delta driver.

Technically, uint8_t comes from the C standard library, while u8 is a
Linux kernel type. Since we don't use the C standard library in the
kernel, we should use the kernel types instead.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 15 ++++++++-------
 include/linux/iio/adc/ad_sigma_delta.h | 10 +++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 6cd3645eaaf38a23d5b6479ac598b6d276cfd81a..1657f64f1c0465b249adcc8a70dda8faf4a90565 100644
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
@@ -185,7 +186,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, "IIO_AD_SIGMA_DELTA");
 int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
 	unsigned int reset_length = sigma_delta->info->num_resetclks;
-	uint8_t *buf;
+	u8 *buf;
 	unsigned int size;
 	int ret;
 
@@ -454,7 +455,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int i, slot, samples_buf_size;
 	unsigned int channel;
-	uint8_t *samples_buf;
+	u8 *samples_buf;
 	int ret;
 
 	if (sigma_delta->num_slots == 1) {
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


