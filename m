Return-Path: <linux-spi+bounces-139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A9803BB9
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AD81F210C0
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2372E844;
	Mon,  4 Dec 2023 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OurRTAy2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3EA1
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:18 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b898c9b4cbso1168079b6e.2
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711318; x=1702316118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELMbPJ/Bj4zA9agSl3Q4pw6/j7PM/9NebqfxKhnmMvI=;
        b=OurRTAy2zoeSTxwWrdD6QQgXqylbWVvtku3UbpESXxggK0Ajxy+jAomAtFYlqnhkw/
         HANVRaQagfVWm5wGuZEnmymwwixQz3+RO0/7TG0Sx4EuTVLjqC3GRN7yj6xu4sfyqJUv
         z68b3m4n8rGvjtS1/eaTmLhbPgyRb7UEHgneNSfQKzri/0V9CeUQKncdr14RPyY9Rwjo
         MWxC2llIhsXJey4BWclkviQNFTX+/yVNNu2rS2eoPJQBGZ4HjYZJH7xj/u6eTWFglDtg
         e3SkdZI32zayiq+w1yvDyfQD3EEHg5rjbAkHOY3erLQ9QaNC5ynRQ7JGkfBttMKsHoPC
         xZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711318; x=1702316118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELMbPJ/Bj4zA9agSl3Q4pw6/j7PM/9NebqfxKhnmMvI=;
        b=I7acAfb+YF1hVlDkNWYx89lLIoJd8qlA0/WDXiWbVD8FLS90JvL5QGyOijckZguqH3
         CKfmKh97Gent1SLhayargVe4+tDI+hVoLnTxyWUNA7rvXXka/EkyFC1UD/hQs5zple9T
         Ibkl0BH+7MpP/a0GX3VdzsHpUc4uZW7BOXNB81aFr7RGQyCFQ0qVRoywS5wi4VWara7K
         rqi51s2dvybaPUYsIzRRBFPGR68l0oeDsNe4+hosaTf4ltIz3U3xOOEOzWe6oAnbhhNh
         vo8h2Poo1i8oRCbzHRavKvrF4+0l8QkBx3Wr4/sAheL7PYwaG67PS9KVfJibq6LQaEry
         Q7Gw==
X-Gm-Message-State: AOJu0YzOfa6+FkEs1hplA2kkg89Etxf6KtW9ENU2xm12bxZ81DCIJo6w
	W3Cf7rCuKbZrXcL4mvJQXL8eRo4rD8nbGECI2n8=
X-Google-Smtp-Source: AGHT+IE/yqFGcXWPTu15sUzxJUaPpuQBk/n79TXrMWam1gnscCWERXd110HIkAly/WudmFOVbxPZIQ==
X-Received: by 2002:a9d:768f:0:b0:6d8:7571:b6d9 with SMTP id j15-20020a9d768f000000b006d87571b6d9mr2147675otl.43.1701711317917;
        Mon, 04 Dec 2023 09:35:17 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] spi: axi-spi-engine: restore clkdiv at end of message
Date: Mon,  4 Dec 2023 11:33:33 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-7-063672323fce@baylibre.com>
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

This modifies the ADI AXI SPI Engine driver to restore the clkdiv
configuration register at the end of a SPI message. Having the clkdiv in
a known state is needed to be able to add a new command in the future
that only performs a delay without any SPI transfers. Furthermore having
that state be the smallest possible divider will allow these delays to
have the highest possible precision.

Changing the initial value of clk_div from -1 to 1 is now possible
because we know the function will always be called with a known clkdiv
config register state. Making this change will also have the effect of
not emitting a clkdiv configuration register instruction in cases where
the maximum sclk rate is used. Having one less instruction to process
reduces delays on the bus which will be beneficial when we implement
offload support to enable reading data from devices at very high rates.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3437829ef8b1..3798f96da586 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -228,7 +228,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
-	clk_div = -1;
+	clk_div = 1;
 
 	spi_engine_program_add_cmd(p, dry,
 		SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -280,6 +280,14 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 
 	if (!keep_cs)
 		spi_engine_gen_cs(p, dry, spi, false);
+
+	/*
+	 * Restore clockdiv to default so that future gen_sleep commands don't
+	 * have to be aware of the current register state.
+	 */
+	if (clk_div != 1)
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,

-- 
2.43.0


