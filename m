Return-Path: <linux-spi+bounces-11128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40128C41A7C
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 21:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5789A4F263A
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5B33F367;
	Fri,  7 Nov 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m/ZEZFLu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132D33B6CE
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548835; cv=none; b=fAYNU0t68/IVEFgg2VATHl3ceOOUt7JOn5ZPZSLFJMhWM0SwTbWYtCFCIZobDP3NDzj3l4hjcbapdfeYpsaID1F62MEnCkkc5VpXXPGj6jGsWX2j6CPn3DZh66bobpkWw3SkiEl7NtEIHOijwvajc+8CcZr9BortS4d2seWR+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548835; c=relaxed/simple;
	bh=tbssLJr+Ebxfwwi08ix3szhLr7wbXMJxmt+laOwzgsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lO+/S7QCgdQL0JTv8hZXdWx4adMo2RbvnmjAmvGb9m/gn5nJb+B1pe5wh3WwCCHkAdliF3vEhY5F3vN+g48BiI0mjZEdULtpsLBZOjbF8jLfd9x7iVa/Cp/Y6OUlwRL2licgVjPD4jZiX0tTN/BjcuWVj7v3WDQ7GxAdBfNb6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m/ZEZFLu; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3c9a42d6349so1506694fac.1
        for <linux-spi@vger.kernel.org>; Fri, 07 Nov 2025 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548830; x=1763153630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PW7GxJfbU3SnzaKjdr7NgLPqXqKnkon2xa5rgjdBpQw=;
        b=m/ZEZFLuJK7mu6vlgEgVASnTwXvD05R73oYsAiOn/ZfRxGPuGeSqPedSOpgDwHhaOE
         qaj6Lv9irlZ17VyUOPVKjJvislkSmcESeC4/WTU7qzuDbA/dWYHd8e61KE8uk0R42CEa
         torLdq6nA3Vv0UxdqcyYmMbLeczCxgvxlI7EsoMAP20/F1BtlCuKYCEXV6YFaHRfNIr8
         foGw5hNsHTmzlpPPO2n6pXHr9Q3scSrPj4OrlNdaiGqbqVdmut23hwETxvCTeEYbosQM
         dccnqWA3cEGwg1s+sXAvrhWaa8gzaCthU9GX+hcWADWTm+J8KQ9dhbI0Of90A3LRjPZY
         nbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548830; x=1763153630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PW7GxJfbU3SnzaKjdr7NgLPqXqKnkon2xa5rgjdBpQw=;
        b=DTQhwvGcymU3CnlGDhcXs7NuKAxg9KXAj99OZifn13rHgkf1etf+OV6QDHRCShUxQP
         3kF3HVZ0aAEjConSCh4cfaWuoKtVDXVgxJbj5rETImpAaa7NYOaZUIxuwA+Ztk4/NfE6
         xjL5VAFfqdEcjabitjexaN/X5zjDKNg49l2JQFIugBipsztPaBacbeszdgJQ6FfAydXX
         kYKmOqnZ7SxoqeH5rnS5yOGlOdH+BQB+b9l8zFLSJGl+K2cpQHhnFXhXIzdiFPp0Mr/5
         gJ9yAfi2IkQ3GPem27KcwS0kzm52Q+WiI4vnDKI+agYqf9mPG1rmVrpgCpFcOw11UGpI
         souA==
X-Forwarded-Encrypted: i=1; AJvYcCWcORVGnNimjim5eCfcOorm7c4PTStK0EoipU+3K+hD/AS2G9q7mY2Ga8kAv7MldafHMlZVW/o/GVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA08nCc0W7Tr9MTnKQzuTSXdo9baQW3CUg1Y1fhnoxlqK43ATL
	6V44FTxcX6C98NkyJvUQI2BZOHinYLGCKt7rOywGV+QfnDtAZpugpsWtkCyUJw7LZc0=
X-Gm-Gg: ASbGncutmnx3PzrswXIeEoa9xD9k3viVqntHc2AvyDztD4WaqOCaJsA3tMIELE0db+3
	e311S4c4yn6Ui+r99UoE+fb70dLwfEyWeCm/JFlS261HHYSCPHQKMVzEqKmP8EeOJ9OKD8Nyr2V
	WICod0KKaOXUGgeek+sJw8jrep/qhi6+alHysloea53UZAj5x+mr/X62DuPhCX8rQKiwbIyUQNU
	wgjLvAcus3HOoapvbOIhy5t8u8C9XAx2WjBJBy+Kq9ILLPZRV+qvHj9KrpsYAmqDXcueQ28WOpd
	det+Rm928ahlfy/0OAYBu2i8XN4GS2oLXB7Z6X6Wd8KdjV72IpwV4Rxd7PqfKeeUkEvWfuRCTNV
	3CGE6zHfv7bin8c+dOqddO7QyYZU0m7MHuTlX6zWcYP5GwV8ygcCD4K2RWgwvdxJK++vqm4EOL6
	CKc7nu
X-Google-Smtp-Source: AGHT+IHqXPyYE1OWCnyptMBezfaHueHqgQabK6yk9FpgjMA2kDvrJ83FzGcWTZhwJdKMwCk9S14+FA==
X-Received: by 2002:a05:6808:1485:b0:44d:a570:bc24 with SMTP id 5614622812f47-4502a25ab41mr379261b6e.9.1762548829651;
        Fri, 07 Nov 2025 12:53:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:52 -0600
Subject: [PATCH v2 6/6] iio: adc: ad7380: Add support for multiple SPI
 buses
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-6-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5209; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=tbssLJr+Ebxfwwi08ix3szhLr7wbXMJxmt+laOwzgsw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpDlxNUG6ZdnRGt/VRUhRiwYC+i1lfjDKmO7HT0
 GnDj1HiKlaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cTQAKCRDCzCAB/wGP
 wHQxCACIkbrlHe6saPRxgNXQbum/Ih+itFqFHRPMLhQgMVl9pAC5uXJhIXAbYmveNmeS9yK5kY+
 yRdVuw6mAY9snTgtpLbqj7ETS6BOQ0nYcXSDhItKkixtYAySAvWwyn0ZDrVagq/efasgJgOuKTH
 A1yD9SzrrxTIDTlXff325cmw7r6m9LmxyipPSmmzoZaN6cBAWE/MLwwZTGdZ53P5hDPQbxqK8AG
 9ypZFRAPSJqNi21COG/+eNV6/GqGLXMRugTRV8nne9kRaT9FG7W9IKUjusJyk4CB5gMfpaneQWj
 RUt4y5uXbockTDUfU9yUBHa9bFAngBKyojCP0n3TojfC4Qrv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for multiple SPI buses to increase throughput. The AD7380
family of ADCs have multiple SDO lines on the chip that can be used to
read each channel on a separate SPI bus. If wired up to a SPI controller
that supports it, the driver will now take advantage of this feature.
This allows reaching the maximum sample rate advertised in the datasheet
when combined with SPI offloading.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Move st->seq_xfer[3].multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
  to probe().
---
 drivers/iio/adc/ad7380.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1..8891c31e61714b00fb01571f7ddd163cc948a8fb 100644
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
@@ -1084,7 +1078,7 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 	if (oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
 			T_CONVERT_X_NS * (oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->spi->num_data_bus;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -1113,7 +1107,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
 			(oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->spi->num_data_bus;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1198,6 +1192,8 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 	xfer->bits_per_word = scan_type->realbits;
 	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
 	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;
+	if (st->spi->num_data_bus > 1)
+		xfer->multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1793,6 +1789,7 @@ static const struct iio_info ad7380_info = {
 
 static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
+	u32 sdo;
 	int ret;
 
 	/* perform hard reset */
@@ -1815,11 +1812,24 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	st->ch = 0;
 	st->seq = false;
 
-	/* SPI 1-wire mode */
+	/* SDO field has an irregular mapping. */
+	switch (st->spi->num_data_bus) {
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
@@ -1842,7 +1852,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 				     "failed to get offload trigger\n");
 
 	sample_rate = st->chip_info->max_conversion_rate_hz *
-		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
+		      spi->num_data_bus / st->chip_info->num_simult_channels;
 
 	st->sample_freq_range[0] = 1; /* min */
 	st->sample_freq_range[1] = 1; /* step */
@@ -2010,6 +2020,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->normal_xfer[1].rx_buf = st->scan_data;
+	if (spi->num_data_bus > 1)
+		st->normal_xfer[1].multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
 					ARRAY_SIZE(st->normal_xfer));
@@ -2031,6 +2043,10 @@ static int ad7380_probe(struct spi_device *spi)
 	st->seq_xfer[2].cs_change = 1;
 	st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	if (spi->num_data_bus > 1) {
+		st->seq_xfer[2].multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
+		st->seq_xfer[3].multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
+	}
 
 	spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
 					ARRAY_SIZE(st->seq_xfer));

-- 
2.43.0


