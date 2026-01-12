Return-Path: <linux-spi+bounces-12310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8ED148BA
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F62311A438
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7D37F8C4;
	Mon, 12 Jan 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlMmHHRo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42D302CAB
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240004; cv=none; b=TtwwjZobLOuvDsb6/pln/cRyf4Pgz7GD1TbDbZX0ZpvfjCpx7tkg2NGpQBrtod/7BGJ68HXmpJXa3LY/AUhHDoHQ+oB0Qq7a8LZOcO8jzkcnoyGPDBpwldoFd1TDEopCnHhkeoS6lOaKZ9XP2c13nDjZcKUM7Vt94m2Q+QM0jzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240004; c=relaxed/simple;
	bh=5fXIrwABFbPXXYTw+nAf2EIqr+PtOXYDToVreVLaI64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJR3RQkR9vB+/CvnWvAR7rWoqtm5Wb07ewPqQ05SQzfNc0WbxM6mOPX5BsRV9JJfTl78ZkJFwbceaRX9OgKQ3u1TwvRoV8F9d2lRVlSj2s7DzoafTe8BdWOyrVoGqZj7sualQIRW2h3ckFwPZBJuVzOUAys4wqOqmUb8LbaWDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mlMmHHRo; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3ff4acb6eebso4187083fac.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768240001; x=1768844801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZo/CUT8jYhOYXP0ze3MUTwMeTqZZQuf98ZaLPyjBl8=;
        b=mlMmHHRozGZgdamCx1yS2Ka2o6mv7UHjcZ5IjlqYW3dQW2sCgYKsG/1SJLXY9oqAt8
         8hOU6T5ONsScJI9X6NGQCGhRiCk/WwAZaGU37eoqQpiAgQ+o11lGlQfinFiNFGb+fkzj
         92F/vOJDTQ9DI5Ti8j0jXV0YlhHmi884/1SOjKMw6Z+Qcsgxn5MeiCRDajBQKWOfeyk9
         bAByU7mvH3H3JnEYat/qwEtUyYc27H2LrN+28wABMB2pR+yMXFpBAeWKDHmlL0wQkx82
         3qIw21tLc68CazMafGrdYZi4ahlTIoc8ii560wCnrBdr8aMOMiIg/STL1NzrSJrRsjo3
         bYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240001; x=1768844801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZo/CUT8jYhOYXP0ze3MUTwMeTqZZQuf98ZaLPyjBl8=;
        b=d+1VPVU/cvCk4BcvR02Q4cZsklldE/iw1EQ/w4BuaU1VKU73G5ZVL/Ysg8Hz/2xNUY
         xfXBhh9rOy2Qw4TBDv8D8bkj/FzgHMRela1uDDmP3cTPaw92j496Ky2R+OJ/Ky3LQIsB
         BXZgKyt8qr0HPBTgfDFNOcOdxZNHEUXqvwGiNnxgM52RvNzp54WOQU0pOvgiexQLG0Vo
         UOf1cyLRq0uz3DhUvNfw6V/wqd/2wcVBrVHjci3CUC2M+vv71ughxIo2p3tNxK6RTamW
         DLVgDwdgn6WEcbECVPnw9NW8TlwToF7dIp9eQiITfIcwfuSxd1Q6HIypwceqCTxcIOC/
         TW4A==
X-Forwarded-Encrypted: i=1; AJvYcCXteWzMYL3FK2FZ4M41Vp1tDWl0sa6kQooOCh984dIDVXj3+QFSh3jyiZSc4kBaucvdo40qVl4cqww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGgvSnnnyY/g8gFalUJ3yFeCXkVgzNcR1a3wPev5q+Lc5QPcK
	txmGx6wdE6xIX21711jK8JQcJbrd2nV4NWdfbjkYaAYTjaoQT8TK1Nq/NXB23dXBzZ8=
X-Gm-Gg: AY/fxX5TsOye6nCar2J7QDStNt/xwxRAcm21iklHhrz/Jil6DQnhrdDnEn+l4ph9cws
	HWDyFQ8gkokPUtrdlBtwIfVStNehZLzuzhMba/66peOeohMELs3FRgnnfYwwlaylis2Co9UhxVD
	INYOAyaC25SyvnXL3zmyQzmY4/ilopHaSTGsDmyHfcB5iPZFAkH77ZYBkhf7YX5aaY26Mku8qjm
	P170wtBGaBd7yDHL7UDE63J/mku68/U1TlB0wSs+eC1Fl4UYyVvJVY37lTGVzmrSJxH0ngA6Rf0
	ZDPPodx9LH4JvPS+SkYXGfXHmfEMbhghsV6Tx/rDfsj7RooKYIVr6KhAc2vKmPP1rRpDJjWoOsY
	Gsj5YVImVzRZCvznytGxT/JeNLN268uPMCwE5z954TiyIHA8nyd6GPoBAHusYP8x17speE6Cgio
	x7Zo+WApyZmnxb8NU=
X-Google-Smtp-Source: AGHT+IHkwkQwWo5YKuZ4K4G1LWdtF+xNJT1UXteHMvzbW4fw/KEo7wfDHBZ4/5kbyMXxjyLESkIA2Q==
X-Received: by 2002:a05:6870:f21a:b0:3ec:48ba:8f3e with SMTP id 586e51a60fabf-3ffc0b73185mr8244317fac.49.1768240001279;
        Mon, 12 Jan 2026 09:46:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:27 -0600
Subject: [PATCH v5 9/9] iio: adc: ad7380: add support for multiple SPI
 lanes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-9-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6242; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=5fXIrwABFbPXXYTw+nAf2EIqr+PtOXYDToVreVLaI64=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNsfVgEagY6+eDtq4388ESB62NiNTp2+uvVc
 BFczfUcwIqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzbAAKCRDCzCAB/wGP
 wO4sCACDr2t8kSUqYKA2dSU2LAGdEhzIr0n6aXw89n+ck3qhECW2NliAxHPxaldEJSOLC09KsXT
 HLu/Kfc6hY0WvQttNCerAAxrGhHZ2b92jqPL7pYIfoWQtcbQKgm/7fHBxnSRkEdJ+wTJSgJnqPS
 QahaCBgnJ+2PPkVUGr4XGwyohaQmP3PysQfqTWeqym4At9wbhTyuvUBxM6hSO1sFCWKlObcURMA
 j0nvqgK3Geam9GNMASe8LEJwXsj17z6Q2vjAf+LFl/C7jYJvDdho874R5XRtMpj8UvS/qjukyuG
 CeFKLktCYOYgscUIBtjgoDgirnKgMqE0SWFT/29UMIjZ0uz4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for multiple SPI lanes to increase throughput. The AD7380
family of ADCs have multiple SDO lines on the chip that can be used to
read each channel on a separate SPI lane. If wired up to a SPI
controller that supports it, the driver will now take advantage of this
feature. This allows reaching the maximum sample rate advertised in the
datasheet when combined with SPI offloading.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Include the number of SDO lines in the error message.

v4 changes:
* Update for core SPI API changes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Move st->seq_xfer[3].multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE;
  to probe().
---
 drivers/iio/adc/ad7380.c | 51 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0..ca411371816f 100644
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
@@ -1887,6 +1899,13 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(dev, -EINVAL, "missing match data\n");
 
+	st->num_sdo_lines = spi->num_rx_lanes;
+
+	if (st->num_sdo_lines < 1 || st->num_sdo_lines > st->chip_info->num_simult_channels)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid number of SDO lines (%d)\n",
+				     st->num_sdo_lines);
+
 	ret = devm_regulator_bulk_get_enable(dev, st->chip_info->num_supplies,
 					     st->chip_info->supplies);
 
@@ -2010,6 +2029,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->normal_xfer[1].rx_buf = st->scan_data;
+	if (st->num_sdo_lines > 1)
+		st->normal_xfer[1].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
 					ARRAY_SIZE(st->normal_xfer));
@@ -2031,6 +2052,10 @@ static int ad7380_probe(struct spi_device *spi)
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


