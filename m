Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49B833A65B
	for <lists+linux-spi@lfdr.de>; Sun, 14 Mar 2021 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhCNQfO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Mar 2021 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhCNQet (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Mar 2021 12:34:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706F3C061574;
        Sun, 14 Mar 2021 09:34:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so18092456wmj.1;
        Sun, 14 Mar 2021 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VDS9nwVRpnwp1Gt1y2Nm54ymg7JoMTmUcGQnNLV4uQ=;
        b=C9yZsEjRxrp4gc3W74jkDo92qk01tgTUAKvMDG9WnosAHVU8Zxcq/IJZyInAsMuGc6
         Q2wIRfpn2mvvvJ+rNXtqo90Vu95TGj/wOHfKluv6SHKeuZJEhDb0lToLFn0kNFjFP4kj
         YMnzDKrYWEAVS0AIqOothD5FYGB7oyAGs842rPDNLob9AdlwlkjB6kp7tXO17OQbUc/Z
         mcb3ABC4yhSLPRnumq1Yljg5QvpREkIpWjzFNK9ry6FOSf+yZ1xPzxt0u+NX8imBRCnD
         cjOjjNSSn97wb0iOPQQf2tvc1TgIVw76RjPN4UXBtj7isoIdcyIs/zf1KEyK3D23K1lj
         wUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VDS9nwVRpnwp1Gt1y2Nm54ymg7JoMTmUcGQnNLV4uQ=;
        b=Oc1G1r6reyL7HFhKqCkOYnpxxRD91aMYTrHhzEkJHX0zkX1L39g40AOJ91srJUUUMV
         b7bEpdTVeohvxHMYT5Phhn39Xf3+QvwY1X67voW6L0bL6PYXJQCdYKiCfrvDG8Loa66Q
         bOrVAdLwwgAK0qVMwBrHdHlf9XYFGTLMa01F/sJt7u643MKlhNl+ftay2MVvksKZGzhq
         +XDPj7+HBOq+krS+HT4x45jFksZmC9Cw7c2hOPkql0AKjSrGR0XYIeQTAu0vMaSsyJwr
         nkHh0HFOzObyIAXDgxCiEZJfCVWveDPBAjzmmpme84HhVIGTa7PNNhwqLBTS2ADBmHM8
         iihQ==
X-Gm-Message-State: AOAM531ImbPwJG+1ZuJaizZxrLlyK/YqHTHrvjH0BOWC0aURlhLfELWE
        Utg16on64HVTNJnQPf0i68s=
X-Google-Smtp-Source: ABdhPJxgazrbjJsdtO+Qb9O7xURTSxtp3mpTpr7Y+oU8LpojEBuNByP4tGjdrYeauFxF4Ici4Bc+EA==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr21903613wmg.90.1615739686691;
        Sun, 14 Mar 2021 09:34:46 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id o7sm15723239wrs.16.2021.03.14.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:34:46 -0700 (PDT)
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
Subject: [PATCH v3 08/15] spi: spi-geni-qcom: Convert to use resource-managed OPP API
Date:   Sun, 14 Mar 2021 19:34:01 +0300
Message-Id: <20210314163408.22292-9-digetx@gmail.com>
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
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-geni-qcom.c  | 16 ++++++----------
 include/linux/qcom-geni-se.h |  2 --
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 881f645661cc..3d0d8ddd5772 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -691,14 +691,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 	mas->se.clk = clk;
-	mas->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
-	if (IS_ERR(mas->se.opp_table))
-		return PTR_ERR(mas->se.opp_table);
+
+	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
+	if (ret)
+		return ret;
 	/* OPP table is optional */
-	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	ret = devm_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		goto put_clkname;
+		return ret;
 	}
 
 	spi->bus_num = -1;
@@ -750,9 +751,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(dev);
-	dev_pm_opp_of_remove_table(&pdev->dev);
-put_clkname:
-	dev_pm_opp_put_clkname(mas->se.opp_table);
 	return ret;
 }
 
@@ -766,8 +764,6 @@ static int spi_geni_remove(struct platform_device *pdev)
 
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
2.30.2

