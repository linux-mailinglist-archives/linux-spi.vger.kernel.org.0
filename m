Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F143A7EF860
	for <lists+linux-spi@lfdr.de>; Fri, 17 Nov 2023 21:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjKQUOY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Nov 2023 15:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjKQUOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Nov 2023 15:14:21 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FC173F
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:14:03 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2ea7cc821so1443667b6e.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252042; x=1700856842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P+/RJb/cpUDSZO9aZmvZcYWX64h3DCpi271jxLHolk=;
        b=mJuBTJQyYIMZXnaCfua6kd7F4fee5sTKKD/NSeXd0DEH8JMEXpWpvWeYM+UxSvPdhL
         igr9ZTk3aWYW4EKOr4jJmq74uKxBn/zMM8srLf/HJz3ldK9b2vekNqWIZJgMt+3LbZh7
         DkFozzyjukJtnZ0lw9w+YW1yas8rIYPyhPlHRujUhO4Y/o0k5GGMC260bA1fLKq6I+iD
         dXG9qfwYI5ov35igQhrlHcO7GoiKNV0otvgNcaasvQr7hk26GpRfztiet6KrD1Xm9M7s
         /emAhjdEVL2TWm0gLBpDsWQwpu3bO7B9kpYAkkIAMbb8cEkPX+Jc2XwiYRqqH5gULECB
         2A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252042; x=1700856842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P+/RJb/cpUDSZO9aZmvZcYWX64h3DCpi271jxLHolk=;
        b=A0GGuOYZSJ7EmH2iYNowDsfflwhYY9fMn96mZVjNpyYz9OjN6Fz9nEXT6EXstbPhSO
         qKtikyRfJyye2ZpudLVH1tFm2CCZTA5+QuEiL0ooxyv8t9zCKEUtU3fX7qSuOP4s0kkj
         Wv+FimGoxHp5F2jcCjiCyF7hHh9Vv8N7ws1C1gZHQywSfDJEHPpCe9foT4+FUAD+4G3N
         Y3sGoo3hkumTaPgaImERNIC2qVhDdBMa+kBc9rG1cC1wzkMYTh6o/zNuQOUq5r8pQuHf
         COXu2gqcRRHLtxHjzLr9oAPu3yYAF9Gzo9SajeufvSy78vtr4B/a/DcRcJ+OIcez0bRk
         wi5g==
X-Gm-Message-State: AOJu0YwTQhNdG1zEaw42fOHVQJRd+9T73TWNEk4z3J+KH6IG1uTby/xF
        4OAXxQxzHkRZLPWN36bg6J3b4le9g7r9Xuze4LL+YQ==
X-Google-Smtp-Source: AGHT+IFEitzBPfYZPR5lABqTFEOeHF0t8EqCeQ2/c/+BO/rZ9LzA3npUgrEGfGJe2sKopIY/JWdDoQ==
X-Received: by 2002:a05:6808:f07:b0:3b2:d8c8:7bfa with SMTP id m7-20020a0568080f0700b003b2d8c87bfamr555396oiw.8.1700252042081;
        Fri, 17 Nov 2023 12:14:02 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:14:01 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] spi: axi-spi-engine: add support for cs_off
Date:   Fri, 17 Nov 2023 14:13:04 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-13-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds support for the spi_transfer::cs_off flag to the AXI SPI
Engine driver.

The logic is copied from the generic spi_transfer_one_message() in
spi.c.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index c39f478f34a7..1c60e6486ee2 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -216,7 +216,7 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div;
-	bool cs_change = true;
+	bool keep_cs = false;
 
 	clk_div = -1;
 
@@ -224,6 +224,9 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 		SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
 			spi_engine_get_config(spi)));
 
+	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
+	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
+
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		new_clk_div = spi_engine_get_clk_div(spi_engine, spi, xfer);
 		if (new_clk_div != clk_div) {
@@ -233,20 +236,28 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 					clk_div));
 		}
 
-		if (cs_change)
-			spi_engine_gen_cs(p, dry, spi, true);
-
 		spi_engine_gen_xfer(p, dry, xfer);
 		spi_engine_gen_sleep(p, dry, spi_engine, clk_div, xfer);
 
-		cs_change = xfer->cs_change;
-		if (list_is_last(&xfer->transfer_list, &msg->transfers))
-			cs_change = !cs_change;
-
-		if (cs_change)
-			spi_engine_gen_cs(p, dry, spi, false);
+		if (xfer->cs_change) {
+			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
+				keep_cs = true;
+			} else {
+				if (!xfer->cs_off)
+					spi_engine_gen_cs(p, dry, spi, false);
+
+				if (!list_next_entry(xfer, transfer_list)->cs_off)
+					spi_engine_gen_cs(p, dry, spi, true);
+			}
+		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
+			   xfer->cs_off != list_next_entry(xfer, transfer_list)->cs_off) {
+			spi_engine_gen_cs(p, dry, spi, xfer->cs_off);
+		}
 	}
 
+	if (!keep_cs)
+		spi_engine_gen_cs(p, dry, spi, false);
+
 	return 0;
 }
 

-- 
2.42.0

