Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253CC6B545E
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 23:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCJW3o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 17:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjCJW31 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 17:29:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC5123DCA
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so26421088eda.7
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/4k4EDtHTwsGrCFmt9A01h3SrewNsUPMEHGiEs4FeY=;
        b=TVdIMwMMrCKmZDAj8bAXcosuz/F+qKLurmGg2tk/JuU0WAeW1zZ3e/5WJFm5zshZxi
         SqKw726uNsBDbGIY2pbSJBufxH78N4ZLW50mMwf71ESTokrIR6XsO7x+je/tAR/wbxyt
         WYxUzBPA1whbkcBPF2K2TOZDDwRH3y2IRF3GPsWajArp2ggTf55DAr1Qk6EvT7FlhPYH
         4+455PnI4SeL9cFUeXrD1nv1O4nsCQkfBMd95Ge0+t3wZzK1f5SMXGVkLeHw7CQi3s+5
         GMsfdtZzfaM1HAp/g0JL3uTpA1omwZTAUUW/0ofTxY2+KChGu+++CqNGcjjsOYO2bQ12
         1obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/4k4EDtHTwsGrCFmt9A01h3SrewNsUPMEHGiEs4FeY=;
        b=MMWo60WqG5PhJC2cOh1RFKrxHQbEkIiubjWSO36nFZUgT9MCH2Htu3UBmfpGISG68y
         dOlSL+CFGL/yOUmxSHFD8uNVfe/Zro6lgcNQUHlnQ++xswpyX0GahDB0T/0DRnbYGg4J
         P1kocNgLnRJ+NG+lvdt+PTfX0pBxU+c0uCM7qWD5xOkwST7q6GIdVbbvXeTwv2TqoyOp
         uM4JzTWd4nyl1PS1kD5/4wl0FQRatBQF+JC8lnsiEuDJOlTA/M8mKj7lhNfZpGFFPu1O
         o7uYb1uoHA6aDIp+mFHnZ77+u4EN4uXReG2XwAPpjc+ialSiebwbmmJNfeoJWazckMPf
         FFfA==
X-Gm-Message-State: AO0yUKV9Q3ve+paTWSvuiEgi9EfTIwPJ6Q/ckS9mVXtjeUipS3KFV08y
        uONNYzeghbtOK3PTPhXvI2tMjA==
X-Google-Smtp-Source: AK7set+a17yOf6VzbwUc0CZ6vTQ58vWyCjXfAH5/wUdFVgNoDsRk2++Q9bB1eIS7zKuhlPF+RpY35g==
X-Received: by 2002:a17:906:9252:b0:8b2:23fb:dfd9 with SMTP id c18-20020a170906925200b008b223fbdfd9mr27625552ejx.39.1678487352519;
        Fri, 10 Mar 2023 14:29:12 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 10/16] spi: pic32: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:51 +0100
Message-Id: <20230310222857.315629-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/spi/spi-pic32.c:857:34: error: ‘pic32_spi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 5a64ad0c94fe..04896e7ff2c1 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -863,7 +863,7 @@ MODULE_DEVICE_TABLE(of, pic32_spi_of_match);
 static struct platform_driver pic32_spi_driver = {
 	.driver = {
 		.name = "spi-pic32",
-		.of_match_table = of_match_ptr(pic32_spi_of_match),
+		.of_match_table = pic32_spi_of_match,
 	},
 	.probe = pic32_spi_probe,
 	.remove_new = pic32_spi_remove,
-- 
2.34.1

