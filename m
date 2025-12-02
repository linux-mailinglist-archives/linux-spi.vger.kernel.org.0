Return-Path: <linux-spi+bounces-11699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F91C99D9D
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 03:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4117B346159
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0261A25BEE7;
	Tue,  2 Dec 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CErnu4MU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB42254B18
	for <linux-spi@vger.kernel.org>; Tue,  2 Dec 2025 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642105; cv=none; b=gRnMm7lRu3/2bVCtpnX4MwHXSF+OmxrwoFSvsAkNeIUqilP5BBydtbbmz/JZOcYXIXAnc9r0h6sTK0IAVHjBL3PfZ8vmuzA+Os8DE6BB/Ta4Ia4r8j/XFSAqWEi2qPFBvfMVInEOPLD4ZaXcOw73mZfOeLdbmGsv8VOubqrO+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642105; c=relaxed/simple;
	bh=SOLtPT6owwghcaZyK3hgcBY1YxMGX+Pp1GA+cecJhgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLHjLmtgxLKCa1NXbMjZQsvrPMhJOkJNeatI1N+zCbMWWnh8vLIuot60dk0/PctGpCnQvU2huhcstwCNABYRMosSIUq2QASXpE6UBUOS7DF0QoI766J7MHRyO9r/06uW3tgzVUHOnVnchPT530D1VW8YTgq6e9b6z+wKGjHy/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CErnu4MU; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c76f65feb5so3552368a34.0
        for <linux-spi@vger.kernel.org>; Mon, 01 Dec 2025 18:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764642101; x=1765246901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPdLzV9759rLu3YraDadPRqj18u/8wh/PsCbPPDkTWQ=;
        b=CErnu4MU+YapaJXiM59I0qDVIVcb0+Dm0p8MrqQzLVY13vIfN5bBVdYrWFV4+/IxlN
         HmicypVrcEQdQYKnj2dEcGj0Xw17TBghv9qDx8d0oIGLk35bBy/+jRzQBz+wflTOKYbm
         cSSA9L+qkMvB4XplShpQIbqKH/7hI3efsIjUZTvapw4BR1S6q63U/1IgupJzgdeRVS82
         b2Y9jPs+9n0IMdxZO21ANwOIoghykfJbtURmu3DZ3clMmhO9vZ0yB6kR1LKqUWA8E1r8
         2IuzqZzr2F0i7K5GMyIJY7ktRFUimZZV2YY+WqFg5E+w1crOD5siCJxYF38rjOuIsT7/
         ePwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642101; x=1765246901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HPdLzV9759rLu3YraDadPRqj18u/8wh/PsCbPPDkTWQ=;
        b=U9Fh0I4RCKdy5kFV7OPGaz8EJBar6jDW/F0t2v09CZ74toTIcv5mt8+gQHKvxo+DfR
         CEsp0/Ms6dxVrkiimEwheSO5l/DUEzidZX9dYsw11l2FJc8JWUEzXGZleEu4EOb9OSXb
         clVIRIznwWJ5tTER5omXD7q8ax0fyBa21f+8rOTDqSvvprEKQFcP1Dd1A8n4u9YaSsng
         3BkYwuvM74BaDpRk+au+cpvMKPlfA9qDRbB71Ne1q9Q5T183MbaogTymkHSy7OfGWG6B
         BE4ZmZs/qN3Cay5mby7beekwTJiitGHz0dmheeam+TfHfxmLHYG5ZOxj3JuXV1snNUQb
         4mNg==
X-Forwarded-Encrypted: i=1; AJvYcCXVhBHCGykOISfQ2kwT7ZQdHaVh7AyBbe3auUIidswImFurvM16x90m6J6SECcc9wefOPINJ6RoM0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2uPbaXvjpku1rdK7B6v7AkxnWn32BXa0ALCfyXse0NbV5kY+
	pRJpv5SN4FQBoVHEqCbNoWlWYRIaNnd2g2s5wT9r8PC+6tXov5YiA44SNqIqQZ0jGaQ=
X-Gm-Gg: ASbGncvdom7fgKW4siAFzpmkaUJyFiusBrHAtyPV/BHsXsZ5L6MGLZ6uae+JRAdFe1t
	94DAkOU5J1e1sN5avSas4iJDYLJ5ZBHm76+6c51SvbzJzHwEzIODluEIHXqi6XBHhXBfyIj1YYz
	yYFRYqzvR7JFa+izndMIml3VPDa8XHOQ9c856OgNsQnmI87Tel58CVG8IRCWGhnI0gQI6yuXosV
	OUOxU2pMZXIPkkqq9Ysu7JUrf7lHblxgIX8ylWGxrANS/DaNNFXOJQWi044M+HFQv8aa4jN9yIL
	OFg5BLwnEyTKTZDVvKoi6uQ7vR/DNBZCC14PcAR4ore0ymWcccm+h4zEV8FnAdubRVrW0IcmftE
	DcjLNdmaL5qdgyUnkGzDjrlb/jl58H2cmkRIE+eGWfScTFOPsHr9WN9+p5+G/48CTOpfnE3v3KM
	IFvxIGcikOZHZuLA==
X-Google-Smtp-Source: AGHT+IGr+eBFnlP4kwuK4x0vUmgIf8E/yZkWXnYDJkbVi4e40IJYit9GKy8xgz4FMlcYzfcdgxlfBQ==
X-Received: by 2002:a05:6830:4107:b0:7c7:6558:277a with SMTP id 46e09a7af769-7c798bff0d0mr19572559a34.15.1764642101497;
        Mon, 01 Dec 2025 18:21:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca0475esm6651747fac.1.2025.12.01.18.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:21:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 01 Dec 2025 20:20:40 -0600
Subject: [PATCH v3 2/7] spi: Support controllers with multiple data lanes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-spi-add-multi-bus-support-v3-2-34e05791de83@baylibre.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5834; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SOLtPT6owwghcaZyK3hgcBY1YxMGX+Pp1GA+cecJhgE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpLk0K7SeSEzsAvi3/ksvzqCAOBju2aRlYBWzMD
 AFTRNaCrLeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaS5NCgAKCRDCzCAB/wGP
 wHdnCACNzRw4+s1mT/i0sKQH6IJm/x705D4bHbUAsrRvZX83ZykQRM5AWbEyc5njqcAE6HeqtNZ
 jIZ27lqT6EdiMtM54dPFC1GCJAPEN1MU9eCUBmLY/QuxT9Gk33usJIpP2Yx1BGheOHjXmStXQCR
 MuJa+us643qgj2hp2b+fj+HRefB6ajEWa+ynFid8IqRDin3qVbuJ1+EScu08hoXRpvNkg6Ofkmu
 WrrB8IeZlxmR560r1vCgYt4Bye/W+nIZkAyCiWudBCHv1XM5OeAVMu5MOv5ZlWwuiZPHIDp+p5O
 SRvUlQRQOdYgPygRbgnJuFCyr7tWKZSmSkRr6T31H5b4ahgg
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

Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

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
 drivers/spi/spi.c       | 28 +++++++++++++++++++++++++++-
 include/linux/spi/spi.h | 17 +++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e25df9990f82de37c5ee20b703abcefc6f80c082..6b0fcbb26f424fe9972276b183117bdac2ee8ad4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2354,7 +2354,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
+	u32 value, lanes[SPI_DEVICE_DATA_LANE_CNT_MAX], cs[SPI_DEVICE_CS_CNT_MAX];
 	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2446,6 +2446,31 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	for (idx = 0; idx < rc; idx++)
 		spi_set_chipselect(spi, idx, cs[idx]);
 
+	rc = of_property_read_variable_u32_array(nc, "data-lanes", lanes, 1,
+						 ARRAY_SIZE(lanes));
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev, "%pOF has invalid 'data-lanes' property (%d)\n",
+			nc, rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is omitted. */
+		spi->num_data_lanes = 1;
+	} else {
+		for (idx = 0; idx < rc; idx++) {
+			if (lanes[idx] >= ctlr->num_data_lanes) {
+				dev_err(&ctlr->dev,
+					"%pOF has out of range 'data-lanes' property (%d/%d)\n",
+					nc, lanes[idx], ctlr->num_data_lanes);
+				return -EINVAL;
+			}
+			spi->data_lanes[idx] = lanes[idx];
+		}
+
+		spi->num_data_lanes = rc;
+	}
+
 	/*
 	 * By default spi->chip_select[0] will hold the physical CS number,
 	 * so set bit 0 in spi->cs_index_mask.
@@ -3066,6 +3091,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_data_lanes = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df3108999a73b67ef4a7b0d2cb07adfc669..607f1eac96364a73f95876ec27a9f86f14fa6112 100644
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
@@ -171,6 +174,9 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
  *	the corresponding physical CS for logical CS i.
  * @num_chipselect: Number of physical chipselects used.
+ * @data_lanes: Array of physical data lanes. This is only used with specialized
+ * controllers that support multiple data lanes.
+ * @num_data_lanes: Number of physical data lanes used.
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
@@ -231,6 +237,8 @@ struct spi_device {
 
 	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;
+	u8			data_lanes[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u8			num_data_lanes;
 
 	/*
 	 * Bit mask of the chipselect(s) that the driver need to use from
@@ -401,6 +409,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI targets, and are numbered from zero to num_chipselects.
  *	each target has a chipselect signal, but it's common that not
  *	every chipselect is connected to a target.
+ * @num_data_lanes: Number of data lanes supported by this controller. Default is 1.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -576,6 +585,14 @@ struct spi_controller {
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


