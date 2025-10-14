Return-Path: <linux-spi+bounces-10625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFBBDB8A1
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1AA421D92
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297C30DD11;
	Tue, 14 Oct 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1KAkKrxb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87F2EB879
	for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479389; cv=none; b=tkTXL43fyyj4DUTmffa6nkB69l+XW06KWLO0jqQN0efUzF/Pvxc13z8cv/Ef/vyFztUgrNGElA7TfF9woTc2KSn5kH/nLTEq3pImvFR1jgYTbY9qRUG1ikpSeLfS/AUX/S9YcI3dCOwWYQd3RMLNMeQkAJt9pXMvXo/3Fkp8mO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479389; c=relaxed/simple;
	bh=ROmAaNI50p2Vlga0mgNZad6drGv0Z8myGEBGCr9B+P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUrmGrcSJbrd8sfjV57q3lZx+NIl4dey6PrsmPCDAvTAooqOAXC5w28UAgmpnObkQu9WzKWxCUVK4Fqc3eNQfO74//uOgI4FPM/p4eiqx7EaQNUUaVHx+OJJxhyMje2EACVKoh7rBYH45hQS0hyfrshyQoZMD0jPaJkOslBysxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1KAkKrxb; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-43fac2df7d4so2524698b6e.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479386; x=1761084186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFQug0ax1ZQ/sivSam4f4n5K6MZzSBshOS8AKiRYp3Q=;
        b=1KAkKrxbjW1QuWQAtz25AyLhmDqzip8DbOgR+lHsQJY/5YRtZAGTxM2E5SI9HqnS8P
         xcoUoW1olueMDdklC67iFXTqe+tSSEwvo2wuahAJtY7a3hIAnu8KYCp384KniM7YuoEj
         FSFI5fLihMf8JMds4+dlGgpiaVFQh7cBdrsu3sBaSs82/huSZD/9JDHonOcueoYRxt/6
         zq0xx50nMvhP6h1zxzqs7BNpFcLiFJoJ7qxJyWHQBwyE3UoIiQp+Kf1J52mQpCkP2rYs
         d8CtNpbbJoGeV23EuhXJ/8Ec3tAoUHi+ksWYs71VebKrd6pfJwmBelDjtwigijszfIKC
         x4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479386; x=1761084186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFQug0ax1ZQ/sivSam4f4n5K6MZzSBshOS8AKiRYp3Q=;
        b=FJW4oM6ZiUxQzgVhRPJ/oglLn41OyrO/Jg/s1SMQLyTwsm9fMMbLz4gOAk7EMnTsj2
         nKnRBW0nLJWuY6+VmhW49qqD2hKCYco14efotj3o9an33hMO5lelTnD7pUWeOxO12KNk
         gO77mo1J5IM14HqNqK3IMrwCJbKEC7T6/VreByDI72TUlCmUWpij/x5YLb0KDcvcygDt
         owSK4P5Tt3TWbI+KCQKaxwkPdz4EKecg1VO6OkzL7aou7cFl6S3VoIPEuPkaDxWrLeZj
         3tSADEFsbL+k/jxmVUJ0remlLYZBSIsWmA2ipmihE9D5ycJWukw1ruZcK5K1tV/DFTrq
         u6eg==
X-Forwarded-Encrypted: i=1; AJvYcCWPd0PC2Mi+r6Q4BwI/6Vtbt2ljrDjGE/bQ1fptMhg0aznrQ4ymXvbl354MjwmqVcSc4g5SJg2REJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBut+dsP3vd/pbSNq0/HocWa1N/kYEtOjHY1uzMagtgpPhN3w
	KLEnd1af/7zmdWinqTRLF5ne3SqiGnHAswaBEYXAar9s0lUGmaCovOm9J23zZTgY6nE=
X-Gm-Gg: ASbGncunR+rTwXuPGZUb7ld4dq56bswguFJ8WdW8V8P2AC/FWv1HUpbLbtvZaHpN5UQ
	41qoYPqWXzdlRFP1s6oxw9ch9S6XQZkOB2JOAtGPSbTaPGuOXIA+eYVqVkLGYQmiZoewhSklUm+
	+XPUBeuFOpTSqC8d7DJ8U9vgOuSqsmJ6OrtYDZ4RCGFzdmzFOTwKLqVdmiNdIvkW6cK3OsOQSXT
	xrXZhWUeHP5Zq4+iZXeOsRje0VmKoLdwe0OgW8tb0R1ss7+1lt7KPXQR+BO2FPGEgdPMhXtCt8S
	9v7x1dDZWMyZzesFh+hssZ6tV/MXw97GtkUE12rzBW0AsAEnu7BijCJ0C517ge/f49b5ckbax4F
	d5YqGa7y1bOUhdwLHEpuC+A3w37AkN+zTRrxJur9R5ODs++HkjFdblhY+
X-Google-Smtp-Source: AGHT+IFKpbUmvAYk1WWWfGqzSu3maIj/Een/NO1GQ62oekNYLVVufQH/VxhIQnaVqdu6TDRkQrTKgw==
X-Received: by 2002:a05:6808:4f22:b0:441:8f74:f0f with SMTP id 5614622812f47-4418f741b7dmr9159704b6e.57.1760479385806;
        Tue, 14 Oct 2025 15:03:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Oct 2025 17:02:12 -0500
Subject: [PATCH 2/6] spi: Support multi-bus controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5603; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ROmAaNI50p2Vlga0mgNZad6drGv0Z8myGEBGCr9B+P8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7shzi9Uf4N+1XNb2ZUa5M82QlQFkTVhvPEMrb
 cY/dyg0qdOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IcwAKCRDCzCAB/wGP
 wGdCB/9E7K1kOdFl5BbOuAs9+Zf/LvUnSOqk6vPCmhJsX/LCTjR6y1AqOJFElfRGDc+ba4yG95f
 V7iec6o0VG90htEsBYR1q/YBtfKG8uWyj747t+A5iPm/rVm5alz1O8qTNWCsR05lc9L1w85WahT
 CTj2kbMTP88weQZF55Ym1kr9CoVEq8SV1TIg+kSE1Efodc8ku291AyeaXprbsyMJX8jQ7hAKtCa
 q4htmUh8eiq3WF3hnm8+EX+r88/BA5co57jBNAwQLSvx+D7NFD4ACmQ1zdSycJ6vrDvsipTBtO1
 twaEBFZGdeE43CIEdSLPEITb9mKgNwf5Yc/YjOjd8rKK4HDp
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI controllers with multiple physical SPI data buses.
(A data bus in this context means lines connected to a serializer, so a
controller with two data buses would have two serializers in a single
controller).

This is common in the type of controller that can be used with parallel
flash memories, but can be used for general purpose SPI as well.

To indicate support, a controller just needs to set ctlr->num_data_bus
to something greater than 1. Peripherals indicate which bus they are
connected to via device tree (ACPI support can be added if needed).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

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
index 2e0647a06890290e1c9dc4a347a0864329795b08..84e5d5057eb41f1a522c4870265d78feb41109c8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2354,7 +2354,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
+	u32 value, buses[SPI_DEVICE_DATA_BUS_CNT_MAX], cs[SPI_DEVICE_CS_CNT_MAX];
 	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2446,6 +2446,31 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	for (idx = 0; idx < rc; idx++)
 		spi_set_chipselect(spi, idx, cs[idx]);
 
+	rc = of_property_read_variable_u32_array(nc, "spi-buses", buses, 1,
+						 ARRAY_SIZE(buses));
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev, "%pOF has invalid 'spi-buses' property (%d)\n",
+			nc, rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is omitted. */
+		spi->num_data_bus = 1;
+	} else {
+		for (idx = 0; idx < rc; idx++) {
+			if (buses[idx] >= ctlr->num_data_bus) {
+				dev_err(&ctlr->dev,
+					"%pOF has out of range 'spi-buses' property (%d/%d)\n",
+					nc, buses[idx], ctlr->num_data_bus);
+				return -EINVAL;
+			}
+			spi->data_bus[idx] = buses[idx];
+		}
+
+		spi->num_data_bus = rc;
+	}
+
 	/*
 	 * By default spi->chip_select[0] will hold the physical CS number,
 	 * so set bit 0 in spi->cs_index_mask.
@@ -3054,6 +3079,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_data_bus = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df3108999a73b67ef4a7b0d2cb07adfc669..c314194d4e7e2b396795ece10e142118ca05f4eb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,9 @@
 /* Max no. of CS supported per spi device */
 #define SPI_DEVICE_CS_CNT_MAX 4
 
+/* Max no. of data buses supported per spi device */
+#define SPI_DEVICE_DATA_BUS_CNT_MAX 8
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -171,6 +174,9 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
  *	the corresponding physical CS for logical CS i.
  * @num_chipselect: Number of physical chipselects used.
+ * @data_bus: Array of physical data buses. This is only used with specialized
+ * controllers that support multiple data buses.
+ * @num_data_bus: Number of physical data buses used.
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
@@ -231,6 +237,8 @@ struct spi_device {
 
 	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;
+	u8			data_bus[SPI_DEVICE_DATA_BUS_CNT_MAX];
+	u8			num_data_bus;
 
 	/*
 	 * Bit mask of the chipselect(s) that the driver need to use from
@@ -401,6 +409,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI targets, and are numbered from zero to num_chipselects.
  *	each target has a chipselect signal, but it's common that not
  *	every chipselect is connected to a target.
+ * @num_data_bus: Number of data buses supported by this controller. Default is 1.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -576,6 +585,14 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
+	/*
+	 * Some specialized SPI controllers can have more than one physical
+	 * bus interface per controller (each having it's own serializer). This
+	 * specifies the number of buses in that case. Other controllers do not
+	 * need to set this (defaults to 1).
+	 */
+	u16			num_data_bus;
+
 	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */

-- 
2.43.0


