Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654447EF84B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Nov 2023 21:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjKQUOJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Nov 2023 15:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346029AbjKQUOD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Nov 2023 15:14:03 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650DD7E
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:13:56 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2f2b9a176so1525913b6e.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252036; x=1700856836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LNYfVKcT7JMz9dURfBMFGVc3NYglRs5IQioTfjD6HM=;
        b=GlzlcKT63c7jWtIAMe3jmcQOBcMb0qs+2CwppZtzYE+Ko5QS+cljsUj442lH/CKqB8
         rKoERKdZTydDrroa3t0J28oaO8BUgPBJYZ5BNkicbImd4zDFF5OX6LjrrpYTOQ/OPadl
         vWi4jp+F2VN+d+T7nRLMgJFO1EUeujAnR8Kt+YhPLYohMhK3wjzcPySUdT4dWHfBDs9I
         QxOBr1NbHZy7hyxxPjbY3P6JrU4V5XlFpHwinvsv5NneThCJRjro71Z4AOC2ikHxiiI9
         CdflXTfKqFxB/Sc9cf7yzj7qHXGZpJ6kRQa3NX9hyz5AQUDMppbmJAR6KDdf/quTWY5W
         jJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252036; x=1700856836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LNYfVKcT7JMz9dURfBMFGVc3NYglRs5IQioTfjD6HM=;
        b=F5XV6eDyQLC6m4vKydmiHPjMcNW1kEo7HIV8qe4x0Q458I4WP/eOp14F4yG/BObkzh
         GCZMDWixKIy2qAEZgR0ESUhMhkUJgPS5mBjrNo3omwuGXh5kT70mCKCKRcmuSNEAJuJl
         pLuz42NKfunTpFBE8QqTsxR42H922uxHdisTC6Visvb2Gr9GiHr/j1vyNZi+twXZJCQn
         5Tli+mNKJ7GGXUj4K4+8406ieYNICNrvtcKLI9qqVbodSqMJ861/cUtn6vth13TmPRJM
         O2/AhHfb7INr+sIddc41fhXPZ+hRCXFfbEtpjvCREGci+rS9yrSmqXG3SerIVqcaG4Is
         zCrQ==
X-Gm-Message-State: AOJu0YwwZxxYJ3tHlookNCctBhdwelB/e2EZUWQrB7pIaJXxbIUv2Ge/
        mP2LI2CTViS2CCx7f8gWwN/SreJLJoiM0nR4UQG87w==
X-Google-Smtp-Source: AGHT+IGg2FRB34z9CXeDmTL8vY+4gqMAua4B68XqFMEtbGb7bY0wDKlsZUjbnqLNSi2hQuDWdGbI7A==
X-Received: by 2002:a05:6808:1410:b0:3b5:a58c:cca6 with SMTP id w16-20020a056808141000b003b5a58ccca6mr608163oiv.3.1700252036277;
        Fri, 17 Nov 2023 12:13:56 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:55 -0800 (PST)
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
Subject: [PATCH 06/14] spi: axi-spi-engine: use devm_request_irq()
Date:   Fri, 17 Nov 2023 14:12:57 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-6-cc59db999b87@baylibre.com>
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

This replaces request_irq() with devm_request_irq() in the AXI SPI
Engine driver. This simplifies the error path and removes the need to
call free_irq() in the remove function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index c18a4b34777e..81d7352d2b8b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -520,7 +520,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, host);
+	ret = devm_request_irq(&pdev->dev, irq, spi_engine_irq, 0, pdev->name,
+			       host);
 	if (ret)
 		return ret;
 
@@ -533,24 +534,18 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	ret = spi_register_controller(host);
 	if (ret)
-		goto err_free_irq;
+		return ret;
 
 	platform_set_drvdata(pdev, host);
 
 	return 0;
-err_free_irq:
-	free_irq(irq, host);
-	return ret;
 }
 
 static void spi_engine_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
 
 	spi_unregister_controller(host);
-
-	free_irq(irq, host);
 }
 
 static const struct of_device_id spi_engine_match_table[] = {

-- 
2.42.0

