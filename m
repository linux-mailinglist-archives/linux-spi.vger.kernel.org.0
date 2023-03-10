Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EED6B5446
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 23:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjCJW3H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCJW3F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 17:29:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54212117D
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a25so26662829edb.0
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fq28ODdLGdVrfwBbBqpAueEDlCBrl+e8GLAYfu+UZE=;
        b=YErFPXDcruuSCyquGlOEihSnf5WEX5TfRFUNUpk794YqO+3d2tGrz+SAukBB6cHeeY
         6f+NU1SAcvVQh206gJNQOLThJ1SeBSThVgv4zR1bXtJdov0FTIYm4pigzFzvKgXKFaCM
         O7ycG+h5VlOwwhKy3GFtQqV/qtNb0b1AcXMZV0wUHhPD7Basl1eKhl+JCDJqKZPWCnPT
         eiAullbhW79U2YRzArw66eDxZ8lqWSfLdRvprB+5f0RyrMcAqDsKHRdrQj5P5AgRZ/Kl
         lwTOuZL3qbuXuP2Vo/rSeZNkzRlTRJvk32snxMw8+KJAOonVRC+QO+iD6crmCf0gb4de
         Lk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fq28ODdLGdVrfwBbBqpAueEDlCBrl+e8GLAYfu+UZE=;
        b=7RDEf3NsxE52E54wl6S+FhpgCgTcZGoA6nPixrhcqFChkwcJx1nci8VvkMnrNHpH3x
         6mmK56S0zpxEXc9VlS48N728sR1J5t9QaPfBMtMDz8+4NR6+Vlj5P43fXwcMKR4V2ZUj
         nadPhRGVNcKGmvfgVoA3S3zrAtD4Xw89rtNKTOncPFcPL+rA9keRcS2kTq78BnQ7rNLN
         1KuZaVPvGf7JLJux9hWSaR8YqKgUdErtmcL7YVvLgk6QYkGyCR/KVim9fXOd21jj3ypU
         u4RncrvyU84LQY+0KjjnnKWT0h1S3zu37PSso87tagPD/LqbcQa4cEsM7Vs7ppEDEi97
         qDNA==
X-Gm-Message-State: AO0yUKW7W/x6PBeImZ2wl6DmpQfEz0hB5o6ttj+abJrnImeEqBBM88Cl
        /CtOd5cQCABTLygS9pOFsuLPxQ==
X-Google-Smtp-Source: AK7set/MN1PmYbla+81mnyLbnX24dl5dsGO4HTEAGHBQdx8CwTY3seLWUkHX5GZDY+FpxIzcnKNvFg==
X-Received: by 2002:a05:6402:1804:b0:4fa:315a:cb55 with SMTP id g4-20020a056402180400b004fa315acb55mr597332edy.21.1678487341960;
        Fri, 10 Mar 2023 14:29:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:01 -0800 (PST)
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
Subject: [PATCH 02/16] spi: mtk-pmif: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:43 +0100
Message-Id: <20230310222857.315629-2-krzysztof.kozlowski@linaro.org>
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

  drivers/spmi/spmi-mtk-pmif.c:517:34: error: ‘mtk_spmi_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index ad511f2c3324..b8583917fa11 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -530,7 +530,7 @@ MODULE_DEVICE_TABLE(of, mtk_spmi_match_table);
 static struct platform_driver mtk_spmi_driver = {
 	.driver		= {
 		.name	= "spmi-mtk",
-		.of_match_table = of_match_ptr(mtk_spmi_match_table),
+		.of_match_table = mtk_spmi_match_table,
 	},
 	.probe		= mtk_spmi_probe,
 	.remove		= mtk_spmi_remove,
-- 
2.34.1

