Return-Path: <linux-spi+bounces-133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E393F803BB2
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B321F211F8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF92E84B;
	Mon,  4 Dec 2023 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vf2jlxV2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCC134
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:10 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d852e06b07so1658962a34.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711309; x=1702316109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98OsS81iJjdYUrIfnnQHE8YiK9lvPvbcglqw48PfjFs=;
        b=Vf2jlxV2tdLEracv5icB41+YhoaMg0csMVqjjn5oCpubGiykjPXSNUSUbLnIC+DnGQ
         PQ/bxseS8omyABCSKDikrlQsfJIlrAzo88/pAbcBhEA454UU5yXlnjGdXPjghraLfUD3
         xphSQPyEyO1HwRtvXFsl2xbjqp/vKbkpTGZmmcOS97iifeIVEfGrYNnR3w2/R7u2hwei
         N25dc4Vckh2E5jnrJPFN/rGyA76t71XNnLhQ7pwfZ/I8DLz+WPkliDKUh8119PYG/kja
         yx4lrdZKA8ZDTfntdE5EnshHQ2a/i1y2sCqzUYH3vVX0+OyS3Pa6wOpC3n/Qqu2Ofu5Q
         y1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711309; x=1702316109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98OsS81iJjdYUrIfnnQHE8YiK9lvPvbcglqw48PfjFs=;
        b=XQ+DrxaHiCcFP6LnRxFgJvuIyQwzHv68+NyH36I2r3HwlpUJ8ef2+TJ8e5+mWW1ylQ
         lZVISwbyyZsxtzYSsuMz1mj3aUGgvk98oTeHAicyJjSt+Umx6WpqAvxC/l9YblxffYKR
         rfA00Rn5cUG0bXj59PYHwCOA1xB/uT7R1ntmEaVterqOlwc0enhiHEGeQsf2QDbp4ULg
         HnT4MsV5OEdrtCUhovn9229AtWUi/p+M0k5Y0KxzLQP2VFIwg+9cmaS/FBHqHpERCUEQ
         KcUuCCv6h/urvH5cGzp/fHfJ29UWmDlr6npTHQektdFD8GT6rlq1ieKTf3xQJMWmHn3n
         Z2Ag==
X-Gm-Message-State: AOJu0YxxqNHKtetYH6O7cjkX/oHZECxzPXVgeTiy/kKN7qhkNR8l0JVd
	onAlB194AVMjMaBIC0xhhPILZdvlwqVZZeF+F0I=
X-Google-Smtp-Source: AGHT+IHg4kzcTZPdowMqqYULC4Xk7Q2T1h9G0+l78eNSUSIGdCPrDTXYGvub/SVq0Dprt3xJgcdH6w==
X-Received: by 2002:a9d:6e0f:0:b0:6d9:aac1:228 with SMTP id e15-20020a9d6e0f000000b006d9aac10228mr767563otr.40.1701711309599;
        Mon, 04 Dec 2023 09:35:09 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] spi: axi-spi-engine: return void from spi_engine_compile_message()
Date: Mon,  4 Dec 2023 11:33:27 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-1-063672323fce@baylibre.com>
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

In the AXI SPI Engine driver, the spi_engine_compile_message() function
does not return any error and none of the callers check the return
value. So we can change the return type to void and drop the return 0.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index cbca783830ea..982b37ac3063 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -218,7 +218,7 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(1, mask));
 }
 
-static int spi_engine_compile_message(struct spi_engine *spi_engine,
+static void spi_engine_compile_message(struct spi_engine *spi_engine,
 	struct spi_message *msg, bool dry, struct spi_engine_program *p)
 {
 	struct spi_device *spi = msg->spi;
@@ -273,8 +273,6 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 
 	if (!keep_cs)
 		spi_engine_gen_cs(p, dry, spi, false);
-
-	return 0;
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,

-- 
2.43.0


