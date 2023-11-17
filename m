Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2C7EF848
	for <lists+linux-spi@lfdr.de>; Fri, 17 Nov 2023 21:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjKQUOH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Nov 2023 15:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjKQUOB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Nov 2023 15:14:01 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC201D57
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:13:57 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b512dd7d5bso1595326b6e.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Nov 2023 12:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252037; x=1700856837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1wQ6CLb/dDh5KiZFFpLs1bmPNGn2Z5vlnYTp1713SY=;
        b=zs/TE/2dzcTIHUUgBQPW21glYKrUWr6e4lez1HsM2FETRIb0q8ttXaWHDhMMvtxAvz
         PAhB3Tm0uoj1B5VYSmFBymiCNJ0qscRwXnixBcesVok1F1NthOM3gCQJ55ulb6TnQ81w
         QoE73k5cJYhWxylpLelYJJ9WOz/68NEgZf77Zx0lX97Ju/Mu1kuYqoQmdP9/AZnwdQKa
         tTR0PXgA2IwZFFujByP9vR/f06oghFv9yczgJDjOQWmB2ZuW3pJugDhDIl+vje0E7HCk
         PZ6+/txXyoTmm2d67EzqcMSCnYEhdm1ANSv96YH/3FiQaCQyBA+EZ7MB4QuoamUFPEdh
         9RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252037; x=1700856837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1wQ6CLb/dDh5KiZFFpLs1bmPNGn2Z5vlnYTp1713SY=;
        b=TgCzFfAVp4rp23wpFpCOeXS4a4Cfp0aqo0Il/WxxJyILyCAN3sADcspgipAe5jAexm
         34mcN4eQbr0+XNl1XsxWoVixQ6Mud57JbJOqirte9b5Yjq5o3lbZNIOOThFLFLeq4BqV
         X4O19BWzmAB7ngyn11bnqsygMH3ycRZdrHkjz1hMGeQoiWluvhh1lreMv+Dia8ChuBkP
         N7f/LD9KUBdaFojtXPFc/yFp1OGN5ofFDSHWD7ifcN6hnOB4ioVgHX/3sW/sFgoTOHGv
         whxsJcI1rSe7i67ajcijUX43X2AEBTjl8kSM/e5SxHaz4X1WDtZ2dOoAAnGkMj33zp4y
         0ikw==
X-Gm-Message-State: AOJu0YwV4Vez13pV7WV1eolSt3HlPk+GkICCcGz1HgjNGdy6DwCO2eph
        1O18nzM4Ok60MJ8Unv+34/5uo9TDDz8rEUE3yTU47Q==
X-Google-Smtp-Source: AGHT+IGtzh7e1k7njF++1U+zMaywWCDh65jE1df5WPD+UmMUdAI4bHvmiDb/8jACwIXkHFTXypjZ/g==
X-Received: by 2002:a05:6808:1922:b0:3b2:e70e:b448 with SMTP id bf34-20020a056808192200b003b2e70eb448mr531624oib.8.1700252037075;
        Fri, 17 Nov 2023 12:13:57 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:56 -0800 (PST)
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
Subject: [PATCH 07/14] spi: axi-spi-engine: use devm_spi_register_controller()
Date:   Fri, 17 Nov 2023 14:12:58 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-7-cc59db999b87@baylibre.com>
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

This replaces spi_register_controller() with
devm_spi_register_controller() in the AXI SPI Engine driver. This
saves us from having to call spi_unregister_controller() in the
remove function.

The remove function is also removed since it is no longer needed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 81d7352d2b8b..819744246952 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -532,7 +532,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->transfer_one_message = spi_engine_transfer_one_message;
 	host->num_chipselect = 8;
 
-	ret = spi_register_controller(host);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
 		return ret;
 
@@ -541,13 +541,6 @@ static int spi_engine_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void spi_engine_remove(struct platform_device *pdev)
-{
-	struct spi_controller *host = platform_get_drvdata(pdev);
-
-	spi_unregister_controller(host);
-}
-
 static const struct of_device_id spi_engine_match_table[] = {
 	{ .compatible = "adi,axi-spi-engine-1.00.a" },
 	{ },
@@ -556,7 +549,6 @@ MODULE_DEVICE_TABLE(of, spi_engine_match_table);
 
 static struct platform_driver spi_engine_driver = {
 	.probe = spi_engine_probe,
-	.remove_new = spi_engine_remove,
 	.driver = {
 		.name = "spi-engine",
 		.of_match_table = spi_engine_match_table,

-- 
2.42.0

