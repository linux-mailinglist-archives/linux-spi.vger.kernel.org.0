Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81284337DF0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhCKTWX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCKTVs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA8C061761;
        Thu, 11 Mar 2021 11:21:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f1so41650857lfu.3;
        Thu, 11 Mar 2021 11:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ncQjRjK6we9+VW90X3d+oYKqpNBh+iHtiBiBJx8Aeg=;
        b=l9H5XZVxeMPHehXPINPXOl+HRg28WGRb95v0DKcngMP4zV6Jd9yaFIMMrjgRwFyVzl
         TilKFAAp8P7x5irOWw16kuK4yqM6NDrZlMmKlFgMZA1ziYB/26w23z640Foe903XBUrL
         VFMC07CnbmcgLj/ZU3JGoApjVq5UvsV+R+8jgG2yTvfe3i+Wbw2vJKGnpKyhLj8WqNjY
         hwHQN3xKIj54vBH4M7GldI8MnukPeQ/IEML7d9CwLjXo2gYAJtS5XGhQv6OCcsKAueAU
         OR6TkLEigWl4mQe3DmzEo87gYdGEco2AuoHxdjkEEMulq7OwP6Jslg2eLH2kwYbo+weA
         Gfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ncQjRjK6we9+VW90X3d+oYKqpNBh+iHtiBiBJx8Aeg=;
        b=trn5XFXr0LWEXK07nmuAToFrfWJpIhNM/JPRo9AvPBSQ0+FjwnMwREOd9Bvtix18oe
         nmOgtvqgdWfI6Gbv22eTzRKwEujObuLJAGE0zBYZ47fyhAVDpXelTGDNrP/05gDl7zS3
         arOhdiV7k/fYXPSQrhUCPoRnFlPOUL81Yo2VI/qJ0QH1YOmbvzxn6PWID2nF9X6L5bZo
         TfOQN+iNyOWQ1YCfsyXarJ+GLcmpuNHJspc/lBWdMU1axN8g4vsbWbfi4LzEltQaDqPk
         tRROTj7mswnh5LcUv/H9c1OPrp5AFKaOlZu5wqjy7+na/hePp4vy1jQg5AkbNaVIA4Oc
         Au0Q==
X-Gm-Message-State: AOAM531LPBr/SVV0qECbmbhLMnMpoB2z3KJBxmKb09777D+PyO+RyHTz
        CwzTLYwpNoOUsoCI6hUT+fM=
X-Google-Smtp-Source: ABdhPJzCh0Qft9dy6G5hWn6tIaRZlWEsGaeKss0+RsKBrcATwvRzpe98QMG4AbkTbMgmz6nalW3KdQ==
X-Received: by 2002:a19:309:: with SMTP id 9mr3246749lfd.268.1615490505282;
        Thu, 11 Mar 2021 11:21:45 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:45 -0800 (PST)
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
Subject: [PATCH v2 07/14] spi: spi-geni-qcom: Convert to use resource-managed OPP API
Date:   Thu, 11 Mar 2021 22:20:58 +0300
Message-Id: <20210311192105.14998-8-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use resource-managed OPP API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Mark brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-geni-qcom.c  | 17 +++++++----------
 include/linux/qcom-geni-se.h |  2 --
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 881f645661cc..20cc29ea198b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -666,6 +666,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *clk;
 	struct device *dev = &pdev->dev;
+	struct opp_table *opp_table;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -691,14 +692,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 	mas->se.clk = clk;
-	mas->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
-	if (IS_ERR(mas->se.opp_table))
-		return PTR_ERR(mas->se.opp_table);
+
+	opp_table = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		goto put_clkname;
+		return ret;
 	}
 
 	spi->bus_num = -1;
@@ -750,9 +752,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-put_clkname:
-	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return ret;
 }
 
@@ -766,8 +765,6 @@ static int spi_geni_remove(struct platform_device *pdev)
 
 	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return 0;
 }
 
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index ec2ad4b0fe14..cddef864a760 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -47,7 +47,6 @@ struct geni_icc_path {
  * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
- * @opp_table:		Pointer to the OPP table
  */
 struct geni_se {
 	void __iomem *base;
@@ -57,7 +56,6 @@ struct geni_se {
 	unsigned int num_clk_levels;
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
-	struct opp_table *opp_table;
 };
 
 /* Common SE registers */
-- 
2.29.2

