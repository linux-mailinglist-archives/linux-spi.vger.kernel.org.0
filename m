Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83B76B5452
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 23:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCJW3S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 17:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjCJW3O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 17:29:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1CC123CC7
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k10so26370575edk.13
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4aKAo6MFb3QMb21J3aoV2riVolfD7kZUTP9+kgcCSU=;
        b=RZ3qkTbRBfZNiA0cqYlVVp21HmjVtY20XaGBwrmGNBazyP6QOIQ0QQeeiMkL7MUPJz
         X7C/0rDhWN32MdR45MbZNH2J+UJZgUl6YA2jF1RnkLqBWV5zT8h0JcGqbLJkYQHJcBap
         S0dnyle/sIgSi32MaROVKLa5wvqJ5gvHk8RJz3hldiuC+82cjq7IpInFb/frDBMPszfJ
         7DJ/vCeaRAhX6wQYox60fKxT9TUKzvESrlhC4kWCfK+0Tj+1dNSd259NjGnwOrpfuWzT
         GvPzpcatvo59dJWBtopFntOFKv4E48mBMqf/6T9rg8W2ymkjI1gSdguO9gia/RG4pRBz
         4Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4aKAo6MFb3QMb21J3aoV2riVolfD7kZUTP9+kgcCSU=;
        b=QYh+iZUekgrpQJ/mCp5bccfTxN2SccZENb1pjxQ+m6yoE2oTsyoVfq0X29axaQPePT
         MCphkDlZH9usYaDihelQAbZXcQ3FzxvMJgxW39CetGL4x/N3jmTcazdxMhXK2YBMRYQO
         BLftgEQvX9ag+6tf3sauOYiGqNmVLREQ6LxkQOTF0iLk5E8X4BYvEI03waFkh/EFaZuL
         W0hbwaDdx1VAUhonqdyKyOQJ2/XM6iQEgrpqlLIPB480uq29r134jLOHcFmXzw1Q4LQn
         66JCwD6ideX9fKXP9E6nx4DskQzQsGwRGB8+TIrSrAK/38S3XKArwan6aUyfpu70GA0a
         oijA==
X-Gm-Message-State: AO0yUKVBArn+8PrrY4bO7SQ+jgjV/7Kd6fZUxvRcxvwV2PMmvPLMmnq9
        s6e5LEIfWU/wPPD+mmXfkUsehA==
X-Google-Smtp-Source: AK7set/W0kTwiGlItblh7tf5JTPG4Jzj41fZ0/kDRrZaCweil86ynzpBOA1iUGvgXuT1rUSP46ReMw==
X-Received: by 2002:aa7:d60b:0:b0:4be:d5b8:c007 with SMTP id c11-20020aa7d60b000000b004bed5b8c007mr23483407edr.25.1678487347617;
        Fri, 10 Mar 2023 14:29:07 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:07 -0800 (PST)
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
Subject: [PATCH 06/16] spi: rockchip: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:47 +0100
Message-Id: <20230310222857.315629-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/spi/spi-rockchip.c:1051:34: error: ‘rockchip_spi_dt_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a66fff0ee20e..57ae58bf7a62 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -1069,7 +1069,7 @@ static struct platform_driver rockchip_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.pm = &rockchip_spi_pm,
-		.of_match_table = of_match_ptr(rockchip_spi_dt_match),
+		.of_match_table = rockchip_spi_dt_match,
 	},
 	.probe = rockchip_spi_probe,
 	.remove_new = rockchip_spi_remove,
-- 
2.34.1

