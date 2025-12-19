Return-Path: <linux-spi+bounces-12054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5ACD2004
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 22:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D37E30530A9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C534A767;
	Fri, 19 Dec 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kJSpsl9u"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7F337BB2
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180022; cv=none; b=l2+voJBJPYzjUnS4Utggc3TslrYrhTvVXy+iiE0tjAOWCAtg6Er+1zU+o5g5PSyB3XiEVO9ntHN33tCuK7jTs2zEHWZwHf2Ya7Tm78MK9EqaTk4EgVQDaqCEC1m+AnlGO5eiqoK5mYS60rqqBXYTDPyMQp+hD6SVZY91UP5THGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180022; c=relaxed/simple;
	bh=LH6Vyxalmz1bUck/pw36flu8Rm/aY8DBxOEtRceLBNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTkh3MW8yKb03V0DiTkfVh8412WRfJDnPHuvDF8J0tKuTGN9ITNbDz4UDqzRk15nvqhJLrVZifISdy6YqaW4QV+qVLfRTRP5xjuIQynf1u+JgRaj0KOlCAzaE6MBmsbnmgRNqFHXdffLCUEMxDol+zeaLCtn8jQFJ7QxXfz8AiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kJSpsl9u; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so1854780a34.0
        for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180017; x=1766784817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52JuNH3Z2gevqmnqd29jbAXefa/G2nNvDA29ajR6gPU=;
        b=kJSpsl9usa+RjG8Ev/lR5x2VG/TtK+U3Rr1aiCfE28QMpla1oGn8JG5aVVND5OAwYH
         IKmLnr7hdebCupBNBOJGeQ8LTvAqdgFazUq0TdUd4t0xSZey95wWoSXekFkUZ7NeaRi2
         s4pjAMBfb4xYVx7k5GnJrr57GDh02v0jyBXQ7y5wQYzvGzFzvKUJGJDK0iAMKApnWu12
         wLEhogoUu2kglIXck9h+Ve2k79Lrkv8mpI4w2kUWg4Gaxpd0zAcJ3Z4SDpb/pppdr/kd
         y+zg9cyseW4Jdx+L6ngV7zGv+q0xa/J29g0fRdvdFV2kUy3ev7sgOcsuNIcOLv5HOB34
         X8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180017; x=1766784817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=52JuNH3Z2gevqmnqd29jbAXefa/G2nNvDA29ajR6gPU=;
        b=EvQBWunEJBPG+3UdVT5pEBBxsk05a1FahaYHHfh/5zwn4OUaevLBgo/IPdJLiG3qVd
         eTHqY/bUZ3iYeKL545yDyC0j+BEJZXogQX8g8XOD0t7CxSaGZyCweHxwe4fgPOpeNGfW
         n4t0fjfgwX4G0iQG2uCpjYIkS//VxH3MoM+XWA6NJnL3s+GZfNBb1r8xlcCLDa39Ftm7
         SGtQ1K2XaOnS87w0O7lA8WtS8fxo6qVYB0oJ9VE75Yhbvt9yfp2+Us54IX64L6D9CuzF
         ix5rKsun5nT7dyJdFOlI9TZFvqj8msVmjyj/2e2qgV/su/52gVs2kMzsXpH6LTvFJDz6
         Gt7A==
X-Forwarded-Encrypted: i=1; AJvYcCWnJD+a5CNfQ4phT2NCiDeDiLhKcWNEjwj3IY3xcox/hs65Y0AHcpXNHJqN/gdGceHdXQX/gI1K4s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCDHjycWXPnFcTuI3qxeSUlRPV+6XlRPgF4D0EuGxDLs1fr6W
	FzOcETm9T/NqTY/ydm2TisaJKrWO38/6T1AvriGDuOgvT9IcPr1WDnAUPjMrmSbIBzk=
X-Gm-Gg: AY/fxX77eo1q/H5NHo4rqqN2oqV22tjIpi5AIxSuegiupdX7CSmOMGVNy4HackfWpYO
	7zAh3xxDiOKd5WKaSQOyfIQf2FqbZ3GmqNrvwBvOBl14HVMHITEnT4rXsPf0olrssyhRTcSqiH9
	YAm1QsDZ/CVnz1wUJevu2OcLES5Yp0SonOEBnKAu3WKTszfVWGoxfoNdxpeTwuvxAI1U6NFf+1L
	2GiE37bqZL/kJRXyg+sqJ/KMKfXdJ95vophyOlA18S2TlUZ4RUc7hsi/4C8xqqr7yEgfmWY/oJr
	enppRAHkpoETqT/Ml5qBf8pTQE/uF8TJbTpN6/8IISk1Bm881ycGvh553RPElIfJBe93dBTczs+
	mxxYZqlx6lvnAFHC5IDibUjsuUFhZyGi2QZk9pfwIosXUhTYX4F4PEtU5Mzx6hgct/E3OTxRcUt
	Tb1nD0jwzM4Mg4fw==
X-Google-Smtp-Source: AGHT+IHmMw3pWZZJVDqUr745Dbk0HYxeUkbZl92MLOTQ4m+qaXZzYjtt4smJbqsMgIkjg0Pk0sdgvA==
X-Received: by 2002:a05:6830:448b:b0:7c7:4bb:dc06 with SMTP id 46e09a7af769-7cc6681931emr2154994a34.0.1766180016976;
        Fri, 19 Dec 2025 13:33:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:17 -0600
Subject: [PATCH v4 9/9] iio: adc: ad7380: add support for multiple SPI
 lanes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-9-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6063; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=LH6Vyxalmz1bUck/pw36flu8Rm/aY8DBxOEtRceLBNY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpRcSfLJx0CYwXi+3uIOIko0pPqOOcsOg6PiCxZ
 0u08pcxhUWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUXEnwAKCRDCzCAB/wGP
 wNA6B/0VO4IDqFUdeHvEoKkOAZ/oM///2K1qeYPoAIWcCcr0cMVnOYjphT8TQK6cOWMmFNCGv4p
 pu+LrQaelIjhREHhgQRe6PMkXc88qb2/ucOO0+A0xk4j4wyfG8Ow3nLYXPiRN3GcWRQip9y3/Kc
 qvXTrsoh+jtmpxwMJqOrnBv0/72H50Uwpp7TX5mwuBoUSaMC4iCIBInxP2+39Ne/uqccqVEAzEF
 /ZU7FOOOBmPHDjkdZqtfSUgDCxtAniQjg9xDyOShilCZgKso7vj4SX5Kg4BMeb9QJMKV/AZFdgC
 w/szwCWzrS5JE7cIMxKZXOJ5aUu3kvhhtSuNuLkWwIL81taP
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for multiple SPI lanes to increase throughput. The AD7380
family of ADCs have multiple SDO lines on the chip that can be used to
read each channel on a separate SPI lane. If wired up to a SPI
controller that supports it, the driver will now take advantage of this
feature. This allows reaching the maximum sample rate advertised in the
datasheet when combined with SPI offloading.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v4 changes:
* Update for core SPI API changes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Move st->seq_xfer[3].multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE;
  to probe().
---
 drivers/iio/adc/ad7380.c | 49 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0..00982b70b316 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -77,8 +77,7 @@
 #define AD7380_CONFIG1_REFSEL		BIT(1)
 #define AD7380_CONFIG1_PMODE		BIT(0)
 
-#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
-#define AD7380_CONFIG2_SDO		BIT(8)
+#define AD7380_CONFIG2_SDO		GENMASK(9, 8)
 #define AD7380_CONFIG2_RESET		GENMASK(7, 0)
 
 #define AD7380_CONFIG2_RESET_SOFT	0x3C
@@ -92,11 +91,6 @@
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
 #define T_POWERUP_US 5000		/* Power up */
 
-/*
- * AD738x support several SDO lines to increase throughput, but driver currently
- * supports only 1 SDO line (standard SPI transaction)
- */
-#define AD7380_NUM_SDO_LINES		1
 #define AD7380_DEFAULT_GAIN_MILLI	1000
 
 /*
@@ -888,6 +882,8 @@ struct ad7380_state {
 	bool resolution_boost_enabled;
 	unsigned int ch;
 	bool seq;
+	/* How many SDO lines are wired up. */
+	u8 num_sdo_lines;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	unsigned int gain_milli[MAX_NUM_CHANNELS];
@@ -1084,7 +1080,7 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 	if (oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
 			T_CONVERT_X_NS * (oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->num_sdo_lines;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -1113,7 +1109,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
 			(oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->num_sdo_lines;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1198,6 +1194,8 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 	xfer->bits_per_word = scan_type->realbits;
 	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
 	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;
+	if (st->num_sdo_lines > 1)
+		xfer->multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1793,6 +1791,7 @@ static const struct iio_info ad7380_info = {
 
 static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
+	u32 sdo;
 	int ret;
 
 	/* perform hard reset */
@@ -1815,11 +1814,24 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	st->ch = 0;
 	st->seq = false;
 
-	/* SPI 1-wire mode */
+	/* SDO field has an irregular mapping. */
+	switch (st->num_sdo_lines) {
+	case 1:
+		sdo = 1;
+		break;
+	case 2:
+		sdo = 0;
+		break;
+	case 4:
+		sdo = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
 				  AD7380_CONFIG2_SDO,
-				  FIELD_PREP(AD7380_CONFIG2_SDO,
-					     AD7380_NUM_SDO_LINES));
+				  FIELD_PREP(AD7380_CONFIG2_SDO, sdo));
 }
 
 static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
@@ -1842,7 +1854,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 				     "failed to get offload trigger\n");
 
 	sample_rate = st->chip_info->max_conversion_rate_hz *
-		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
+		      st->num_sdo_lines / st->chip_info->num_simult_channels;
 
 	st->sample_freq_range[0] = 1; /* min */
 	st->sample_freq_range[1] = 1; /* step */
@@ -1887,6 +1899,11 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(dev, -EINVAL, "missing match data\n");
 
+	st->num_sdo_lines = spi->num_rx_lanes;
+
+	if (st->num_sdo_lines < 1 || st->num_sdo_lines > st->chip_info->num_simult_channels)
+		return dev_err_probe(dev, -EINVAL, "invalid number of SDO lines\n");
+
 	ret = devm_regulator_bulk_get_enable(dev, st->chip_info->num_supplies,
 					     st->chip_info->supplies);
 
@@ -2010,6 +2027,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->normal_xfer[1].rx_buf = st->scan_data;
+	if (st->num_sdo_lines > 1)
+		st->normal_xfer[1].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
 					ARRAY_SIZE(st->normal_xfer));
@@ -2031,6 +2050,10 @@ static int ad7380_probe(struct spi_device *spi)
 	st->seq_xfer[2].cs_change = 1;
 	st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	if (st->num_sdo_lines > 1) {
+		st->seq_xfer[2].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+		st->seq_xfer[3].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+	}
 
 	spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
 					ARRAY_SIZE(st->seq_xfer));

-- 
2.43.0


