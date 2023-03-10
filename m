Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9336B5464
	for <lists+linux-spi@lfdr.de>; Fri, 10 Mar 2023 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjCJWaK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Mar 2023 17:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjCJW3x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Mar 2023 17:29:53 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2D124EBA
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw28so26494173edb.5
        for <linux-spi@vger.kernel.org>; Fri, 10 Mar 2023 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3WdhQD5rAXvneo2z5R6lNFWc2ZYKuwan4rS9Bakw0M=;
        b=FH0mRWxSv3dhvkjeAGdGWC3XJUniNQrv9dUJ0DlkmSHDBsR1cMKPip4P5qxshWquPT
         o30zH/P6OAMsiqd3b0gJ9NO9k37kxCWE+3g5o0qJuGCMqEhIOhBWbVB55yR9EIYjwikl
         MUi7ljpJcIO9BHqSC8yhPoVOk7jtPv7Jy5AuYh0rPtyhy+iFBBXeYwq2rREH8uUGRdYS
         /P4xnqadCBAt+jcFiqqZPyh2zUeyHC2ZbAOtBHuovmw213/b91juyL9shSC7qo/JEzMk
         8aInCsXVd2L2IU6uBunWkv86D74zDz99X+zHVkraLs4W584lOZl9HtWsQzBPfqK2Xq7Q
         dqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3WdhQD5rAXvneo2z5R6lNFWc2ZYKuwan4rS9Bakw0M=;
        b=QpHgrPjaumCOXbkwFKtrVfLons93RBr3DwDDuGJmJzOXXnrkCRkXCXUfWP5HEraGhg
         EhoCq3H0rZYHLrIjMzyMlUeQZkHwV1NRfYQg2LvmgNMy4Oo11lvY4OgLN+0WdTI3s67Q
         Uyk/se9HQEaBRSC0Sw7LAii/PaHGqHWJowgjKyrQ4p++Lxx54ICWM9QtByoaPXcILu09
         64kwPH8GbShiCODl8Z6188gPUugLES7VWkpwaQ+hUEJQbZ3VvVEHuiPqPDXAlvNYQ8jA
         SGUGkdcOkCsIyfgxHE82f0fVR4sbE9sJrFCsXZu5aBknpDP8QMU7LqrhqaJwjXd0H5yE
         SUSg==
X-Gm-Message-State: AO0yUKUWkY97TCxKmfjv7Wk31OwWTCd/e5uFVe/cxBlC459MkfQhQCvn
        jSXuadOitPPLyuFjcWSkQQBnCQ==
X-Google-Smtp-Source: AK7set/aeDYIEUgYw5BDy72ya0/wLgG/2r8MQ4JILKTIDWdyXnTsT8LTeyXPCHZ13QKftG5RxlCVrQ==
X-Received: by 2002:a17:906:4e15:b0:883:3299:91c8 with SMTP id z21-20020a1709064e1500b00883329991c8mr26654805eju.55.1678487357988;
        Fri, 10 Mar 2023 14:29:17 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:17 -0800 (PST)
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
Subject: [PATCH 14/16] spi: sh-msiof: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 23:28:55 +0100
Message-Id: <20230310222857.315629-14-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/spi/spi-sh-msiof.c:1076:34: error: ‘sh_msiof_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index d828a3b370b8..412aa1882e5d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1073,7 +1073,7 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.min_div_pow = 1,
 };
 
-static const struct of_device_id sh_msiof_match[] = {
+static const struct of_device_id sh_msiof_match[] __maybe_unused = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7745",   .data = &rcar_gen2_data },
-- 
2.34.1

