Return-Path: <linux-spi+bounces-2789-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE68C01AD
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61DF28ACAF
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76712881C;
	Wed,  8 May 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NjLvA0bp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADF1292E4
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184434; cv=none; b=FZ0WGY2TP+cNgGbHowHM0IXtBWVfGVzNWO32pIObFnunN2vhAGq5qb2kQmweCxDhyebs8vTfMmaDLEvH3ikZmxPdbHvFej2gRiemP9Bns4QsJ2Tit5J5w4TCcBGvxKb5RiJmaE8i6uskxpvXmsGzaCAn5uGR8JZgXnn4/tE5xds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184434; c=relaxed/simple;
	bh=q16+U8it1Rbj8kcS615V9+ovc13B45Zfiql3EJCzgCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OYw0QFaFzFFBMWAcrcKpDzWQe4OlaLFGpZry/9ftHZPhetIBICCCfSSH/mGuLmwkAJsDiKQHgvDPnjd0mOzRm1OVti3rRwx9nfW834zcqW1139Zkr7El422Cfjga6emeoAq3AsVZ3KlehvgpTjGdAuGqFNL4+VpyShN6xOnNKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NjLvA0bp; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f05c253669so1844229a34.2
        for <linux-spi@vger.kernel.org>; Wed, 08 May 2024 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715184430; x=1715789230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEsfCnEb9qWSI7b3tGrpLDUN799XBozcU4lpS4eg30Q=;
        b=NjLvA0bpjXbzkyGvkBoD/ZQ9SusT1yN5DdJKgXZYFvipkqwHUoz2hO3ylmcoa76xtg
         PJefoZVIFSVEINhFzn/ln8z1uNqqfEKatq+HlLwCmQOGuxLOOMdsUca+7xzBGmN1dNCz
         rsSnoADoCxwv7HYsm9KRzGp7JHJUrc3AH3DymooDBBSHL6MjqqPpY9mkciE4gQSVPKQh
         Kd0Eedga0bhKb2sg5MJ6mtQCExs+1rYBhPoNtcm7hl7pp/2K4dk+qYt0CcpNb+Qn6cZK
         aenW6CYs99I70V06Tu9PWdvp0hgJcAIFQycWbeJzRCUyH6uCVcoX7TuWWcFMzo5GvQmO
         uNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715184430; x=1715789230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEsfCnEb9qWSI7b3tGrpLDUN799XBozcU4lpS4eg30Q=;
        b=ClJ3aMi5IGM3MSP/Zd3XaDB8qPh8ldLhqRrc6gWuH5Qwj74+or2adqzWqPvuWP2QhK
         B3e3+H3FOPL12Ul65Y7dDp3ue4M/MevcdkjyXEUBa+BPFE0b0jEuMx+Y/HUR8JtbwtYK
         4HJJqU0/ut5WAu0JzlQ3tkfwaIJsuJKjrNAmYYYQmuUz6ONCAqQXtIvbF1BWB3IolAhF
         goMdCJsOGxfk7cYtbi2hli2NbYhYlh6h0ZzN8cuIZw+ZUil3yZ+Siy1nASuWsPkzwpt8
         y9M/MRVH/YpdN6yJwJGi5ANoR33gu0qWgug4dew+zjOLX59xl2jiUXe7cduOG0iO2F/d
         07tA==
X-Forwarded-Encrypted: i=1; AJvYcCUtp8xS5C34zQqas2aglQ0plBMhlDnj5sAts4PTtxqNMXxEubZK2Nq0Lsw1LO/dBBy7WEyXKZX6J49Khc4HXbol5tEEVnx36BFA
X-Gm-Message-State: AOJu0YzFU/EDL+ekfQ9oVOh4ETIyn330FzQ0eY20u5NTGu1psgMeR25U
	v0l3BrIwZMGV2v2gK6FC5c1EKGZt5Zs3eTIlbW20VoLF+wfZ+cgi0IvK8i3Go/8=
X-Google-Smtp-Source: AGHT+IEi2GLx1RbFg7gRutWj3V4JgU850hOVjemp9G7In5q+x1nGS2KGI6U+/GK3lVG2fDM6TgGhKg==
X-Received: by 2002:a05:6870:e998:b0:23e:b42a:499 with SMTP id 586e51a60fabf-24097bdf8camr3379296fac.2.1715184430241;
        Wed, 08 May 2024 09:07:10 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id iv6-20020a056870b9c600b0023a91e3e428sm2980500oab.18.2024.05.08.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:07:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: Add SPI_CS_HIGH support
Date: Wed,  8 May 2024 11:06:53 -0500
Message-ID: <20240508-spi-axi-spi-engine-add-spi_cs_high-support-v1-1-695dd8e45f00@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The AXI SPI Engine IP core v1.2 added support for SPI_CS_HIGH. This
provides the driver implementation to make use of this feature when
supported hardware is detected.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index e358ac5b4509..3231f67ae265 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -46,6 +46,7 @@
 #define SPI_ENGINE_INST_ASSERT			0x1
 #define SPI_ENGINE_INST_WRITE			0x2
 #define SPI_ENGINE_INST_MISC			0x3
+#define SPI_ENGINE_INST_CS_INV			0x4
 
 #define SPI_ENGINE_CMD_REG_CLK_DIV		0x0
 #define SPI_ENGINE_CMD_REG_CONFIG		0x1
@@ -73,6 +74,8 @@
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_MISC, SPI_ENGINE_MISC_SLEEP, (delay))
 #define SPI_ENGINE_CMD_SYNC(id) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_MISC, SPI_ENGINE_MISC_SYNC, (id))
+#define SPI_ENGINE_CMD_CS_INV(flags) \
+	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
 
 struct spi_engine_program {
 	unsigned int length;
@@ -111,6 +114,8 @@ struct spi_engine {
 	struct spi_engine_message_state msg_state;
 	struct completion msg_complete;
 	unsigned int int_enable;
+	/* shadows hardware CS inversion flag state */
+	u8 cs_inv;
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -530,6 +535,29 @@ static int spi_engine_unoptimize_message(struct spi_message *msg)
 	return 0;
 }
 
+static int spi_engine_setup(struct spi_device *device)
+{
+	struct spi_controller *host = device->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+
+	if (device->mode & SPI_CS_HIGH)
+		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
+	else
+		spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, 0));
+
+	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
+		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
+	/*
+	 * In addition to setting the flags, we have to do a CS assert command
+	 * to make the new setting actually take effect.
+	 */
+	writel_relaxed(SPI_ENGINE_CMD_ASSERT(0, 0xff),
+		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+
+	return 0;
+}
+
 static int spi_engine_transfer_one_message(struct spi_controller *host,
 	struct spi_message *msg)
 {
@@ -653,6 +681,12 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->num_chipselect = 8;
 
+	/* Some features depend of the IP core version. */
+	if (ADI_AXI_PCORE_VER_MINOR(version) >= 2) {
+		host->mode_bits |= SPI_CS_HIGH;
+		host->setup = spi_engine_setup;
+	}
+
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");
 

---
base-commit: a2890dc5d13c377f54c21010c040ed092fcf99c4
change-id: 20240508-spi-axi-spi-engine-add-spi_cs_high-support-d1aa542e9530

