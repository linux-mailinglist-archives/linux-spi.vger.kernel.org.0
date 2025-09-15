Return-Path: <linux-spi+bounces-10034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB6B584C2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F11A288B1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BCF337684;
	Mon, 15 Sep 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwAJZcDy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56525320A17
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961470; cv=none; b=u6rNQm9TsP5EitQcO+kiYxznW3tEOyoFFikv8cJAlWTdoqhv4+7d5+Y+Ls7gJsx78SCIlA74kknC937Fhg44owysVUJubfGjOttmC/AWNEH3A9E2Vt/DospHgA2dIa5kcXo2ZBL6RkrufIqSU8x7bz9puU3nFRzxI098NoRjJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961470; c=relaxed/simple;
	bh=jbnenaa4O6i14j4ZifdqFvInS3eJxZIQbMEEwSis0yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFl+FZU1AL3gZI61/yF3qCaA7fMM/vX1TnUyJUboBERETSaDiSB28iDgFL9QwRM5hE3/PiNK8c86YZasuylZ7s2uEBkv2hKE+vdBvapIZNo737kO3k48jVTu2zVHtTMkOu6Jw9N2L+Lftt1XU6EObajfefmbcouuZlBxW/nr1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwAJZcDy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0787fdb137so677851866b.0
        for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961466; x=1758566266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qjOlUlJq2SsNzQS1L4g2nZJSlF7eLB1a0byw2EKzH4=;
        b=CwAJZcDy83d14bePGKhFeirGFaVzBPdELC/8dwWdncFwmhv0Gy6AZixUgqwyGC4M4T
         npdZAMnqnaMjnUm+nb77+Sk8MLj+lUpYwtoYjBGgfSXDV91sc0nrrREFLJByEcZ8RgAr
         W88+t5JjxlCDVNja6fQDwflSfXKqTZ4jhGOv6UFhu9Sh93Vxm3/Qb89+XqskIq9Bcrz/
         3h2EDdcoBIK/YPlWwibFF+/mDS6sT3T192RRv1OxTgPSSzP54w2KrKkYX9yOpfTHFARn
         gJL1qvmOC5s/4b4+WC8BOsxIH5tlH1tdQm18P1jkReKLRZTZkJqaMfShvEPWcRQbcm2C
         Qcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961466; x=1758566266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qjOlUlJq2SsNzQS1L4g2nZJSlF7eLB1a0byw2EKzH4=;
        b=o4lKS0VoZYdb0IBzoibblic38RyDQU5n4KY3BOOkCuFA7J2qUKhrVzeH/+44cgEmKI
         QW0p1sykIMUMu5dXMQJaBdnebt423SJfPKR8bnykyWY530p3noWcNJww7xO+EumQo3bJ
         fT494gJ52EjD3BrTcA6GGBTyKeO9oS3mQGYWQ/2wFrknxMnshgYugNvBvZfNGH57jbRA
         KBWh2xZDCKG4W02wCrc+fLBDaPtCqtpK5sndnwFr0intwpjwM46N3oba8UShefZz391x
         7JPOthhqdBIQmyNkyRouxDxUPdtpxrGJMkp6VMCmheZRJq8HO7pwoCn1R3WYtw2u3FFA
         rjsg==
X-Gm-Message-State: AOJu0YzkahOEryFq9o+sw3v5YpGQJb1JUgXV8kFEpQ104U35qojC7wTk
	dbNWbuPjmx8fgYzeRBZrTLsR7+HJ0yk7N/iNHe9R5B7HOUhjW2tcOOmy
X-Gm-Gg: ASbGncuJlL16EuL5uZchyJ/4/z9DpbEsCUR1v54fR0KgTfMcDNNP+gUT1F+hoqKezoV
	vQVlenD/rxb01WpO6Zg/0O+n8n4ZAcAlM6QIDifd6Iegm8VBKpHLS4dT3Us4Tf6X4RQIaPs0E8a
	Z6qixr6saeryAPpDGLMJcjUYTd7Yd69D9HHJwrXrb2G0lKDuSOJGdrYH8HWsN1+e2KBru3W63oJ
	lro8pqmDImyPkH82U4QIgap2IpCB+N2UNJ0EBoN93P8e9nyTsXqKbLMnFKn27vw5YqEDFoyaDFo
	gjylBzy/T9TC1/Hte/P60eDCkPEaL8Rg6ZDsqnSN08rHp6J48dPFkFvYpa+yGtLkPu31bDVc5ik
	GvF45j1b8xjiAiofgxaFvUOjqg2Zj/01iugE4f5hNtEOm2sHCgYjgBeo9SMQ+YnLk3e10PJHD1O
	NUJC4ggfhK4gF9hA==
X-Google-Smtp-Source: AGHT+IGOgHgfT9pewzJMSeqVIebTPIEkxQX8DNga8jXtGvUMJHVHxmWcNBP2oUmlSXgcd2MHGYeYbw==
X-Received: by 2002:a17:907:1c93:b0:b04:590a:a5b5 with SMTP id a640c23a62f3a-b07c3579f62mr1299448766b.24.1757961465968;
        Mon, 15 Sep 2025 11:37:45 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f1cc4sm1016951266b.76.2025.09.15.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:45 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 7/7] spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX
Date: Mon, 15 Sep 2025 20:37:25 +0200
Message-ID: <20250915183725.219473-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename SPI_CS_CNT_MAX to SPI_DEVICE_CS_CNT_MAX to make it more obvious
that this is the max number of CS per device supported, not per
controller.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* no changes

 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi.c                 | 14 +++++++-------
 include/linux/spi/spi.h           | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9bf823348cd3..d6b2c1051328 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -33,7 +33,7 @@
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		4
 
-static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
+static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2eb361e9e44d..2e0647a06890 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -670,9 +670,9 @@ static int __spi_add_device(struct spi_device *spi)
 	int status, idx;
 	u8 cs;
 
-	if (spi->num_chipselect > SPI_CS_CNT_MAX) {
+	if (spi->num_chipselect > SPI_DEVICE_CS_CNT_MAX) {
 		dev_err(dev, "num_cs %d > max %d\n", spi->num_chipselect,
-			SPI_CS_CNT_MAX);
+			SPI_DEVICE_CS_CNT_MAX);
 		return -EOVERFLOW;
 	}
 
@@ -699,7 +699,7 @@ static int __spi_add_device(struct spi_device *spi)
 	}
 
 	/* Initialize unused logical CS as invalid */
-	for (idx = spi->num_chipselect; idx < SPI_CS_CNT_MAX; idx++)
+	for (idx = spi->num_chipselect; idx < SPI_DEVICE_CS_CNT_MAX; idx++)
 		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
 
 	/* Set the bus ID string */
@@ -1076,7 +1076,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	trace_spi_set_cs(spi, activate);
 
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
 		if (enable && idx < spi->num_chipselect)
 			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
 		else
@@ -2354,7 +2354,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_CS_CNT_MAX];
+	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
 	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2429,7 +2429,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
-						 SPI_CS_CNT_MAX);
+						 SPI_DEVICE_CS_CNT_MAX);
 	if (rc < 0) {
 		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, rc);
@@ -3313,7 +3313,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 
 	/* Setting last_cs to SPI_INVALID_CS means no chip selected */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++)
 		ctlr->last_cs[idx] = SPI_INVALID_CS;
 
 	status = device_add(&ctlr->dev);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index df4842abbc6f..cb2c2df31089 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 4
+#define SPI_DEVICE_CS_CNT_MAX 4
 
 struct dma_chan;
 struct software_node;
@@ -229,7 +229,7 @@ struct spi_device {
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
 
-	u8			chip_select[SPI_CS_CNT_MAX];
+	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;
 
 	/*
@@ -238,9 +238,9 @@ struct spi_device {
 	 * multiple chip selects & memories are connected in parallel
 	 * then more than one bit need to be set in cs_index_mask.
 	 */
-	u32			cs_index_mask : SPI_CS_CNT_MAX;
+	u32			cs_index_mask : SPI_DEVICE_CS_CNT_MAX;
 
-	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
+	struct gpio_desc	*cs_gpiod[SPI_DEVICE_CS_CNT_MAX];	/* Chip select gpio desc */
 
 	/*
 	 * Likely need more hooks for more protocol options affecting how
@@ -721,8 +721,8 @@ struct spi_controller {
 	bool				auto_runtime_pm;
 	bool                            fallback;
 	bool				last_cs_mode_high;
-	s8				last_cs[SPI_CS_CNT_MAX];
-	u32				last_cs_index_mask : SPI_CS_CNT_MAX;
+	s8				last_cs[SPI_DEVICE_CS_CNT_MAX];
+	u32				last_cs_index_mask : SPI_DEVICE_CS_CNT_MAX;
 	struct completion               xfer_completion;
 	size_t				max_dma_len;
 
-- 
2.43.0


