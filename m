Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39B05080DC
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiDTGNb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 02:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiDTGNa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 02:13:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369838BF0
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 23:10:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g19so1011983lfv.2
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nh0Plxg6xGtyFa26OZqYVp7flmusHz3YwO8Ud36lHk=;
        b=mKofICiJIr/1Wu/VgOxfjhGfUfKAmix7o4lgKgJKJKLgTsu57ZS14GcNHfgeYCjAhv
         OR2r4FLyDy0fDxTGO967MO6DGGxTu3mmbjoJyJZL8fW6qfz/Mu+dbn13Y+QjpCmAs/jB
         qViwlFvHpWGhzV30YDcugUiaE9Xqe63Z9MqRZYUN0OYGfemIcXs28BVZmByIO6K9LN7o
         4EWXHACTjTIwr1qdhB6YwQQtEniPfp+Z7G/v1YC+hWAFQ7SJlLtA1OH0jEBzGoEyDg1x
         7KOv8bWEq4FM1arwjFwT/UP74ysWKwlmkLpau5N6sxtz901k3+h2zd5GRWmtcApYaEDg
         XVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5nh0Plxg6xGtyFa26OZqYVp7flmusHz3YwO8Ud36lHk=;
        b=Yoi7rIjBMeEDPzqaJ3cHs/BpXrIlm2OgjcTiRtJZlSV3mxlsearTilcTuGDlHOchzt
         x5ct/UjYK+yEKYzZ3joXwKANx6rkbjVwcrbxXAUf9GU4MvyxyMCXwb+fvofCTQEu0aok
         ZifZLd0/ToKhaXF/WxzbYZFSSRe0y2nujGH9m6L4z9iT7wQdgihbALH/vnd9dNNwtQwU
         cOgUR0YCCFBFrQy3uPLI4xyLCKVxcHP+2AVXgCdiIOZ5haoSrPYjhQJCDRzuqJoP/LK3
         KcF0BCIWwTqf+EalOjIqUuf+oo7ZcYDFgW2t/D0Niwq3mIFPQiPrKs3oxJXYgSXTxTVX
         NtGA==
X-Gm-Message-State: AOAM532kCLKHSe1HPDPvi7GFmSA0iGVGz8/MN7NIYrey8I6XKZ7mwGa6
        DznVB+IiAKn8qgm4b9kROfUGCJp4LMAHAvke
X-Google-Smtp-Source: ABdhPJxxZLl09L1Y5jwNY33vl3ZRjEGgONT8Zfzk+GLiNSP/JlAM3Fi0oYnFSEyOuqIPQ0qnwhcspg==
X-Received: by 2002:ac2:4d18:0:b0:46b:c318:193b with SMTP id r24-20020ac24d18000000b0046bc318193bmr13009403lfi.293.1650435042881;
        Tue, 19 Apr 2022 23:10:42 -0700 (PDT)
Received: from shc.milas.spb.ru ([188.243.217.78])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05651c232400b0024db6a80c92sm1027536ljb.129.2022.04.19.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 23:10:42 -0700 (PDT)
From:   Alexander Shiyan <eagle.alexander923@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: [PATCH] spi: clps711x: Use syscon_regmap_lookup_by_phandle
Date:   Wed, 20 Apr 2022 09:10:38 +0300
Message-Id: <20220420061038.22570-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since version 5.13, the standard syscon bindings have been added
to all clps711x DT nodes, so we can now use the more general
syscon_regmap_lookup_by_phandle function to get the syscon pointer.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 drivers/spi/spi-clps711x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 0bef5ce08094..c005ed26a3e1 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -89,6 +90,7 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 
 static int spi_clps711x_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct spi_clps711x_data *hw;
 	struct spi_master *master;
 	int irq, ret;
@@ -117,8 +119,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	hw->syscon =
-		syscon_regmap_lookup_by_compatible("cirrus,ep7209-syscon3");
+	hw->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
 	if (IS_ERR(hw->syscon)) {
 		ret = PTR_ERR(hw->syscon);
 		goto err_out;
-- 
2.32.0

