Return-Path: <linux-spi+bounces-7789-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9AA9FB83
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5E61A87485
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2D2135C5;
	Mon, 28 Apr 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CmQRre3V"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A621F4C8E
	for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873988; cv=none; b=Q7yL75D/s39G4HYddpNz+PyzbONUfNqwyQxZyvr/biGZlFCrhm6KBZAzrSUjSdJkEtpnQ3QwpLoO0x6rapQgLm84BUy4NUa/GAOSiVcVEvJ2M+j75hZTtB6aj6YfB0+0Hh1xlxLwfON/x+bNAKTjXIcWvTqnKvxzjIMrngkagD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873988; c=relaxed/simple;
	bh=DelXqB0kZspoqygncW6vUyeVFO+EIcLtNSWKTaOCkQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5sG0PjQlTnzNc3YCptvQejCmajeBeFTBHxm70Yoj6WC2a8NJZVweAdaoR6EVEED6S5Q/uSODOuvGkNvMc+iE+gCSrZeZjGxCPV+/1XggDJmW0flHrL6kKgp/scng5Uaxxd/cEtJ1LRP5fh9dRd33wHkAXbIB5R3deyruUDua2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CmQRre3V; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72ec58e45baso3267320a34.2
        for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745873985; x=1746478785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Hj8neZG0BLKL1cfy93HnA9rg0nDsQm55TmsJP7Yas0=;
        b=CmQRre3V/ea0D/AAgOcH7h0mgTIZiG3cmLubqSTy9i203rmvkLVNk4j/T3R0zj+nqb
         0wRp5LOp9LBm07DoEsDRx12HISi0whGN1lvfRLHLjIYh6WukpoACclZm1M9WPvcOkWXw
         hV8zId/virL63ZeS3diQY3oJ2PnmRL73zvT+y6ZW5yjg0i5r3a0z2wAa+Ak8ybdkeZkx
         IlK3Drx4uxN4yaMesPDqPy47tbiwwBok1Xle8N11db++4i1AmbvuXOPUhL4TThm4VZha
         iC6Zj+KQN2TUVy1HdQyQi7eh6hpiRM3tvRxyUtuF4vY10i82IqrblzRMZW5289IVapeR
         OQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873985; x=1746478785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Hj8neZG0BLKL1cfy93HnA9rg0nDsQm55TmsJP7Yas0=;
        b=pvXwKaU9pFnzyx4SkKQrPSOpAXJMTIV3Jl2cPlpaXmc8pUVpeB4g8zJm2tCMgMvFsE
         J3fhkIX2+IUgQsk9ZAeL8WUZ/3OA7IMCwI/0MrhFCnEtl/Rjnmr8oxgdZhk8D01pgFr4
         5iH5n9Je7LD7USZw59gZ5HRAsRSNtsv3yOQVFWuuoXdxJ/ezmyHg9n3UY7M/gfVMOvIQ
         kRtXGPBLPVkMzGH2wGb2tta1qoId0MuUJee0py0dY9ulNREM82xSk55J11os2wpAEHWG
         1kdKkNdaTiS++ghQirUBdCeOwwbtC4LTD8OVaP9pj67h2edVfEdaXjf0X84oBp6BQMTK
         0IFA==
X-Gm-Message-State: AOJu0YyH7GHBV0s4onhaKDFZwWc9dhituvgM7rSGteeZxG2kW+h1TxJW
	U+jkzwIQ6OB0of/4nwLZMKBK2NGAGubPws707qbUsrrEFbviKKRiOxBicxeF/9s=
X-Gm-Gg: ASbGncvPkICdFeCgCEca99ulwusBNoW9w2fAo81gJOH5c/rwbv9V8Dp7Lf+qXFG4D48
	JJVE9DPV1moDSLH8weYd5P6tJS70tA/9zFVqHhSohM3uVJchNHzJlvCv406IVJFU7mEPDtUTApb
	YfEO3JxRs4N7be4Wug414UZEgVtiJDgkCKrwT8xCshva3OY4DuCxSU0NLxeIv7ek+basxIbXyLl
	EkYn/dMb0+wZkr216Lw0slk1mHbgdGMLu+/tkOs+wVJ0ymtQVbyrF+l9GGR071UYNCrjbNLk/mV
	l7LlD5UGTQoJHKPRMLkto3DEP9fHwEW9ih1440jJeKpcP7uPadzbLJMYHQ==
X-Google-Smtp-Source: AGHT+IHPXzFGESNGtWPXMMYFKuEbAcfuFQSq+tY06p70W8UYIb1ZbppxXWy49aCkKdbqNVV2dVqjGQ==
X-Received: by 2002:a05:6830:7008:b0:727:3f3e:53bb with SMTP id 46e09a7af769-730652484d4mr7554910a34.24.1745873984945;
        Mon, 28 Apr 2025 13:59:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f056ed8sm1907614a34.0.2025.04.28.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:59:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:58:57 -0500
Subject: [PATCH 2/4] spi: axi-spi-engine: don't repeat mode config for
 offload
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-adi-main-v1-2-4b8a1b88a212@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
In-Reply-To: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2855; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=DelXqB0kZspoqygncW6vUyeVFO+EIcLtNSWKTaOCkQo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+wnk1x4zDUziAXMKBJGxbZJ++ALElXgHtjSE
 EWSxK4NEQyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/sJwAKCRDCzCAB/wGP
 wBdMB/9J7r9hguCa0J/Bnaby+br8PqrHL4r6wyA7ZkJb4nG+Wce9yqgNTEnn1ZEA2FlE1M99LTZ
 A61+R2SvcrT18kSR1rVEBwMK/lUmPm7MtGT+FAS2qj00sr5V1moXmV3RFoww0qVzfgnk2Yuq9kr
 hk/XcMTzJ1fSeGb9BIfLH+zaCEYlr0gVi7d8UsLW/DurZ3mNUfmiNLv841UAAL+0QLr8GKFclf0
 YIIvH4DSBzKZ9YGBdVDVKXBEcJIoSr/iZQxbzITG7OFA1Pb6Udld2SW6V343Fz6o2tk3QiHrbPd
 LESpyRfD69A0U7dcz9F0T6h5bjwYagnoD34YgvhcA7kLjbVq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add an optimization to avoid repeating the config instruction in each
SPI message when using SPI offloading. Instead, the instruction is
run once when the SPI offload trigger is enabled.

This is done to allow higher sample rates for ADCs using this SPI
controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index d040deffa9bb9bdcb67bcc8af0a1cfad2e4f6041..05ef2589f8dc0bdaa1b3bb3a459670d174f821a2 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -141,6 +141,7 @@ struct spi_engine_offload {
 	struct spi_engine *spi_engine;
 	unsigned long flags;
 	unsigned int offload_num;
+	unsigned int spi_mode_config;
 };
 
 struct spi_engine {
@@ -284,6 +285,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 {
 	struct spi_device *spi = msg->spi;
 	struct spi_controller *host = spi->controller;
+	struct spi_engine_offload *priv;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div, inst_ns;
 	bool keep_cs = false;
@@ -297,9 +299,18 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 
 	clk_div = 1;
 
-	spi_engine_program_add_cmd(p, dry,
-		SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
-			spi_engine_get_config(spi)));
+	/*
+	 * As an optimization, SPI offload sets once this when the offload is
+	 * enabled instead of repeating the instruction in each message.
+	 */
+	if (msg->offload) {
+		priv = msg->offload->priv;
+		priv->spi_mode_config = spi_engine_get_config(spi);
+	} else {
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
+				spi_engine_get_config(spi)));
+	}
 
 	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
 	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
@@ -842,6 +853,22 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 	struct spi_engine_offload *priv = offload->priv;
 	struct spi_engine *spi_engine = priv->spi_engine;
 	unsigned int reg;
+	int ret;
+
+	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
+		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
+	writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
+					    priv->spi_mode_config),
+		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
+	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
+		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
+	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
+					 reg, reg == 1, 1, 1000);
+	if (ret)
+		return ret;
 
 	reg = readl_relaxed(spi_engine->base +
 			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));

-- 
2.43.0


