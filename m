Return-Path: <linux-spi+bounces-5210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B399B2B8
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BB3B231BE
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB9170A03;
	Sat, 12 Oct 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAXPbN+R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7215624C;
	Sat, 12 Oct 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726873; cv=none; b=kaFPB3D5eBobgUAcYomE3ZO153UQUvd/CxH6fLPaxfP+m+dy4wbHkB1Bz1X6NLEeaj37qU7pFua948fXptSCWydOg+1Uemq/ZZzhyQpCGI5rpx6Y26lmrgtjMyXgpsAcI6+t+4m85VVfqfndxBYKQtmBqe3eCBj1yUES9RVUtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726873; c=relaxed/simple;
	bh=ys5JI1ngpU3G1uGclEajO7jpE8cm1XVyWQVve05jHZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1dgUHgS4LQvokH3CFM8OZaf9eVbujAh2mpsiJa4dAsvujMJ7P3sRt31/p9DE+5b6Abt5sCbwiwzRy6ZalZxEDMEAx7p1WxTo7yKx28o/a30cYmMGLIinhjvim853gQT4KCj/nhGptfyAeANioff8F1D175HRm5qL1wR4/cGBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAXPbN+R; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99f646ff1bso12125066b.2;
        Sat, 12 Oct 2024 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726870; x=1729331670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1Thee1kAUeC9PampdCJ2+s3t8t439kgGHTpMFquxb8=;
        b=CAXPbN+RE92zD4V2Nf+PKTPIBR5C3OTx6gNAMSXaSwuVnJoakX9fnzPdXajhRbApDu
         KEXZytBkwhGB1MWhKmoA2Xb+6Wur3HZQ2Uwly9AA4sckcVTmVDVQjJoJJyUJAYwq9oey
         QdvqvLNIHPvDvM53ukO/+GqOELS0nXpxoCOgKbsXwIf6pZ/FUIj1ydqUmeguHfuDU9qM
         a7PVpRFAVUwPVMhkgFtDlEu8qGdojra0LZvrsLwOfh0+V9JUtA/BPfOyuE4nA+UPUDY+
         fMSJH/sxzPJxmsAlRg5GQkO6c3gY9c+6UXJZLbQ0/+gSw78CdVzKteFjvfJOA1O6ARBh
         UPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726870; x=1729331670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1Thee1kAUeC9PampdCJ2+s3t8t439kgGHTpMFquxb8=;
        b=mU+ae8jc6pUtzX/pyTgRPW/5rIpbln3nF54IMv8vS84zWZDiz05TRZee+2guIpGpQa
         MyIF9OWBp1FKjezhC5loScpNYBdqld6xzUzt8up03aIZryeHwuaOpJpjhiT0+2Py2ZoG
         2RUtXY/iGwTcmSxHpvMhfYwOgdpnRxTwOlwzokyRjI7WlZsSsImBx+CqThvBmE/misrc
         NYQk02WyB2f/rR/A95diW3/SeJN17fIXeAaIbX8JnVpRmh7UG2RcidSJ2Z4W1yAB3LoP
         dxah51ssLEPjzNc3hBO1ozuXTGa5uymMmaXrZfmks+hqSYWfPHI5YhPk1Ps47lG0mP7s
         TVlA==
X-Forwarded-Encrypted: i=1; AJvYcCWrwoSmHBDcBTB/dDjQiw3lGht62UF3HWEhTR2860ilwnmIijfNDe7G3+Uo0ctb6OCA0Cuitvc8vLhFv5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0iV/fg1OCy6YO21eCgAbmKVQI+OUJq7aeUJrmPOB7I9mc2IuJ
	UkMe63CsoE3Sr1EXddVO4Wwo1ssx8ZomsGI9g5j9ZnbzTnM4SwovqMhDltdXviM=
X-Google-Smtp-Source: AGHT+IF23x4Q8xt+C2xkJXHCIx5ufh0hlAp9EyjODTlu5mgcNg9wjq0+L2LUiez9T+63Op9Z/58wXw==
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a99b930e9d1mr438259866b.13.1728726869491;
        Sat, 12 Oct 2024 02:54:29 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c0217sm304936466b.110.2024.10.12.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:29 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Oct 2024 11:53:40 +0200
Subject: [PATCH 6/6] spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-spi_multi_cs_cleanup-v1-6-dc491113880d@gmail.com>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Rename SPI_CS_CNT_MAX to SPI_DEVICE_CS_CNT_MAX to make it more obvious
that this is the max number of CS per device supported, not per
controller.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi.c                 | 12 ++++++------
 include/linux/spi/spi.h           | 13 +++++++------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 0b45b7b2b3ab30951d94ea2ce57dcba3a2600847..3b5776c80c6adfdb4ff67f03b065f0bb81fb735b 100644
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
index ebf8bc9c2276a6f50ba6e9fded48c870c4bd5ff0..a147975cec452bc857f836ce9742da0b6ddfcff2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -671,9 +671,9 @@ static int __spi_add_device(struct spi_device *spi)
 	int status, idx;
 	u8 cs;
 
-	if (spi->num_chipselect > SPI_CS_CNT_MAX) {
+	if (spi->num_chipselect > SPI_DEVICE_CS_CNT_MAX) {
 		dev_err(dev, "num_cs %d > max %d\n", spi->num_chipselect,
-			SPI_CS_CNT_MAX);
+			SPI_DEVICE_CS_CNT_MAX);
 		return -EOVERFLOW;
 	}
 
@@ -1075,7 +1075,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	trace_spi_set_cs(spi, activate);
 
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
 		if (enable && idx < spi->num_chipselect)
 			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
 		else
@@ -2357,7 +2357,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_CS_CNT_MAX];
+	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
 	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2432,7 +2432,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
-						 SPI_CS_CNT_MAX);
+						 SPI_DEVICE_CS_CNT_MAX);
 	if (rc < 0) {
 		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, rc);
@@ -3316,7 +3316,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 
 	/* Setting last_cs to SPI_INVALID_CS means no chip selected */
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++)
 		ctlr->last_cs[idx] = SPI_INVALID_CS;
 
 	status = device_add(&ctlr->dev);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fe99f46c7d926eeb75398f4dddc5ef64d8f7736e..cdf8e4338f3850075123eec76db75a94033ccaaa 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 4
+#define SPI_DEVICE_CS_CNT_MAX 4
 
 struct dma_chan;
 struct software_node;
@@ -186,7 +186,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
-	u8			chip_select[SPI_CS_CNT_MAX];
+	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;
 	u8			bits_per_word;
 	bool			rt;
@@ -218,7 +218,8 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
+	/* Chip select gpio desc */
+	struct gpio_desc	*cs_gpiod[SPI_DEVICE_CS_CNT_MAX];
 	struct spi_delay	word_delay; /* Inter-word delay */
 	/* CS delays */
 	struct spi_delay	cs_setup;
@@ -233,7 +234,7 @@ struct spi_device {
 	 * multiple chip selects & memories are connected in parallel
 	 * then more than one bit need to be set in cs_index_mask.
 	 */
-	u32			cs_index_mask : SPI_CS_CNT_MAX;
+	u32			cs_index_mask : SPI_DEVICE_CS_CNT_MAX;
 
 	/*
 	 * Likely need more hooks for more protocol options affecting how
@@ -711,8 +712,8 @@ struct spi_controller {
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


