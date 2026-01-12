Return-Path: <linux-spi+bounces-12306-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7BD14926
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 18:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DFD2302FBA5
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B837F10E;
	Mon, 12 Jan 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dB95nqva"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF337F0E9
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240001; cv=none; b=MTw92ugyLGwBq6P0pqxKuSApiSQWRJlvPCu78hxusn2dUq51uG/J2icPGFut7QQiPQwFv/GRGx6Oj8tQdhvdI2sl+lCU/UtEDu58VIkaCTpjqodSxeEnzgyZKBMKOKPCI92trsZLHL3ICqbpCM0pM9o/ATX/rzxp59KzjFmObSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240001; c=relaxed/simple;
	bh=LUltyTseSHIB0eWsvKd5k7CM1sj/ygbKdi0CfX8XI5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jarg10FcenUj6r/XsevwZuI/te+YP9jLVW38mnOfPfzZJQKm8gAC0ry1Zs83oIsyzFlopSLvl5IQ2aRTUnSGKyHWlSCjXcsJ2ngsqbbg0hxmFAe5wre5+hh2Gw4DNWVZwsGYr7xOWyHKlB3He7iH2Kq61/m0EHLgl/4MzdBxCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dB95nqva; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c76f65feb5so5424794a34.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239991; x=1768844791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xTAHRixVuqxs0O57y6EbN2F3QQoOxp90CtlWkeqDbM=;
        b=dB95nqvaCjTGoI0BsKN9h2DbqkvQ/5BNbnTrT1cMj4+ydCAfcl/Gu525iG7ZIMKKsU
         bkEsLEnt4UxCGjBYQEbBv/w6HBc/gaiGt3mWTQnsztvBkuFPf0fNfntQyJJP+jsBXeV6
         5KkfrACbTIVT6TnaZlt3tLcQHfAMyPXQPF1AdSKSyDnLiiBKTfJZsEiWSY8zcN/MUV3L
         432JWtTg5/24jHqdIx/OmtwgzNTHziYyrRsfcU9eAtA3DaxDp3ISW91QzdW2ibM0c5IY
         8h+pml1Gy9kbEWmClcsNcssHwu6/Kph13bKP1b4fEiBHlIJofBKQ9kmYNEoeKZhCnJMP
         xGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239991; x=1768844791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/xTAHRixVuqxs0O57y6EbN2F3QQoOxp90CtlWkeqDbM=;
        b=PU3NakSrJb7QJzCqup+o3yJ3rzBJWKbx1BYh7uXk/GBpAXL8YBGla+BX2qFxOEaf+s
         rwJNN0sKlODv7+H3K306RWad+d2wYLEotmpQzjSyRKWqwNbtYDClnLmFq84Ta2P9mIn4
         OwGSUPrOgO2KSJl52MTX+/kXkITK1QaxFw37KKP4vgH0qSK12vFllN045LGvEjnhevAi
         X6gNYCQqMcByUpQdB7vdUjP9zsBupgvOENbIrXhdda7h9OqyU5SdL7350HUyOAF8JeRN
         1l8+cC2S4cRqAlbt8U9JG7DfpUGoJWnnnzN3BKn7HZe5Vi/0ZnVitqN1ylrukjJ0cx1n
         58sg==
X-Forwarded-Encrypted: i=1; AJvYcCWg7zaYqxZNSc264pIQ7btbik76WWGKGQKHFZnxmByfcM395RiLEzBXAsR8Gc3JfEYKZ6jB1ivxxxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxygy/7n4XCCI5D5/7AQ99hpSNP9hCSOvi0/yDTc9L6+LrNUob8
	dY/ODGJz2WHnIdH4xBBGJmEW8oaU8V1iLW0zVNj9PlIItQ4Kicz16i5JPnAwLt+Z4hA=
X-Gm-Gg: AY/fxX4CtvwPYshjH2KNU1iiaI6AWYADgrvAfSJAh8ENLfHmhpqD24DX0ukfsOByDNd
	z8qM3i/XRJAIcgvrt7oNKoPSDMecguG5u9dbnyqXcQGLIQj6Rtp833uSXi3VEoNZwMxIiZkY82X
	wX64Sq/7cQYbOYL/juNauycgYUXpdIED+8XRp6JORldq5syxc0miJ87kKQ0u3VvyT4eE6I20fuc
	C5g8INMB543wpJYu1HJitTKsmaeOHPOPW4ythrdb2IZtM1OkHnOFpF51ZnEUW1tLDeQ4DS/w0Cp
	wdoHJdznL7DwZ3XViE/U/ylZ49CM+K5w7wzT9tAfdMLgvWYDEf8xYZnKbKx09pxzvRC1bUT9w8Q
	1D0bwLElrf2sBssZSqU82ajqKfJQIt7Xqrv0013XvxuwE8sn/ee/Ctgr47GgXd1utPNnSwj/dQE
	sgyPG503z0GhcBURc=
X-Google-Smtp-Source: AGHT+IFwJxkYkRXklamjZLQ5Ezsu/RpFPePYADM5gAAE1rZrarULL0rlM1Pu+WCRABkUpZh6ZNR5fg==
X-Received: by 2002:a4a:d597:0:b0:659:9a49:8f57 with SMTP id 006d021491bc7-65f54ef65b6mr6677190eaf.28.1768239991602;
        Mon, 12 Jan 2026 09:46:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:21 -0600
Subject: [PATCH v5 3/9] spi: support controllers with multiple data lanes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9082; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=LUltyTseSHIB0eWsvKd5k7CM1sj/ygbKdi0CfX8XI5Y=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDJTjV1l9JhLK/eGrRFbFJJjvYZ7393Cos2swRerzq5Ud
 lg4SeN4J6MxCwMjF4OsmCLLG4mb85L4mq/NuZExA2YQKxPIFAYuTgGYSMYc9v8hk+fnVa55YD99
 L++pnXFRncrNmWt2LNZNv8/FHvarY1vJ0SbFv1ODxfYrSNkF6LPPe+bNH+7hEips1Cm8KFXBata
 s88y/nrza2TtdUOM408E904I5pz84G3v18MYzoWsyXof1qhrkhDBp5oXu1y0N22GxyH6Nik6Gl8
 93h6vZhZxM6yIeHcwujBW84dV0S7jn1BWrcx++HbyXwc8ctLB3cYZ03JZHCaEe/D4vYyU9ee/dz
 hO+ct3vVPU1v01HGv82M0aGhoWFthvzyjr0ms3e/6NuZaO/Ru+dv4FznJgczjnsufuopKnBRnaH
 cbqJvEN2W+e5le6iTWxTvgpZrm6evCPxqK4de8pJ+R2fAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI controllers with multiple physical SPI data lanes.
(A data lane in this context means lines connected to a serializer, so a
controller with two data lanes would have two serializers in a single
controller).

This is common in the type of controller that can be used with parallel
flash memories, but can be used for general purpose SPI as well.

To indicate support, a controller just needs to set ctlr->num_data_lanes
to something greater than 1. Peripherals indicate which lane they are
connected to via device tree (ACPI support can be added if needed).

The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
the array indicates the number of data lanes, and each element indicates
the bus width of that lane. For now, we restrict all lanes to have the
same bus width to keep things simple. Support for an optional controller
lane mapping property is also implemented.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
- Use of_property_read_variable_u32_array() for lane maps.

v4 changes:
- Update for changes in devicetree bindings.
- Don't put new fields in the middle of CS fields.
- Dropped acks since this was a significant rework.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

This patch has been seen in a different series [1] by Sean before:

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@linux.dev/

Changes:
* Use u8 array instead of bitfield so that the order of the mapping is
  preserved. (Now looks very much like chip select mapping.)
* Added doc strings for added fields.
* Tweaked the comments.
---
 drivers/spi/spi.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  22 +++++++++
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e25df9990f82..5c3f9ba3f606 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2370,7 +2370,53 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_CS_HIGH;
 
 	/* Device DUAL/QUAD mode */
-	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
+
+	rc = of_property_read_variable_u32_array(nc, "spi-tx-lane-map",
+						 spi->tx_lane_map, 1,
+						 ARRAY_SIZE(spi->tx_lane_map));
+	if (rc == -EINVAL) {
+		/* Default lane map */
+		for (idx = 0; idx < ARRAY_SIZE(spi->tx_lane_map); idx++)
+			spi->tx_lane_map[idx] = idx;
+	} else if (rc < 0) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-tx-lane-map property: %d\n", rc);
+		return rc;
+	}
+
+	rc = of_property_count_u32_elems(nc, "spi-tx-bus-width");
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-tx-bus-width property: %d\n", rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is not present. */
+		spi->num_tx_lanes = 1;
+	} else {
+		u32 first_value;
+
+		spi->num_tx_lanes = rc;
+
+		for (idx = 0; idx < spi->num_tx_lanes; idx++) {
+			of_property_read_u32_index(nc, "spi-tx-bus-width", idx,
+						   &value);
+
+			/*
+			 * For now, we only support all lanes having the same
+			 * width so we can keep using the existing mode flags.
+			 */
+			if (!idx)
+				first_value = value;
+			else if (first_value != value) {
+				dev_err(&ctlr->dev,
+					"spi-tx-bus-width has inconsistent values: first %d vs later %d\n",
+					first_value, value);
+				return -EINVAL;
+			}
+		}
+
 		switch (value) {
 		case 0:
 			spi->mode |= SPI_NO_TX;
@@ -2394,7 +2440,62 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
-	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
+	for (idx = 0; idx < spi->num_tx_lanes; idx++) {
+		if (spi->tx_lane_map[idx] >= spi->controller->num_data_lanes) {
+			dev_err(&ctlr->dev,
+				"spi-tx-lane-map has invalid value %d (num_data_lanes=%d)\n",
+				spi->tx_lane_map[idx],
+				spi->controller->num_data_lanes);
+			return -EINVAL;
+		}
+	}
+
+	rc = of_property_read_variable_u32_array(nc, "spi-rx-lane-map",
+						 spi->rx_lane_map, 1,
+						 ARRAY_SIZE(spi->rx_lane_map));
+	if (rc == -EINVAL) {
+		/* Default lane map */
+		for (idx = 0; idx < ARRAY_SIZE(spi->rx_lane_map); idx++)
+			spi->rx_lane_map[idx] = idx;
+	} else if (rc < 0) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-rx-lane-map property: %d\n", rc);
+		return rc;
+	}
+
+	rc = of_property_count_u32_elems(nc, "spi-rx-bus-width");
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-rx-bus-width property: %d\n", rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is not present. */
+		spi->num_rx_lanes = 1;
+	} else {
+		u32 first_value;
+
+		spi->num_rx_lanes = rc;
+
+		for (idx = 0; idx < spi->num_rx_lanes; idx++) {
+			of_property_read_u32_index(nc, "spi-rx-bus-width", idx,
+						   &value);
+
+			/*
+			 * For now, we only support all lanes having the same
+			 * width so we can keep using the existing mode flags.
+			 */
+			if (!idx)
+				first_value = value;
+			else if (first_value != value) {
+				dev_err(&ctlr->dev,
+					"spi-rx-bus-width has inconsistent values: first %d vs later %d\n",
+					first_value, value);
+				return -EINVAL;
+			}
+		}
+
 		switch (value) {
 		case 0:
 			spi->mode |= SPI_NO_RX;
@@ -2418,6 +2519,16 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
+	for (idx = 0; idx < spi->num_rx_lanes; idx++) {
+		if (spi->rx_lane_map[idx] >= spi->controller->num_data_lanes) {
+			dev_err(&ctlr->dev,
+				"spi-rx-lane-map has invalid value %d (num_data_lanes=%d)\n",
+				spi->rx_lane_map[idx],
+				spi->controller->num_data_lanes);
+			return -EINVAL;
+		}
+	}
+
 	if (spi_controller_is_target(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
@@ -3066,6 +3177,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_data_lanes = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df31089..7aff60ab257e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,9 @@
 /* Max no. of CS supported per spi device */
 #define SPI_DEVICE_CS_CNT_MAX 4
 
+/* Max no. of data lanes supported per spi device */
+#define SPI_DEVICE_DATA_LANE_CNT_MAX 8
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -174,6 +177,10 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
+ * @tx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
+ * @num_tx_lanes: Number of transmit lanes wired up.
+ * @rx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
+ * @num_rx_lanes: Number of receive lanes wired up.
  *
  * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
@@ -242,6 +249,12 @@ struct spi_device {
 
 	struct gpio_desc	*cs_gpiod[SPI_DEVICE_CS_CNT_MAX];	/* Chip select gpio desc */
 
+	/* Multi-lane SPI controller support. */
+	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u32			num_tx_lanes;
+	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u32			num_rx_lanes;
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -401,6 +414,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI targets, and are numbered from zero to num_chipselects.
  *	each target has a chipselect signal, but it's common that not
  *	every chipselect is connected to a target.
+ * @num_data_lanes: Number of data lanes supported by this controller. Default is 1.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -576,6 +590,14 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
+	/*
+	 * Some specialized SPI controllers can have more than one physical
+	 * data lane interface per controller (each having it's own serializer).
+	 * This specifies the number of data lanes in that case. Other
+	 * controllers do not need to set this (defaults to 1).
+	 */
+	u16			num_data_lanes;
+
 	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */

-- 
2.43.0


