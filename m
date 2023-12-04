Return-Path: <linux-spi+bounces-135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C3803BB4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B62810C7
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BED2E84E;
	Mon,  4 Dec 2023 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AUr+6Gr7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4D101
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:13 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58e238b654fso501798eaf.2
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711312; x=1702316112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kupm0qr6Q3RnoGuZ1Z7nDXeRsP45pYQV7G5LGdS88ts=;
        b=AUr+6Gr7b5rgwTUziaNJyXuBJ5EdLiWL8AURdHFIv0z7wJfZW8l2HXkvUfohY1Ukjn
         wiQO2cQwEtk37GIXazHMawZsHVlVq3gEv1RzzQH7PzPsylco1o58QmjKRUQzHes3A4er
         /6A1w9l5v3wzznMUXVvmwXE4posmak1f3MDfVCKDqJlYMcGXt/qjClBaHMdCO6coA5RA
         pO+QlgIdNkUERrqqQ9OsTjVIvIhT3nDl1KtZrlOcxSG+HOULyTGSj+u8Dxh4bXDISTRU
         SAv5qGJUHhvT4lgAVTzl8pgSRcbI5VxllLEqmazRF9TFEfIc70QTheWyDsI2qB4RMqt0
         sJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711312; x=1702316112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kupm0qr6Q3RnoGuZ1Z7nDXeRsP45pYQV7G5LGdS88ts=;
        b=B1059OMvLw7LO1DuH5ev9RdgrObQrMSd7vBSC9/17WU6OVS02wC9mP0sbTd47nhQBz
         A8O6Bc6jpe5TZzSsNj7ONm9PcbGikATCkXW7fhQMHPBEuYUDxpGJIUv5VQvwttTs7tGd
         xxR6FhCt15neZDgtxOY3ct5/FS9O4SU3Pq25i/rJTgEL9S6Auxiq7YXmLpD5N14ByT6V
         NPBmFBCyCVey+eVGd7RYotPRDGI46YWw/wrnocndrh/rNIG4PScHI7NiXYchQOZpHV86
         HvdMEOS0/zVOMKbh/JK0NjXiMIiRD7pQVAqk5bkna0ZcEpyWI8yieJwOU7LJzrEK9vtr
         785Q==
X-Gm-Message-State: AOJu0YzkbCbz2AZ8G2VnH+Fh8qZ4+v+BPjUbtuEF5KFZcpjjYYnxv112
	7/UjsFyZarzmpKpNgvpad4HyFslvHl0iQGkm8go=
X-Google-Smtp-Source: AGHT+IFUKMvyDr3pCqBprdVy+wT0uIcEmQdfHX9XEOYbbBzlirNTiThCnIRkYtJ5czxdwXlpiSb1wQ==
X-Received: by 2002:a05:6820:2214:b0:58e:4c67:f35 with SMTP id cj20-20020a056820221400b0058e4c670f35mr2028968oob.0.1701711312694;
        Mon, 04 Dec 2023 09:35:12 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] spi: axi-spi-engine: remove spi_engine_get_clk_div()
Date: Mon,  4 Dec 2023 11:33:29 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-3-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Now that host->max_speed_hz and xfer->effective_speed_hz are properly
set, we can use them instead of having to do more complex calculations
to get the clock divider for each transfer.

This removes the spi_engine_get_clk_div() function and replaces it with
just dividing the two clock rates. Since the hardware register value is
the divider minus one, we need to subtract one. Subtracting one was
previously done in the spi_engine_get_clk_div() function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index ee7b904ae5cf..fa2264d630c3 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -140,21 +140,6 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 	return config;
 }
 
-static unsigned int spi_engine_get_clk_div(struct spi_engine *spi_engine,
-	struct spi_device *spi, struct spi_transfer *xfer)
-{
-	unsigned int clk_div;
-
-	clk_div = DIV_ROUND_UP(clk_get_rate(spi_engine->ref_clk),
-		xfer->speed_hz * 2);
-	if (clk_div > 255)
-		clk_div = 255;
-	else if (clk_div > 0)
-		clk_div -= 1;
-
-	return clk_div;
-}
-
 static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 	struct spi_transfer *xfer)
 {
@@ -243,6 +228,7 @@ static void spi_engine_compile_message(struct spi_engine *spi_engine,
 	struct spi_message *msg, bool dry, struct spi_engine_program *p)
 {
 	struct spi_device *spi = msg->spi;
+	struct spi_controller *host = spi->controller;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div;
 	bool keep_cs = false;
@@ -258,12 +244,13 @@ static void spi_engine_compile_message(struct spi_engine *spi_engine,
 	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		new_clk_div = spi_engine_get_clk_div(spi_engine, spi, xfer);
+		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
 		if (new_clk_div != clk_div) {
 			clk_div = new_clk_div;
+			/* actual divider used is register value + 1 */
 			spi_engine_program_add_cmd(p, dry,
 				SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV,
-					clk_div));
+					clk_div - 1));
 		}
 
 		if (bits_per_word != xfer->bits_per_word) {
@@ -274,7 +261,7 @@ static void spi_engine_compile_message(struct spi_engine *spi_engine,
 		}
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, spi_engine, clk_div, xfer);
+		spi_engine_gen_sleep(p, dry, spi_engine, clk_div - 1, xfer);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {

-- 
2.43.0


