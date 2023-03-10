Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6916B545B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 23:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCJW3l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 17:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCJW3Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 17:29:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DB1241FF
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j11so26471950edq.4
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TH+2UFUJbKaymij+b3WrxcVf44nTpYHKEBIPAlM6LWE=;
        b=TavnzZF5kaPHm0mujD/3h+51xHQx7ZCx8G31x/bxMt3RbfzsnQrtXpv04b4bbdXXS2
         T3YKb7NeqFFdymYQG+jvv9I0fUbqvS2izxLVgYfVePxlIpQGz/thUXh2BQxKLm8MCNAz
         sqBFEdjft3Z9ikX2JNWpwOMLLRq6YTg/BjHv6LDnqrvnSszc5MkiEHODmrYWeiqZDifx
         E4IflVpvfeyGhsWS7EafD2stGzcVrnCIPRNo7Jmd2BmAfOfGDaBZKuAbkZGVdpLJ3WYV
         /KflYWU3yCTEX4qTuYr+a/+Gk0rNerW/kEfQveIZw3hp2m88bpisRoINfGmCaE4q49A7
         f2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH+2UFUJbKaymij+b3WrxcVf44nTpYHKEBIPAlM6LWE=;
        b=3/SNQeZYDoHyBTPmVt6qJKLytbvtmtDym/dqrq9YT8kquO9W6pULfcKvJf+PWzi3X0
         9uwbA2FS4splJFHihIRiQByfTYhulnccjplB/P4ErzDQpXvkvW3q9kHhDQ8o0OnRd2y9
         88vgNuKU4M2VNFQzqc0fUfFIZ64Tuds34vhLUZpcKXqnoOKS07Eug4uhEYqE6kVteWDX
         /iGrDCnjiX88j3DdIpH5WvsY4l/MwgH4Yg4CuULNifXsY0usUMDJsYI3xL800dQXdzJF
         34S6k5HfsHbLASy/d1XAUqmGluru7mbwV4adilA/I6R5L+NlEu+KHypeNGRGHjRin/vM
         L7lA==
X-Gm-Message-State: AO0yUKVHRUThpf01IpIPHKruLV1N2NLfrtwOGDQP0kKsTkAj4k9Q3923
        9t1/Mn0iItjKAOcO9hcAmhJ7ug==
X-Google-Smtp-Source: AK7set9cWJOlJkNbsIRY/kVw1cHXOuGBRabzfO/YisfOBi6mPLmqHO4D5ZvGGrVNRhOqaiOFRt27aA==
X-Received: by 2002:aa7:da49:0:b0:4bf:3cdb:fb42 with SMTP id w9-20020aa7da49000000b004bf3cdbfb42mr25096957eds.6.1678487350030;
        Fri, 10 Mar 2023 14:29:10 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:09 -0800 (PST)
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
Subject: [PATCH 08/16] spi: img-spfi: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:49 +0100
Message-Id: <20230310222857.315629-8-krzysztof.kozlowski@linaro.org>
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

  drivers/spi/spi-img-spfi.c:746:34: error: ‘img_spfi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-img-spfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c64e4fd3fdf0..bc360e779933 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -753,7 +753,7 @@ static struct platform_driver img_spfi_driver = {
 	.driver = {
 		.name = "img-spfi",
 		.pm = &img_spfi_pm_ops,
-		.of_match_table = of_match_ptr(img_spfi_of_match),
+		.of_match_table = img_spfi_of_match,
 	},
 	.probe = img_spfi_probe,
 	.remove_new = img_spfi_remove,
-- 
2.34.1

