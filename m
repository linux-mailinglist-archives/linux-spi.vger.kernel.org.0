Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AE6B5448
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 23:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCJW3H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjCJW3G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 17:29:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3757121B7D
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ay14so26374793edb.11
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76/EJUTO15RzyW4Bq3aXjUUXSFzqS7eUnx+uuY+qlw4=;
        b=QY+FHC9r4+RzAXwp4hRMO7dX5kmQsDXfU75lOdEZEw/5sR6fWA7KyEW89bZ4QaKtiA
         5nMcH4WM7F79MtlVuGFWbq4njYJHE3nin7z1x5/Y62sE1/FUd9ROnyj6/etq6mfce0GT
         UxU44MXgwq+ozgNLDyH6wRr5FmUGNNLw+fwUCP8Q1mITsJ2iI7TiO14GMnI+kmZQvO2b
         /b7APHAP+iaFIBAZnYZwOMDVAnlxbRZkxoOpLaGVakb3bbfVJBUjdnbU/ryWER1uX1My
         K7WeYQ3YEjmvpVGLlt61EcqGbwxZ69eWbT1wLS4zIXYURTaaJtMwwLqRjWPfF3WNdTDp
         ZZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76/EJUTO15RzyW4Bq3aXjUUXSFzqS7eUnx+uuY+qlw4=;
        b=OhL6Y67EAdqHzFRjym52CY7zbNaX9NayacUeHDNqBeArKCPRZY64vcfvwmUH4EFkjr
         FaEgLyFbfhTcoGZlKunr5hEIbwmx2cehkLaq4bui7bDja00LNB+4zX2SHLecoY+uIr7z
         Ye0vZYbt/Jmp2t2hn2+9AGjV7m7jgHQdiJZ7RYWik4lU+VmztEunAImRML/xVy6lrkSR
         8xiASlX5wMgvUyybOK0z6GNROwnPRQ/83lnDg5J8xFMQpu7cUFr/NdHwjqCOPVO6z1ve
         C6a2/z7/EIPfGxg2Bfo68pt1GbyL+cjdUj/paxEaIM/fQhB4mKyIdjbY8F56Rv6nqyfh
         N7hQ==
X-Gm-Message-State: AO0yUKVgjUS7N2BdoCtGm2NtmCtLS1Flp8i/NNqm6to0UV+K0neaBzKq
        q9bkAK0O8k0podUU2F0PJ9Qwow==
X-Google-Smtp-Source: AK7set9xqAwgrRfSWZTYjl4H4cCqoLWPjOPJyHkzao/CGH+3TLt7ijPQdvoiK9ldcAApOqBUnsuWUA==
X-Received: by 2002:a05:6402:3d2:b0:4ac:bde4:ff14 with SMTP id t18-20020a05640203d200b004acbde4ff14mr25348254edw.42.1678487343369;
        Fri, 10 Mar 2023 14:29:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:02 -0800 (PST)
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
Subject: [PATCH 03/16] spi: meson-spicc: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:44 +0100
Message-Id: <20230310222857.315629-3-krzysztof.kozlowski@linaro.org>
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

  drivers/spi/spi-meson-spicc.c:949:34: error: ‘meson_spicc_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-meson-spicc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b9f812837cd6..2e9cbc507e26 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -968,7 +968,7 @@ static struct platform_driver meson_spicc_driver = {
 	.remove_new = meson_spicc_remove,
 	.driver  = {
 		.name = "meson-spicc",
-		.of_match_table = of_match_ptr(meson_spicc_of_match),
+		.of_match_table = meson_spicc_of_match,
 	},
 };
 
-- 
2.34.1

