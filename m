Return-Path: <linux-spi+bounces-136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A2803BB5
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFFE2810D8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2D2E851;
	Mon,  4 Dec 2023 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ajV2BD1J"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8157CD
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:14 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d857f6f1c0so2631587a34.0
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711314; x=1702316114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vE/Lazu2cf7B6o5i/hH3jypTqxe96xetp8QoO+SVLg=;
        b=ajV2BD1J/1CO3IP+n6TS34r5UbBoG50J9ZMMYgOmG320efWcd7mb1WM9Qwf8wc6Dt7
         zEp3PQmVBD8T1H72lZtn0IwWIHZZKjGjWU1h+GUj9LNHmXv0wLSIVrLMhlTPpBD+T5Ay
         D6kiEzVKA9w6yd+qIY57Fo64JUqkIIW2xFxmiH+4FagfSI4Fz6a0dIhXcCayd7xnHzv8
         FQScbKw6q7FNYX6AiH3EiLtomSnDJfjNLb3ik7DC8t+77yAJ3O7nC6ICm/HHSaNe+MZs
         v5r01R1UKQDSd7zxi111kvLzh6AIj9gnhHjkxs6dwqXApi2qpbxRKGFuJlPsQFiAz/rw
         EVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711314; x=1702316114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vE/Lazu2cf7B6o5i/hH3jypTqxe96xetp8QoO+SVLg=;
        b=cn8tKr7m7FTp8f6mWp/TjD0tZv0dQnyrA9KchlUMWtT6/P2xUFWRpqgRvPDjy5Ebvy
         UaQZEkwiHQuUquWmJ/IHYEAoG5l0ffAay+FAeRmjHDI56WxP7BbsFiBrW5qqY0TbpZfx
         JgGsLGP5XgdxNw8jSHcyYkgKubuapT/E8qOUIHLyEWBGBQenwKOOeN2Qxro4V0rgSA89
         ONR1lzZOf0Atr0S5qBUVVDfmVN8M0aMd9bqw5Q87IgwDHBG1fZ1cgPhJRXB3tACYkxk3
         vwvr5m3AXp5nxhekklJWy0YttESSC7qe19t6LaFvg1/CKxu5cEVZ6rH51oW4f4d2bJTp
         2KAg==
X-Gm-Message-State: AOJu0YxSz87SNO/+hxXYI/UydCTZaSZ+wBMaSyvNcp8BZnRxch1Zityt
	Hx1TNrqhV3/IPanKY2tGI7wcoY4AfDan3qqWduQ=
X-Google-Smtp-Source: AGHT+IEJDbU4/GFS0r8bfZ90Qi/bwXcMtxkv0WvUFlfaUtDNJ+ir6BlFpRM7qCksKlWxLLK8oUOm1Q==
X-Received: by 2002:a9d:4b1a:0:b0:6d9:76cd:d6b8 with SMTP id q26-20020a9d4b1a000000b006d976cdd6b8mr2118498otf.68.1701711314085;
        Mon, 04 Dec 2023 09:35:14 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] spi: axi-spi-engine: fix sleep ticks calculation
Date: Mon,  4 Dec 2023 11:33:30 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-4-063672323fce@baylibre.com>
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

This fixes the sleep ticks calculation when generating sleep
instructions in the AXI SPI Engine driver. The previous calculation
was ignoring delays less than one microsecond and missed a microsecond
to second conversion factor.

This fixes the first issue by not rounding to microseconds. Now that
xfer->effective_speed_hz is guaranteed to be set correctly, we can use
that to simplify the calculation. This new calculation replaces the old
incorrect math.

Also add unit suffix to the delay variable for clarity while we are
touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index fa2264d630c3..b3e72308fcc5 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -168,22 +168,17 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_engine *spi_engine, unsigned int clk_div,
 	struct spi_transfer *xfer)
 {
-	unsigned int spi_clk = clk_get_rate(spi_engine->ref_clk);
 	unsigned int t;
-	int delay;
+	int delay_ns;
 
-	delay = spi_delay_to_ns(&xfer->delay, xfer);
-	if (delay < 0)
+	delay_ns = spi_delay_to_ns(&xfer->delay, xfer);
+	if (delay_ns <= 0)
 		return;
-	delay /= 1000;
 
-	if (delay == 0)
-		return;
-
-	t = DIV_ROUND_UP(delay * spi_clk, (clk_div + 1) * 2);
+	/* rounding down since executing the instruction adds a couple of ticks delay */
+	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * xfer->effective_speed_hz, NSEC_PER_SEC);
 	while (t) {
 		unsigned int n = min(t, 256U);
 
@@ -224,8 +219,8 @@ static void spi_engine_precompile_message(struct spi_message *msg)
 	}
 }
 
-static void spi_engine_compile_message(struct spi_engine *spi_engine,
-	struct spi_message *msg, bool dry, struct spi_engine_program *p)
+static void spi_engine_compile_message(struct spi_message *msg, bool dry,
+				       struct spi_engine_program *p)
 {
 	struct spi_device *spi = msg->spi;
 	struct spi_controller *host = spi->controller;
@@ -261,7 +256,7 @@ static void spi_engine_compile_message(struct spi_engine *spi_engine,
 		}
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, spi_engine, clk_div - 1, xfer);
+		spi_engine_gen_sleep(p, dry, xfer);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
@@ -515,7 +510,7 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 	spi_engine_precompile_message(msg);
 
 	p_dry.length = 0;
-	spi_engine_compile_message(spi_engine, msg, true, &p_dry);
+	spi_engine_compile_message(msg, true, &p_dry);
 
 	size = sizeof(*p->instructions) * (p_dry.length + 1);
 	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
@@ -533,7 +528,7 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 
 	st->sync_id = ret;
 
-	spi_engine_compile_message(spi_engine, msg, false, p);
+	spi_engine_compile_message(msg, false, p);
 
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
 

-- 
2.43.0


