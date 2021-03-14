Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195EC33A694
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhCNQft (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhCNQex (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E7C061762;
        Sun, 14 Mar 2021 09:34:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so1259198wmq.1;
        Sun, 14 Mar 2021 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekucTjVivEQ90zhQvUqUcTjBwjviVC3YtIBQBVEBzF4=;
        b=Qd9you/7YOWedpOG1hvsUbVfiK6yVG8ZIN1eeu8EeN0oBoynBCJqewyO2AUV65SZK4
         I3/qUxhda2DRofX+y5Vqzu7fqIzYlw2DqB+9jK9UAHSKpj5NqscMLcQGNg5ShHKQfseN
         8ivwaU4F/qGeJzS3bjBg9hwpVynsI36qfyRUWF5oAsyeMHhD9eyj9sanwrZaRgjA1csz
         yXvSdS9/m9UEcj2BykHoqz+Qc9Y3YRGVU05CVjS9XwXdFImfbjbQRIGqwNEkZjWrmoX8
         NG4olmzn8kZdcomDkFWi0DHlUc491i2dog4piB204tHMBvUEHJJW7aM4l7e/XtJyJMo5
         HACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekucTjVivEQ90zhQvUqUcTjBwjviVC3YtIBQBVEBzF4=;
        b=MmJhOqwsFYn9Fl3WRMz7xd6CM673ki6rcWGClibGLPedmJ2llBKjoJElV+/TTKCT8v
         3UeFEEEvuDT4TEsWig9qwiGk/j5fOZQ5wpLqUNNN8qzAkRFXGFqBtWE6gdai32VrwSJk
         9vWfY+vQn8fo6kJDwYyxbZQDpMqTbHPYZLzHtFNZEbTcN5e3/r4NfLX5pZfk7v4vs/tT
         bFChO1p2o5lzANXkKNOh5Wj+B9xo09OODWDfSBhFj6razCsdYxG0VeBok8hDGygv+Lvu
         8WzxYpaPZvSRvNaJDAnJLe4CckECbrLpb0+PyS4AnWybzvtO8CQXCgmt7llGRuzDW3g4
         8X8Q==
X-Gm-Message-State: AOAM533zNbj63znIDH6lbbbZWL/MPp9s+DCLeVBAHrh3He5eo4RqDtpq
        VQpKV5e5vzq8ZlJo3WzOKI4=
X-Google-Smtp-Source: ABdhPJxCnEzz9dJy2Xdztr6bWqPxnNPEWIx01FtULZIwAIx6ZrM+uJHA7UaOro3z3yHFaKdZAMcN2g==
X-Received: by 2002:a05:600c:4013:: with SMTP id i19mr16812944wmm.33.1615739690935;
        Sun, 14 Mar 2021 09:34:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 10/15] mmc: sdhci-msm: Convert to use resource-managed OPP API
Date:   Sun, 14 Mar 2021 19:34:03 +0300
Message-Id: <20210314163408.22292-11-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314163408.22292-1-digetx@gmail.com>
References: <20210314163408.22292-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use resource-managed OPP API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-msm.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5e1da4df096f..d170c919e6e4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -264,7 +264,6 @@ struct sdhci_msm_host {
 	struct clk_bulk_data bulk_clks[5];
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
-	struct opp_table *opp_table;
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
@@ -2551,17 +2550,15 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto bus_clk_disable;
 
-	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
-	if (IS_ERR(msm_host->opp_table)) {
-		ret = PTR_ERR(msm_host->opp_table);
+	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
+	if (ret)
 		goto bus_clk_disable;
-	}
 
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
-		goto opp_put_clkname;
+		goto bus_clk_disable;
 	}
 
 	/* Vote for maximum clock rate for maximum performance */
@@ -2587,7 +2584,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				      msm_host->bulk_clks);
 	if (ret)
-		goto opp_cleanup;
+		goto bus_clk_disable;
 
 	/*
 	 * xo clock is needed for FLL feature of cm_dll.
@@ -2732,10 +2729,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 clk_disable:
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
-opp_cleanup:
-	dev_pm_opp_of_remove_table(&pdev->dev);
-opp_put_clkname:
-	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
@@ -2754,8 +2747,6 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.30.2

