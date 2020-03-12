Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83335183172
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgCLNbk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 09:31:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54093 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgCLNbk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 09:31:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so6112009wmk.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSxwbrvkTLQhCnvQXX1HjNSZff7G2HPoi6i2nBxHFtc=;
        b=YulRMKVUILMBNhdYGtTrxVJ+7BW7AY4paeNn1T/pfY9D9nSoD8fqGuY045sjsbxU5h
         hQ0pixA54oUGhTR0jYQB9S5danxRYtlzUqJyDZYZsoYUx0X+efvsf0OdsCg/D1aImZRN
         8axNItGQjFv2xvXC8Z2fQbZQOC4Feqijr7BfKcZpHm6nbZIhiZ8Xuhyg4zw3/6UbsuAo
         KLt30d5dY5soGBfrQOsshd8nQwIvKOsYdwNkij/OGVux17s15SGHzo8bB+irZX4Mbg79
         8GW8UhcUsBjWj1fWPAgTmfugsrl2NLfjlNX69Zxf2MqaT58r5tU81vWCQ+QNFl5x36Uj
         1tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSxwbrvkTLQhCnvQXX1HjNSZff7G2HPoi6i2nBxHFtc=;
        b=nIcbH5mFa3aGPGue25wJTxcuTWG0BUYx7r5Jtn7Ed6SGkmUjLCu0VjD5cuYdldScJX
         cflaF/yie7u/yC3ScN3xY0vsz+r+/ZSZ5M+OeZ82KGkHUg0HWAWtCvqHZnoqDeIbMcaa
         C58ODvRV4usbj3w23ZH4T4FGciamGPWI51PZqlrzfAX8T96c96SwlN+2f7o6m0eU6SKO
         /K1cxXCaEjmknPdOgGyu9aOoakBKb2IY5gGfEJXwvlS7MAKzbFLghn0GH0xgaDFpuUT7
         8aT7aDxOBxATuDXYDitVYl4NfqrQhJLZe/Sm4QcF+7yTjJEFSMrEj0JhHQkw8HQ9lSbk
         RYcA==
X-Gm-Message-State: ANhLgQ2oZfANfpf3HO3cQsHyku5Bt4bnrFuJSA+t7rlDtp3sEjvAzDQO
        iMBi06PYy9fddXYQfQY5ehwivg==
X-Google-Smtp-Source: ADFU+vuiXvA7ItIqTn6tHh9dRy8ISscfNKEPxJAkBuAl1GcZMGcUCuRRIWBWKC/j6F3R7b2fLXVfSA==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr4854913wmd.101.1584019898516;
        Thu, 12 Mar 2020 06:31:38 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sunny Luo <sunny.luo@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 4/9] spi: meson-spicc: support max 80MHz clock
Date:   Thu, 12 Mar 2020 14:31:26 +0100
Message-Id: <20200312133131.26430-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPICC controller in Meson-AXG is capable of running at 80M clock.
The ASIC IP is improved and the clock is actually running higher than
previous old SoCs.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index bd434d9055d9..710b4e780daa 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -35,7 +35,6 @@
  *   to have a CS go down over the full transfer
  */
 
-#define SPICC_MAX_FREQ	30000000
 #define SPICC_MAX_BURST	128
 
 /* Register Map */
@@ -132,6 +131,7 @@
 #define SPICC_FIFO_HALF 10
 
 struct meson_spicc_data {
+	unsigned int			max_speed_hz;
 	bool				has_oen;
 	bool				has_enhance_clk_div;
 };
@@ -693,11 +693,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->transfer_one = meson_spicc_transfer_one;
 	master->use_gpio_descriptors = true;
 
-	/* Setup max rate according to the Meson GX datasheet */
-	if ((rate >> 2) > SPICC_MAX_FREQ)
-		master->max_speed_hz = SPICC_MAX_FREQ;
-	else
-		master->max_speed_hz = rate >> 2;
+	/* Setup max rate according to the Meson datasheet */
+	master->max_speed_hz = min_t(unsigned int, rate >> 1,
+				     spicc->data->max_speed_hz);
 
 	meson_spicc_oen_enable(spicc);
 
@@ -737,9 +735,11 @@ static int meson_spicc_remove(struct platform_device *pdev)
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
+	.max_speed_hz		= 30000000,
 };
 
 static const struct meson_spicc_data meson_spicc_axg_data = {
+	.max_speed_hz		= 80000000,
 	.has_oen		= true,
 	.has_enhance_clk_div	= true,
 };
-- 
2.22.0

